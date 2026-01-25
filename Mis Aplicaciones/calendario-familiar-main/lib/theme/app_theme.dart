import 'package:flutter/material.dart';
import 'package:calendario_familiar/core/utils/color_ext.dart';
import 'package:calendario_familiar/core/models/app_event.dart';

class AppTheme {
  // Paleta de colores unificada con la versión web
  static const Color _primaryColor = Color(0xFF1B5E20);          // Verde oscuro - Header principal
  static const Color _primaryLight = Color(0xFF2E7D32);          // Verde medio
  static const Color _primaryDark = Color(0xFF0F4C14);           // Verde muy oscuro
  static const Color _secondaryColor = Color(0xFF1976D2);         // Azul - Navigation tabs
  static const Color _secondaryLight = Color(0xFF2196F3);         // Azul claro - Month nav
  static const Color _secondaryDark = Color(0xFF1565C0);          // Azul oscuro
  static const Color _accentColor = Color(0xFFF59E0B);            // Ámbar warning
  static const Color _successColor = Color(0xFF10B981);           // Verde éxito
  static const Color _errorColor = Color(0xFFEF4444);             // Rojo error
  static const Color _infoColor = Color(0xFF3B82F6);              // Azul información
  
  // Colores de fondo
  static const Color _bgPrimary = Color(0xFFF5F5F5);              // Fondo principal
  static const Color _bgSecondary = Color(0xFFFFFFFF);            // Superficie
  static const Color _bgDark = Color(0xFF2A2A2A);                 // Fondo oscuro
  
  // Colores de texto
  static const Color _textPrimary = Color(0xFF333333);            // Texto principal
  static const Color _textSecondary = Color(0xFF666666);          // Texto secundario
  static const Color _textTertiary = Color(0xFF999999);           // Texto terciario
  
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      // ColorScheme unificado
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: _primaryColor,
        onPrimary: Colors.white,
        secondary: _secondaryColor,
        onSecondary: Colors.white,
        tertiary: _accentColor,
        error: _errorColor,
        onError: Colors.white,
        surface: _bgSecondary,
        onSurface: _textPrimary,
        surfaceContainerHighest: _bgPrimary,
      ),
      scaffoldBackgroundColor: _bgPrimary,
      // AppBar unificado
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: _primaryColor,
        foregroundColor: Colors.white,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
      // Botones elevados
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 2,
          backgroundColor: _primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
      // Inputs unificados
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFDDDDDD)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: _primaryColor, width: 2),
        ),
        filled: true,
        fillColor: _bgSecondary,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      // Floating Action Button
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: _primaryColor,
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      // Chips
      chipTheme: ChipThemeData(
        backgroundColor: _bgSecondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      // Dividers
      dividerTheme: const DividerThemeData(
        space: 1,
        thickness: 1,
        color: Color(0xFFDDDDDD),
      ),
      // Cards
      cardTheme: CardThemeData(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: _bgSecondary,
      ),
      // Dialog
      dialogTheme: DialogThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 8,
      ),
    );
  }
  
  static ThemeData get darkTheme {
    const darkBgPrimary = Color(0xFF1A1A1A);
    const darkBgSecondary = Color(0xFF2A2A2A);
    const darkTextPrimary = Color(0xFFFFFFFF);
    const darkTextSecondary = Color(0xFFCCCCCC);
    
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: _primaryLight,
        onPrimary: Colors.white,
        secondary: _secondaryLight,
        onSecondary: Colors.white,
        tertiary: _accentColor,
        error: _errorColor,
        onError: Colors.white,
        surface: darkBgSecondary,
        onSurface: darkTextPrimary,
        surfaceContainerHighest: darkBgPrimary,
      ),
      scaffoldBackgroundColor: darkBgPrimary,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: _primaryColor,
        foregroundColor: Colors.white,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 2,
          backgroundColor: _primaryLight,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF333333)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: _primaryLight, width: 2),
        ),
        filled: true,
        fillColor: darkBgSecondary,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: _primaryLight,
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: darkBgSecondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      dividerTheme: const DividerThemeData(
        space: 1,
        thickness: 1,
        color: Color(0xFF333333),
      ),
      cardTheme: CardThemeData(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: darkBgSecondary,
      ),
      dialogTheme: DialogThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 8,
      ),
    );
  }
  
  Color getEventColor(EventType eventType) {
    switch (eventType) {
      case EventType.event:
        return Colors.blue;
      case EventType.shift:
        return Colors.red;
      case EventType.note:
        return Colors.green;
    }
  }
  
  static List<Color> get eventColors => AppColors.eventColors;
  
  static Color getEventTypeColor(EventType type) {
    switch (type) {
      case EventType.event:
        return _primaryColor;
      case EventType.shift:
        return _accentColor;
      case EventType.note:
        return Colors.green;
    }
  }
}

