FROM docker.io/runatlantis/atlantis:v0.11.1

LABEL maintainer="Scott Crooks <scrooks@stackstate.com>"

ENV LOCAL_BIN=/usr/local/bin

ARG TERRAFORM_VERSION="0.12.20"
RUN set -ex \
    && apk add --no-cache --virtual .build-dependencies curl unzip \
    && curl -fSL "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip" -o /tmp/terraform.zip \
    && unzip /tmp/terraform.zip -d /tmp \
    && rm -f ${LOCAL_BIN}/terraform \
    && mv /tmp/terraform ${LOCAL_BIN}/terraform \
    && rm -f /tmp/terraform* \
    && apk del .build-dependencies

ARG TERRAGRUNT_VERSION="v0.22.3"
ADD https://github.com/gruntwork-io/terragrunt/releases/download/${TERRAGRUNT_VERSION}/terragrunt_linux_amd64 ${LOCAL_BIN}/terragrunt
RUN chmod +x ${LOCAL_BIN}/terragrunt

ARG SOPS_VERSION="v3.5.0"
ADD https://github.com/mozilla/sops/releases/download/${SOPS_VERSION}/sops-${SOPS_VERSION}.linux ${LOCAL_BIN}/sops
RUN chmod +x ${LOCAL_BIN}/sops

ARG KUBECTL_VERSION="v1.17.3"
ADD https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl ${LOCAL_BIN}/kubectl
RUN chmod +x ${LOCAL_BIN}/kubectl
