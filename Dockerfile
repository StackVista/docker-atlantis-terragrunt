FROM docker.io/runatlantis/atlantis:v0.14.0

LABEL maintainer="Vincent Partington <vpartington@stackstate.com>"

ENV \
    LOCAL_DIR=/usr/local \
    PERSISTENT_PACKAGES="curl python3"

ENV PATH="$PATH:$LOCAL_DIR/google-cloud-sdk/bin"

RUN set -ex \
    && apk add --no-cache ${PERSISTENT_PACKAGES}

ARG TERRAFORM_VERSION="0.13.2"
RUN set -ex \
    && apk add --no-cache --virtual .build-dependencies unzip \
    && curl -fSL "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip" -o /tmp/terraform.zip \
    && unzip /tmp/terraform.zip -d /tmp \
    && rm -f ${LOCAL_DIR}/bin/terraform \
    && mv /tmp/terraform ${LOCAL_DIR}/bin/terraform \
    && rm -f /tmp/terraform* \
    && apk del .build-dependencies

ARG TERRAGRUNT_VERSION="v0.23.33"
RUN set -ex \
    && curl -fSL "https://github.com/gruntwork-io/terragrunt/releases/download/${TERRAGRUNT_VERSION}/terragrunt_linux_amd64" \
        -o ${LOCAL_DIR}/bin/terragrunt \
    && chmod +x ${LOCAL_DIR}/bin/terragrunt

ARG SOPS_VERSION="v3.6.0"
RUN set -ex \
    && curl -fSL "https://github.com/mozilla/sops/releases/download/${SOPS_VERSION}/sops-${SOPS_VERSION}.linux" \
        -o ${LOCAL_DIR}/bin/sops \
    && chmod +x ${LOCAL_DIR}/bin/sops

ARG KUBECTL_VERSION="v1.17.4"

RUN set -ex \
    && curl -fSL "https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl" \
        -o ${LOCAL_DIR}/bin/kubectl \
    && chmod +x ${LOCAL_DIR}/bin/kubectl

RUN set -ex \
    && curl -fSL https://sdk.cloud.google.com | bash -s -- --disable-prompts --install-dir=${LOCAL_DIR} \
    && rm -rf /tmp/* /root/.config/gcloud

RUN gcloud config set disable_usage_reporting false \
    && rm -rf /root/.config/gcloud
