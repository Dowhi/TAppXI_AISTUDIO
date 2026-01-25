# FamilySync - Sistema de Diseño Unificado

Este documento describe el sistema de diseño unificado implementado para la aplicación FamilySync, que asegura coherencia visual entre la versión web (HTML/CSS/JS) y la versión Flutter (Android/iOS).

## 🎨 Paleta de Colores

### Colores Principales
- **Primary**: `#1B5E20` - Verde oscuro (Header principal, elementos principales)
- **Primary Light**: `#2E7D32` - Verde medio (Variantes claras)
- **Primary Dark**: `#0F4C14` - Verde muy oscuro (Variantes oscuras)

### Colores Secundarios
- **Secondary**: `#1976D2` - Azul (Navigation tabs)
- **Secondary Light**: `#2196F3` - Azul claro (Month navigation)
- **Secondary Dark**: `#1565C0` - Azul oscuro

### Colores de Estado
- **Success**: `#10B981` - Verde éxito
- **Error**: `#EF4444` - Rojo error
- **Warning**: `#F59E0B` - Ámbar advertencia
- **Info**: `#3B82F6` - Azul información

### Colores de Fondo
- **Background Primary**: `#F5F5F5` - Fondo principal
- **Background Secondary**: `#FFFFFF` - Superficie (cards, modals)
- **Background Dark**: `#2A2A2A` - Fondo oscuro (páginas dark mode)

### Colores de Texto
- **Text Primary**: `#333333` - Texto principal
- **Text Secondary**: `#666666` - Texto secundario
- **Text Tertiary**: `#999999` - Texto terciario
- **Text White**: `#FFFFFF` - Texto blanco

### Colores de Borde
- **Border**: `#DDDDDD` - Borde estándar
- **Border Light**: `#F0F0F0` - Borde claro
- **Border Dark**: `#CCCCCC` - Borde oscuro

## 📐 Espaciados

### Sistema de Espaciado
- **XS**: 4px
- **SM**: 8px
- **MD**: 12px
- **LG**: 16px
- **XL**: 20px
- **2XL**: 24px
- **3XL**: 32px

## 🔲 Radios de Borde

- **SM**: 4px
- **MD**: 8px
- **LG**: 12px
- **XL**: 16px
- **Full**: 50px (círculos)

## 🌫️ Sombras

- **SM**: `0 1px 2px rgba(0, 0, 0, 0.05)`
- **MD**: `0 2px 4px rgba(0, 0, 0, 0.1)`
- **LG**: `0 4px 8px rgba(0, 0, 0, 0.15)`
- **XL**: `0 8px 16px rgba(0, 0, 0, 0.2)`

## 🔄 Transiciones

- **Fast**: 0.15s ease
- **Base**: 0.2s ease
- **Slow**: 0.3s ease

## 📝 Tipografía

### Familia de Fuente
```css
-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif
```

### Tamaños
- **H1**: 24px
- **H2**: 20px
- **H3**: 18px
- **H4**: 16px
- **H5**: 14px
- **H6**: 12px
- **Body**: 16px (14px en móviles)

### Pesos
- **Regular**: 400
- **Medium**: 500
- **Semibold**: 600
- **Bold**: 700

## 🎯 Componentes

### Headers
- **Color**: Primary (`#1B5E20`)
- **Padding**: 4px 12px
- **Min-height**: 36px
- **Sombra**: SM

### Botones
- **Border-radius**: 8px
- **Padding**: 12px 24px (estándar)
- **Font-weight**: 600
- **Transición**: scale(0.97) en active

### Inputs
- **Border**: 1px solid `#DDDDDD`
- **Border-radius**: 8px
- **Padding**: 12px 16px
- **Focus**: Border 2px Primary

### Cards
- **Background**: `#FFFFFF`
- **Border-radius**: 12px
- **Shadow**: SM
- **Padding**: 16px

### Modales
- **Max-width**: 500px (600px en tablets)
- **Border-radius**: 16px
- **Shadow**: XL
- **Padding**: 20px

## 📱 Aplicación

### Versión Web
Los estilos globales están definidos en `web/global-style.css` y pueden ser importados en las pantallas HTML:

```html
<link rel="stylesheet" href="global-style.css">
```

### Versión Flutter
Los estilos están definidos en `lib/theme/app_theme.dart` y se aplican automáticamente a toda la aplicación Flutter.

## 🔒 Principios

1. **Consistencia**: Todos los componentes usan la misma paleta de colores y espaciados
2. **Jerarquía**: Los tamaños y pesos de fuente crean una clara jerarquía visual
3. **Accesibilidad**: Contraste adecuado entre texto y fondos
4. **Responsividad**: El diseño se adapta a diferentes tamaños de pantalla
5. **Modernidad**: Uso de Material Design 3 (Material You) donde aplica

## 📋 Checklist para Nuevos Componentes

Al crear nuevos componentes, asegúrate de:
- [ ] Usar colores de la paleta definida
- [ ] Aplicar espaciados consistentes
- [ ] Usar radios de borde estandarizados
- [ ] Aplicar sombras apropiadas
- [ ] Incluir transiciones suaves
- [ ] Seguir la jerarquía de tipografía
- [ ] Probar en modo claro y oscuro
- [ ] Verificar accesibilidad

## 🔗 Referencias

- [Material Design 3](https://m3.material.io/)
- [Color System](https://material.io/design/color/the-color-system.html)
- [Typography](https://material.io/design/typography/the-type-system.html)

