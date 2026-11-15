# Framework multi-agente — portfolio_ls

> **Fuente de verdad del framework:** este directorio `.agents/` (skills, agents, rules, hooks).  
> Cursor consume la misma config vía symlinks en `.cursor/`.


Índice del sistema de orquestación para el portafolio Flutter + Firebase, enriquecido con skills de proceso de [caveman](https://github.com/JuliusBrussee/caveman).

## Por qué las skills no se reconocían

Cursor **no** carga skills como archivos sueltos `.md`. El formato requerido es:

```
.cursor/skills/<nombre-skill>/SKILL.md
```

con frontmatter YAML (`name`, `description`). En este repo la **fuente versionable** es `.agents/skills/`; `.cursor/skills/` mantiene copias o **symlinks** hacia ahí.

## Estructura

```
.agents/skills/                 ← fuente de skills (repo)
│   ├── orquestacion-portfolio/ ← routing proceso + dominio
│   ├── arquitectura-estado|seguridad-firebase|optimizacion-web
│   └── caveman* | investigate-first | lean-build | …
.cursor/
├── README.md
├── hooks.json
├── agents/                     ← sub-agentes (Task /slash)
│   ├── orchestrator.md
│   ├── agent-firebase-expert.md
│   ├── agent-flutter-logic.md
│   ├── agent-ui-expert.md
│   ├── cavecrew-investigator.md
│   ├── cavecrew-builder.md
│   └── cavecrew-reviewer.md
├── skills/                     ← descubrimiento Cursor (symlink → .agents/skills)
├── rules/
│   └── portfolio-orchestrator.mdc   (alwaysApply)
└── hooks/
```

Lock de paquetes caveman: `skills-lock.json` (raíz del repo).

## Flujo obligatorio

```
Requerimiento
  → Clasificar PROCESO (caveman) + DOMINIO (portfolio)
  → Orquestador planifica y delega
  → Sub-agentes / cavecrew ejecutan
  → Integración
  → verify-and-stop + checklist (bloqueante)
  → Cierre explícito
```

## Agentes

| Agente | Especialidad |
| --- | --- |
| **orchestrator** | Analizar, rutar skills, delegar, validar |
| **agent-firebase-expert** | Firestore, Rules, Functions |
| **agent-flutter-logic** | Clean Architecture, estado |
| **agent-ui-expert** | Flutter Web UI / a11y |
| **cavecrew-investigator** | Ubicar código (read-only) |
| **cavecrew-builder** | Parche ≤2 archivos |
| **cavecrew-reviewer** | Review comprimido |

## Skills

### Dominio (portfolio)

| Skill | Cuándo |
| --- | --- |
| `orquestacion-portfolio` | Todo trabajo: elige proceso + dominio |
| `arquitectura-estado` | Providers, repos, dominio |
| `seguridad-firebase` | Rules, keys, Functions |
| `optimizacion-web` | Widgets, assets, renderer |

### Proceso (caveman)

| Skill | Cuándo |
| --- | --- |
| `investigate-first` | Causa desconocida — antes de editar |
| `lean-build` | Feature / slice sin overbuild |
| `surgical-patch` | Bug/cambio chico, sitio conocido |
| `safe-refactor` | Refactor con prueba antes/después |
| `verify-and-stop` | Gate de cierre |
| `caveman-explore` | Orientación / localización |
| `caveman-review` | Review de diff |
| `cavecrew` | Cuándo usar investigator/builder/reviewer |
| `caveman` / `ultracave` | Voz corta (opcional) |
| `caveman-commit` | Solo si el usuario pide commit |

## Matriz rápida

| Pedido | Proceso | Dominio / agentes |
| --- | --- | --- |
| Bug sin causa clara | `investigate-first` | investigator → experto de capa |
| Bug chico | `surgical-patch` | builder o experto |
| Feature | `lean-build` | Firebase → Logic → UI |
| Refactor | `safe-refactor` | flutter-logic (+ otros) |
| Solo validar | `verify-and-stop` | orquestador |
| Review | `caveman-review` | cavecrew-reviewer |

## Hooks

| Evento | Efecto |
| --- | --- |
| `sessionStart` | Contexto orquestador + caveman |
| `beforeShellExecution` | Bloquea force-push/reset; confirma `firebase deploy` |
| `afterFileEdit` | Recuerda skills proceso + dominio |
| `subagentStop` | Follow-up checklist (incluye cavecrew) |
| `stop` | Extension point |

## Cómo verificar en Cursor

1. **Skills**: deben aparecer las de dominio + proceso (vía `.cursor/skills` / `.agents/skills`).
2. **Agents**: `/orchestrator`, expertos, `/cavecrew-investigator`, etc.
3. **Rules**: `portfolio-orchestrator` en Always Apply.
4. Reinicia Cursor si no cargan hooks o skills nuevas.
