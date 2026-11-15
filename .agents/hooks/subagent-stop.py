#!/usr/bin/env python3
"""When a portfolio/cavecrew subagent finishes, nudge orchestrator quality gate once."""
import json
import sys

PROJECT_AGENTS = {
    "orchestrator",
    "agent-firebase-expert",
    "agent-flutter-logic",
    "agent-ui-expert",
    "cavecrew-investigator",
    "cavecrew-builder",
    "cavecrew-reviewer",
}


def main() -> None:
    raw = sys.stdin.read()
    try:
        data = json.loads(raw) if raw.strip() else {}
    except json.JSONDecodeError:
        print("{}")
        return

    status = data.get("status")
    loop_count = int(data.get("loop_count") or 0)
    subagent_type = str(data.get("subagent_type") or "")

    if status != "completed" or loop_count > 0:
        print("{}")
        return

    if subagent_type not in PROJECT_AGENTS:
        print("{}")
        return

    files = data.get("modified_files") or []
    files_txt = ", ".join(files[:12]) if files else "(sin archivos listados)"

    followup = (
        f"El sub-agente `{subagent_type}` terminó. Como PORTFOLIO-ORCHESTRATOR: "
        f"integra el entregable, confirma skills de proceso+dominio del plan, "
        f"corre verify-and-stop (y caveman-review si el diff no es trivial) "
        f"y completa la checklist antes de cerrar. Archivos: {files_txt}."
    )
    print(json.dumps({"followup_message": followup}))


if __name__ == "__main__":
    main()
