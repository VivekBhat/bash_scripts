export FLINK_HOME=$HOME/Projects/owaiops
export MLAIOPS_MASTER_PASSWORD_FILE=$HOME/.credentials/iactl_creds
export REQUESTS_CA_BUNDLE="/etc/ssl/certs/ca-certificates.crt"
export GRADLE_HOME="/opt/gradle/latest"
export SSL_CERT_FILE="/etc/ssl/certs/ca-certificates.crt"

# Add directories to PATH using the custom function
add_to_path $HOME/go/bin
add_to_path $HOME/flink/bin
add_to_path /usr/local/go/bin
add_to_path $HOME/.local/bin
add_to_path ${GRADLE_HOME}/bin
add_to_path /usr/local/apache-maven-3.9.6/bin
