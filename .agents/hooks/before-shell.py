#!/usr/bin/env python3
"""Gate risky shell commands for the Flutter + Firebase portfolio."""
import json
import re
import sys

DENY_PATTERNS = [
    (r"git\s+push\s+[^\n]*--force", "Force push bloqueado por política del proyecto."),
    (r"git\s+push\s+[^\n]*-f\b", "Force push bloqueado por política del proyecto."),
    (r"git\s+reset\s+--hard", "git reset --hard bloqueado; es destructivo."),
    (r"rm\s+-rf\s+/(?:\s|$)", "Borrado recursivo de raíz bloqueado."),
]

ASK_PATTERNS = [
    (r"firebase\s+deploy", "Deploy Firebase: confirma entorno (dev/prod) y que Rules no estén abiertas."),
    (r"firebase\s+deploy\s+[^\n]*--only\s+[^\n]*firestore", "Deploy de Firestore Rules/índices: revisa deny-by-default antes de continuar."),
    (r"flutter\s+build\s+web[^\n]*--web-renderer\s+html", "Cambio a HTML renderer: requiere QA visual multi-browser."),
]


def main() -> None:
    raw = sys.stdin.read()
    try:
        data = json.loads(raw) if raw.strip() else {}
    except json.JSONDecodeError:
        print(json.dumps({"permission": "allow"}))
        return

    command = data.get("command") or ""

    for pattern, message in DENY_PATTERNS:
        if re.search(pattern, command, flags=re.IGNORECASE):
            print(json.dumps({
                "permission": "deny",
                "user_message": message,
                "agent_message": message + " Usa un enfoque no destructivo o pide confirmación explícita al usuario.",
            }))
            return

    for pattern, message in ASK_PATTERNS:
        if re.search(pattern, command, flags=re.IGNORECASE):
            print(json.dumps({
                "permission": "ask",
                "user_message": message,
                "agent_message": message + " Aplica skill seguridad-firebase / optimizacion-web según corresponda.",
            }))
            return

    print(json.dumps({"permission": "allow"}))


if __name__ == "__main__":
    main()
