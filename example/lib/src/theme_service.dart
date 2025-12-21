import 'package:flutter/material.dart';

class ThemeService {
  ThemeService._();
  static Color primaryColor = const Color.fromARGB(255, 31, 105, 165);

  static ThemeData get lightTheme => _theme(Brightness.light);

  static ThemeData get darkTheme => _theme(Brightness.dark);

  static ThemeData _theme(Brightness brighttness) => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          brightness: brighttness,
        ),
        brightness: brighttness,
      );
}
