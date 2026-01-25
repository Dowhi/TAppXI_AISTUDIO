#!/bin/bash

# Script para desplegar a GitHub Pages
echo "🚀 Desplegando a GitHub Pages..."

# Compilar para web
echo "📦 Compilando Flutter Web..."
flutter build web --release --dart-define=FLUTTER_WEB_USE_SKIA=false

# Crear directorio docs si no existe
mkdir -p docs

# Copiar archivos compilados a docs
echo "📁 Copiando archivos a docs..."
cp -r build/web/* docs/

# Crear .nojekyll para evitar problemas con Jekyll
touch docs/.nojekyll

# Agregar y hacer commit
echo "💾 Haciendo commit..."
git add docs/
git commit -m "Deploy to GitHub Pages - $(date)"

# Push a GitHub
echo "⬆️ Subiendo a GitHub..."
git push origin main

echo "✅ Desplegado a GitHub Pages!"
echo "🌐 URL: https://[tu-usuario].github.io/[tu-repo]"



