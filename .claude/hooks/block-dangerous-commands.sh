#!/usr/bin/env bash
#
# PreToolUse hook: Block dangerous bash commands.
# Blocks destructive commands like rm -rf, force push, etc.
#

set -euo pipefail

# Read JSON input from stdin
INPUT=$(cat)

# Extract tool name
TOOL_NAME=$(echo "$INPUT" | python3 -c "import sys, json; print(json.load(sys.stdin).get('tool_name', ''))" 2>/dev/null || echo "")

# Only check Bash tool
if [[ "$TOOL_NAME" != "Bash" ]]; then
    exit 0
fi

# Extract the command
COMMAND=$(echo "$INPUT" | python3 -c "import sys, json; print(json.load(sys.stdin).get('tool_input', {}).get('command', ''))" 2>/dev/null || echo "")

# Function to block with reason
block() {
    local reason="$1"
    echo "{\"decision\": \"block\", \"reason\": \"$reason\"}"
    exit 0
}

# Check for dangerous patterns

# rm -rf with dangerous targets
if echo "$COMMAND" | grep -qE 'rm\s+(-[a-zA-Z]*r[a-zA-Z]*f|-[a-zA-Z]*f[a-zA-Z]*r)\s+(/|~|\.|/\*|~/\*|\.\*)'; then
    block "Blocked: 'rm -rf' with dangerous target (/, ~, or .)"
fi

# Force push to main/master
if echo "$COMMAND" | grep -qE 'git\s+push\s+.*--force.*\s+(main|master)|git\s+push\s+.*\s+(main|master)\s+.*--force|git\s+push\s+-f\s+.*(main|master)'; then
    block "Blocked: force push to main/master branch"
fi

# chmod 777
if echo "$COMMAND" | grep -qE 'chmod\s+777'; then
    block "Blocked: 'chmod 777' is insecure"
fi

# Piping curl/wget to shell
if echo "$COMMAND" | grep -qE 'curl\s+.*\|\s*(bash|sh|zsh)|wget\s+.*\|\s*(bash|sh|zsh)'; then
    block "Blocked: piping curl/wget to shell is dangerous"
fi

# cat .env (reading env files via bash)
if echo "$COMMAND" | grep -qE '(cat|less|more|head|tail)\s+.*\.env(\s|$|;|\|)'; then
    block "Blocked: reading .env files via shell commands"
fi

# Allow the command (no output)
exit 0
