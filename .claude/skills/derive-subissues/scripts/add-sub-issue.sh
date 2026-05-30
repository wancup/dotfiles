#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <parent_issue_id> <sub_issue_url>" >&2
  exit 1
fi

issue_id="$1"
sub_issue_url="$2"

gh api graphql \
  -f query="mutation(\$issueId: ID!, \$subIssueUrl: String!) { addSubIssue(input: {issueId: \$issueId, subIssueUrl: \$subIssueUrl}) { issue { number } subIssue { number } } }" \
  -F issueId="$issue_id" \
  -F subIssueUrl="$sub_issue_url"
