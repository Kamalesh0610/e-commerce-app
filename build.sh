#!/bin/bash
set -e
set -x

# ./build.sh <project name> <version> <branch_name>
# Example:
#   ./build.sh e-commerce-app 1 dev
#   ./build.sh e-commerce-app 1 main
image_name=$1       
version=$2          
branch_name=$3     

if [ -z "$image_name" ] || [ -z "$version" ] || [ -z "$branch_name" ]; then
  echo "Usage: $0 <image_name> <version> <branch_name>"
  exit 1
fi

# Decide repo based on branch name
if [ "$branch_name" = "main" ]; then
  repo="kamalesh0610/prod"
else
  repo="kamalesh0610/dev"
fi

# Build local image
docker build -t ${image_name}:${version} .

# Tag for Docker Hub
docker tag ${image_name}:${version} ${repo}:${version}
docker tag ${image_name}:${version} ${repo}:latest

# Push
docker push ${repo}:${version}
docker push ${repo}:latest
