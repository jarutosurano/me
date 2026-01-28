#!/usr/bin/env bash
#
# PreToolUse hook: Block modifications to protected project files.
# Protects README.md and other important files from accidental changes.
#

set -euo pipefail

# Read JSON input from stdin
INPUT=$(cat)

# Extract tool name
TOOL_NAME=$(echo "$INPUT" | python3 -c "import sys, json; print(json.load(sys.stdin).get('tool_name', ''))" 2>/dev/null || echo "")

# Only check Edit and Write operations (not Read)
if [[ "$TOOL_NAME" != "Edit" && "$TOOL_NAME" != "Write" ]]; then
    exit 0
fi

# Extract the file path
FILE_PATH=$(echo "$INPUT" | python3 -c "import sys, json; print(json.load(sys.stdin).get('tool_input', {}).get('file_path', ''))" 2>/dev/null || echo "")

# Get basename for comparison
BASENAME=$(basename "$FILE_PATH" 2>/dev/null || echo "")
LOWER_BASENAME=$(echo "$BASENAME" | tr '[:upper:]' '[:lower:]')

# Function to block with reason
block() {
    local reason="$1"
    echo "{\"decision\": \"block\", \"reason\": \"$reason\"}"
    exit 0
}

# Protected files list (add more as needed)
# These files require explicit user permission to modify
PROTECTED_FILES=(
    "readme.md"
    "readme"
    "license"
    "license.md"
    "license.txt"
    "changelog.md"
    "changelog"
    "contributing.md"
    "code_of_conduct.md"
    "security.md"
)

# Check if file is protected
for protected in "${PROTECTED_FILES[@]}"; do
    if [[ "$LOWER_BASENAME" == "$protected" ]]; then
        block "Blocked: '$BASENAME' is a protected file. Ask user for permission to modify."
    fi
done

# Allow the operation (no output)
exit 0
