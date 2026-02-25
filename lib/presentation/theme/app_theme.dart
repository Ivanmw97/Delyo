import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';

abstract class AppTheme {
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.light(
      primary:          AppColors.accent,
      surface:          AppColors.lightSurface,
      onSurface:        AppColors.lightOnSurface,
    ),
    scaffoldBackgroundColor: AppColors.lightBackground,
    appBarTheme: const AppBarTheme(
      backgroundColor:  AppColors.lightBackground,
      foregroundColor:  AppColors.lightOnSurface,
      elevation:        0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor:           Colors.transparent,
        statusBarIconBrightness:  Brightness.dark,
        statusBarBrightness:      Brightness.light,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor:      AppColors.lightSurface,
      selectedItemColor:    AppColors.accent,
      unselectedItemColor:  Color(0xFF8E8E93),
      elevation:            0,
    ),
    cardColor: AppColors.lightSurface,
  );

  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.dark(
      primary:          AppColors.accent,
      surface:          AppColors.darkSurface,
      onSurface:        AppColors.darkOnSurface,
    ),
    scaffoldBackgroundColor: AppColors.darkBackground,
    appBarTheme: const AppBarTheme(
      backgroundColor:  AppColors.darkBackground,
      foregroundColor:  AppColors.darkOnSurface,
      elevation:        0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor:           Colors.transparent,
        statusBarIconBrightness:  Brightness.light,
        statusBarBrightness:      Brightness.dark,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor:      AppColors.darkSurface,
      selectedItemColor:    AppColors.accent,
      unselectedItemColor:  Color(0xFF636366),
      elevation:            0,
    ),
    cardColor: AppColors.darkSurface,
  );
}
