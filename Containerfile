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
    ELEMENT_VERSION="v1.12.13" \
    ELEMENT_REPO_URL="https://github.com/element-hq/element-web" \
    PATCH=FALSE 
    
ENV \
    IMAGE_NAME="nfrastack/element" \
    IMAGE_REPO_URL="https://github.com/nfrastack/container-element/"

COPY CHANGELOG.md /usr/src/container/CHANGELOG.md
COPY LICENSE /usr/src/container/LICENSE
COPY README.md /usr/src/container/README.md
COPY patches/* /usr/src/patches/

RUN echo "" && \
    BUILD_ENV=" \
                10-nginx/NGINX_SITE_ENABLED=element \
              " && \
    ELEMENT_BUILD_DEPS_ALPINE=" \
                                git \
                                nodejs \
                                npm \
                                patch \
                             " \
                             && \
    ELEMENT_RUN_DEPS_ALPINE=" \
                            " \
                            && \
    source /container/base/functions/container/build && \
    container_build_log image && \
    package update && \
    package upgrade && \
    package install \
                    ELEMENT_BUILD_DEPS \
                    ELEMENT_RUN_DEPS \
                    && \
    \
    package build go buildtime && \
    package build yq && \
    \
    npm install -g pnpm && \
    \
    clone_git_repo "${ELEMENT_REPO_URL}" "${ELEMENT_VERSION}" /usr/src/element-web && \
    if [ "$PATCH" = "true" ] || [ "$PATCH" = "TRUE" ] || [ "$PATCH" = "True" ] ; then \
        PATCH_VERS="" ; \
        for p in /usr/src/patches/*.patch; do \
            [ -f "$p" ] || continue; \
           name=$(basename $p .patch) && \
        echo "Applying $name..." && \
        if patch -p1 < "$p"; then \
            echo "  OK" && \
            PATCH_VERS="${PATCH_VERS}+${name}"; \
        else \
            echo "  FAILED" && \
            PATCH_VERS="${PATCH_VERS}+${name}-FAILED"; \
        fi; \
    done ; \
    fi && \
    pnpm install && \
    VERSION="${ELEMENT_VERSION}${PATCH_VERS}" pnpm exec nx run apps/web:build && \
    mkdir -p /www/html && \
    cp -R apps/web/webapp/* /www/html/ && \
    \
    container_build_log add "Element" "${ELEMENT_VERSION}" "${ELEMENT_REPO_URL}" && \
    npm uninstall -g pnpm && \
    package remove \
                    ELEMENT_BUILD_DEPS \
                    && \
    package cleanup

COPY rootfs /
