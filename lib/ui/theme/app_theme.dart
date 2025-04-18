import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Color(0xFF6200EE),
    primaryColorDark: Color(0xFF3700B3),
    primaryColorLight: Color(0xFFBB86FC),
    colorScheme: ColorScheme.light(
      primary: Color(0xFF6200EE),
      secondary: Color(0xFF03DAC6),
      background: Colors.white,
      surface: Colors.white,
      onBackground: Colors.black,
      onSurface: Colors.black,
    ),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF6200EE),
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    cardTheme: CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Color(0xFF6200EE),
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF6200EE),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    textTheme: GoogleFonts.interTextTheme(),
    // textTheme: TextTheme(
    //   headlineLarge: TextStyle(
    //     fontSize: 28,
    //     fontWeight: FontWeight.bold,
    //     color: Colors.black,
    //   ),
    //   headlineMedium: TextStyle(
    //     fontSize: 24,
    //     fontWeight: FontWeight.bold,
    //     color: Colors.black,
    //   ),
    //   titleLarge: TextStyle(
    //     fontSize: 20,
    //     fontWeight: FontWeight.w600,
    //     color: Colors.black,
    //   ),
    //   bodyLarge: TextStyle(
    //     fontSize: 16,
    //     color: Colors.black87,
    //   ),
    //   bodyMedium: TextStyle(
    //     fontSize: 14,
    //     color: Colors.black87,
    //   ),
    // ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Color(0xFFBB86FC),
    primaryColorDark: Color(0xFF3700B3),
    primaryColorLight: Color(0xFFBB86FC),
    colorScheme: ColorScheme.dark(
      primary: Color(0xFFBB86FC),
      secondary: Color(0xFF03DAC6),
      background: Color(0xFF121212),
      surface: Color(0xFF1E1E1E),
      onBackground: Colors.white,
      onSurface: Colors.white,
    ),
    scaffoldBackgroundColor: Color(0xFF121212),
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF1E1E1E),
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    cardTheme: CardTheme(
      color: Color(0xFF1E1E1E),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Color(0xFFBB86FC),
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFFBB86FC),
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    textTheme: GoogleFonts.interTextTheme(),
    // textTheme: TextTheme(
      
    //   headlineLarge: TextStyle(
    //     fontSize: 28,
    //     fontWeight: FontWeight.bold,
    //     color: Colors.white,
    //   ),
    //   headlineMedium: TextStyle(
    //     fontSize: 24,
    //     fontWeight: FontWeight.bold,
    //     color: Colors.white,
    //   ),
    //   titleLarge: TextStyle(
    //     fontSize: 20,
    //     fontWeight: FontWeight.w600,
    //     color: Colors.white,
    //   ),
    //   bodyLarge: TextStyle(
    //     fontSize: 16,
    //     color: Colors.white70,
    //   ),
    //   bodyMedium: TextStyle(
    //     fontSize: 14,
    //     color: Colors.white70,
    //   ),
    // ),
  );
}
