---
name: arquitectura-estado
description: >-
  Estándares de Clean Architecture, separación UI↔negocio e inyección de dependencias para el portafolio Flutter. Use when editing providers, repositories, use cases, models, state management (Provider/Riverpod), or Dart logic under lib/.
---

# Skill: Arquitectura y Estado

> Estándares obligatorios para separar UI de negocio e inyectar dependencias en `portfolio_ls`.

## Propósito

Garantizar que el portafolio Flutter evolucione con **Clean Architecture** y estado predecible, evitando el acoplamiento actual potencial entre `components/`, `utils/` y fuentes de datos.

**Agentes que deben aplicarla:** `agent-flutter-logic` (owner), `agent-ui-expert` (cumplimiento en presentación), `PORTFOLIO-ORCHESTRATOR` (gate de calidad).

---

## Arquitectura permitida

### Capas

| Capa | Responsabilidad | Ejemplos en este repo |
| --- | --- | --- |
| **Presentation** | Widgets, layout, animaciones, binding al estado | `lib/components/`, `lib/portfolio.dart`, listeners de Provider |
| **Application / State** | Orquestar use cases, exponer estado a UI | `lib/providers/` (hoy); notifiers Riverpod (objetivo) |
| **Domain** | Entidades, reglas, interfaces de repositorio | `lib/models/` como punto de partida; preferir entidades puras |
| **Data** | Datasources, DTO, APIs, Firestore, assets JSON | `lib/utils/cv_service.dart`, futuros `*_repository_impl.dart` |

### Flujos permitidos

```
UI  →  Provider/Notifier  →  UseCase  →  Repository (interface)
                                      →  RepositoryImpl → Datasource
```

Flujos **prohibidos**:

```
UI → Firestore / HTTP / rootBundle
UI → parsing de JSON de negocio
Repository → Navigate / ShowDialog / Theme
```

### Estado global: estándares

| Tipo de estado | Dónde vive | Notas |
| --- | --- | --- |
| Tema | `ThemeProvider` (o equivalente Riverpod) | Sin I/O de red |
| Idioma | `LanguageProvider` | Coordinado con `flutter_localizations` / ARB |
| Contenido remoto/async | Notifier por feature | `loading / data / error` explícitos |
| Estado efímero de UI (hover, tab local) | `StatefulWidget` / local | No contaminar estado global |

#### Provider (baseline actual)

- Usar `context.watch` solo donde el rebuild es necesario; `read` para acciones.
- Preferir `select` para campos puntuales (`themeMode`, `locale`).
- Registrar dependencias en `MultiProvider` en `main.dart`.

#### Riverpod (dirección preferida en código nuevo)

- `Provider` / `NotifierProvider` / `AsyncNotifierProvider` según el caso.
- Overrides en tests.
- No mezclar lecturas de Provider y Riverpod en el mismo widget sin capa anti-corrupción.

---

## Separación UI ↔ lógica de negocio

### Reglas

1. Los widgets **no** deciden reglas de negocio (p. ej. “¿el proyecto se publica?”, “¿el CV incluye X sección?”).
2. Los widgets **no** conocen paths de colección ni API keys.
3. El formateo de presentación menor (mayúsculas visuales, elipsis) puede vivir en UI; el formateo de dominio (cálculo de años de experiencia) vive en dominio.
4. `BuildContext` no atraviesa dominio ni data.
5. Animaciones y hover son presentación; no disparan escrituras a backend salvo intención explícita ya modelada (p. ej. botón enviar contacto → notifier).

### Inyección de dependencias

| Patrón | Permitido | Uso |
| --- | --- | --- |
| Constructor injection | ✅ Preferido | Use cases, repositorios, datasources |
| Provider/Riverpod registration en root | ✅ | Cableado de implementaciones |
| Service Locator global ad hoc | ⚠️ Solo si el orquestador lo aprueba | Evitar proliferación |
| Instanciar `FooRepository()` dentro del widget | ❌ | — |
| Singletons estáticos mutables con estado | ❌ | — |

Ejemplo de dirección correcta (ilustrativo):

```dart
class LoadProjects {
  LoadProjects(this._repository);
  final ProjectsRepository _repository;

  Future<List<Project>> call() => _repository.fetchPublished();
}
```

La UI no construye `LoadProjects` con detalles de Firestore; recibe un notifier ya configurado.

---

## Convenciones de código Dart

- APIs públicas de notifiers en verbos de intención: `load`, `refresh`, `submit`, `setLocale`.
- Errores: tipos de fallo o mensajes mapeados; no `catch (e) {}` vacío.
- Inmutabilidad preferida en modelos de dominio (`copyWith`).
- Evitar `dynamic` en fronteras de datos; tipar DTO.
- Código web-sensitive aislado (PDF, `universal_html`) detrás de abstracciones si crece.

---

## Anti-patrones (vigilancia obligatoria)

| Anti-patrón | Señal | Acción del agente |
| --- | --- | --- |
| **God Widget** | Sección > ~400 líneas con red + layout + parseo | Partir UI / mover lógica |
| **God Provider** | Un notifier para todo el app | Dividir por feature |
| **Lógica en `build`** | Cálculos/filtros pesados o I/O en build | Mover a notifier/use case |
| **Service en utils sin interfaz** | `CvService` usado directo desde 5 widgets | Introducir repository + DI |
| **DTO = Widget model** | Clase usada en UI con anotaciones Firestore | Crear mapper |
| **Context en capa data** | `BuildContext` para leer provider dentro del repo | Eliminar |
| **Estados mágicos** | `bool loading` + `String? error` + data sin coherencia | Modelo de estado unificado |
| **Dependencias ocultas** | `FirebaseFirestore.instance` deep en el call stack sin inyección | Inyectar datasource |
| **Multi-stack de estado** | Provider + Riverpod + Bloc en la misma feature | Una sola herramienta por feature |
| **Side effect en constructor de Provider** | Fetch de red al crear sin control | Carga explícita / `AsyncNotifier` |

---

## Lista de verificación (obligatoria en PRs/tareas de lógica o estado)

### Separación de capas

- [ ] Ningún widget nuevo accede a Firestore/HTTP/assets de negocio directamente.
- [ ] Reglas de negocio fuera de la presentación.
- [ ] Repositorio (o servicio con interfaz clara) para I/O.

### Estado

- [ ] Estado global justificado; lo efímero quedó local.
- [ ] Loading/error/data coherentes en flujos async.
- [ ] Rebuilds limitados con `select` / watches granulares.

### Dependencias

- [ ] Inyección por constructor o registro root.
- [ ] Tests pueden sustituir fakes/mocks sin reescribir UI.
- [ ] Sin nuevos singletons mutables.

### Higiene

- [ ] Sin anti-patrones de la tabla anterior.
- [ ] Analyze limpio en archivos tocados.
- [ ] Migraciones Provider→Riverpod documentadas si aplican.

---

## Criterio de rechazo

El orquestador **rechaza** el cierre de una tarea si esta skill aplica y alguna casilla obligatoria queda en ❌, o si aparece un anti-patrón de la tabla sin remedio planificado en la misma entrega.
