---
name: orquestacion-portfolio
description: >-
  Routing del PORTFOLIO-ORCHESTRATOR: elige skill de proceso (caveman) + skill de
  dominio + sub-agente. Use when starting any feature, bugfix, refactor, review,
  investigation, or multi-agent work in this Flutter+Firebase portfolio.
---

# Skill: Orquestación portfolio + caveman

Une el framework multi-agente del repo con las skills de proceso de [caveman](https://github.com/JuliusBrussee/caveman).

**Owner:** `PORTFOLIO-ORCHESTRATOR`  
**Spec completa:** `.cursor/agents/orchestrator.md`

## Dos ejes (obligatorio)

Todo requerimiento se clasifica en **ambos** ejes antes de editar:

| Eje | Qué decide | Catálogo |
| --- | --- | --- |
| **Proceso** (cómo trabajar) | Skill caveman de modo | abajo |
| **Dominio** (qué capa) | Skill portfolio + sub-agente | `arquitectura-estado` / `seguridad-firebase` / `optimizacion-web` |

Sin skill de proceso → riesgo de overbuild o parche ciego.  
Sin skill de dominio → riesgo de romper Clean Architecture / Rules / Web.

## Matriz proceso (caveman)

| Señal del pedido | Skill de proceso | Agente táctico |
| --- | --- | --- |
| Causa desconocida, intermitente, “no sé por qué” | `investigate-first` | `cavecrew-investigator` → luego dominio |
| Ubicar símbolo / callers / mapa de carpeta | `caveman-explore` | `cavecrew-investigator` |
| Bug o cambio chico, sitio ya conocido | `surgical-patch` | `cavecrew-builder` (≤2 archivos) o experto de capa |
| Feature / slice / integración nueva | `lean-build` | expertos de capa (Firebase → Logic → UI) |
| Extraer / mover ownership / cleanup estructural | `safe-refactor` | `agent-flutter-logic` (+ UI/Firebase si cruza) |
| Solo validar / “¿está listo?” / gate | `verify-and-stop` | orquestador (sin editar producto) |
| Review de diff/PR | `caveman-review` | `cavecrew-reviewer` |
| Commit (solo si el usuario lo pide) | `caveman-commit` | orquestador |
| Respuestas más cortas en sesión | `caveman` / `ultracave` | todos (voz); código intacto |

### Encadenados recomendados

```
Investigación → fix:
  investigate-first → cavecrew-investigator → surgical-patch → verify-and-stop
  (+ caveman-review si el diff no es trivial)

Feature:
  lean-build → (Firebase) → (Logic) → (UI) → verify-and-stop → caveman-review

Refactor:
  safe-refactor → verify-and-stop

Orientación fría:
  caveman-explore / cavecrew-investigator  (sin editar)
```

## Matriz dominio (portfolio)

| Señal | Skill dominio | Sub-agente |
| --- | --- | --- |
| Firestore, Rules, Functions, Auth, Hosting | `seguridad-firebase` | `agent-firebase-expert` |
| Providers, repos, use cases, Dart | `arquitectura-estado` | `agent-flutter-logic` |
| Widgets, layout web, a11y, assets | `optimizacion-web` | `agent-ui-expert` |
| Cruza capas | todas las aplicables | Firebase → Logic → UI |

## Reglas de precedencia

1. Si la causa no está clara → **bloquea edición** hasta `investigate-first`.
2. `cavecrew-builder` solo con path conocido y ≤2 archivos; si no → investigator o experto de capa.
3. Feature 3+ archivos / cross-cutting → **no** builder; usar `lean-build` + expertos portfolio.
4. Conflicto UI vs lógica → gana `arquitectura-estado`.
5. Conflicto velocidad vs seguridad Firebase → gana `seguridad-firebase`.
6. Cierre → `verify-and-stop` + checklist del orquestador. Sin eso, no hay “hecho”.

## Brief mínimo al delegar

```markdown
## Brief
- Proceso: <skill caveman>
- Dominio: <skill portfolio>
- Agente: <sub-agente>
- Objetivo / fuera de alcance:
- Contratos:
- Criterios de aceptación:
- Prueba focal (verify-and-stop):
```

## Paths

Skills viven en `.agents/skills/<nombre>/SKILL.md` (fuente de repo) y se descubren también vía `.cursor/skills/` (symlinks).
