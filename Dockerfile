FROM runatlantis/atlantis:latest

ENV LOCAL_BIN=/usr/local/bin

ARG TERRAGRUNT_VERSION="v0.19.9"
RUN curl -fSL https://github.com/gruntwork-io/terragrunt/releases/download/$TERRAGRUNT_VERSION/terragrunt_linux_amd64 \
      -o $LOCAL_BIN/terragrunt \
    && chmod +x $LOCAL_BIN/terragrunt

ARG SOPS_VERSION="3.3.1"
RUN curl -fSL https://github.com/mozilla/sops/releases/download/$SOPS_VERSION/sops-$SOPS_VERSION.linux \
      -o $LOCAL_BIN/sops \
    && chmod +x $LOCAL_BIN/sops

ARG KUBECTL_VERSION="v1.15.1"
RUN curl -fSL https://storage.googleapis.com/kubernetes-release/release/$KUBECTL_VERSION/bin/linux/amd64/kubectl \
      -o $LOCAL_BIN/kubectl
    && chmod +x $LOCAL_BIN/kubectl
