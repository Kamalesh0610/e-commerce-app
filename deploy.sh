#!/bin/bash
set -e
set -x

# ./deploy.sh <project name> <version> <branch_name>
# Example:
#   ./deploy.sh e-commerce-app 1 dev
#   ./deploy.sh e-commerce-app 1 main
image_name=$1   
version=$2      
branch_name=$3 

if [ -z "$image_name" ] || [ -z "$version" ] || [ -z "$branch_name" ]; then
  echo "Usage: $0 <image_name> <version> <branch_name>"
  exit 1
fi

# Decide repo based on branch name
if [ "$branch_name" = "main" ]; then
  export DOCKERHUB_REPO="kamalesh0610/prod"
else
  export DOCKERHUB_REPO="kamalesh0610/dev"
fi

export APP_TAG="${version}"

# Pull & start with compose (port 80 exposed in compose)
docker compose pull
docker compose down
docker compose up -d