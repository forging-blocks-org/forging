#!/bin/bash
set -e

# Get latest tag from remote
git fetch --tags
LATEST_TAG=$(git tag --sort=-v:refname | head -n1)

if [ -z "$LATEST_TAG" ]; then
  echo "0.1.0"
  exit 0
fi

# Parse version
IFS='.' read -r MAJOR MINOR PATCH <<< "${LATEST_TAG#v}"

# Bump patch version by default
PATCH=$((PATCH+1))
NEXT_VERSION="$MAJOR.$MINOR.$PATCH"
echo "$NEXT_VERSION"
