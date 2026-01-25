@echo off
REM Script de despliegue para Firebase Hosting
REM Optimizado para iPhone con Firebase Hosting

echo 🚀 Iniciando despliegue para iPhone con Firebase Hosting...

REM Limpiar build anterior
echo 🧹 Limpiando build anterior...
flutter clean

REM Obtener dependencias
echo 📦 Obteniendo dependencias...
flutter pub get

REM Analizar código
echo 🔍 Analizando código...
flutter analyze --no-fatal-infos

REM Compilar para web
echo 🌐 Compilando para web...
flutter build web --release

REM Verificar que el build se completó
if not exist "build\web" (
    echo ❌ Error: El build web no se completó correctamente
    exit /b 1
)

REM Desplegar a Firebase Hosting
echo 🔥 Desplegando a Firebase Hosting...
firebase deploy --only hosting

echo ✅ Despliegue completado exitosamente!
echo 📱 La app está optimizada para iPhone y disponible en Firebase Hosting



