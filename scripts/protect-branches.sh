#!/bin/bash
# Set branch protection on all self-created repos across 3 orgs
# Rules: require PR to merge, admins/code owners cannot bypass
# Usage: bash scripts/protect-branches.sh

set -euo pipefail

SKIP_REPOS="my-exploration Brood"

is_skip() {
    echo "$SKIP_REPOS" | grep -qw "$1"
}

protect_branch() {
    local org=$1 repo=$2 branch=$3

    if is_skip "$repo"; then
        echo "SKIP: $org/$repo"
        return
    fi

    echo -n "$org/$repo ($branch) → "

    gh api "repos/$org/$repo/branches/$branch/protection" \
        --method PUT \
        --input - <<'JSON' --jq '.enforce_admins.enabled' 2>/dev/null && echo " (enforce_admins=true)" || echo "FAILED"
{
  "required_pull_request_reviews": {
    "dismiss_stale_reviews": true,
    "require_code_owner_reviews": false,
    "required_approving_review_count": 1
  },
  "enforce_admins": true,
  "required_status_checks": null,
  "restrictions": null
}
JSON
}

echo "=== Setting branch protection: require PR + no admin bypass ==="
echo ""

for org in AAStarCommunity MushroomDAO AuraAIHQ; do
    echo "--- $org ---"
    for line in $(gh repo list "$org" --no-archived --source --json name,isFork,defaultBranchRef --limit 50 -q '.[] | select(.isFork==false) | .name + ":" + .defaultBranchRef.name'); do
        repo="${line%%:*}"
        branch="${line##*:}"
        protect_branch "$org" "$repo" "$branch"
    done
    echo ""
done

echo "=== Done ==="
