import 'package:ccd2023/configurations/configurations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

export 'typography.dart';
export 'ccd_asset.dart';
export 'ccd_colors.dart';
export 'ccd_icons.dart';

class AppTheme {
  static CardTheme cardTheme = CardTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(kPadding),
    ),
  );
  static ListTileThemeData listTileThemeData = ListTileThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );
  static SwitchThemeData switchThemeData = SwitchThemeData(
    thumbColor: MaterialStateProperty.all(GCCDColor.white),
    trackColor: MaterialStateProperty.resolveWith(
      (states) =>
          states.contains(MaterialState.selected) ? GCCDColor.googleBlue : null,
    ),
  );

  static ThemeData light = ThemeData.light().copyWith(
    appBarTheme: AppBarTheme(
      backgroundColor: GCCDColor.white,
      elevation: 0,
      iconTheme: const IconThemeData(
        color: GCCDColor.black,
        size: kPadding * 4,
      ),
      titleTextStyle: AppTextStyle.titleLarge.copyWith(
        color: GCCDColor.black,
      ),
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: GCCDColor.white,
    ),
    dividerColor: Colors.black54,
    scaffoldBackgroundColor: GCCDColor.white,
    textTheme: AppTextStyle.textTheme.apply(
      bodyColor: GCCDColor.black,
      displayColor: GCCDColor.black,
    ),
    listTileTheme: listTileThemeData.copyWith(
      iconColor: GCCDColor.black,
      selectedTileColor: GCCDColor.black,
      selectedColor: GCCDColor.white,
    ),
    switchTheme: switchThemeData,
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: const BorderSide(
          color: GCCDColor.googleBlue,
        ),
        borderRadius: BorderRadius.circular(kPadding * 2),
      ),
      fillColor: GCCDColor.white,
      filled: true,
      labelStyle: const TextStyle(
        color: Color(0xFFF1F1F1),
      ),
    ),
    cardTheme: cardTheme,
    buttonTheme: const ButtonThemeData(
      buttonColor: GCCDColor.googleBlue,
      textTheme: ButtonTextTheme.accent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(kPadding * 3),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        textStyle: AppTextStyle.headlineSmall.copyWith(
          color: GCCDColor.white,
        ),
        side: const BorderSide(
          color: GCCDColor.black,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(kPadding * 3),
          ),
        ),
      ),
    ),
  );

  static ThemeData dark = ThemeData.dark().copyWith(
    appBarTheme: AppBarTheme(
      backgroundColor: GCCDColor.black,
      elevation: 0,
      iconTheme: const IconThemeData(
        color: GCCDColor.white,
        size: kPadding * 4,
      ),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: GCCDColor.black,
      ),
      titleTextStyle: AppTextStyle.titleLarge.copyWith(
        color: GCCDColor.white,
      ),
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: GCCDColor.black,
    ),
    dividerColor: Colors.white54,
    scaffoldBackgroundColor: GCCDColor.black,
    textTheme: AppTextStyle.textTheme.apply(
      bodyColor: GCCDColor.white,
      displayColor: GCCDColor.white,
    ),
    listTileTheme: listTileThemeData.copyWith(
      iconColor: GCCDColor.white,
      selectedTileColor: GCCDColor.white,
      selectedColor: GCCDColor.black,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: const BorderSide(
          color: GCCDColor.googleBlue,
        ),
        borderRadius: BorderRadius.circular(kPadding * 2),
      ),
      fillColor: GCCDColor.black,
      filled: true,
      labelStyle: const TextStyle(
        color: Color(0xFF1F1E1E),
      ),
    ),
    cardTheme: cardTheme,
    buttonTheme: const ButtonThemeData(
      buttonColor: GCCDColor.googleBlue,
      textTheme: ButtonTextTheme.accent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(kPadding * 3),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        textStyle: AppTextStyle.headlineMedium.copyWith(
          color: GCCDColor.white,
        ),
        side: const BorderSide(
          color: GCCDColor.white,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(kPadding * 3),
          ),
        ),
      ),
    ),
    switchTheme: switchThemeData,
  );
}
