FROM runatlantis/atlantis:latest

LABEL maintainer="Scott Crooks <scrooks@stackstate.com>"

ENV LOCAL_BIN=/usr/local/bin

ARG TERRAGRUNT_VERSION="v0.21.9"
ADD https://github.com/gruntwork-io/terragrunt/releases/download/${TERRAGRUNT_VERSION}/terragrunt_linux_amd64 $LOCAL_BIN/terragrunt
RUN chmod +x $LOCAL_BIN/terragrunt

ARG SOPS_VERSION="v3.5.0"
ADD https://github.com/mozilla/sops/releases/download/${SOPS_VERSION}/sops-${SOPS_VERSION}.linux $LOCAL_BIN/sops
RUN chmod +x $LOCAL_BIN/sops

ARG KUBECTL_VERSION="v1.17.0"
ADD https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl $LOCAL_BIN/kubectl
RUN chmod +x $LOCAL_BIN/kubectl
