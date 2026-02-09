#!/bin/bash
#
# Automated release script for the Forging toolkit
#
# Usage:
#   ./scripts/release.sh [--dry-run]
#
# - Must be run from the main branch after all implementation PRs are merged.
# - Determines the next version automatically.
# - Generates and commits the changelog.
# - Creates a release branch from main.
# - Pushes the release branch to origin.
# - Opens a PR to main with the changelog as the PR body (requires GitHub CLI).
# - In --dry-run mode, prints actions without making changes.
#
# Prerequisites:
#   - git-chglog (https://github.com/git-chglog/git-chglog)
#   - GitHub CLI (https://cli.github.com/)
#
# Example:
#   ./scripts/release.sh         # Real release flow
#   ./scripts/release.sh --dry-run  # Preview actions only
set -e

DRY_RUN=false
while [[ "$1" =~ ^- ]]; do
  case $1 in
    --dry-run) DRY_RUN=true ;;
    *) echo "Unknown option: $1"; exit 1 ;;
  esac
  shift
done

# Check for required tools
gh_installed=$(command -v gh || true)
chglog_installed=$(command -v git-chglog || true)
if [ -z "$gh_installed" ]; then
  echo "Error: GitHub CLI (gh) is required."
  exit 1
fi
if [ -z "$chglog_installed" ]; then
  echo "Error: git-chglog is required."
  exit 1
fi

CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
if [ "$CURRENT_BRANCH" != "main" ]; then
  echo "Error: Release script must be run from the main branch."
  exit 1
fi

echo "Syncing with remote..."
$DRY_RUN || git pull

VERSION=$(./scripts/next_version.sh)
BRANCH="release/v$VERSION"

echo "Creating release branch $BRANCH..."
$DRY_RUN || git checkout -b "$BRANCH"

echo "Generating changelog for v$VERSION..."
$DRY_RUN || git-chglog -o CHANGELOG.md "$VERSION"

$DRY_RUN || git add CHANGELOG.md
$DRY_RUN || git commit -m "chore: update CHANGELOG for v$VERSION"

$DRY_RUN || git push origin "$BRANCH"

CHANGELOG_BODY=$($DRY_RUN && echo "[DRY RUN]" || awk '/^## /{flag=1;next}/^$/{flag=0}flag' CHANGELOG.md | head -n -1)

echo "Opening PR to main..."
$DRY_RUN || gh pr create --base main --head "$BRANCH" --title "Release v$VERSION" --body "$CHANGELOG_BODY"

echo "Release branch and PR created for v$VERSION. Merge the PR to main, then tag the release."
