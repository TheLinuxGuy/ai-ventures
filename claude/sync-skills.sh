#!/usr/bin/env bash
set -euo pipefail

# Sync repository-managed Claude assets into a local runtime directory:
# - Global instructions file: CLAUDE.md
# - Skills directory
#
# Default runtime directory in this repo workflow: ~/claude
#
# Usage:
#   ./claude/sync-skills.sh
#   ./claude/sync-skills.sh /custom/runtime-dir
#   ./claude/sync-skills.sh --clean
#   ./claude/sync-skills.sh /custom/runtime-dir --clean

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC_SKILLS_DIR="$SCRIPT_DIR/skills"
SRC_GLOBAL_CLAUDE_MD="$SCRIPT_DIR/CLAUDE.md"
RUNTIME_DIR="$HOME/claude"
CLEAN=false

for arg in "$@"; do
  case "$arg" in
    --clean)
      CLEAN=true
      ;;
    *)
      RUNTIME_DIR="$arg"
      ;;
  esac
done

if [[ ! -d "$SRC_SKILLS_DIR" ]]; then
  echo "Source skills directory not found: $SRC_SKILLS_DIR" >&2
  exit 1
fi

if [[ ! -f "$SRC_GLOBAL_CLAUDE_MD" ]]; then
  echo "Source global CLAUDE.md not found: $SRC_GLOBAL_CLAUDE_MD" >&2
  exit 1
fi

DEST_SKILLS_DIR="$RUNTIME_DIR/skills"
DEST_GLOBAL_CLAUDE_MD="$RUNTIME_DIR/CLAUDE.md"

mkdir -p "$DEST_SKILLS_DIR"

cp "$SRC_GLOBAL_CLAUDE_MD" "$DEST_GLOBAL_CLAUDE_MD"

synced=0
for skill_dir in "$SRC_SKILLS_DIR"/*; do
  [[ -d "$skill_dir" ]] || continue
  skill_name="$(basename "$skill_dir")"

  rm -rf "$DEST_SKILLS_DIR/$skill_name"
  cp -R "$skill_dir" "$DEST_SKILLS_DIR/$skill_name"
  synced=$((synced + 1))
done

if [[ "$CLEAN" == true ]]; then
  for dest_skill in "$DEST_SKILLS_DIR"/*; do
    [[ -d "$dest_skill" ]] || continue
    skill_name="$(basename "$dest_skill")"
    if [[ ! -d "$SRC_SKILLS_DIR/$skill_name" ]]; then
      rm -rf "$dest_skill"
    fi
  done
fi

echo "Synced global CLAUDE.md to $DEST_GLOBAL_CLAUDE_MD"
echo "Synced $synced skill(s) to $DEST_SKILLS_DIR"
if [[ "$CLEAN" == true ]]; then
  echo "Clean mode enabled: removed destination-only skill folders."
fi
