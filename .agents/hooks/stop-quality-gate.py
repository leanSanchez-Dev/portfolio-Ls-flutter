#!/usr/bin/env python3
"""
stop hook: intentionally does NOT auto-follow-up on every turn (noisy).
Quality gate is enforced by rules + orchestrator + subagentStop.
Kept as an explicit extension point for future audit/telemetry.
"""
import json
import sys


def main() -> None:
    try:
        sys.stdin.read()
    except Exception:
        pass
    print("{}")


if __name__ == "__main__":
    main()
