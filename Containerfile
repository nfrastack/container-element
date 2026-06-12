# SPDX-FileCopyrightText: © 2026 Nfrastack <code@nfrastack.com>
#
# SPDX-License-Identifier: MIT

ARG \
    BASE_IMAGE

FROM ${BASE_IMAGE}

LABEL \
        org.opencontainers.image.title="Element" \
        org.opencontainers.image.description="Web client for Matrix Homeservers" \
        org.opencontainers.image.url="https://hub.docker.com/r/nfrastack/element" \
        org.opencontainers.image.documentation="https://github.com/nfrastack/container-element/blob/main/README.md" \
        org.opencontainers.image.source="https://github.com/nfrastack/container-element.git" \
        org.opencontainers.image.authors="Nfrastack <code@nfrastack.com>" \
        org.opencontainers.image.vendor="Nfrastack <https://www.nfrastack.com>" \
        org.opencontainers.image.licenses="MIT"
ARG \
    ELEMENT_VERSION="v1.12.21" \
    ELEMENT_REPO_URL="https://github.com/element-hq/element-web"

ENV \
    IMAGE_NAME="nfrastack/element" \
    IMAGE_REPO_URL="https://github.com/nfrastack/container-element/"

COPY CHANGELOG.md /usr/src/container/CHANGELOG.md
COPY LICENSE /usr/src/container/LICENSE
COPY README.md /usr/src/container/README.md

RUN echo "" && \
    BUILD_ENV=" \
                NGINX_SITE_ENABLED=element \
              " && \
    ELEMENT_BUILD_DEPS_ALPINE=" \
                               " \
                                    && \
    ELEMENT_RUN_DEPS_ALPINE=" \
                            " \
                            && \
    \
    source /container/base/functions/container/build && \
    container_build_log image && \
    package update && \
    package upgrade && \
    package install \
                        ELEMENT_BUILD_DEPS \
                        ELEMENT_RUN_DEPS \
                        && \
    \
    package build yq && \
    \
    mkdir -p /www/html && \
    curl -sSL ${ELEMENT_REPO_URL}/releases/download/${ELEMENT_VERSION}/element-${ELEMENT_VERSION}.tar.gz | tar xvfz - --strip 1 -C /www/html && \
    container_build_log add "Element" "${ELEMENT_VERSION}" "${ELEMENT_REPO_URL}" && \
    package cleanup

COPY rootfs /
