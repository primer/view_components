# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.177.0/containers/ruby/.devcontainer/base.Dockerfile

ARG BUNDLER_VERSION=1.14.7=2.2.11

# [Choice] Ruby version: 3, 3.0, 2, 2.7, 2.6
ARG VARIANT="2.7"
FROM mcr.microsoft.com/vscode/devcontainers/ruby:0-${VARIANT}

# [Option] Install Node.js
ARG INSTALL_NODE="true"
ARG NODE_VERSION="lts/*"
RUN if [ "${INSTALL_NODE}" = "true" ]; then su vscode -c "umask 0002 && . /usr/local/share/nvm/nvm.sh && nvm install ${NODE_VERSION} 2>&1"; fi

# Install bundler
RUN gem install bundler:$BUNDLER_VERSION

# Install yarn
RUN npm install -g yarn

# Setup
RUN script/setup
