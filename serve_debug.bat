@echo off
echo ===============================================
echo  SIRVIENDO PORTFOLIO - MODO DEBUG
echo ===============================================
echo.

cd "build\web"

echo Iniciando servidor web en modo debug...
echo URL: http://localhost:8080
echo.
echo Presiona Ctrl+C para detener el servidor
echo.

python -m http.server 8080
