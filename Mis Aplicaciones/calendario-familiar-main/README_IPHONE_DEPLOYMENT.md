# Calendario Familiar - Despliegue para iPhone

## 📱 Optimización para iPhone

Este proyecto ha sido optimizado específicamente para funcionar en iPhone con Firebase Hosting. Se han eliminado todas las dependencias y configuraciones específicas de Android, Linux, Windows y macOS.

## 🚀 Despliegue Rápido

### Opción 1: Script Automático (Recomendado)

**En Windows:**
```bash
deploy.bat
```

**En macOS/Linux:**
```bash
chmod +x deploy.sh
./deploy.sh
```

### Opción 2: Comandos Manuales

```bash
# 1. Limpiar y obtener dependencias
flutter clean
flutter pub get

# 2. Analizar código
flutter analyze --no-fatal-infos

# 3. Compilar para web
flutter build web --release

# 4. Desplegar a Firebase Hosting
firebase deploy --only hosting
```

## 🔧 Configuración Optimizada

### Dependencias Eliminadas
- `android_alarm_manager_plus` - Específico de Android
- Configuraciones de Android, Linux, Windows y macOS

### Características Mantenidas
- ✅ Notificaciones locales para iOS
- ✅ Firebase Authentication
- ✅ Firebase Firestore
- ✅ Google Sign-In
- ✅ Generación de PDFs
- ✅ Calendario familiar completo
- ✅ Sincronización en tiempo real

### Configuración iOS
- Notificaciones locales optimizadas
- Permisos de notificación configurados
- Soporte para notificaciones críticas
- Modo oscuro nativo

## 📋 Requisitos

- Flutter SDK 3.4.0+
- Firebase CLI instalado
- Proyecto Firebase configurado
- Cuenta de Google para autenticación

## 🌐 Acceso

Una vez desplegado, la app estará disponible en:
- URL de Firebase Hosting (se mostrará después del despliegue)
- Optimizada para iPhone Safari
- Funciona como PWA (Progressive Web App)

## 🔍 Verificación

Después del despliegue, verifica:
1. ✅ La app carga correctamente en iPhone Safari
2. ✅ Las notificaciones funcionan
3. ✅ La autenticación con Google funciona
4. ✅ Los eventos se sincronizan en tiempo real
5. ✅ Los PDFs se generan correctamente

## 🛠️ Solución de Problemas

### Error de compilación
```bash
flutter clean
flutter pub get
flutter build web --release
```

### Error de Firebase
```bash
firebase login
firebase use --add
```

### Error de dependencias
```bash
flutter pub deps
flutter pub upgrade
```

## 📞 Soporte

Si encuentras problemas:
1. Verifica que todas las dependencias estén instaladas
2. Asegúrate de que Firebase esté configurado correctamente
3. Revisa los logs de Firebase Hosting
4. Verifica la configuración de iOS en `ios/Runner/Info.plist`



