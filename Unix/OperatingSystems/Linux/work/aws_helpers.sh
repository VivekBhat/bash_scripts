#!/bin/bash
function refresh-ecr-login() {
    aws ecr get-login-password --region eu-west-2 | docker login --username AWS --password-stdin 181148949657.dkr.ecr.eu-west-2.amazonaws.com
}

function refresh-maven-token() {
    # Define the file where the token and expiration timestamp will be stored
    TOKEN_FILE=~/.maven_token_info

    # Initialize variables
    CURRENT_TIME=$(date +%s)
    STORED_AUTH_TOKEN=""
    TOKEN_EXPIRATION=""

    # Check if the token file exists
    if [[ -f $TOKEN_FILE ]]; then
        # Extract token and expiration time from the file
        STORED_AUTH_TOKEN=$(grep 'authorizationToken' $TOKEN_FILE | cut -d'=' -f2)
        TOKEN_EXPIRATION=$(grep 'expiration' $TOKEN_FILE | cut -d'=' -f2)

        # echo "STORED_AUTH_TOKEN=$STORED_AUTH_TOKEN"
        # echo "TOKEN_EXPIRATION=$TOKEN_EXPIRATION"

        # Validate the token's expiration
        if [[ -z $STORED_AUTH_TOKEN || $CURRENT_TIME -ge $TOKEN_EXPIRATION ]]; then
            echo "Stored CodeArtifact token is expired or invalid. Fetching a new one..."
            STORED_AUTH_TOKEN=$(aws codeartifact get-authorization-token \
                --domain hughes \
                --domain-owner 181148949657 \
                --region eu-west-2 \
                --query authorizationToken \
                --output text)

            # Update the token file with the new token and expiration time
            TOKEN_EXPIRATION=$(($CURRENT_TIME + 43200)) # 12 hours
            # remove the existing file
            rm -rf $TOKEN_FILE
            {
                echo "authorizationToken=$STORED_AUTH_TOKEN"
                echo "expiration=$TOKEN_EXPIRATION"
            } >$TOKEN_FILE
        else
            echo "Stored CodeArtifact token is valid."
        fi
    else
        # If the file doesn’t exist, fetch a new token
        echo "Token file does not exist. Fetching a new CodeArtifact token..."
        STORED_AUTH_TOKEN=$(aws codeartifact get-authorization-token \
            --domain hughes \
            --domain-owner 181148949657 \
            --region eu-west-2 \
            --query authorizationToken \
            --output text)

        # Save the new token and expiration time
        TOKEN_EXPIRATION=$(($CURRENT_TIME + 43200)) # 12 hours
        {
            echo "authorizationToken=$STORED_AUTH_TOKEN"
            echo "expiration=$TOKEN_EXPIRATION"
        } >$TOKEN_FILE
    fi

    # Check if the environment variable is set
    if [[ -z $CODEARTIFACT_AUTH_TOKEN ]]; then
        export CODEARTIFACT_AUTH_TOKEN=$STORED_AUTH_TOKEN
        echo "CODEARTIFACT_AUTH_TOKEN has been exported to the environment."
    else
        echo "CODEARTIFACT_AUTH_TOKEN is already set in the environment."
    fi
}

refresh-maven-token &>/dev/null

function refresh-aws() {
    aws sso login
    trace "Updated AWS SSO login"
    refresh-ecr-login &>/dev/null
    trace "Updated docker login"
    refresh-maven-token &>/dev/null
    trace "Updated maven token"
}

alias aws-kubectl-update='aws eks update-kubeconfig --region eu-west-2 --name insightalytics'

function connect-ds() {
    connect-ec2 "ia-deployment-server" $1
}

function connect-msk() {
    connect-ec2 "MSK-CLIENT" $1
}

function connect-ec2() {
    local instance_name=$1

    if [ -n "$profile" ]; then
        echo "exporting AWS_PROFILE to '$profile'"
        export AWS_PROFILE=$profile
    fi

    local instance_id=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=$instance_name" | jq -r '.Reservations[].Instances[] | select(.State.Name == "running") | .InstanceId')
    echo "connecting to instance_name=$instance_name, instance_id=$instance_id"
    aws ssm start-session --target $instance_id
}

function sort_cloudwatch_dashboard_json() {
    local json_file=$1
    local output_file="${json_file%.json}_sorted.json"

    if [[ -z "$json_file" || ! -f "$json_file" ]]; then
        echo "Please provide a valid JSON file."
        return 1
    fi

    # Remove the output file if it exists to ensure it gets overwritten
    [[ -f "$output_file" ]] && rm "$output_file"

    jq '.widgets |= sort_by(.y, .x)' "$json_file" >"$output_file"

    if [[ $? -eq 0 ]]; then
        echo "Sorted JSON saved to $output_file"

        cat $output_file | xclip -selection clipboard
        echo "Copied the file to clipboard"
    else
        echo "Failed to sort the JSON file."
    fi
}

export AWS_CA_BUNDLE="/etc/ssl/certs/ca-certificates.crt"
