#!/bin/bash
# github-trending-watch — daily scan of https://github.com/trending
# Clones repos matching the user's interests (skills, hunting, security,
# AI agents, smart contracts). Runs from the github-trending-watch cron.
# Safe by design: shallow clone only, no install scripts, no code execution.
# Only clones into ~/workspace/github-repos/ (skills/research) or
# ~/bugbounty/ (security/hunting). Skips repos already present.
set -u
REPOS_DIR="$HOME/workspace/github-repos"
BOUNTY_DIR="$HOME/bugbounty"
STATE="$HOME/workspace/github-repos/.trending-seen.txt"
LOG="$HOME/workspace/github-repos/.trending-watch.log"
mkdir -p "$REPOS_DIR" "$BOUNTY_DIR"
touch "$STATE"
echo "=== $(date '+%Y-%m-%d %H:%M %Z') trending watch ===" >> "$LOG"

# Fetch trending (daily). GitHub trending page is HTML; extract owner/repo.
HTML=$(curl -sL -m 30 -A "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36" "https://github.com/trending?since=daily")
if [ -z "$HTML" ]; then echo "fetch failed (empty)" >> "$LOG"; exit 0; fi
# Repo links look like href="/owner/repo" — grab them, dedupe, keep order.
REPOS=$(echo "$HTML" | grep -oE 'href="/[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+"' | sed 's/href="\///; s/"$//' | awk '!seen[$0]++' | head -30)
if [ -z "$REPOS" ]; then echo "no repos parsed" >> "$LOG"; exit 0; fi

# Interest keywords (lowercase match against owner/repo + description).
# Skills / hunting / security / agents / contracts — the user's lanes.
KEYWORDS='skill|hunt|bounty|bughunt|pentest|pen-test|security|audit|solidity|smart-contract|exploit|recon|agent|mcp|claude|redteam|red-team|fuzz|scanner|vuln|ctf|osint|payload|jailbreak|prompt-inject|llm|evasion|bypass'
CLONED=""
SKIPPED=0
for R in $REPOS; do
  # Skip if already cloned anywhere (either dir) or already seen.
  NAME=$(echo "$R" | tr '/' '_')
  BASE=$(basename "$R")
  if [ -d "$REPOS_DIR/$NAME" ] || [ -d "$BOUNTY_DIR/$NAME" ] || [ -d "$REPOS_DIR/$BASE" ] || [ -d "$BOUNTY_DIR/$BASE" ]; then
    SKIPPED=$((SKIPPED+1)); continue
  fi
  # Interest check: match keywords against the repo path (owner/repo).
  # Description is not in the link list, so match on the name only here;
  # the daily report lets the user judge the rest.
  if ! echo "$R" | grep -qiE "$KEYWORDS"; then
    # Not a keyword match — record as seen so we don't re-check daily.
    grep -qx "$R" "$STATE" || echo "$R" >> "$STATE"
    continue
  fi
  # Decide destination: security/hunting repos go to ~/bugbounty, the rest
  # (skills/research/agents) to ~/workspace/github-repos.
  if echo "$R" | grep -qiE 'hunt|bounty|pentest|security|audit|exploit|recon|redteam|vuln|bypass|osint|payload'; then
    DEST="$BOUNTY_DIR/$NAME"
  else
    DEST="$REPOS_DIR/$NAME"
  fi
  if git clone --depth 1 "https://github.com/$R.git" "$DEST" >> "$LOG" 2>&1; then
    CLONED="$CLONED $R"
    echo "$R" >> "$STATE"
    echo "CLONED $R -> $DEST" >> "$LOG"
  else
    echo "CLONE FAILED $R" >> "$LOG"
    rm -rf "$DEST"
  fi
done
echo "scanned $(echo "$REPOS" | wc -l) trending repos, skipped $SKIPPED already-cloned, cloned:${CLONED:- none}" >> "$LOG"
# Print a short summary for the cron handoff.
echo "Trending watch $(date '+%Y-%m-%d'): cloned:${CLONED:- none}"
