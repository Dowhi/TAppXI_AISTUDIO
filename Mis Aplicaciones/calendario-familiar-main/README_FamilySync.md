# 🏠 FamilySync - Calendario Familiar Inteligente

![FamilySync Logo](https://img.shields.io/badge/FamilySync-Calendario%20Familiar-green?style=for-the-badge&logo=calendar)

## 📱 **Descripción**

FamilySync es una aplicación web moderna y elegante diseñada para mantener a las familias organizadas y sincronizadas. Con una interfaz intuitiva y funcionalidades avanzadas, permite gestionar eventos, turnos, notas y recordatorios de manera colaborativa.

## ✨ **Características Principales**

### 📅 **Gestión de Calendario**
- **Vista mensual** interactiva y responsiva
- **Eventos personalizables** con colores y categorías
- **Notas diarias** para recordatorios importantes
- **Gestión de turnos** para familias con horarios rotativos

### 👥 **Colaboración Familiar**
- **Sincronización en tiempo real** con Firebase
- **Múltiples usuarios** por familia
- **Asignación de eventos** por persona
- **Notificaciones inteligentes**

### 🎨 **Interfaz Moderna**
- **Diseño responsivo** para móviles y desktop
- **Tema oscuro/claro** automático
- **Iconos intuitivos** para cada categoría
- **Animaciones fluidas** y transiciones suaves

### 📊 **Funcionalidades Avanzadas**
- **Reportes y estadísticas** familiares
- **Exportación a PDF** de calendarios
- **Gestión de plantillas** de turnos
- **Configuraciones personalizables**

## 🚀 **Tecnologías Utilizadas**

- **Frontend**: Flutter Web
- **Backend**: Firebase (Firestore, Authentication)
- **Estado**: Riverpod
- **Navegación**: GoRouter
- **UI**: Material Design 3
- **Notificaciones**: Flutter Local Notifications

## 🌐 **Despliegue**

### **GitHub Pages**
```bash
# Compilar y desplegar
flutter build web --release --dart-define=FLUTTER_WEB_USE_SKIA=false
./deploy_github_pages.sh
```

### **Netlify**
```bash
# Deploy automático desde GitHub
# Configuración incluida en netlify.toml
```

### **Firebase Hosting**
```bash
# Deploy a Firebase
firebase deploy --only hosting
```

## 📱 **Compatibilidad**

- ✅ **Chrome** (Desktop y móvil)
- ✅ **Firefox** (Desktop y móvil)
- ✅ **Safari** (Desktop y móvil)
- ✅ **Edge** (Desktop)
- ⚠️ **iOS Safari** (versión compatible disponible)

## 🛠️ **Instalación Local**

### **Prerrequisitos**
- Flutter SDK 3.35.6+
- Dart SDK 3.9.2+
- Firebase CLI (opcional)

### **Pasos**
1. **Clonar el repositorio**
   ```bash
   git clone https://github.com/[usuario]/FamilySync.git
   cd FamilySync
   ```

2. **Instalar dependencias**
   ```bash
   flutter pub get
   ```

3. **Configurar Firebase** (opcional)
   ```bash
   firebase login
   firebase use [proyecto-id]
   ```

4. **Ejecutar en desarrollo**
   ```bash
   flutter run -d chrome
   ```

## 📁 **Estructura del Proyecto**

```
FamilySync/
├── lib/
│   ├── core/                 # Servicios y utilidades
│   ├── features/             # Funcionalidades por módulo
│   ├── routing/              # Configuración de rutas
│   └── theme/                # Temas y estilos
├── web/                      # Configuración web
├── assets/                   # Recursos estáticos
└── docs/                     # Documentación
```

## 🔧 **Configuración**

### **Variables de Entorno**
```dart
// Firebase configuration
const firebaseConfig = {
  'apiKey': 'tu-api-key',
  'authDomain': 'tu-proyecto.firebaseapp.com',
  'projectId': 'tu-proyecto-id',
  // ... más configuraciones
};
```

### **Personalización**
- **Colores**: Modifica `lib/theme/app_theme.dart`
- **Rutas**: Configura `lib/routing/app_router.dart`
- **Servicios**: Personaliza `lib/core/services/`

## 📊 **Estadísticas del Proyecto**

- **Líneas de código**: ~15,000+
- **Archivos Dart**: 50+
- **Widgets personalizados**: 20+
- **Servicios**: 10+
- **Pantallas**: 15+

## 🤝 **Contribuir**

1. Fork el proyecto
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## 📄 **Licencia**

Este proyecto está bajo la Licencia MIT. Ver `LICENSE` para más detalles.

## 👨‍💻 **Autor**

**Desarrollado con ❤️ para familias modernas**

## 🔗 **Enlaces Útiles**

- [Demo en vivo](https://[usuario].github.io/FamilySync)
- [Documentación](https://github.com/[usuario]/FamilySync/wiki)
- [Reportar bugs](https://github.com/[usuario]/FamilySync/issues)
- [Solicitar features](https://github.com/[usuario]/FamilySync/issues)

---

**¡Mantén a tu familia sincronizada con FamilySync! 🏠✨**



