#!/bin/bash

# Script para desplegar a Surge.sh
echo "🚀 Desplegando a Surge.sh..."

# Compilar para web
echo "📦 Compilando Flutter Web..."
flutter build web --release --dart-define=FLUTTER_WEB_USE_SKIA=false

# Instalar surge si no está instalado
if ! command -v surge &> /dev/null; then
    echo "📦 Instalando Surge..."
    npm install -g surge
fi

# Desplegar
echo "⬆️ Desplegando a Surge..."
surge build/web

echo "✅ Desplegado a Surge.sh!"
echo "🌐 Tu app estará disponible en la URL que te proporcione Surge"



