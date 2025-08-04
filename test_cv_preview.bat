@echo off
echo ===============================================
echo  PORTFOLIO CV PREVIEW - SOLUCION IMPLEMENTADA
echo ===============================================
echo.
echo ✅ CAMBIOS REALIZADOS:
echo.
echo 1. Habilitada previsualización PDF en todos los entornos
echo 2. Implementado fallback robusto si PdfPreview falla
echo 3. Mejorados mensajes informativos para el usuario
echo 4. Optimizada experiencia en web y móvil
echo.
echo ===============================================
echo  OPCIONES DE PRUEBA:
echo ===============================================
echo.
echo [1] Servir aplicación en modo DEBUG
echo [2] Servir aplicación en modo RELEASE (producción)
echo [3] Compilar y deploy automático
echo [4] Mostrar información de archivos modificados
echo.
set /p choice="Selecciona una opción (1-4): "

if "%choice%"=="1" goto debug
if "%choice%"=="2" goto release
if "%choice%"=="3" goto deploy
if "%choice%"=="4" goto info
goto end

:debug
echo.
echo 🔧 MODO DEBUG - Ejecutando con funcionalidad completa de PdfPreview
echo URL: http://localhost:8080
echo.
cd build\web
python -m http.server 8080
goto end

:release
echo.
echo 🚀 MODO RELEASE - Simulando entorno de producción
echo URL: http://localhost:8081
echo.
cd build\web
python -m http.server 8081
goto end

:deploy
echo.
echo 📦 COMPILANDO Y DESPLEGANDO...
flutter clean
flutter pub get
flutter build web --release
echo.
echo ✅ Compilación completada. Usa la opción 2 para probar.
goto end

:info
echo.
echo 📁 ARCHIVOS MODIFICADOS:
echo.
echo ✅ lib\utils\web_pdf_utils.dart - Habilitada compatibilidad web
echo ✅ lib\components\cv_preview_screen.dart - Mejorado manejo de errores
echo ✅ serve_debug.bat - Script de prueba DEBUG
echo ✅ test_cv_preview.bat - Este script de prueba
echo.
echo 🎯 FUNCIONALIDAD:
echo - ✅ Previsualización PDF en navegador (preferida)
echo - ✅ Descarga directa si preview falla
echo - ✅ Apertura en nueva pestaña como alternativa
echo - ✅ Mensajes informativos para el usuario
echo.
pause
goto end

:end
echo.
echo Presiona cualquier tecla para continuar...
pause >nul
