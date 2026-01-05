#!/usr/bin/env python3
# /// script
# requires-python = ">=3.8"
# dependencies = []
# ///
"""
Notification hook for UV-related reminders.
"""

import json
import sys


def main():
    """Main hook function."""
    try:
        # Read input
        input_data = json.loads(sys.stdin.read())
        message = input_data.get("message", "")

        # Check for Python-related permission requests
        python_keywords = ["python", "pip", "install", "package", "dependency"]
        if any(keyword in message.lower() for keyword in python_keywords):
            reminder = "\\n💡 Reminder: Use UV commands (uv run, uv add) instead of pip/python directly."

            # Provide context-specific suggestions
            if "install" in message.lower():
                reminder += "\\n   To add packages: uv add <package_name>"
            if "python" in message.lower() and "run" in message.lower():
                reminder += "\\n   To run Python: uv run python or uv run script.py"

            print(reminder, file=sys.stderr)

        sys.exit(0)

    except Exception as e:
        print(f"Notification hook error: {str(e)}", file=sys.stderr)
        sys.exit(1)


if __name__ == "__main__":
    main()
