#!/usr/bin/env python3
"""
PreToolUse hook: Block access to sensitive files.
Blocks Read/Edit/Write operations on secrets, credentials, and keys.
"""

import json
import sys
import os
import re

# Patterns for sensitive files
BLOCKED_EXACT = {
    ".env",
    "secrets.json",
    "credentials.json",
    "id_rsa",
    "id_ed25519",
    "id_dsa",
    "id_ecdsa",
}

BLOCKED_EXTENSIONS = {".pem", ".key"}

BLOCKED_PATTERNS = [
    r"\.env\.[^.]+$",  # .env.* files (but we'll allow .env.example)
    r"secret",
    r"credential",
    r"password",
]

ALLOWED_PATTERNS = [
    r"\.env\.example$",
    r"\.env\.sample$",
    r"\.env\.template$",
]


def is_sensitive_file(file_path: str) -> tuple[bool, str]:
    """Check if a file path is sensitive. Returns (is_blocked, reason)."""
    if not file_path:
        return False, ""

    # Normalize path
    file_path = os.path.normpath(file_path)
    basename = os.path.basename(file_path)
    lower_path = file_path.lower()
    lower_basename = basename.lower()

    # Check allowed patterns first (allowlist)
    for pattern in ALLOWED_PATTERNS:
        if re.search(pattern, lower_basename):
            return False, ""

    # Check exact matches
    if lower_basename in {f.lower() for f in BLOCKED_EXACT}:
        return True, f"Access to '{basename}' is blocked (sensitive file)"

    # Check extensions
    _, ext = os.path.splitext(lower_basename)
    if ext in BLOCKED_EXTENSIONS:
        return True, f"Access to '*{ext}' files is blocked (key/certificate)"

    # Check patterns
    for pattern in BLOCKED_PATTERNS:
        if re.search(pattern, lower_path, re.IGNORECASE):
            return True, f"Access blocked: path contains sensitive pattern"

    return False, ""


def main():
    # Read hook input from stdin
    try:
        hook_input = json.load(sys.stdin)
    except json.JSONDecodeError:
        # If we can't parse input, allow the operation
        sys.exit(0)

    tool_name = hook_input.get("tool_name", "")
    tool_input = hook_input.get("tool_input", {})

    # Only check file operations
    if tool_name not in ("Read", "Edit", "Write"):
        sys.exit(0)

    # Get the file path from the tool input
    file_path = tool_input.get("file_path", "")

    is_blocked, reason = is_sensitive_file(file_path)

    if is_blocked:
        # Output JSON to block the operation
        result = {
            "decision": "block",
            "reason": reason,
        }
        print(json.dumps(result))
        sys.exit(0)

    # Allow the operation (no output needed)
    sys.exit(0)


if __name__ == "__main__":
    main()
