# 📱 INSTRUCCIONES PARA INSTALAR LA APP EN ANDROID COMO PWA

## MÉTODO 1: Banner automático de Chrome (RECOMENDADO)

Cuando la app cumple todos los requisitos de PWA, Chrome mostrará automáticamente un banner en la parte inferior de la pantalla.

### Pasos:
1. **Abre la app en Chrome para Android**
2. **Usa la app durante unos minutos** (Chrome necesita verificar que la usas)
3. **Busca el banner** que aparece en la parte inferior:
   ```
   ┌─────────────────────────────────────┐
   │ 📱 Añadir a pantalla de inicio     │
   │ Calendario Familiar                 │
   └─────────────────────────────────────┘
   ```
4. **Toca "Añadir"** o el botón de instalación
5. **Confirma la instalación** cuando te lo pida
6. **Busca el icono** en tu pantalla de inicio

---

## MÉTODO 2: Menú de Chrome

Si el banner no aparece, puedes usar el menú:

### Pasos:
1. **Abre Chrome** y navega a la app
2. **Toca el menú** (3 puntos en la esquina superior derecha)
3. **Busca "Instalar app"** o **"Añadir a pantalla de inicio"**
   - En versiones recientes puede aparecer como: "Instalar FamilySync" o "Instalar Calendario"
4. **Toca la opción**
5. **Confirma** cuando aparezca el diálogo
6. **El icono aparecerá** en tu pantalla de inicio

---

## MÉTODO 3: Botón de instalación en la app

La app ahora tiene un botón flotante de instalación que aparece automáticamente en Android:

### Pasos:
1. **Abre la app** en Chrome Android
2. **Espera unos segundos** después de cargar
3. **Busca el botón verde flotante** en la parte inferior:
   ```
   ┌─────────────────┐
   │ 📱 Instalar App │
   └─────────────────┘
   ```
4. **Toca el botón**
5. **Se abrirá el diálogo de instalación** nativo de Android
6. **Toca "Instalar"** o "Añadir"
7. **Confirma** si te lo pide

---

## REQUISITOS PARA QUE FUNCIONE

Para que Android muestre el banner o permita instalar como PWA, la app debe cumplir:

✅ **Service Worker registrado** - Ya está implementado (`sw.js`)
✅ **Manifest.json válido** - Ya está configurado
✅ **HTTPS** - La app debe estar en HTTPS (GitHub Pages, Firebase Hosting, etc.)
✅ **Iconos** - Debe tener iconos de 192x192 y 512x512 ✅
✅ **start_url** - Debe apuntar a una página válida ✅
✅ **display: standalone** - Ya configurado ✅

---

## VERIFICAR SI ESTÁ INSTALADA

Después de instalar, para verificar:

1. **Busca el icono** en tu pantalla de inicio
2. **Abre la app desde el icono**
3. **Si se abre sin la barra de Chrome** (sin URL visible) = ✅ Está instalada como PWA
4. **Si se abre con la barra de Chrome** = ❌ Es solo un acceso directo

---

## DIFERENCIA ENTRE PWA Y ACCESO DIRECTO

### PWA Instalada (lo que queremos):
- ✅ Se abre sin barra de navegador
- ✅ Aparece como app independiente
- ✅ Mejor rendimiento
- ✅ Service Workers funcionan mejor
- ✅ Notificaciones más confiables
- ✅ Se ve en el cajón de apps como una app normal

### Acceso Directo (lo que NO queremos):
- ❌ Se abre con barra de navegador de Chrome
- ❌ Es básicamente un bookmark
- ❌ Funcionalidades limitadas
- ❌ No cuenta como app instalada

---

## SI NO APARECE EL BANNER

Si después de varios minutos no aparece el banner:

1. **Verifica que estés usando HTTPS** (no HTTP)
2. **Limpia el caché de Chrome:**
   - Menú → Configuración → Privacidad → Borrar datos de navegación
   - Selecciona "Imágenes y archivos en caché"
3. **Cierra completamente Chrome** y vuelve a abrirlo
4. **Usa la app unos minutos** (Chrome necesita ver actividad)
5. **Intenta el Método 2** (menú de Chrome)

---

## ACTUALIZAR LA APP

Si ya está instalada y quieres actualizarla:

1. **Abre Chrome**
2. **Ve a la URL de la app** (no uses el icono instalado)
3. **Espera a que Chrome detecte la actualización**
4. **Se instalará automáticamente** la nueva versión

O simplemente:
- **Elimina el icono** de la pantalla de inicio
- **Sigue los pasos de instalación** de nuevo

---

## SOLUCIÓN DE PROBLEMAS

### "No aparece el banner"
- Asegúrate de estar en HTTPS
- Espera unos minutos usando la app
- Usa el menú de Chrome (Método 2)
- Usa el botón flotante (Método 3)

### "Se instala pero se abre en Chrome"
- Elimina el acceso directo actual
- Reinstala usando el Método 1 o 3
- Verifica que `manifest.json` tenga `"display": "standalone"`

### "El botón de instalación no aparece"
- Verifica que estés en Android (no iOS)
- Asegúrate de estar usando Chrome (no otro navegador)
- Verifica la consola para ver si hay errores del Service Worker

---

## NOTAS TÉCNICAS

- Chrome solo muestra el banner después de cierta actividad del usuario
- El evento `beforeinstallprompt` es lo que permite el botón personalizado
- Una vez instalada, la app funciona offline básico gracias al Service Worker
- Las alarmas funcionan mejor cuando está instalada como PWA

---

## RESUMEN RÁPIDO

**Para Android:**
1. Abre en Chrome Android
2. Espera el banner o usa el menú de Chrome
3. O busca el botón verde "📱 Instalar App" que aparece en la parte inferior
4. Confirma la instalación
5. Busca el icono en tu pantalla de inicio

**¡Listo!** Ya tienes la app instalada como PWA, no como acceso directo.

