FROM runatlantis/atlantis:latest

ARG TERRAGRUNT_VERSION="v0.19.9"
RUN curl -fSL https://github.com/gruntwork-io/terragrunt/releases/download/$TERRAGRUNT_VERSION/terragrunt_linux_amd64 \
      -o /usr/local/bin/terragrunt \
    && chmod +x /usr/local/bin/terragrunt

ARG SOPS_VERSION="3.3.1"
RUN curl -fSL https://github.com/mozilla/sops/releases/download/$SOPS_VERSION/sops-$SOPS_VERSION.linux \
      -o /usr/local/bin/sops \
    && chmod +x /usr/local/bin/sops
