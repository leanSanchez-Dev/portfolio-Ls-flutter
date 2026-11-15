#!/usr/bin/env python3
"""Inject portfolio multi-agent framework context at session start."""
import json
import sys

def main() -> None:
    try:
        json.load(sys.stdin)
    except Exception:
        pass

    context = """
[portfolio_ls] Framework multi-agente + caveman activo.
- Orquestador: .cursor/agents/orchestrator.md
- Routing: skill orquestacion-portfolio (proceso caveman + dominio portfolio).
- Dominio: agent-firebase-expert | agent-flutter-logic | agent-ui-expert
  → seguridad-firebase | arquitectura-estado | optimizacion-web
- Proceso: investigate-first | lean-build | surgical-patch | safe-refactor | verify-and-stop
  + caveman-explore | caveman-review | cavecrew
- Tácticos: cavecrew-investigator | cavecrew-builder | cavecrew-reviewer
- Skills en .agents/skills/*/SKILL.md (symlinks en .cursor/skills/)
No marques trabajo como completado sin verify-and-stop + checklist del orquestador.
""".strip()

    print(json.dumps({
        "env": {
            "PORTFOLIO_ORCHESTRATOR": "1",
            "PORTFOLIO_FRAMEWORK_ROOT": ".cursor",
            "PORTFOLIO_SKILLS_ROOT": ".agents/skills",
        },
        "additional_context": context,
    }))

if __name__ == "__main__":
    main()
