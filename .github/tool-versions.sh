#!/usr/bin/env bash
# Prints the newest upstream version of every tool that this image installs
# with "latest" or "lts", one line per tool: <name>=<version>.
# The release workflow rebuilds the image when a version changes.
set -uo pipefail

# Deno: newest LTS release, like "deno upgrade lts" and the deno feature
deno_lts() {
    curl -fsSL https://dl.deno.land/release-lts-latest.txt ||
        curl -fsSL https://dl.deno.land/release-latest.txt
}

echo "deno=$(deno_lts 2>/dev/null | head -n 1 | tr -d '[:space:]')"
