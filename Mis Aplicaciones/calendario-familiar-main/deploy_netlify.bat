@echo off
echo 🚀 Desplegando a Netlify...

echo 📦 Verificando Netlify CLI...
netlify --version >nul 2>&1
if errorlevel 1 (
    echo 📦 Instalando Netlify CLI...
    npm install -g netlify-cli
)

echo 📦 Compilando Flutter Web...
flutter build web --release --dart-define=FLUTTER_WEB_USE_SKIA=false

if not exist build\web (
    echo ❌ Error: No se encontró el directorio build/web
    pause
    exit /b 1
)

echo 🔐 Verificando login a Netlify...
netlify status

echo ⬆️ Desplegando a Netlify...
netlify deploy --prod --dir=build/web

echo ✅ Desplegado a Netlify!
echo 🌐 Tu app estará disponible en la URL que te proporcione Netlify
pause



