#!/bin/bash
# Fix README license mentions across all self-created repos via PR
# - Fix wrong license badges/text (MIT → Apache 2.0)
# - Add license section where missing
# Creates a branch + PR for each repo (respects branch protection)
# Usage: bash scripts/fix-readme-license.sh [--dry-run]

set -euo pipefail

DRY_RUN=false
[[ "${1:-}" == "--dry-run" ]] && DRY_RUN=true

TIER4_REPOS="aastar-docs .github aastar.io research EvaluationAll-AA zu.coffee docs blog mushroomdao.github.io demo-repository courses AI_Beginner_Courses TVdocs"
SKIP_REPOS="my-exploration Brood"

is_tier4() { echo "$TIER4_REPOS" | grep -qw "$1"; }
is_skip() { echo "$SKIP_REPOS" | grep -qw "$1"; }

BRANCH_NAME="chore/fix-readme-license"
COMMIT_MSG="chore: fix README license badge and section to Apache 2.0"
PR_TITLE="chore: fix README license badge — MIT → Apache 2.0"
PR_BODY="## Summary
- Fix incorrect MIT license references in README (actual LICENSE is Apache 2.0)
- Add Apache 2.0 badge where missing
- Add license section where missing

Automated fix via \`scripts/fix-readme-license.sh\`"

APACHE_BADGE='[![License: Apache 2.0](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)'
APACHE_SECTION="## License

Licensed under the [Apache License, Version 2.0](https://opensource.org/licenses/Apache-2.0). See [LICENSE](./LICENSE) for details."

fix_readme() {
    local org=$1 repo=$2

    if is_skip "$repo" || is_tier4 "$repo"; then
        echo "SKIP: $org/$repo"
        return
    fi

    # Get default branch
    local default_branch
    default_branch=$(gh api "repos/$org/$repo" --jq '.default_branch' 2>/dev/null) || {
        echo "ERROR: cannot get default branch for $org/$repo"
        return
    }

    # Get README content and SHA from default branch
    local api_response
    api_response=$(gh api "repos/$org/$repo/contents/README.md?ref=$default_branch" 2>/dev/null) || {
        echo "NO README: $org/$repo"
        return
    }

    local sha readme
    sha=$(echo "$api_response" | jq -r '.sha')
    readme=$(echo "$api_response" | jq -r '.content' | base64 -d 2>/dev/null) || {
        echo "DECODE ERROR: $org/$repo"
        return
    }

    local modified=false
    local new_readme="$readme"

    # === Fix wrong MIT badges ===
    if echo "$new_readme" | grep -q 'License-MIT'; then
        new_readme=$(echo "$new_readme" | sed \
            -e 's|\[!\[License: MIT\](https://img.shields.io/badge/License-MIT-yellow.svg)\](https://opensource.org/licenses/MIT)|'"$APACHE_BADGE"'|g' \
            -e 's|<img src="https://img.shields.io/badge/License-MIT-yellow.svg"[^/]*/>\?|<img src="https://img.shields.io/badge/License-Apache%202.0-blue.svg" alt="License: Apache 2.0" style="display:inline-block; margin-right: 5px;" />|g')
        modified=true
        echo "  FIX badge: MIT → Apache 2.0"
    fi

    # === Fix wrong license section text ===
    if echo "$new_readme" | grep -qE '^\s*(MIT|MIT License)\s*(—|–|-|:)?\s*(see\s+\[LICENSE\]|$)'; then
        new_readme=$(echo "$new_readme" | sed -E \
            -e 's/^MIT\s*(—|–|-)\s*see\s+\[LICENSE\]\(\.\/LICENSE\)/Licensed under the [Apache License, Version 2.0](https:\/\/opensource.org\/licenses\/Apache-2.0). See [LICENSE](.\/LICENSE) for details./g' \
            -e 's/^MIT License$/Licensed under the [Apache License, Version 2.0](https:\/\/opensource.org\/licenses\/Apache-2.0)./g' \
            -e 's/^MIT$/Licensed under the [Apache License, Version 2.0](https:\/\/opensource.org\/licenses\/Apache-2.0). See [LICENSE](.\/LICENSE) for details./g')
        modified=true
        echo "  FIX text: MIT → Apache 2.0"
    fi

    # === Fix tree listing "LICENSE # MIT 许可证" ===
    if echo "$new_readme" | grep -q 'LICENSE.*MIT.*许可证'; then
        new_readme=$(echo "$new_readme" | sed 's/LICENSE.*# MIT 许可证/LICENSE               # Apache 2.0 许可证/g')
        modified=true
        echo "  FIX tree: MIT 许可证 → Apache 2.0 许可证"
    fi

    # === Fix "# MIT License" mentions ===
    if echo "$new_readme" | grep -q '# MIT License'; then
        new_readme=$(echo "$new_readme" | sed 's/MIT License/Apache License 2.0/g')
        modified=true
        echo "  FIX heading: MIT License → Apache License 2.0"
    fi

    # === Add license section if none exists ===
    if ! echo "$new_readme" | grep -qiE '^#{1,3}\s*(License|许可|授权)'; then
        new_readme="$new_readme

$APACHE_SECTION
"
        modified=true
        echo "  ADD: license section"
    fi

    # === Add badge to top if no badge exists ===
    if ! echo "$new_readme" | grep -qiE '(shields\.io.*license|badge.*license|License.*badge)'; then
        local first_line
        first_line=$(echo "$new_readme" | head -1)
        if echo "$first_line" | grep -q '^#'; then
            new_readme=$(echo "$new_readme" | sed "1 a\\
\\
$APACHE_BADGE")
            modified=true
            echo "  ADD: Apache 2.0 badge"
        fi
    fi

    if [ "$modified" = false ]; then
        echo "OK: $org/$repo (no changes needed)"
        return
    fi

    if [ "$DRY_RUN" = true ]; then
        echo "DRY-RUN: $org/$repo would be updated"
        return
    fi

    # --- Create branch, commit, and PR ---

    # Get the SHA of the default branch HEAD
    local head_sha
    head_sha=$(gh api "repos/$org/$repo/git/ref/heads/$default_branch" --jq '.object.sha' 2>/dev/null)

    # Check if branch already exists (delete if so)
    if gh api "repos/$org/$repo/git/ref/heads/$BRANCH_NAME" >/dev/null 2>&1; then
        gh api "repos/$org/$repo/git/refs/heads/$BRANCH_NAME" --method DELETE >/dev/null 2>&1 || true
    fi

    # Create branch
    gh api "repos/$org/$repo/git/refs" \
        --method POST \
        --input - <<< "$(jq -n --arg ref "refs/heads/$BRANCH_NAME" --arg sha "$head_sha" '{ref: $ref, sha: $sha}')" \
        >/dev/null 2>&1 || {
        echo "  FAILED: cannot create branch for $org/$repo"
        return
    }

    # Push README to the new branch
    local content_b64
    content_b64=$(echo "$new_readme" | base64)
    local json
    json=$(jq -n --arg msg "$COMMIT_MSG" --arg content "$content_b64" --arg sha "$sha" --arg branch "$BRANCH_NAME" \
        '{message: $msg, content: $content, sha: $sha, branch: $branch}')

    gh api "repos/$org/$repo/contents/README.md" \
        --method PUT \
        --input - <<< "$json" \
        >/dev/null 2>&1 || {
        echo "  FAILED: cannot push README to $org/$repo"
        return
    }

    # Create PR
    local pr_url
    pr_url=$(gh api "repos/$org/$repo/pulls" \
        --method POST \
        --input - <<< "$(jq -n \
            --arg title "$PR_TITLE" \
            --arg body "$PR_BODY" \
            --arg head "$BRANCH_NAME" \
            --arg base "$default_branch" \
            '{title: $title, body: $body, head: $head, base: $base}')" \
        --jq '.html_url' 2>/dev/null) || {
        echo "  FAILED: cannot create PR for $org/$repo"
        return
    }

    echo "  PR: $pr_url"
}

echo "=== Fixing README license across all repos (via PR) ==="
[ "$DRY_RUN" = true ] && echo "(DRY RUN MODE)"
echo ""

for org in AAStarCommunity MushroomDAO AuraAIHQ; do
    echo "--- $org ---"
    for repo in $(gh repo list "$org" --no-archived --source --json name,isFork,isPrivate --limit 50 -q '.[] | select(.isFork==false and .isPrivate==false) | .name'); do
        echo "$org/$repo:"
        fix_readme "$org" "$repo"
    done
    echo ""
done

echo "=== Done ==="
