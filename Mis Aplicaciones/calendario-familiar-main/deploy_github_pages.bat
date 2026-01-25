@echo off
echo 🚀 Desplegando a GitHub Pages...

echo 📦 Compilando Flutter Web...
flutter build web --release --dart-define=FLUTTER_WEB_USE_SKIA=false

echo 📁 Creando directorio docs...
if not exist docs mkdir docs

echo 📁 Copiando archivos a docs...
xcopy /E /I /Y build\web\* docs\

echo 📄 Creando .nojekyll...
echo. > docs\.nojekyll

echo 💾 Haciendo commit...
git add docs/
git commit -m "Deploy to GitHub Pages - %date%"

echo ⬆️ Subiendo a GitHub...
git push origin main

echo ✅ Desplegado a GitHub Pages!
echo 🌐 URL: https://[tu-usuario].github.io/[tu-repo]
pause



