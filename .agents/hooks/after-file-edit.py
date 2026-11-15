#!/usr/bin/env python3
"""After edits, inject reminders tied to portfolio + caveman process skills."""
import json
import sys
from pathlib import PurePosixPath


def normalize(path: str) -> str:
    p = path.replace("\\", "/")
    marker = "/portfolio-Ls-flutter/"
    if marker in p:
        p = p.split(marker, 1)[1]
    return p.lstrip("./")


def hint_for(path: str) -> str | None:
    p = normalize(path)
    name = PurePosixPath(p).name

    if name in {"firestore.rules", "firebase.json", "firestore.indexes.json"} or "/functions/" in p:
        return (
            "Config Firebase. Dominio: seguridad-firebase. "
            "Proceso: surgical-patch si es cambio mínimo; investigate-first si la falla de Rules no tiene causa clara. "
            "Cierre: verify-and-stop antes de deploy."
        )
    if p.startswith("lib/providers/") or p.startswith("lib/models/") or "/repository" in p.lower():
        return (
            "Capa estado/datos. Dominio: arquitectura-estado. "
            "Proceso: lean-build (feature) / surgical-patch (bug) / safe-refactor (mover ownership). "
            "UI sin I/O; DI por constructor."
        )
    if (
        p.startswith("lib/components/")
        or p.endswith("/lib/portfolio.dart")
        or p.endswith("/lib/main.dart")
        or p in {"lib/portfolio.dart", "lib/main.dart"}
    ):
        return (
            "UI. Dominio: optimizacion-web + arquitectura-estado. "
            "Proceso: lean-build sin polish no pedido; surgical-patch sin rediseño. "
            "Sin datasources en widgets."
        )
    if p.startswith("assets/") or p.startswith("fonts/") or "/assets/" in p or "/fonts/" in p:
        return (
            "Assets/fuentes. Dominio: optimizacion-web. "
            "Comprime imágenes, limita pesos de Poppins, lazy-load offscreen."
        )
    if p.endswith(".arb") or "/l10n/" in p:
        return "i18n. Verifica layouts ES/EN y overflow en móvil (verify-and-stop visual)."
    if p.startswith(".agents/skills/") or p.startswith(".cursor/skills/") or p.startswith(".cursor/agents/"):
        return (
            "Framework/skills. Mantén dual eje proceso+dominio en orquestacion-portfolio; "
            "no rompas symlinks .cursor/skills → .agents/skills."
        )
    return None


def main() -> None:
    raw = sys.stdin.read()
    try:
        data = json.loads(raw) if raw.strip() else {}
    except json.JSONDecodeError:
        print("{}")
        return

    candidates = []
    for key in ("file_path", "path", "file"):
        if data.get(key):
            candidates.append(str(data[key]))
    for edit in data.get("edits") or []:
        if isinstance(edit, dict) and edit.get("file_path"):
            candidates.append(str(edit["file_path"]))

    hints = []
    seen = set()
    for path in candidates:
        msg = hint_for(path)
        if msg and msg not in seen:
            seen.add(msg)
            hints.append(f"- `{path}`: {msg}")

    if not hints:
        print("{}")
        return

    print(json.dumps({
        "additional_context": "Recordatorios post-edit (portfolio_ls + caveman):\n" + "\n".join(hints)
    }))


if __name__ == "__main__":
    main()
