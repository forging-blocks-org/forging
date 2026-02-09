#!/bin/bash
set -e

VERSION=$1

if [ -z "$VERSION" ]; then
  echo "Usage: $0 <version>"
  exit 1
fi

CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
if [ "$CURRENT_BRANCH" != "main" ]; then
  echo "Error: Release script must be run from the main branch."
  exit 1
fi

BRANCH="release/v$VERSION"

git pull

git checkout -b "$BRANCH"

git-chglog -o CHANGELOG.md "$VERSION"
git add CHANGELOG.md
git commit -m "chore: update CHANGELOG for v$VERSION"

git push origin "$BRANCH"

echo "Release branch created for v$VERSION. Tag and merge to main to complete the release."
