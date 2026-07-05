#!/usr/bin/env bash
# daily-maintenance.sh — unattended /ingest + /lint for AI-LLM-Wiki
# Invoked by ~/Library/LaunchAgents/com.yeewl.ai-llm-wiki.maintenance.plist
# Safe to run manually: ./scripts/daily-maintenance.sh

set -uo pipefail

REPO="/Users/yeewl/repo/AI-LLM-Wiki"
LOG_DIR="$REPO/logs"
CLAUDE="/Users/yeewl/.local/bin/claude"
TIMESTAMP=$(date +"%Y-%m-%d_%H%M%S")
LOG_FILE="$LOG_DIR/${TIMESTAMP}-maintenance.log"

# Ensure log dir exists
mkdir -p "$LOG_DIR"

# All output goes to log file; also echoed to stdout (captured by launchd plist StandardOutPath)
exec > >(tee -a "$LOG_FILE") 2>&1

echo "=============================="
echo " AI-LLM-Wiki Daily Maintenance"
echo " $(date)"
echo "=============================="
echo "Repo:   $REPO"
echo "Claude: $CLAUDE ($("$CLAUDE" --version 2>&1 || echo 'version check failed'))"
echo ""

cd "$REPO" || { echo "ERROR: cannot cd to $REPO"; exit 1; }

# Count unprocessed files so we know whether ingest will do real work
UNPROCESSED=$(find raw/ -maxdepth 1 -type f \( -name "*.md" -o -name "*.txt" -o -name "*.pdf" \) 2>/dev/null | wc -l | tr -d ' ')
echo "Unprocessed files in raw/: $UNPROCESSED"
echo ""

# --- /ingest ---
echo "--- /ingest -------------------------------------------------------"
"$CLAUDE" --print \
  --permission-mode bypassPermissions \
  "/ingest"
INGEST_RC=$?
echo ""
echo "ingest exit code: $INGEST_RC"
echo ""

# --- /lint ---
echo "--- /lint ---------------------------------------------------------"
"$CLAUDE" --print \
  --permission-mode bypassPermissions \
  "/lint"
LINT_RC=$?
echo ""
echo "lint exit code: $LINT_RC"
echo ""

echo "=============================="
echo " Done at $(date)"
echo " ingest=$INGEST_RC  lint=$LINT_RC"
echo "=============================="

# Return non-zero only if both commands failed (one failing is survivable)
[[ $INGEST_RC -eq 0 || $LINT_RC -eq 0 ]]
