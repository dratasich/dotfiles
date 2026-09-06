# fish files in conf.d are automatically executed before config.fish

# --- environment variables ---

# vscode (github copilot)
# https://github.com/orgs/community/discussions/32285#discussioncomment-4776853
set -xg NODE_EXTRA_CA_CERTS /etc/ssl/certs/

# Java
set -xg JAVA_HOME /usr/lib/jvm/default-java
set -xga PATH $JAVA_HOME/bin
set -xg M2_HOME /opt/apache-maven-3.8.6
set -xg MAVEN_HOME /opt/apache-maven-3.8.6
set -xga PATH $M2_HOME/bin

# kubectl
set -xg KUBECONFIG ~/.kube/config
for config in (find ~/.kube/config.d/ -type f -exec ls {} \;)
    set -xg KUBECONFIG $KUBECONFIG:$config
end

# .net
set -xg DOTNET_CLI_TELEMETRY_OPTOUT true

# python
set -xga PATH ~/.local/bin
set -xg REQUESTS_CA_BUNDLE /etc/ssl/certs/ca-certificates.crt

# go
set -xg GOPATH $HOME/go
set -xga PATH $GOPATH/bin

# gaming
set -xg MANGOHUD 1
