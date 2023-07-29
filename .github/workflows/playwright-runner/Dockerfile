FROM ubuntu:latest

RUN useradd -d /home/runner -ms /bin/bash -g root -G sudo -p runner runner
RUN mkdir /usr/src/app && chown runner /usr/src/app
VOLUME /usr/src/app

ARG NODE_VERSION
ARG PLAYWRIGHT_VERSION

RUN apt-get update && apt-get install -y curl
RUN curl -sL https://deb.nodesource.com/setup_${NODE_VERSION}.x | bash -
RUN apt-get install nodejs

RUN npm install -g @playwright/test@${PLAYWRIGHT_VERSION}

RUN npx playwright install --with-deps
