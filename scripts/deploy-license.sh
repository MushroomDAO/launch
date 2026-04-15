#!/bin/bash
# Deploy LICENSE, NOTICE, TRADEMARK.md to all self-created repos across 3 orgs
# Usage: bash scripts/deploy-license.sh

set -euo pipefail

LICENSE_FILE="docs/license/LICENSE-commons-clause.txt"  # Now pure Apache 2.0
NOTICE_TEMPLATE="docs/license/NOTICE-template.txt"
TRADEMARK_FILE="docs/license/TRADEMARK.md"

COMMIT_MSG="chore: add Apache 2.0 license + NOTICE + TRADEMARK

- Apache 2.0 (OSI-approved open source)
- NOTICE: attribution requirement per Section 4(d)
- TRADEMARK.md: brand protection policy
- CLA required for all contributions

Part of MushroomDAO license unification.
See: https://github.com/MushroomDAO/launch/tree/main/docs/license"

# Tier 4 repos get CC BY-SA 4.0 instead
TIER4_REPOS="aastar-docs .github aastar.io research EvaluationAll-AA zu.coffee docs blog mushroomdao.github.io demo-repository courses AI_Beginner_Courses TVdocs"

# Skip repos (github config, too small, or special)
SKIP_REPOS="my-exploration Brood"

is_tier4() {
    echo "$TIER4_REPOS" | grep -qw "$1"
}

is_skip() {
    echo "$SKIP_REPOS" | grep -qw "$1"
}

# Encode file to base64 for GitHub API
encode_file() {
    base64 < "$1"
}

# Get SHA of existing file (empty if not exists)
get_file_sha() {
    local org=$1 repo=$2 path=$3
    gh api "repos/$org/$repo/contents/$path" --jq '.sha' 2>/dev/null || echo ""
}

# Create or update a file via GitHub API
upsert_file() {
    local org=$1 repo=$2 filepath=$3 content_b64=$4 message=$5
    local sha
    sha=$(get_file_sha "$org" "$repo" "$filepath")

    local json
    if [ -n "$sha" ]; then
        json=$(jq -n --arg msg "$message" --arg content "$content_b64" --arg sha "$sha" \
            '{message: $msg, content: $content, sha: $sha}')
    else
        json=$(jq -n --arg msg "$message" --arg content "$content_b64" \
            '{message: $msg, content: $content}')
    fi

    gh api "repos/$org/$repo/contents/$filepath" \
        --method PUT \
        --input - <<< "$json" \
        --jq '.content.html_url' 2>/dev/null || echo "FAILED: $org/$repo/$filepath"
}

# Process a single repo
process_repo() {
    local org=$1 repo=$2

    if is_skip "$repo"; then
        echo "SKIP: $org/$repo"
        return
    fi

    echo "Processing: $org/$repo"

    # Generate NOTICE with repo name
    local notice_content
    notice_content=$(sed "s/\[REPO_NAME\]/$repo/" "$NOTICE_TEMPLATE")
    local notice_b64
    notice_b64=$(echo "$notice_content" | base64)

    if is_tier4 "$repo"; then
        # Tier 4: CC BY-SA 4.0 — just add NOTICE and TRADEMARK
        echo "  [Tier 4: docs/community] Adding NOTICE + TRADEMARK only"
        upsert_file "$org" "$repo" "NOTICE" "$notice_b64" "$COMMIT_MSG"
        upsert_file "$org" "$repo" "TRADEMARK.md" "$(encode_file "$TRADEMARK_FILE")" "$COMMIT_MSG"
    else
        # Tier 1/2/3: Apache 2.0
        echo "  [Apache 2.0] Adding LICENSE + NOTICE + TRADEMARK"
        upsert_file "$org" "$repo" "LICENSE" "$(encode_file "$LICENSE_FILE")" "$COMMIT_MSG"
        upsert_file "$org" "$repo" "NOTICE" "$notice_b64" "$COMMIT_MSG"
        upsert_file "$org" "$repo" "TRADEMARK.md" "$(encode_file "$TRADEMARK_FILE")" "$COMMIT_MSG"
    fi

    echo "  Done: $org/$repo"
}

echo "=== Deploying license to all repos ==="
echo ""

# AAStarCommunity
for repo in $(gh repo list AAStarCommunity --no-archived --source --json name,isFork --limit 50 -q '.[] | select(.isFork==false) | .name'); do
    process_repo "AAStarCommunity" "$repo"
done

echo ""

# MushroomDAO
for repo in $(gh repo list MushroomDAO --no-archived --source --json name,isFork --limit 50 -q '.[] | select(.isFork==false) | .name'); do
    process_repo "MushroomDAO" "$repo"
done

echo ""

# AuraAIHQ
for repo in $(gh repo list AuraAIHQ --no-archived --source --json name,isFork --limit 50 -q '.[] | select(.isFork==false) | .name'); do
    process_repo "AuraAIHQ" "$repo"
done

echo ""
echo "=== License deployment complete ==="
