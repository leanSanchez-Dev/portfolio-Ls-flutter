---
name: optimizacion-web
description: >-
  Optimización Flutter Web: CanvasKit vs HTML, carga de assets, LCP/TTI, rebuilds y animaciones del portafolio. Use when editing widgets, components, images, fonts, web build flags, carousel, CV/PDF preview, or performance.
---

# Skill: Optimización Web (Flutter)

> Mejores prácticas de renderizado en navegadores (CanvasKit vs HTML) y optimización de carga de assets para el portafolio.

## Propósito

Maximizar rendimiento percibido y real del portafolio en **Flutter Web**: primera carga, scroll fluido, imágenes, fuentes y animaciones, sin sacrificar la fidelidad visual del brand.

**Agentes que deben aplicarla:** `agent-ui-expert` (owner), `agent-flutter-logic` (evitar trabajo pesado en estado que dispare rebuilds masivos), `PORTFOLIO-ORCHESTRATOR` (gate).

---

## Renderers: CanvasKit vs HTML

| Criterio | CanvasKit | HTML (skwasm/html según versión) |
| --- | --- | --- |
| Fidelidad visual / efectos | Alta; cercano a móvil | Puede diferir en shaders, blur, algunos efectos |
| Tamaño de descarga inicial | Mayor (WASM + canvas) | Menor en muchos escenarios |
| Texto / SEO / selección | Peor para SEO; texto en canvas | Mejor integración con DOM/texto |
| Rendimiento gráfico | Fuerte en animaciones complejas | Suficiente en UIs simples; cuidado con overlays |
| Uso típico portafolio visual | Preferible si hay motion/gradientes/custom paint | Preferible si prioridad es TTI/SEO y UI simple |

### Reglas de decisión

1. **Default del producto visual:** preferir **CanvasKit** cuando el portafolio dependa de animaciones, hover elaborados, tipografía pixel-perfect y consistencia con diseño.
2. **Perfil “carga mínima”:** evaluar HTML renderer solo con medición (Lighthouse / Web Vitals) y checklist visual de regresiones.
3. No cambiar el renderer en CI/prod sin brief del orquestador y prueba en Chrome + Safari + Firefox.
4. Documentar el comando de build usado, por ejemplo:
   - `flutter build web --web-renderer canvaskit`
   - `flutter build web --web-renderer html`
5. Con Flutter reciente, verificar flags vigentes (`--web-renderer` puede evolucionar); anclar la decisión en la versión del SDK del proyecto (`environment.sdk` en `pubspec.yaml`).

### Implicaciones de desarrollo

| Tema | Práctica |
| --- | --- |
| `ImageFiltered` / blurs / shaders | Validar en el renderer elegido; costes altos en low-end |
| Texto seleccionable / SEO | Si se necesita indexación rica, contenido crítico también en HTML estático de Hosting o meta tags |
| Plugins `dart:html` / `universal_html` | Aislar; no asumir disponibilidad idéntica en todos los modos |
| Precisión de fuentes | Poppins como familia local; evitar FOUT severo con carga ordenada |

---

## Optimización de carga de assets

### Inventario típico del repo

- `assets/` (imágenes, slides, iconos)
- `assets/cv_data.json`
- Temas JSON (`appainter_theme*.json`)
- Fuentes `fonts/Poppins-*.ttf` (múltiples pesos)

### Principios

1. **Presupuesto de peso:** cada imagen de hero/slide debe justificarse; comprimir antes de commit.
2. **No cargar todo eager:** secciones below-the-fold con lazy load (`image_loader` / `Image.asset` diferido / visibilidad).
3. **Resoluciones:** evitar PNG 4K para thumbnails; usar tamaños acordes al viewport máximo real.
4. **Fuentes:** no registrar más pesos de Poppins de los usados; cada `.ttf` suma KB al bundle.
5. **JSON de CV/temas:** cargar bajo demanda si no bloquean el primer paint; cachear en memoria tras la primera lectura.
6. **Cache HTTP (Hosting):** assets hasheados con cache largo; `index.html` con cache corto.
7. **Tree-shake icons:** preferir imports puntuales de `font_awesome_flutter` cuando sea posible.

### Tabla de prácticas de imágenes

| Práctica | Obligatorio |
| --- | --- |
| Comprimir JPG/WebP/PNG antes de añadir a `assets/slide/` | Sí |
| Dimensiones alineadas al uso en layout | Sí |
| Lazy load fuera del primer viewport | Sí |
| Placeholders / fade-in para evitar CLS brusco | Recomendado |
| Múltiples copias del mismo asset a distinta calidad sin necesidad | No |
| Animar `Opacity` + decode de imágenes enormes en scroll | Evitar |

### Primer viewport (hero / banner)

El primer viewport debe priorizar:

1. CSS/HTML shell de Flutter + main.dart.js / canvas kit chunks críticos.
2. Fuente primaria en peso usado por el H1.
3. Imagen/hero esencial únicamente.
4. Diferir carruseles pesados, PDF engine y precargas de CV hasta interacción o idle.

---

## Rendimiento de frames y rebuilds

| Problema | Señal | Remedio |
| --- | --- | --- |
| Rebuild de árbol completo | Cambiar idioma/tema reconstruye listas pesadas sin select | `select` / partir listeners |
| Trabajo en `build` | Parse JSON / filtros en build | Precacular en notifier |
| Animaciones perpetuas | CPU alta en idle | Pausar offscreen; respetar reduced motion |
| Carrusel + imágenes full-res | Jank al deslizar | Precache selectivo; tamaños menores |
| PDF preview al inicio | TTI alto | Carga diferida al abrir sección CV |

### `const` y composición

- Usar `const` en widgets inmutables.
- Evitar closures que invalidan `const` sin necesidad.
- Preferir widgets pequeños para limitar el área de repaint.

---

## Build y despliegue

Checklist de build web orientado a prod:

- [ ] `flutter build web` (renderer acordado) sin warnings críticos nuevos.
- [ ] Revisar tamaño de `build/web/assets/` tras añadir binarios.
- [ ] Confirmar `firebase.json` public dir y rewrites SPA.
- [ ] Probar ruta profunda / refresh en Hosting.
- [ ] Verificar tema claro/oscuro e i18n tras el deploy de staging.

Comandos de referencia (ajustar a flags del SDK instalado):

```bash
flutter build web --release --web-renderer canvaskit
firebase deploy --only hosting
```

---

## Anti-patrones web

| Anti-patrón | Por qué duele | Remedio |
| --- | --- | --- |
| Meter 10 pesos de fuente “por si acaso” | +MB en TTI | Solo pesos usados |
| Hero 5MB PNG | LCP destruido | Comprimir / redimensionar |
| Cambiar a HTML renderer sin QA visual | Regresiones de UI | Checklist visual multi-browser |
| Precargar PDF + todos los slides al startup | Main thread ocupado | Diferir |
| `setState` en scroll listeners sin throttle | Jank | Throttle / AnimationController cuidadoso |
| Ignorar Safari | Bugs de hover/overflow | Probar WebKit |
| Duplicar assets en `assets/` y `web/` sin razón | Confusión de cache | Una fuente de verdad |

---

## Lista de verificación (obligatoria en tareas UI/assets/build web)

### Renderer

- [ ] Renderer elegido documentado (CanvasKit u HTML) con justificación.
- [ ] Sin cambio silencioso de renderer en prod.
- [ ] Efectos visuales críticos validados en ese renderer.

### Assets

- [ ] Nuevas imágenes comprimidas y dimensionadas.
- [ ] Lazy load para contenido offscreen.
- [ ] Fuentes/pesos mínimos necesarios.
- [ ] `pubspec.yaml` assets actualizado solo con lo necesario.

### Runtime UI

- [ ] Sin trabajo pesado en `build`.
- [ ] Animaciones justificadas; reduced motion considerado.
- [ ] Rebuilds de tema/idioma acotados.
- [ ] CV/PDF/carrusel no bloquean el first paint sin necesidad.

### Verificación

- [ ] Vista mobile y desktop revisadas.
- [ ] Scroll estable en sección tocada.
- [ ] Impacto en bundle/assets mencionado al orquestador.

---

## Criterio de rechazo

El orquestador **rechaza** el cierre si se añaden assets pesados sin optimizar, se cambia el renderer sin QA, o se introduce trabajo de arranque que degrade claramente el LCP/TTI del portafolio sin plan de mitigación en la misma entrega.
