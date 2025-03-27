#!/bin/bash

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "Error: Not inside a Git repository."
  exit 1
fi

if ! command -v gh &> /dev/null; then
    echo "Error: GitHub CLI (gh) not found. Please install it. See https://cli.github.com/"
    exit 1
fi

if ! command -v xdg-open &> /dev/null; then
    echo "Warning: xdg-open command not found. Cannot automatically open browser."
fi

BRANCH=$(git rev-parse --abbrev-ref HEAD)
if [ "$BRANCH" == "master" ] || [ "$BRANCH" == "main" ]; then
  echo "Error: Cannot create PR from master/main branch."
  exit 1
fi

echo "Fetching latest changes from origin..."
git fetch origin

LAST_COMMIT_MSG=$(git log -1 --pretty=%s)
PR_TITLE="$BRANCH: $LAST_COMMIT_MSG"

UPDATED_FILES=$(git diff --name-only origin/master...HEAD)
if [ -z "$UPDATED_FILES" ]; then
    echo "Warning: No file changes detected between origin/master and HEAD."
fi

# Create a truncated diff with a maximum of 20 lines
DIFF_OUTPUT=$(git diff --patch origin/master...HEAD | head -n 20)
if [ $(git diff --patch origin/master...HEAD | wc -l) -gt 20 ]; then
    DIFF_OUTPUT="$DIFF_OUTPUT\n...(diff truncated for brevity)..."
fi

PR_DESCRIPTION="### Changes in this PR:
\`\`\`diff
$DIFF_OUTPUT
\`\`\`

---
Files changed:
\`\`\`
$UPDATED_FILES
\`\`\`"

echo "Creating Pull Request..."
echo "Title: $PR_TITLE"

# Create PR and store output in a temporary file to avoid command line length issues
PR_TEMP_FILE=$(mktemp)
echo "$PR_DESCRIPTION" > "$PR_TEMP_FILE"

PR_URL=$(gh pr create --base master --head "$BRANCH" --title "$PR_TITLE" --body-file "$PR_TEMP_FILE")
EXIT_STATUS=$?

rm -f "$PR_TEMP_FILE"

if [ $EXIT_STATUS -eq 0 ]; then
  echo "Pull request created successfully!"
  echo "URL: $PR_URL"

  if command -v xdg-open &> /dev/null && [ -n "$PR_URL" ]; then
      echo "Opening PR in browser..."
      xdg-open "$PR_URL"
  elif [ -n "$PR_URL" ]; then
      echo "Please open the PR manually: $PR_URL"
  fi
else
  echo "Failed to create pull request."
  exit 1
fi

exit 0
