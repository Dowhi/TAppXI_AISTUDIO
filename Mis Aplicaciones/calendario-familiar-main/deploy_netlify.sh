#!/bin/bash

# Script para deploy manual a Netlify
echo "🚀 Desplegando a Netlify..."

# Verificar que Netlify CLI esté instalado
if ! command -v netlify &> /dev/null; then
    echo "📦 Instalando Netlify CLI..."
    npm install -g netlify-cli
fi

# Compilar Flutter Web
echo "📦 Compilando Flutter Web..."
flutter build web --release --dart-define=FLUTTER_WEB_USE_SKIA=false

# Verificar que el build fue exitoso
if [ ! -d "build/web" ]; then
    echo "❌ Error: No se encontró el directorio build/web"
    exit 1
fi

# Login a Netlify (si no está logueado)
echo "🔐 Verificando login a Netlify..."
netlify status

# Deploy
echo "⬆️ Desplegando a Netlify..."
netlify deploy --prod --dir=build/web

echo "✅ Desplegado a Netlify!"
echo "🌐 Tu app estará disponible en la URL que te proporcione Netlify"



