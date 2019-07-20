FROM runatlantis/atlantis:v0.8.3

ARG TERRAGRUNT_VERSION="v0.19.9"
RUN curl -fSL https://github.com/gruntwork-io/terragrunt/releases/download/$TERRAGRUNT_VERSION/terragrunt_linux_amd64 \
      -o /usr/local/bin/terragrunt \
    && chmod +x /usr/local/bin/terragrunt
