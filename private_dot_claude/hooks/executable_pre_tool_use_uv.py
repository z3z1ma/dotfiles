#!/usr/bin/env python3
# /// script
# requires-python = ">=3.8"
# dependencies = []
# ///
"""
Pre-tool use hook for Claude Code to guide UV usage in Python projects.
Since PreToolUse hooks cannot modify commands (Claude Code limitation),
this hook provides helpful guidance when Python commands are used in UV projects.
"""

import json
import os
import re
import sys
from pathlib import Path
from typing import Any, Dict


class UVCommandHandler:
    """Handle Python commands with UV awareness."""

    def __init__(self):
        self.project_root = Path.cwd()
        self.has_uv = self.check_uv_available()
        self.in_project = self.check_in_project()

    def check_uv_available(self) -> bool:
        """Check if UV is available in PATH."""
        return os.system("which uv > /dev/null 2>&1") == 0

    def check_in_project(self) -> bool:
        """Check if we're in a Python project with pyproject.toml."""
        return (self.project_root / "pyproject.toml").exists()

    def analyze_command(self, command: str) -> Dict[str, Any]:
        """Analyze command to determine how to handle it."""
        # Check if command already uses uv
        if command.strip().startswith("uv"):
            return {"action": "approve", "reason": "Already using uv"}

        # Skip non-Python commands entirely
        # Common commands that should never be blocked
        skip_prefixes = [
            "git ",
            "cd ",
            "ls ",
            "cat ",
            "echo ",
            "grep ",
            "find ",
            "mkdir ",
            "rm ",
            "cp ",
            "mv ",
        ]
        if any(command.strip().startswith(prefix) for prefix in skip_prefixes):
            return {"action": "approve", "reason": "Not a Python command"}

        # Check for actual Python command execution (not just mentions)
        python_exec_patterns = [
            r"^python3?\s+",  # python script.py
            r"^python3?\s*$",  # just python
            r"\|\s*python3?\s+",  # piped to python
            r";\s*python3?\s+",  # after semicolon
            r"&&\s*python3?\s+",  # after &&
            r"^pip3?\s+",  # pip commands
            r"\|\s*pip3?\s+",  # piped pip
            r";\s*pip3?\s+",  # after semicolon
            r"&&\s*pip3?\s+",  # after &&
            r"^(pytest|ruff|mypy|black|flake8|isort)\s+",  # dev tools
            r";\s*(pytest|ruff|mypy|black|flake8|isort)\s+",
            r"&&\s*(pytest|ruff|mypy|black|flake8|isort)\s+",
        ]

        is_python_exec = any(
            re.search(pattern, command) for pattern in python_exec_patterns
        )

        if not is_python_exec:
            return {"action": "approve", "reason": "Not a Python execution command"}

        # If we're in a UV project, provide guidance
        if self.has_uv and self.in_project:
            # Parse command to provide better suggestions
            suggestion = self.suggest_uv_command(command)
            return {
                "action": "block",
                "reason": f"This project uses UV for Python management. {suggestion}",
            }

        # Otherwise, let it through
        return {"action": "approve", "reason": "UV not required"}

    def suggest_uv_command(self, command: str) -> str:
        """Provide UV command suggestions."""
        # Handle compound commands (e.g., cd && python)
        if "&&" in command:
            parts = command.split("&&")
            transformed_parts = []

            for part in parts:
                part = part.strip()
                # Only transform the Python-related parts
                if re.search(r"\b(python3?|pip3?|pytest|ruff|mypy|black)\b", part):
                    transformed_parts.append(self._transform_single_command(part))
                else:
                    transformed_parts.append(part)

            return f"Try: {' && '.join(transformed_parts)}"

        # Simple commands
        return f"Try: {self._transform_single_command(command)}"

    def _transform_single_command(self, command: str) -> str:
        """Transform a single Python command to use UV."""
        # Python execution
        if re.match(r"^python3?\s+", command):
            return re.sub(r"^python3?\s+", "uv run python ", command)

        # Package installation
        elif re.match(r"^pip3?\s+install\s+", command):
            return re.sub(r"^pip3?\s+install\s+", "uv add ", command)

        # Other pip commands
        elif re.match(r"^pip3?\s+", command):
            return re.sub(r"^pip3?\s+", "uv pip ", command)

        # Development tools
        elif re.match(r"^(pytest|ruff|mypy|black|flake8|isort)\s+", command):
            return f"uv run {command}"

        return command


def main():
    """Main hook function."""
    try:
        # Read input from Claude Code
        input_data = json.loads(sys.stdin.read())

        # Only process Bash/Run commands
        tool_name = input_data.get("tool_name", "")
        if tool_name not in ["Bash", "Run"]:
            # Approve non-Bash tools
            output = {"decision": "approve"}
            print(json.dumps(output))
            return

        # Get the command
        tool_input = input_data.get("tool_input", {})
        command = tool_input.get("command", "")

        if not command:
            # Approve empty commands
            output = {"decision": "approve"}
            print(json.dumps(output))
            return

        # Analyze command
        handler = UVCommandHandler()
        result = handler.analyze_command(command)

        # Return decision
        output = {"decision": result["action"], "reason": result["reason"]}

        print(json.dumps(output))

    except Exception as e:
        # On error, approve to avoid blocking workflow
        output = {"decision": "approve", "reason": f"Hook error: {str(e)}"}
        print(json.dumps(output))


if __name__ == "__main__":
    main()
