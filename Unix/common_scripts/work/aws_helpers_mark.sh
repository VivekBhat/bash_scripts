complete -C '/usr/local/bin/aws_completer' aws

function aws-switch-profile() {
    export AWS_PROFILE=$1
}

function aws-login-docker() {
    [[ ${1:-dev} == "prod" ]] && account=772048276950 || account=181148949657
    local registry=${account}.dkr.ecr.eu-west-2.amazonaws.com
    echo "Configuring docker credentials for registry: $registry"
    aws ecr get-login-password --region eu-west-2 | docker login --username AWS --password-stdin ${registry}
}

alias aws-kubectl-update='aws eks update-kubeconfig --region eu-west-2 --name insightalytics'

alias follow-wsp='kubectl -n insightalytics logs -f weather-stream-processor-taskmanager-1-1'
alias follow-asp='kubectl -n insightalytics logs -f alarm-stream-processor-taskmanager-1-1'
alias follow-str='kubectl -n insightalytics logs -f deployments/snmp-trap-relay'

alias follow-alarminator='aws logs tail --follow --format short /aws/lambda/alarminator'

function get_deployment_server_instance() {
    echo $(aws ec2 describe-instances --filters "Name=tag:Name,Values=ia-deployment-server" | jq -r '.Reservations[].Instances[] | select(.State.Name == "running") | .InstanceId')
}

function ssm-deployment-server() {
    export AWS_PROFILE=${1:-dev}
    aws ssm start-session --target $(get_deployment_server_instance)
}

function ssm-port-forward() {
    export AWS_PROFILE=${1:-dev}
    aws ssm start-session --target $(get_deployment_server_instance) --document-name AWS-StartPortForwardingSession --parameters '{"portNumber":["8081"],"localPortNumber":["8081"]}'
}

function ssm-msk-client() {
    export AWS_PROFILE=${1:-dev}
    aws ssm start-session --target $(aws ec2 describe-instances --filters "Name=tag:Name,Values=MSK-CLIENT" | jq -r '.Reservations[].Instances[] | select(.State.Name == "running") | .InstanceId')
}

function aws-setcreds() {
    aws-set-credentials.py --env $1 && aws-kubectl-setup
}

function aws-tools-setup() {
    # Configure pip to use our private pypi repository in Code Artifact

    export AWS_CA_DOMAIN=hughes
    export AWS_CA_DOMAIN_OWNER=181148949657
    export AWS_CA_REPOSITORY=pypi-store

    echo -e "pip\ntwine" | parallel aws codeartifact login --tool {} --domain $AWS_CA_DOMAIN --domain-owner $AWS_CA_DOMAIN_OWNER --repository $AWS_CA_REPOSITORY

    # Needed to support UV tooling

    export AWS_CODEARTIFACT_TOKEN=$(aws codeartifact get-authorization-token --domain $AWS_CA_DOMAIN --domain-owner $AWS_CA_DOMAIN_OWNER  --query authorizationToken --output text --region eu-west-2)
    export UV_INDEX_URL="https://aws:${AWS_CODEARTIFACT_TOKEN}@$AWS_CA_DOMAIN-$AWS_CA_DOMAIN_OWNER.d.codeartifact.eu-west-2.amazonaws.com/pypi/$AWS_CA_REPOSITORY/simple/"
}

#export UV_INDEX_CODEARTIFACT_USERNAME=aws
#export UV_INDEX_CODEARTIFACT_PASSWORD="${CODEARTIFACT_AUTH_TOKEN}"
