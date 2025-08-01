# Funcionalidad de CV - Portfolio LS

Este documento explica cómo usar la nueva funcionalidad de CV integrada en el portafolio.

## 🎯 Características

### 1. **Sección de CV Completa**

- Vista previa de información del CV
- Estadísticas resumidas (experiencia, educación, habilidades, proyectos)
- Botones para previsualizar y descargar
- Diseño responsivo y animado

### 2. **Generación de PDF Automática**

- PDF profesional generado dinámicamente
- Diseño limpio y estructurado
- Incluye todas las secciones del CV
- Fuente personalizada (Poppins)

### 3. **Navegación Integrada**

- Nuevo enlace "CV" en la navegación
- Disponible tanto en versión desktop como móvil
- Scroll suave hacia la sección

### 4. **Componentes Reutilizables**

- `CVDownloadButton`: Botón para descargar CV
- `FloatingCVButton`: Tarjeta flotante con información del CV
- Fácil integración en cualquier parte del portafolio

## 📁 Estructura de Archivos

```
lib/
├── models/
│   └── cv_model.dart          # Modelo de datos del CV
├── utils/
│   └── cv_service.dart        # Servicio para generar y manejar PDFs
├── components/
│   ├── cv_section.dart        # Sección principal del CV
│   └── cv_download_button.dart # Botones de descarga reutilizables
assets/
└── cv_data.json              # Datos del CV en formato JSON
```

## 🔧 Configuración

### 1. **Personalizar Datos del CV**

Edita el archivo `assets/cv_data.json` con tu información:

```json
{
  "name": "Tu Nombre",
  "title": "Tu Título Profesional",
  "email": "tu@email.com",
  "phone": "+XX XXX XXX XXXX",
  "location": "Tu Ciudad, País",
  "summary": "Tu resumen profesional...",
  "experience": [...],
  "education": [...],
  "skills": [...],
  "projects": [...]
}
```

### 2. **Personalizar Diseño del PDF**

En `lib/utils/cv_service.dart`, puedes modificar:

- Colores del PDF
- Estructura de las secciones
- Fuentes y tamaños
- Formato de datos

### 3. **Agregar Botones de Descarga**

Usa los componentes en cualquier parte de tu app:

```dart
// Botón simple
CVDownloadButton(
  label: 'Descargar CV',
  showIcon: true,
)

// Botón compacto
CVDownloadButton(
  isCompact: true,
  backgroundColor: Colors.blue,
)

// Tarjeta flotante
FloatingCVButton()
```

## 🎨 Personalización de Estilos

### Colores del PDF

```dart
// En cv_service.dart
color: PdfColors.blue900, // Color principal
color: PdfColors.grey700, // Color secundario
```

### Tamaños y Espaciado

```dart
// Márgenes de página
margin: const pw.EdgeInsets.all(32),

// Tamaños de fuente
fontSize: 28, // Título principal
fontSize: 16, // Subtítulos
fontSize: 12, // Texto normal
```

## 📱 Funcionalidades por Plataforma

### Web

- Descarga directa del PDF
- Previsualización en nueva ventana
- Compatible con todos los navegadores modernos

### Móvil (Android/iOS)

- Compartir PDF a través del sistema nativo
- Previsualización con herramientas del sistema
- Integración con aplicaciones de PDF

## 🔄 Flujo de Uso

1. **Usuario navega al portafolio**
2. **Ve la sección "CV" en navegación**
3. **Hace clic para ir a la sección**
4. **Ve resumen y estadísticas del CV**
5. **Puede previsualizar o descargar PDF**
6. **PDF se genera dinámicamente**
7. **Usuario recibe archivo profesional**

## 🛠️ Dependencias Utilizadas

- `pdf: ^3.10.6` - Generación de PDFs
- `printing: ^5.11.0` - Vista previa y compartir
- `universal_html: ^2.2.4` - Compatibilidad web
- `path_provider: ^2.1.1` - Manejo de archivos
- `http: ^1.1.0` - Requests HTTP

## 📋 Próximas Mejoras

- [ ] Múltiples plantillas de CV
- [ ] Editor de CV en línea
- [ ] Exportar en múltiples formatos
- [ ] Integración con APIs de trabajo
- [ ] Versiones en múltiples idiomas del PDF
- [ ] Temas personalizables para PDF

## 🐛 Solución de Problemas

### Error al cargar datos del CV

- Verifica que `assets/cv_data.json` esté en `pubspec.yaml`
- Asegúrate de que el JSON sea válido

### PDF no se descarga en web

- Verifica que las dependencias estén instaladas
- Comprueba la consola del navegador por errores

### Fuente no se carga en PDF

- Asegúrate de que `fonts/Poppins-Regular.ttf` exista
- Verifica la configuración en `pubspec.yaml`

## 💡 Consejos de Uso

1. **Mantén los datos actualizados** en `cv_data.json`
2. **Prueba el PDF** en diferentes dispositivos
3. **Personaliza los colores** según tu marca personal
4. **Optimiza las imágenes** si agregas fotos al PDF
5. **Testa la funcionalidad** en web y móvil

---

**¡Tu CV profesional está listo para impresionar a los reclutadores! 🚀**
