# PROMPT COMPLETO PARA RECREAR LA APP FAMILYSYNC DESDE CERO

## CONTEXTO Y DESCRIPCIÓN GENERAL

Necesito crear una aplicación web PWA (Progressive Web App) llamada **FamilySync** - un calendario familiar colaborativo con sincronización en tiempo real. La aplicación debe estar completamente desarrollada en HTML, CSS y JavaScript vanilla (sin frameworks como React o Vue), y debe funcionar perfectamente en dispositivos móviles (iPhone/iPad y Android) y escritorio.

**Tecnologías principales:**
- HTML5, CSS3, JavaScript ES6+
- Firebase Firestore para base de datos en tiempo real
- Firebase Authentication (aunque se usa un sistema de usuarios locales)
- Service Workers para funcionalidad offline y alarmas
- PWA con manifest.json

---

## ESTRUCTURA DE ARCHIVOS Y DIRECTORIOS

```
web/
├── index.html                          # Página de inicio/landing
├── calendar.html                       # Página principal del calendario (más importante)
├── summary.html                        # Página de estadísticas y resumen
├── shifts.html                         # Gestión de turnos disponibles
├── shift-config.html                   # Configuración de turnos
├── users-management.html               # Gestión de usuarios
├── alarm-notification.html             # Pantalla de notificación de alarma
├── iphone.html                         # Versión específica para iPhone
├── manifest.json                       # Configuración PWA
├── sw-alarm.js                         # Service Worker para alarmas
├── firestore_backup.html               # Herramienta de backup
├── firestore_cleanup.html              # Herramienta de limpieza
├── icons/                              # Iconos de la aplicación
│   ├── Icon-192.png
│   ├── Icon-512.png
│   ├── Icon-maskable-192.png
│   └── Icon-maskable-512.png
└── favicon.png                         # Favicon

```

---

## ARCHIVO 1: `index.html` - PÁGINA DE INICIO

**Funcionalidad:**
- Página de bienvenida que detecta el dispositivo (especialmente iOS)
- Redirige automáticamente a `calendar.html` o `iphone.html` según el dispositivo
- Muestra información de la app y opciones de instalación como PWA

**Elementos clave:**
- Detección de iOS mediante `navigator.userAgent`
- Botones para navegar a diferentes secciones
- Instrucciones de instalación como PWA
- Diseño limpio y minimalista

**Características técnicas:**
- Meta tags para PWA: `apple-mobile-web-app-capable`, `theme-color`
- Enlaces a `calendar.html`, `summary.html`, `shifts.html`
- Script de detección de dispositivo y redirección automática

---

## ARCHIVO 2: `calendar.html` - CALENDARIO PRINCIPAL (ARCHIVO MÁS IMPORTANTE)

Este es el archivo más complejo y central de la aplicación. Contiene aproximadamente 5000+ líneas de código.

### ESTRUCTURA HTML:

```html
<!DOCTYPE html>
<html lang="es">
<head>
    <!-- Meta tags PWA, Firebase SDK, estilos CSS -->
</head>
<body>
    <!-- Header con título "My Calendar" -->
    <!-- Navegación por tabs: CALENDARIO, AÑO (2025), RESUMEN -->
    <!-- Navegación de mes con flechas y título -->
    <!-- Grid de calendario (7 columnas x 5-6 filas) -->
    <!-- Botones de acción: PINTAR, EDITAR, TURNOS -->
    <!-- Modales: evento, configuración, alarma -->
</body>
</html>
```

### SECCIÓN HEADER:

- **Fondo:** `#1B5E20` (verde oscuro)
- **Color texto:** blanco
- **Elementos:**
  - Título "My Calendar" a la izquierda
  - Botón de menú/configuración (⚙️) a la derecha
  - Selector de usuario con 5 usuarios (botones circulares con colores)
  - Altura: 44px mínimo

### NAVEGACIÓN POR TABS:

- **Fondo:** `#1976D2` (azul)
- **3 tabs:** "CALENDARIO", "2025" (año actual), "RESUMEN"
- **Tab activo:** fondo `rgba(255,255,255,0.2)`
- **Clic en tab:** cambia la vista entre calendario, año y estadísticas

### NAVEGACIÓN DE MES:

- **Fondo:** `#2196F3` (azul claro)
- **Elementos:**
  - Flecha izquierda (`‹`) para mes anterior
  - Título del mes en español (ej: "Octubre 2025")
  - Flecha derecha (`›`) para mes siguiente
- **Altura:** 32px

### GRID DEL CALENDARIO:

**Estructura CSS:**
```css
.calendar-grid {
    display: grid;
    grid-template-columns: repeat(7, 1fr);
    gap: 0;
}
```

**Celdas del día:**
- **Bordes:** 1px sólido `#ddd`
- **Altura mínima:** `calc((100vh - 160px) / 6)` para 6 semanas
- **Altura cuando hay 5 semanas:** `calc((100vh - 160px) / 5)`
- **Estado "today":** borde `2px solid #1B5E20`, fondo `#f1f8e9`
- **Número de día "today":** fondo rojo (`#FF1744`), círculo blanco
- **Días de otro mes:** opacidad 0.3, fondo `#f9f9f9`

**Contenido de cada celda:**
1. **Número del día** (esquina superior derecha)
2. **Abreviaturas de turnos** (ej: "D1", "D2", "L") con colores
3. **Iconos de categorías** (parte inferior, máximo 3)
4. **Texto de nota principal** (centro, con color según usuario)
5. **Indicador de cantidad de turnos**

### BOTONES DE ACCIÓN (Footer):

- **PINTAR** (naranja `#FF9800`): modo pintura para asignar turnos rápidamente
- **EDITAR** (azul `#2196F3`): abre modal de edición de día
- **TURNOS** (verde `#4CAF50`): navega a `shifts.html`

---

### MODAL DE EVENTO/DÍA (`dayModal`):

**Estructura:**
```html
<div class="modal" id="dayModal">
    <div class="modal-content">
        <div class="modal-header">
            <div class="modal-title">Fecha: DD/MM/YYYY</div>
            <button class="modal-close">×</button>
        </div>
        <div class="modal-body">
            <!-- Sección de Notas del día -->
            <textarea id="mainTextarea"></textarea>
            
            <!-- Sección de Categorías (3 dropdowns) -->
            <!-- Dropdown 1, 2, 3 con iconos y texto -->
            
            <!-- Sección de Alarma -->
            <div class="alarm-section" onclick="openAlarmModal()">
                <div class="alarm-icon">🔔</div>
                <div class="alarm-text">Aviso de Alarma</div>
                <div class="alarm-number" id="alarmNumber">0</div>
            </div>
            
            <!-- Botones: CANCELAR, ACEPTAR -->
        </div>
    </div>
</div>
```

**Funcionalidades del modal:**
1. **Textarea de notas:**
   - Permite texto multilínea
   - Tamaño de texto configurable (8-20px)
   - Se guarda en Firebase bajo `events[].type === 'note'`
   
2. **3 Dropdowns de categorías:**
   - Cada dropdown tiene iconos: ⭐, ❤️, 🏥, 📞, ⚽, 🎂, 🔔, 🛒, 🐶, ✈️
   - Texto asociado: "Estrella", "Corazón", "Hospital", etc.
   - Se guardan como `categories: [{icon: "⭐", text: "Estrella"}]`

3. **Sección de alarma:**
   - Muestra número de alarmas configuradas
   - Al hacer clic, abre modal de configuración de alarmas

**Botones:**
- **CANCELAR:** cierra el modal sin guardar
- **ACEPTAR:** guarda cambios en Firebase y cierra

---

### MODAL DE CONFIGURACIÓN DE ALARMA (`alarmModal`):

**Estructura:**
```html
<div class="alarm-modal" id="alarmModal">
    <div class="alarm-modal-content">
        <div class="alarm-modal-header">
            <div class="alarm-modal-title">Configurar Alarma</div>
            <button class="alarm-modal-close">×</button>
        </div>
        <div class="alarm-modal-body">
            <input type="date" id="alarmDateInput" />
            <input type="time" id="alarmTimeInput" />
            <button onclick="addAlarm()">AGREGAR</button>
            <div class="alarm-list" id="alarmList">
                <!-- Lista de alarmas configuradas -->
            </div>
        </div>
    </div>
</div>
```

**Funcionalidades:**
- Agregar alarmas con fecha y hora
- Listar alarmas existentes
- Eliminar alarmas (botón × rojo)
- Guardar alarmas en Firebase bajo `note.alarms: [{dateTime: ISO, id: timestamp}]`

---

### MODAL DE CONFIGURACIÓN (`settingsModal`):

**Opciones:**
1. **Tema:** Sistema, Claro, Oscuro
2. **Inicio de semana:** Lunes o Domingo
3. **Resaltar hoy:** checkbox
4. **Semanas inteligentes:** checkbox (ajusta altura cuando hay 5 semanas)

**Botones:**
- **Guardar:** aplica cambios y los guarda en localStorage
- **Restablecer:** vuelve a valores por defecto

---

### VISTA DE AÑO (`yearView`):

- Muestra los 12 meses en una cuadrícula
- Cada mes muestra un mini calendario con días marcados
- Navegación con flechas para cambiar año
- Clic en un mes: cambia a vista mensual de ese mes

---

## JAVASCRIPT DEL CALENDARIO - FUNCIONES PRINCIPALES

### VARIABLES GLOBALES:

```javascript
let currentDate = new Date();
let currentUserId = 1; // ID del usuario actual (1-5)
let selectedDate = null; // Fecha seleccionada para editar
let db = null; // Instancia de Firestore
let isFirebaseConnected = false;
let eventsCache = { events: {} }; // Cache de eventos
let alarms = []; // Array de alarmas del día seleccionado
let users = [
    {id: 1, name: "Usuario 1", color: "#FF5722"},
    {id: 2, name: "Usuario 2", color: "#2196F3"},
    {id: 3, name: "Usuario 3", color: "#4CAF50"},
    {id: 4, name: "Usuario 4", color: "#FF9800"},
    {id: 5, name: "Usuario 5", color: "#9C27B0"}
];
```

### FUNCIONES PRINCIPALES:

1. **`init()`** - Inicialización:
   - Conecta a Firebase
   - Carga usuario guardado de localStorage
   - Renderiza calendario
   - Solicita permiso de notificaciones
   - Registra Service Worker
   - Configura detección de iOS/Android

2. **`renderCalendar()`** - Renderiza el grid:
   - Calcula días del mes
   - Crea celdas con días anteriores/siguientes
   - Aplica estilos según estado (today, other-month)
   - Llama a `renderDay()` para cada día

3. **`renderDay(date)`** - Renderiza contenido de un día:
   - Obtiene eventos de ese día desde Firebase o cache
   - Muestra turnos con abreviaturas y colores
   - Muestra iconos de categorías
   - Muestra texto de nota con color del usuario
   - Muestra cantidad de turnos

4. **`openDayModal(date)`** - Abre modal de edición:
   - Establece `selectedDate`
   - Carga eventos del día
   - Rellena textarea y categorías
   - Carga alarmas con `loadAlarms()`
   - Muestra el modal

5. **`saveDayChanges()`** - Guarda cambios:
   - Obtiene texto del textarea
   - Obtiene categorías seleccionadas
   - Guarda en Firebase bajo `calendar_events/{dateKey}` con estructura:
     ```json
     {
         "events": [
             {
                 "type": "note",
                 "text": "Texto de la nota",
                 "textSize": 11,
                 "userId": 1,
                 "userColor": "#FF5722",
                 "categories": [{"icon": "⭐", "text": "Estrella"}],
                 "alarms": [...],
                 "createdAt": "ISO string",
                 "updatedAt": "ISO string"
             },
             {
                 "type": "shift",
                 "shiftId": "shift_id",
                 "shiftName": "D1",
                 "shiftColor": "#FF5722",
                 "userId": 1,
                 "time": "08:00-16:00"
             }
         ],
         "lastModified": "server timestamp",
         "modifiedBy": 1
     }
     ```

6. **`getEventsForDate(date)`** - Obtiene eventos:
   - Primero intenta desde cache
   - Si no existe, consulta Firebase
   - Formatea fecha como clave: `"2025-10-31"`
   - Retorna array de eventos

7. **`saveEvents(date, events)`** - Guarda eventos:
   - Guarda en Firebase bajo `calendar_events/{dateKey}`
   - Actualiza cache
   - Fallback a localStorage si Firebase falla

### SISTEMA DE ALARMAS:

1. **`loadAlarms()`** - Carga alarmas del día seleccionado
2. **`saveAlarms()`** - Guarda alarmas en Firebase dentro de `note.alarms`
3. **`addAlarm()`** - Agrega nueva alarma con validación
4. **`deleteAlarm(index)`** - Elimina alarma
5. **`renderAlarmsList()`** - Renderiza lista de alarmas en modal
6. **`scheduleAllAlarms()`** - Programa alarmas en Service Worker
7. **`checkAlarms()`** - Verifica cada minuto si alguna alarma debe activarse
8. **`showAlarmNotification(alarm)`** - Muestra pantalla de alarma
9. **`openAlarmNotificationPage()`** - Abre `alarm-notification.html` con parámetros

### DETECCIÓN DE DISPOSITIVOS:

```javascript
const isMobile = /iPhone|iPad|iPod|Android/i.test(navigator.userAgent);
const isIOS = /iPad|iPhone|iPod/.test(navigator.userAgent) && !window.MSStream;
const isAndroid = /Android/i.test(navigator.userAgent);
```

### CONFIGURACIÓN FIREBASE:

```javascript
const firebaseConfig = {
    apiKey: "AIzaSyB5vvp7IQOZLO7LlsUY_Wq-H8M_5PH3ZQE",
    authDomain: "apptaxi-f2190.firebaseapp.com",
    projectId: "apptaxi-f2190",
    storageBucket: "apptaxi-f2190.firebasestorage.app",
    messagingSenderId: "804273724178",
    appId: "1:804273724178:web:c5955a1f657884c0e7f1cb",
    measurementId: "G-3D8R30TYTM"
};
```

---

## ARCHIVO 3: `summary.html` - ESTADÍSTICAS Y RESUMEN

**Funcionalidades:**

1. **ESTADÍSTICAS DE TURNOS:**
   - Tabs: "Mes", "Año", "Rango"
   - Tabla con turnos: nombre, cantidad, tiempo total, global
   - Navegación de fechas para rango personalizado
   - Suma global de todos los turnos

2. **NOTAS CERCANAS:**
   - Muestra notas de últimos 30 días
   - Tabs: "Pasadas" / "Próximas"
   - Lista con fecha y texto

3. **BUSCAR EN NOTAS:**
   - Input de búsqueda
   - Busca en todas las notas de Firebase
   - Muestra resultados con fecha

4. **BUSCAR DÍAS POR ICONO:**
   - Selector de iconos
   - Checkbox "Días pasados"
   - Filtros: turnos, autores
   - Lista de resultados con fecha clicable

**Diseño:**
- Header verde oscuro con botón volver
- Secciones con bordes redondeados
- Tablas y listas estilizadas
- Colores: fondo `#e9edf1`, texto `#2f3b44`

---

## ARCHIVO 4: `shifts.html` - GESTIÓN DE TURNOS

**Funcionalidades:**

1. **Lista de turnos disponibles:**
   - Cada turno muestra: color, nombre, horario
   - Botón de opciones (⋮) para editar/eliminar
   - Estado vacío cuando no hay turnos

2. **Botones de acción:**
   - **AGREGAR TURNO:** abre modal para crear nuevo
   - **CONFIGURAR:** navega a `shift-config.html`

**Diseño:**
- Fondo oscuro (`#1a1a1a`)
- Header con botón volver
- Lista de turnos con cards oscuras
- Botones de acción en footer

---

## ARCHIVO 5: `shift-config.html` - CONFIGURACIÓN DE TURNOS

**Funcionalidades:**
- Crear, editar, eliminar plantillas de turnos
- Cada turno tiene: nombre, color, horario de inicio y fin
- Guardado en Firebase bajo colección `shifts`

---

## ARCHIVO 6: `users-management.html` - GESTIÓN DE USUARIOS

**Funcionalidades:**

1. **Perfil de cada usuario (1-5):**
   - Input para cambiar nombre
   - Selector de color (paleta de colores)
   - Guardado en Firebase bajo colección `users`

2. **Estructura de usuario:**
```json
{
    "id": 1,
    "name": "Usuario 1",
    "color": "#FF5722"
}
```

**Diseño:**
- Cards blancas con inputs
- Selector de color visual
- Header verde con botón volver

---

## ARCHIVO 7: `alarm-notification.html` - PANTALLA DE ALARMA

**Diseño exacto (réplica de imagen):**

**Header oscuro:**
- Fondo: `#2f2f2f`
- Texto blanco
- Nombre del usuario: "M. Carmen:"
- Título: "NOTIFICACIÓN" (mayúsculas)

**Contenido principal (gris claro `#e5e5e5`):**
- **Reloj analógico:**
  - Círculo blanco con borde
  - Manecillas de hora y minuto
  - Marca de horas (4 puntos)
  - Centro sólido
  
- **Caja de fecha/hora:**
  - Fondo blanco, borde negro 2px
  - Texto: "HOY: 31/10/25"
  - Hora: "22:12"

- **Sliders interactivos:**
  1. "Deslizar para silenciar alarma >>>" con icono 🔕
  2. "Deslizar para salir >>>" con icono ✕
  - Funcionalidad de deslizar (touch)

**Footer oscuro (`#2f2f2f`):**
- Título: "Notas del día de la alarma"
- Caja de texto blanco con borde mostrando nota

**Funcionalidades:**
- Parámetros URL: `?date=2025-10-31&time=22:12&note=Texto&user=Nombre`
- Sliders funcionan con touch events
- Botón silenciar: cierra la ventana
- Botón salir: redirige a `calendar.html`

---

## ARCHIVO 8: `sw-alarm.js` - SERVICE WORKER PARA ALARMAS

**Funcionalidades:**

1. **Instalación y activación:**
   - Se registra automáticamente
   - Reclama clientes inmediatamente

2. **Programación de alarmas:**
   - Recibe mensajes de tipo `SCHEDULE_ALARM`
   - Programa notificaciones con `setTimeout`
   - Almacena alarmas en `Map` para cancelación

3. **Notificaciones:**
   - Muestra notificación cuando llega la hora
   - Al hacer clic, abre `alarm-notification.html`
   - Maneja errores de permisos graciosamente

4. **Eventos:**
   - `install`: activa inmediatamente
   - `activate`: reclama clientes
   - `notificationclick`: abre página de alarma
   - `message`: recibe alarmas programadas

---

## ARCHIVO 9: `manifest.json` - CONFIGURACIÓN PWA

```json
{
    "name": "Calendario Familiar",
    "short_name": "Calendario",
    "start_url": "./",
    "display": "standalone",
    "background_color": "#1B5E20",
    "theme_color": "#1B5E20",
    "description": "Calendario familiar compartido con sincronización en tiempo real",
    "orientation": "portrait-primary",
    "icons": [
        {
            "src": "icons/Icon-192.png",
            "sizes": "192x192",
            "type": "image/png"
        },
        {
            "src": "icons/Icon-512.png",
            "sizes": "512x512",
            "type": "image/png"
        }
    ]
}
```

---

## SISTEMA DE COLORES Y DISEÑO

### PALETA DE COLORES PRINCIPALES:

- **Verde oscuro:** `#1B5E20` (header, tema)
- **Azul:** `#1976D2` (tabs)
- **Azul claro:** `#2196F3` (navegación mes, botón EDITAR)
- **Naranja:** `#FF9800` (botón PINTAR, alarmas)
- **Verde:** `#4CAF50` (botón TURNOS)
- **Rojo:** `#FF1744` (indicador de hoy)
- **Fondo claro:** `#f5f5f5`
- **Gris oscuro:** `#2f2f2f` (pantalla alarma)

### TIPOGRAFÍA:

- **Familia:** `-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Arial, sans-serif`
- **Tamaños:**
  - Header: 16px
  - Tabs: 12px
  - Días: 11px
  - Notas: 11-20px (configurable)

---

## FUNCIONALIDADES ESPECÍFICAS DETALLADAS

### 1. MODO PINTURA:

- Activa al hacer clic en "PINTAR"
- Permite seleccionar un turno de la lista
- Al tocar días del calendario, asigna ese turno
- Muestra indicador visual del turno seleccionado
- Desactiva al hacer clic en "EDITAR" o "TURNOS"

### 2. GESTIÓN DE TURNOS EN DÍAS:

- Los turnos se guardan como eventos tipo "shift"
- Cada turno tiene: `shiftId`, `shiftName`, `shiftColor`, `time`
- Se muestran como abreviaturas (ej: "D1", "D2", "L") con color de fondo
- Un día puede tener múltiples turnos

### 3. CATEGORÍAS:

- Máximo 3 categorías por día
- Cada categoría: icono (emoji) + texto
- Se muestran como iconos pequeños en la parte inferior de las celdas
- Iconos disponibles: ⭐, ❤️, 🏥, 📞, ⚽, 🎂, 🔔, 🛒, 🐶, ✈️

### 4. NOTAS:

- Una nota principal por día
- Texto multilínea
- Tamaño de texto configurable (8-20px)
- Se guarda con color del usuario que la creó
- Se muestra en el centro de la celda del día

### 5. USUARIOS:

- 5 usuarios predefinidos (1-5)
- Cada usuario tiene: ID, nombre, color
- Los nombres se pueden cambiar en `users-management.html`
- Los colores se asignan automáticamente pero pueden cambiarse
- El usuario actual se guarda en `localStorage.getItem('current_user_id')`

### 6. ALARMAS:

- Se configuran por día
- Múltiples alarmas por día
- Cada alarma tiene: `dateTime` (ISO string), `id` (timestamp)
- Se guardan dentro de `note.alarms: []`
- Verificación cada 30 segundos (móvil) o 60 segundos (escritorio)
- Service Worker programa notificaciones para cuando la app está cerrada
- iOS: verifica alarmas perdidas al abrir la app

### 7. SINCRONIZACIÓN FIREBASE:

**Colecciones:**
1. `calendar_events/{dateKey}` - Eventos del día
2. `shifts/{shiftId}` - Plantillas de turnos
3. `users/{userId}` - Información de usuarios

**Reglas de Firestore (si aplica):**
- Lectura/escritura pública (sin autenticación requerida)

### 8. CACHE Y OFFLINE:

- Cache de eventos en memoria (`eventsCache`)
- Fallback a `localStorage` si Firebase falla
- Service Worker para funcionalidad offline
- Alarmas guardadas en `localStorage` para iOS

---

## DETALLES TÉCNICOS ESPECÍFICOS

### RESPONSIVE DESIGN:

- **Móviles:** Viewport `width=device-width, initial-scale=1.0, maximum-scale=1.0`
- **PWA:** Meta tags `apple-mobile-web-app-capable`, `viewport-fit=cover`
- **Touch:** `-webkit-tap-highlight-color` para feedback

### NAVEGACIÓN:

- Enlaces directos entre páginas HTML
- Uso de `window.location.href` para navegar
- Parámetros URL para alarmas: `alarm-notification.html?date=...&time=...`

### EVENTOS Y LISTENERS:

- Click en días: abre modal de edición
- Cambio de mes: recalcula y renderiza
- Cierre de modales: click fuera o botón X
- Touch events para sliders de alarma

### VALIDACIONES:

- Fechas de alarma no pueden ser en el pasado
- Texto de notas con `trim()`
- Categorías opcionales (máximo 3)
- Usuarios válidos (1-5)

---

## FUNCIONALIDADES ESPECIALES iOS

1. **Detección de iOS:**
   - Redirección a `iphone.html` si es necesario
   - Mensaje para instalar como PWA

2. **Alarmas en iOS:**
   - Service Worker limitado, usa verificación local
   - Detecta alarmas perdidas al abrir la app
   - Verificación cada 30 segundos cuando está abierta
   - Guarda alarmas en `localStorage` como backup

3. **Detección de PWA instalada:**
   - `window.matchMedia('(display-mode: standalone)')`
   - `window.navigator.standalone`
   - Muestra mensaje si no está instalada

---

## INSTALACIÓN Y CONFIGURACIÓN

### REQUISITOS:

1. **Firebase:**
   - Proyecto creado
   - Firestore habilitado
   - Reglas configuradas para lectura/escritura

2. **Hosting:**
   - Cualquier servidor web (GitHub Pages, Netlify, Firebase Hosting)
   - HTTPS requerido para Service Workers

3. **Iconos:**
   - Iconos en formato PNG
   - Tamaños: 192x192, 512x512
   - Maskable: 192x192, 512x512

### ARCHIVOS NECESARIOS:

- Todos los archivos HTML mencionados
- `manifest.json`
- `sw-alarm.js`
- Carpeta `icons/` con imágenes
- `favicon.png`

---

## CONSIDERACIONES DE IMPLEMENTACIÓN

1. **Sin frameworks:** Todo en JavaScript vanilla
2. **Compatibilidad:** Funciona en Safari iOS, Chrome Android, navegadores modernos
3. **Performance:** Cache de eventos, verificación optimizada
4. **Offline:** Fallback a localStorage, Service Worker básico
5. **Seguridad:** Firebase con reglas apropiadas (ajustar según necesidades)

---

## ORDEN DE IMPLEMENTACIÓN RECOMENDADO

1. **Estructura base:** `index.html`, `manifest.json`, estructura de carpetas
2. **Calendario básico:** Grid, navegación, renderizado de días
3. **Firebase:** Conexión, lectura/escritura de eventos
4. **Modal de edición:** Textarea, categorías, guardado
5. **Turnos:** Asignación, visualización, gestión
6. **Usuarios:** Selector, colores, gestión
7. **Alarmas:** Configuración, Service Worker, notificaciones
8. **Estadísticas:** `summary.html` con todas las funciones
9. **Páginas secundarias:** `shifts.html`, `users-management.html`
10. **Pantalla de alarma:** `alarm-notification.html` con diseño exacto
11. **Optimizaciones:** iOS, PWA, cache, offline

---

## NOTAS FINALES

- **Idioma:** Todo en español
- **Formato de fechas:** DD/MM/YYYY
- **Formato de hora:** HH:MM (24 horas)
- **Zona horaria:** UTC o local (ajustar según necesidad)
- **Testing:** Probar en iPhone Safari, Chrome Android, Chrome Desktop

Este prompt contiene TODA la información necesaria para recrear la aplicación completa desde cero con todos los detalles, funcionalidades, diseño y estructura de archivos.

