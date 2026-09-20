import 'package:flutter/material.dart';

class AppTheme {
  // Paleta propia de Campus Eventos
  static const Color primario = Color(0xFF5B2EFF);
  static const Color primarioOscuro = Color(0xFF2A1B8F);
  static const Color acento = Color(0xFFFF8A3D);
  static const Color fondo = Color(0xFFF4F3FB);

  static const LinearGradient headerGradient = LinearGradient(
    colors: [primarioOscuro, primario, Color(0xFF8E5CFF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primario,
        primary: primario,
        secondary: acento,
      ),
      scaffoldBackgroundColor: fondo,
      fontFamily: 'Roboto',
      appBarTheme: const AppBarTheme(centerTitle: false, elevation: 0),
      cardTheme: CardThemeData(
        elevation: 3,
        margin: EdgeInsets.zero,
        shadowColor: Colors.black26,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  // Color asociado a cada categoría
  static Color colorCategoria(String categoria) {
    switch (categoria) {
      case 'Académicos':
        return const Color(0xFF1E88E5);
      case 'Deportivos':
        return const Color(0xFF2E9E5B);
      case 'Culturales':
        return const Color(0xFFD81B60);
      case 'Tecnología':
        return const Color(0xFF5B2EFF);
      case 'Talleres':
        return const Color(0xFFF57C00);
      default:
        return const Color(0xFF455A64);
    }
  }

  // Icono asociado a cada categoría
  static IconData iconoCategoria(String categoria) {
    switch (categoria) {
      case 'Académicos':
        return Icons.school_rounded;
      case 'Deportivos':
        return Icons.sports_soccer_rounded;
      case 'Culturales':
        return Icons.palette_rounded;
      case 'Tecnología':
        return Icons.memory_rounded;
      case 'Talleres':
        return Icons.build_rounded;
      default:
        return Icons.apps_rounded;
    }
  }
}
