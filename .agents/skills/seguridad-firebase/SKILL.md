---
name: seguridad-firebase
description: >-
  Directrices de seguridad Firebase para Flutter Web: API keys del cliente, Security Rules deny-by-default, secretos en Functions y protección de PII. Use when working with Firestore, firebase.json, firestore.rules, Cloud Functions, Auth, Hosting security, or credentials.
---

# Skill: Seguridad Firebase

> Directrices críticas para proteger configuración en el cliente web y estructurar reglas de lectura/escritura en Firestore.

## Propósito

El portafolio se despliega como **Flutter Web** (Hosting). Todo lo empaquetado en el cliente es visible. Esta skill establece el modelo de amenaza y las reglas de implementación para Firebase.

**Agentes que deben aplicarla:** `agent-firebase-expert` (owner), `agent-flutter-logic` (consumo seguro), `PORTFOLIO-ORCHESTRATOR` (gate).

**Proyecto de referencia:** `portfolio-lean-dev` (Hosting). Cualquier otro proyecto debe confirmarse explícitamente.

---

## Modelo de amenaza (cliente web)

| Activo | Riesgo | Mitigación |
| --- | --- | --- |
| Contenido público del portafolio | Lectura anónima esperada | Rules permiten solo datos marcados públicos |
| Mensajes de contacto / PII | Enumeración, spam, filtración | Solo `create` acotado o Function + rate limit; sin `list` anónimo |
| Credenciales admin | Robo de sesión / privilege escalation | Auth fuerte; claims; sin Admin SDK en cliente |
| Secretos de terceros (SMTP, APIs) | Extracción del bundle | Solo Functions / Secret Manager |
| API Key web de Firebase | Uso abusivo de cuotas | Restricciones HTTP referrer; Rules estrictas; App Check |

### Principio rector

> La **API key web de Firebase no es un secreto de autorización**. La autorización real está en **Security Rules**, **Auth** y **Functions**. Tratar la key como identificador de proyecto sujeto a abuso de cuotas, no como contraseña.

---

## Protección de API Keys y configuración en el cliente

### Permitido en el cliente Flutter Web

- `apiKey`, `authDomain`, `projectId`, `storageBucket`, `messagingSenderId`, `appId` de la app **Web**.
- IDs de medición Analytics si se acepta el riesgo de visibilidad.
- Endpoints públicos de Functions callable/HTTPS pensados para el browser.

### Prohibido en el cliente (y en el repo público)

| Prohibido | Dónde debe vivir |
| --- | --- |
| Service account JSON | CI secreto / backend solamente |
| Claves privadas PEM / Google application credentials | Secret Manager / CI |
| Claves SMTP, SendGrid, OpenAI, etc. | Cloud Functions secrets |
| Passwords de usuarios hardcodeados | Nunca |
| Rules de emulador permisivas desplegadas a prod | Nunca |

### Prácticas de configuración

1. Preferir `--dart-define` / `--dart-define-from-file` para config por entorno (dev/stage/prod), sin commitear secretos reales.
2. No subir `.env` con privilegios al repositorio; usar `.gitignore`.
3. Separar proyectos Firebase **dev** y **prod** cuando haya escrituras reales o Auth admin.
4. Restringir la API key web en Google Cloud Console por **HTTP referrer** a dominios del portafolio (`*.web.app`, dominio custom).
5. Habilitar **App Check** (reCAPTCHA v3 en web) cuando haya escrituras anónimas (contacto) o abuso de lectura.
6. Nunca “arreglar” un permiso faltante moviendo lógica privilegiada al cliente.

### Checklist rápida de keys

- [ ] No hay service accounts en `lib/`, `assets/`, ni web/.
- [ ] Config web documentada como no privilegiada.
- [ ] Referrers de API key restringidos (prod).
- [ ] Secretos de integración solo en Functions.
- [ ] `.gitignore` cubre archivos de credenciales locales.

---

## Estructura de Security Rules (Firestore)

### Plantilla mental obligatoria

```
deny all by default
→ allow read público solo a documentos/campos publicados
→ allow write solo a principals autorizados + validación de schema
→ contact: create limitado OR solo via Function
```

### Matriz de acceso recomendada

| Recurso | `read` | `list` | `create` | `update` | `delete` |
| --- | --- | --- | --- | --- | --- |
| Proyectos publicados | Anónimo | Anónimo (query `published==true`) | Admin | Admin | Admin |
| Borradores | Admin | Admin | Admin | Admin | Admin |
| Skills / experiencia públicas | Anónimo | Anónimo | Admin | Admin | Admin |
| `contact_messages` | Admin | Admin | Anónimo validado **o** Function | No | Admin |
| `site_settings` | Anónimo | N/A (doc único) | Admin | Admin | Admin |

### Reglas de validación de escritura

Toda escritura desde cliente debe validar, como mínimo:

- Autenticación/rol cuando no sea un `create` público controlado.
- Tipos de campos (`is string`, `is number`, `is bool`).
- Longitudes máximas (anti-spam en contacto).
- Lista blanca de keys (`request.resource.data.keys().hasOnly([...])`).
- Inmutabilidad de campos de servidor (`createdAt` solo en create, no cambiable).
- Para contenido público: `published` solo lo puede poner un admin.

### Prohibiciones explícitas en Rules

| Patrón | Estado |
| --- | --- |
| `allow read, write: if true;` | Prohibido en prod |
| `allow read: if true` sobre colección con PII | Prohibido |
| Validación solo en el cliente Flutter | Insuficiente (Rules/Functions obligatorias) |
| Confiar en ocultar el path del documento | Prohibido (security by obscurity) |

### Cloud Functions — complementos de seguridad

Usar Functions cuando:

- Hace falta un secreto.
- Se requiere rate limiting / CAPTCHA server-side / antispam.
- Hay que enviar email o notificar.
- La validación supera lo expresable en Rules.

Obligatorio en Functions:

- Verificar Auth cuando el endpoint no sea público.
- Validar y sanitizar input.
- No devolver stack traces internos al cliente.
- No loguear cuerpos completos con PII.

---

## Almacenamiento y Hosting

| Tema | Directiva |
| --- | --- |
| Storage público | Solo assets intencionalmente públicos; rules por path |
| URLs de CV | Preferir asset estático versionado o URL con control de cache; evitar PII extra en metadata |
| Headers Hosting | No desactivar protecciones necesarias; cuidar cache de `index.html` vs assets hasheados |
| Emulators | Rules permisivas solo locales; nunca copiar a prod |

---

## Anti-patrones de seguridad

| Anti-patrón | Impacto | Remedio |
| --- | --- | --- |
| Service account en el front | Compromiso total del proyecto | Rotar + eliminar del cliente |
| Rules abiertas “temporalmente” en prod | Exfiltración / defacement | Deny default + deploy rules testeadas |
| Mensajes de contacto listables | Filtración de emails | Quitar list; solo admin |
| Clave restringida a `*` referrer | Abuso de cuotas | Dominios explícitos |
| Admin por email hardcodeado en Rules sin claim | Fragilidad / fugas | Custom claims |
| Logs de Function con mensaje de contacto completo | PII en Cleartext logging | Redacción |

---

## Lista de verificación (obligatoria en tareas Firebase / config)

### Cliente web

- [ ] Sin secretos privilegiados en bundle ni repo.
- [ ] Config Firebase web tratada como pública pero restringida.
- [ ] Separación de entornos clara si hay escrituras reales.

### Firestore Rules

- [ ] Deny by default.
- [ ] Lecturas públicas limitadas a contenido publicado.
- [ ] Escrituras validadas (tipo, tamaño, keys).
- [ ] Colecciones con PII sin list anónimo.
- [ ] Sin `if true` de escritura en prod.

### Functions / secretos

- [ ] Secretos fuera del cliente.
- [ ] Auth/input validados.
- [ ] Rate limiting o App Check considerado para endpoints públicos.

### Operación

- [ ] Plan de prueba de rules (emulator o casos).
- [ ] Breaking changes comunicados a Flutter Logic / UI.
- [ ] Rotación planificada si hubo exposición.

---

## Criterio de rechazo

Cualquier cambio que despliegue Rules permisivas, introduzca credenciales privilegiadas en el cliente, o permita listar PII anónimamente **bloquea** el cierre por el orquestador, sin excepción de “solo por ahora”.
