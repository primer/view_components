#!/usr/bin/env bash

# [start-readme]
#
# This script sets environment variables with info about the preview app for a given PR
#
# [end-readme]

# ENV VARS NEEDED TO RUN
[[ -z $GITHUB_REPOSITORY ]] && { echo "Missing GITHUB_REPOSITORY. Exiting."; exit 1; }
[[ -z $PR_NUMBER ]] && { echo "Missing PR_NUMBER. Exiting."; exit 1; }
[[ -z $GITHUB_ENV ]] && { echo "Missing GITHUB_ENV. Exiting."; exit 1; }

REPO_NAME="${GITHUB_REPOSITORY#*\/}"
echo "REPO_NAME=${REPO_NAME}" >> $GITHUB_ENV

DEPLOYMENT_NAME="${REPO_NAME}-pr-${PR_NUMBER}"
echo "DEPLOYMENT_NAME=${DEPLOYMENT_NAME}" >> $GITHUB_ENV

APP_NAME="primer-view-components-preview-${PR_NUMBER}"
echo "APP_NAME=${APP_NAME}" >> $GITHUB_ENV

APP_URL="http://${APP_NAME}.eastus.azurecontainer.io"
echo "APP_URL=${APP_URL}" >> $GITHUB_ENV

IMAGE_REPO="${GITHUB_REPOSITORY}/pr-${PR_NUMBER}"
echo "IMAGE_REPO=${IMAGE_REPO}" >> $GITHUB_ENV

IMAGE_URL="primer.azurecr.io/${IMAGE_REPO}"
echo "IMAGE_URL=${IMAGE_URL}" >> $GITHUB_ENV

IMAGE_TAG="${COMMIT_REF}-${GITHUB_RUN_NUMBER}-${GITHUB_RUN_ATTEMPT}"
echo "IMAGE_TAG=${IMAGE_TAG}" >> $GITHUB_ENV

# Image tag is unique to each workflow run so that it always triggers a new deployment
DOCKER_IMAGE="${IMAGE_URL}:${IMAGE_TAG}"
echo "DOCKER_IMAGE=${DOCKER_IMAGE}" >> $GITHUB_ENV
