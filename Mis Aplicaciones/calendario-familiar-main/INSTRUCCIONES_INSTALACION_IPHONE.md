# 📱 INSTRUCCIONES PARA INSTALAR LA APP EN iPhone COMO PWA

## ⚠️ IMPORTANTE: Cómo instalar correctamente en iPhone

Para que la app se abra en modo standalone (sin barra de Safari), es **CRÍTICO** seguir estos pasos exactamente:

---

## PASOS CORRECTOS PARA INSTALAR EN iPhone:

### 1. **Abre la app desde Safari** (NO desde otro navegador):
   - Abre Safari en tu iPhone
   - Navega a la URL de la app
   - **IMPORTANTE:** Asegúrate de estar en la página `calendar.html` directamente

### 2. **Usa la app normalmente:**
   - Espera a que la página cargue completamente
   - Usa la app durante unos segundos
   - Esto asegura que Safari reconozca la app como instalable

### 3. **Toca el botón Compartir:**
   - En la barra inferior de Safari, toca el **botón de compartir** (cuadrado con flecha hacia arriba)
   - Se abrirá el menú de compartir

### 4. **Selecciona "Añadir a pantalla de inicio":**
   - Desplázate hacia abajo en el menú de compartir
   - Busca y toca **"Añadir a pantalla de inicio"** (icono de +)
   - Si no lo ves, desplázate más abajo

### 5. **Personaliza el nombre (opcional):**
   - Puedes cambiar el nombre que aparecerá en el icono
   - Por defecto será "Calendario" o "FamilySync"

### 6. **Toca "Añadir":**
   - Toca el botón "Añadir" en la esquina superior derecha
   - El icono se agregará a tu pantalla de inicio

### 7. **Abre desde el icono:**
   - Busca el icono en tu pantalla de inicio
   - Toca el icono para abrir la app
   - **✅ Debe abrirse SIN la barra de Safari** (modo standalone)

---

## ✅ VERIFICAR QUE ESTÁ INSTALADA CORRECTAMENTE:

### Si está bien instalada (PWA):
- ✅ Se abre **SIN barra de navegador** de Safari
- ✅ No se ve la URL en la parte superior
- ✅ Se ve como una app independiente
- ✅ El fondo ocupa toda la pantalla

### Si NO está bien instalada (acceso directo):
- ❌ Se abre **CON barra de navegador** de Safari
- ❌ Se ve la URL en la parte superior
- ❌ Parece que está dentro de Safari

---

## ⚠️ PROBLEMAS COMUNES Y SOLUCIONES:

### Problema 1: Se abre con barra de Safari

**Causa:** La app se añadió desde una página incorrecta o hay redirecciones.

**Solución:**
1. **Elimina el icono actual** de la pantalla de inicio (mantén presionado → eliminar)
2. **Abre Safari** y navega directamente a `calendar.html`
3. **Espera a que cargue completamente**
4. **Vuelve a añadir** usando Compartir → Añadir a pantalla de inicio
5. **Importante:** Asegúrate de añadir desde `calendar.html`, no desde `index.html` o otra página

### Problema 2: No aparece "Añadir a pantalla de inicio"

**Causa:** Puede estar oculto en el menú de compartir.

**Solución:**
1. Desplázate hacia abajo en el menú de compartir
2. Si no aparece, toca "Más" o "Editar acciones"
3. Activa "Añadir a pantalla de inicio" si está desactivado
4. Intenta de nuevo

### Problema 3: La app se abre pero sigue mostrando Safari

**Causa:** Puede haber errores de JavaScript que impiden el modo standalone.

**Solución:**
1. Abre la consola de desarrollador (si tienes acceso)
2. Verifica que no haya errores
3. Elimina y vuelve a instalar siguiendo los pasos correctos
4. Asegúrate de estar en HTTPS (requerido para PWA)

### Problema 4: La app se redirige a otra página al abrir

**Causa:** Hay redirecciones en el código.

**Solución:**
- Ya está corregido en el código
- Si persiste, elimina y reinstala

---

## 🔧 CONFIGURACIÓN TÉCNICA (Ya implementada):

La app ya tiene configurado:

✅ Meta tag `apple-mobile-web-app-capable="yes"`
✅ Meta tag `apple-mobile-web-app-status-bar-style="black-translucent"`
✅ Viewport con `viewport-fit=cover`
✅ Iconos de Apple Touch configurados
✅ Manifest.json con `display: "standalone"`
✅ Sin redirecciones cuando está en modo standalone
✅ Detección correcta de modo standalone

---

## 📝 NOTAS IMPORTANTES:

1. **HTTPS requerido:** La app debe estar en HTTPS para funcionar como PWA (GitHub Pages, Firebase Hosting, etc.)

2. **Desde la URL correcta:** Siempre añade a pantalla de inicio desde `calendar.html`, no desde otras páginas

3. **Primera vez:** La primera vez que añades puede tardar unos segundos en configurarse

4. **Actualizaciones:** Si actualizas la app, puedes necesitar eliminar y volver a añadir el icono

5. **Modo privado:** El modo privado/incógnito de Safari puede no permitir añadir a pantalla de inicio

---

## 🎯 RESUMEN RÁPIDO:

1. ✅ Abre Safari en iPhone
2. ✅ Navega a `calendar.html`
3. ✅ Espera a que cargue completamente
4. ✅ Toca Compartir (cuadrado con flecha)
5. ✅ Desplázate y toca "Añadir a pantalla de inicio"
6. ✅ Toca "Añadir"
7. ✅ Abre desde el icono (debe abrirse sin barra de Safari)

---

## 🔍 VERIFICACIÓN FINAL:

Después de instalar, cuando abras la app desde el icono:

- ✅ **NO debería verse la barra de Safari**
- ✅ **NO debería verse la URL**
- ✅ **Debería ocupar toda la pantalla**
- ✅ **Debería funcionar como app independiente**

Si ves la barra de Safari, elimina el icono y vuelve a instalarlo siguiendo los pasos exactos.

