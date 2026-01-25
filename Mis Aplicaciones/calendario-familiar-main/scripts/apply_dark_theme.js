// Script para aplicar tema oscuro a todas las pantallas HTML

const fs = require('fs');
const path = require('path');

// Función para aplicar tema
const themeFunction = `
        // Aplicar tema guardado
        function applyTheme() {
            try {
                const settings = JSON.parse(localStorage.getItem('app_settings_v1')) || {};
                const theme = settings.theme || 'system';
                
                if (theme === 'dark') {
                    document.body.classList.add('dark-theme');
                    document.body.classList.remove('light-theme');
                } else if (theme === 'light') {
                    document.body.classList.add('light-theme');
                    document.body.classList.remove('dark-theme');
                } else {
                    document.body.classList.remove('dark-theme', 'light-theme');
                }
            } catch (e) {
                console.error('Error aplicando tema:', e);
            }
        }`;

// Estilos CSS para tema oscuro
const darkThemeStyles = `
        /* Dark Theme Styles */
        body.dark-theme {
            background: #1a1a1a;
            color: #e0e0e0;
        }
        
        body.dark-theme .header,
        body.dark-theme .app-header {
            background: #0D47A1;
            border-bottom: 1px solid #0a3470;
        }
        
        body.dark-theme input,
        body.dark-theme select,
        body.dark-theme textarea {
            background: #2a2a2a;
            color: #e0e0e0;
            border-color: #3a3a3a;
        }
        
        body.dark-theme button {
            background: #2a2a2a;
            color: #e0e0e0;
            border-color: #3a3a3a;
        }
        
        body.dark-theme .card,
        body.dark-theme .modal-content {
            background: #2a2a2a;
            color: #e0e0e0;
            border-color: #3a3a3a;
        }
        
        /* Auto dark mode */
        @media (prefers-color-scheme: dark) {
            body:not(.light-theme) {
                background: #1a1a1a;
                color: #e0e0e0;
            }
            
            body:not(.light-theme) .header,
            body:not(.light-theme) .app-header {
                background: #0D47A1;
            }
            
            body:not(.light-theme) input,
            body:not(.light-theme) select,
            body:not(.light-theme) textarea {
                background: #2a2a2a;
                color: #e0e0e0;
                border-color: #3a3a3a;
            }
        }`;

// Lista de archivos a actualizar
const files = [
    'web/week-view.html',
    'web/recurring-events.html',
    'web/reminders.html',
    'web/export-calendar.html',
    'web/alarm-notification.html'
];

files.forEach(filePath => {
    try {
        let content = fs.readFileSync(filePath, 'utf8');
        
        // Agregar estilos de tema oscuro antes del cierre de </style>
        if (!content.includes('Dark Theme Styles')) {
            content = content.replace('</style>', darkThemeStyles + '\n    </style>');
        }
        
        // Agregar función applyTheme si no existe
        if (!content.includes('function applyTheme')) {
            // Buscar donde insertar la función
            const scriptMatch = content.match(/<script[^>]*>/);
            if (scriptMatch) {
                const insertPoint = content.indexOf(scriptMatch[0]) + scriptMatch[0].length;
                content = content.slice(0, insertPoint) + '\n' + themeFunction + '\n' + content.slice(insertPoint);
            }
        }
        
        // Agregar llamada a applyTheme en init o DOMContentLoaded
        if (content.includes('function init()') && !content.includes('applyTheme()')) {
            content = content.replace(
                'function init() {',
                'function init() {\n            applyTheme();'
            );
        } else if (content.includes('document.addEventListener(\'DOMContentLoaded\'') && !content.includes('applyTheme()')) {
            content = content.replace(
                'document.addEventListener(\'DOMContentLoaded\', ',
                'document.addEventListener(\'DOMContentLoaded\', () => { applyTheme(); '
            );
        }
        
        fs.writeFileSync(filePath, content);
        console.log(`✅ Actualizado: ${filePath}`);
        
        // Copiar a docs
        const docsPath = filePath.replace('web/', 'docs/');
        fs.copyFileSync(filePath, docsPath);
        console.log(`📁 Copiado a: ${docsPath}`);
        
    } catch (error) {
        console.error(`❌ Error actualizando ${filePath}:`, error.message);
    }
});

console.log('\n✨ Proceso completado!');
