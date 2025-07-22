#!/bin/bash

export AWS_CA_BUNDLE="/etc/ssl/certs/ca-certificates.crt"

function refresh-ecr-login() {
    aws ecr get-login-password --region eu-west-2 | docker login --username AWS --password-stdin 181148949657.dkr.ecr.eu-west-2.amazonaws.com
}

# This function retrieves and caches a CodeArtifact token.
# It checks if a valid token exists in a file, and only fetches a new one if expired or missing.
get_codeartifact_token() {
    local domain=$1
    local domain_owner=$2
    local region=$3
    local token_file=$4

    local current_time=$(date +%s)
    local stored_token=""
    local token_expiration=""

    # Check if token file exists
    if [[ -f $token_file ]]; then
        # Read token and expiration from file
        stored_token=$(grep 'authorizationToken' "$token_file" | cut -d'=' -f2)
        token_expiration=$(grep 'expiration' "$token_file" | cut -d'=' -f2)

        # If token is missing or expired, fetch a new one
        if [[ -z $stored_token || $current_time -ge $token_expiration ]]; then
            echo "Token expired or invalid. Fetching new token..."
            stored_token=$(aws codeartifact get-authorization-token \
                --domain "$domain" \
                --domain-owner "$domain_owner" \
                --region "$region" \
                --query authorizationToken \
                --output text)
            token_expiration=$((current_time + 43200)) # Token valid for 12 hours

            # Save new token and expiration to file
            echo "authorizationToken=$stored_token" > "$token_file"
            echo "expiration=$token_expiration" >> "$token_file"
        else
            echo "Using cached token."
        fi
    else
        # If token file doesn't exist, fetch and save a new token
        echo "Token file not found. Fetching new token..."
        stored_token=$(aws codeartifact get-authorization-token \
            --domain "$domain" \
            --domain-owner "$domain_owner" \
            --region "$region" \
            --query authorizationToken \
            --output text)
        token_expiration=$((current_time + 43200))

        echo "authorizationToken=$stored_token" > "$token_file"
        echo "expiration=$token_expiration" >> "$token_file"
    fi

    # Return the token
    echo "$stored_token"
}

# Refreshes the Maven CodeArtifact token if needed and exports it to the environment.
refresh_maven_token() {
    local token_file=~/.maven_token_info
    local domain="hughes"
    local domain_owner="181148949657"
    local region="eu-west-2"

    # Get the token using the helper function
    local token=$(get_codeartifact_token "$domain" "$domain_owner" "$region" "$token_file")

    # Export the token if not already set
    if [[ -z $CODEARTIFACT_AUTH_TOKEN ]]; then
        export CODEARTIFACT_AUTH_TOKEN="$token"
        echo "CODEARTIFACT_AUTH_TOKEN exported."
    else
        echo "CODEARTIFACT_AUTH_TOKEN already set."
    fi
}

# Refreshes the PyPI CodeArtifact token if needed and logs in using pip and twine.
refresh_pypi() {
    local token_file=~/.pypi_token_info
    local domain="hughes"
    local domain_owner="181148949657"
    local region="eu-west-2"
    local repository="pypi-store"

    # Get the token using the helper function
    local token=$(get_codeartifact_token "$domain" "$domain_owner" "$region" "$token_file")

    # Use the token to log in with pip and twine
    for tool in pip twine; do
        aws codeartifact login \
            --tool "$tool" \
            --domain "$domain" \
            --domain-owner "$domain_owner" \
            --repository "$repository"
    done
}


function set-aws-profile() {
    local profile=${1:-dev}
    export AWS_PROFILE=$profile
    trace "Using AWS_PROFILE $profile"
}

function refresh-aws() {
    local profile=$1

    set-aws-profile "$profile"

    aws sso login
    trace "Updated AWS SSO login"
    refresh-ecr-login &>/dev/null
    trace "Updated docker login"
    refresh_maven_token &>/dev/null
    trace "Updated maven token"
    refresh_pypi &>/dev/null
    trace "Updated pypi token"
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

    set-aws-profile "$2"

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


# refresh_maven_token &>/dev/null
# refresh_pypi &>/dev/null
