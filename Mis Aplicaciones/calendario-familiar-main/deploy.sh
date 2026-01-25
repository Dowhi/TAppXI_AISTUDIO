#!/bin/bash

# Script de despliegue para Firebase Hosting
# Optimizado para iPhone con Firebase Hosting

echo "🚀 Iniciando despliegue para iPhone con Firebase Hosting..."

# Limpiar build anterior
echo "🧹 Limpiando build anterior..."
flutter clean

# Obtener dependencias
echo "📦 Obteniendo dependencias..."
flutter pub get

# Analizar código
echo "🔍 Analizando código..."
flutter analyze --no-fatal-infos

# Compilar para web
echo "🌐 Compilando para web..."
flutter build web --release

# Verificar que el build se completó
if [ ! -d "build/web" ]; then
    echo "❌ Error: El build web no se completó correctamente"
    exit 1
fi

# Desplegar a Firebase Hosting
echo "🔥 Desplegando a Firebase Hosting..."
firebase deploy --only hosting

echo "✅ Despliegue completado exitosamente!"
echo "📱 La app está optimizada para iPhone y disponible en Firebase Hosting"



