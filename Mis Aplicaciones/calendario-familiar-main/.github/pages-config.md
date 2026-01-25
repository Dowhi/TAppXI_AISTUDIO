# Configuración de GitHub Pages

## ⚙️ Configuración Recomendada

### En GitHub.com:
1. Ve a: Settings > Pages
2. Configura:
   - **Source**: GitHub Actions ⭐
   - **Branch**: (No aplica, se gestiona automáticamente)
   - **Custom domain**: (Opcional)
   - **Enforce HTTPS**: ✅ Activado

## 🚀 Ventajas de GitHub Actions vs Deploy from Branch

### GitHub Actions (Recomendado):
✅ Build automático y controlado
✅ Caché de dependencias (más rápido)
✅ Limpieza automática antes de cada build
✅ Versionado y trazabilidad
✅ Rollback fácil
✅ Optimizaciones automáticas
✅ Logs detallados de cada despliegue

### Deploy from Branch (No recomendado):
❌ Requiere compilar localmente
❌ Sin control de versiones del build
❌ Archivos compilados en el repositorio
❌ Más propenso a errores
❌ Difícil de mantener
❌ Sin optimizaciones automáticas

## 📊 Comparación de Rendimiento

| Característica | GitHub Actions | Deploy from Branch |
|----------------|----------------|-------------------|
| Velocidad | ⚡⚡⚡ (caché) | ⚡ |
| Confiabilidad | ✅✅✅ | ✅ |
| Mantenibilidad | ✅✅✅ | ❌ |
| Optimización | ✅✅✅ | ❌ |
| Trazabilidad | ✅✅✅ | ✅ |
| Rollback | ✅✅✅ | ❌ |

## 🔧 Optimizaciones Incluidas

1. **Caché de Flutter SDK**: Reduce tiempo de build en ~2-3 minutos
2. **Caché de dependencias**: Reduce tiempo de `pub get`
3. **Limpieza automática**: Evita conflictos entre builds
4. **Compresión de artifacts**: Reduce tamaño de transferencia
5. **Análisis de código**: Detecta errores antes del despliegue
6. **Versionado automático**: Trazabilidad completa

## 📈 Tiempos Estimados

### Primer build (sin caché):
- Setup Flutter: ~2 minutos
- Dependencias: ~1 minuto
- Build: ~3-4 minutos
- Deploy: ~1 minuto
- **Total**: ~7-8 minutos

### Builds subsecuentes (con caché):
- Setup Flutter: ~30 segundos
- Dependencias: ~20 segundos
- Build: ~2-3 minutos
- Deploy: ~1 minuto
- **Total**: ~4-5 minutos ⚡

## 🎯 Mejores Prácticas

1. ✅ Usar GitHub Actions (no Deploy from Branch)
2. ✅ Mantener workflow actualizado
3. ✅ Usar caché para Flutter y dependencias
4. ✅ Limpiar builds anteriores (flutter clean)
5. ✅ Incluir análisis de código
6. ✅ Versionado automático
7. ✅ Notificaciones de éxito/error

## 🔄 Proceso de Despliegue Optimizado

```
Push a main
    ↓
Trigger workflow
    ↓
Checkout código
    ↓
Setup Flutter (con caché) ⚡
    ↓
Limpiar builds anteriores
    ↓
Obtener dependencias (con caché) ⚡
    ↓
Análisis de código
    ↓
Build web optimizado
    ↓
Optimizar archivos
    ↓
Upload artifact (comprimido)
    ↓
Deploy a GitHub Pages
    ↓
✅ Sitio actualizado
```

## 🛡️ Seguridad

- ✅ Permisos mínimos necesarios
- ✅ Tokens automáticos de GitHub
- ✅ Sin secretos en el código
- ✅ HTTPS forzado
- ✅ Artifacts con retención limitada

## 📝 Mantenimiento

### Actualizar Flutter:
```yaml
flutter-version: '3.35.4'  # Cambiar aquí
```

### Cambiar base-href:
```yaml
--base-href="/FamilySync/"  # Cambiar aquí
```

### Habilitar/deshabilitar caché:
```yaml
cache: true  # false para deshabilitar
```

