#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <issue-number>" >&2
  exit 2
fi

issue_number="$1"
if ! [[ "$issue_number" =~ ^[0-9]+$ ]]; then
  echo "issue-number must be a positive integer" >&2
  exit 2
fi

gh api graphql \
  -F owner='{owner}' \
  -F repo='{repo}' \
  -F number="$issue_number" \
  -f query='
query IssueRelationships($owner: String!, $repo: String!, $number: Int!) {
  repository(owner: $owner, name: $repo) {
    issue(number: $number) {
      number
      title
      url
      state
      parent {
        number
        title
        url
        state
      }
      subIssues(first: 50) {
        nodes {
          number
          title
          url
          state
        }
      }
      trackedInIssues(first: 50) {
        nodes {
          number
          title
          url
          state
        }
      }
      trackedIssues(first: 50) {
        nodes {
          number
          title
          url
          state
        }
      }
      blockedBy(first: 50) {
        nodes {
          number
          title
          url
          state
        }
      }
      blocking(first: 50) {
        nodes {
          number
          title
          url
          state
        }
      }
      issueDependenciesSummary {
        blockedBy
        blocking
        totalBlockedBy
        totalBlocking
      }
    }
  }
}
'
