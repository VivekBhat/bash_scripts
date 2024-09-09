#!/bin/bash
function refresh_maven_token() {
    export CODEARTIFACT_AUTH_TOKEN=$(aws codeartifact get-authorization-token \
        --domain hughes \
        --domain-owner 181148949657 \
        --region eu-west-2 \
        --query authorizationToken \
        --output text)
}

alias aws-kubectl-update='aws eks update-kubeconfig --region eu-west-2 --name insightalytics'

function connect_ds() {
    connect_ec2 "ia-deployment-server"
}

function connect_msk() {
    connect_ec2 "MSK-CLIENT"
}

function connect_ec2() {
    local instance_name=$1
    local instance_id=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=$instance_name" | jq -r '.Reservations[].Instances[] | select(.State.Name == "running") | .InstanceId')
    echo "connecting to instance_name=$instance_name, instance_id=$instance_id"
    aws ssm start-session --target $instance_id
}

refresh_maven_token
export AWS_CA_BUNDLE="/etc/ssl/certs/ca-certificates.crt"
