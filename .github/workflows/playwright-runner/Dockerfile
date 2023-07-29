FROM ubuntu:latest

ARG NODE_VERSION
ARG PLAYWRIGHT_VERSION

RUN apt-get update && apt-get install -y curl
RUN curl -sL https://deb.nodesource.com/setup_${NODE_VERSION}.x | bash -
RUN apt-get install nodejs

RUN npm install -g playwright@${PLAYWRIGHT_VERSION}
RUN npm install -g @playwright/test@${PLAYWRIGHT_VERSION}

RUN npx playwright install --with-deps
