#!/bin/bash
function refresh-ecr-login() {
    aws ecr get-login-password --region eu-west-2 | docker login --username AWS --password-stdin 181148949657.dkr.ecr.eu-west-2.amazonaws.com
}

function refresh-maven-token() {
    # Define the file where the token and expiration timestamp will be stored
    TOKEN_FILE=~/.maven_token_info

    # Check if the token file exists and read the expiration time
    if [[ -f $TOKEN_FILE ]]; then
        # Read the expiration time from the file
        TOKEN_EXPIRATION=$(cat $TOKEN_FILE | grep 'expiration' | cut -d'=' -f2)
        CURRENT_TIME=$(date +%s)

        # Check if the current time is greater than the expiration time
        if [[ $CURRENT_TIME -lt $TOKEN_EXPIRATION ]]; then
            echo "No need to update CodeArtifact token as it is still valid."
            return 0
        fi
    fi

    # If the token is expired or the file does not exist, refresh the token
    echo "Refreshing CodeArtifact token..."
    CODEARTIFACT_AUTH_TOKEN=$(aws codeartifact get-authorization-token \
        --domain hughes \
        --domain-owner 181148949657 \
        --region eu-west-2 \
        --query authorizationToken \
        --output text)

    # Store the token and the new expiration time (current time + 12 hours)
    EXPIRATION_TIMESTAMP=$(($(date +%s) + 43200))
    echo "authorizationToken=$CODEARTIFACT_AUTH_TOKEN" >$TOKEN_FILE
    echo "expiration=$EXPIRATION_TIMESTAMP" >>$TOKEN_FILE

    # Export the token for the current session
    export CODEARTIFACT_AUTH_TOKEN
}

refresh-maven-token &>/dev/null

alias aws-kubectl-update='aws eks update-kubeconfig --region eu-west-2 --name insightalytics'

function connect-ds() {
    connect-ec2 "ia-deployment-server"
}

function connect-msk() {
    connect-ec2 "MSK-CLIENT"
}

function connect-ec2() {
    local instance_name=$1
    local instance_id=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=$instance_name" | jq -r '.Reservations[].Instances[] | select(.State.Name == "running") | .InstanceId')
    echo "connecting to instance_name=$instance_name, instance_id=$instance_id"
    aws ssm start-session --target $instance_id
}

export AWS_CA_BUNDLE="/etc/ssl/certs/ca-certificates.crt"
