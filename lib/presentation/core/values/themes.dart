import 'package:flutter/material.dart';

import 'palette.dart';

abstract class AppTheme {
  static final RoundedRectangleBorder _defaultButtonShape =
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(4));
  static const EdgeInsets _defaultButtonPadding = EdgeInsets.all(12);

  static final BorderRadius _defaultInputBorderRadius = BorderRadius.circular(4);

  static final ThemeData darkTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Palette.background,
    primaryColor: Palette.primary,
    primaryColorLight: Palette.primaryLight,
    primaryColorDark: Palette.primaryDark,
    secondaryHeaderColor: Palette.textSecondary,
    disabledColor: Palette.disabled,
    splashFactory: NoSplash.splashFactory,
    colorScheme: const ColorScheme.light().copyWith(
      primary: Palette.primary,
      primaryContainer: Palette.primaryContainer,
      secondary: Palette.secondary,
      secondaryContainer: Palette.secondaryContainer,
    ),
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      backgroundColor: Palette.primaryDark,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: _defaultInputBorderRadius,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: _defaultInputBorderRadius,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: _defaultInputBorderRadius,
        borderSide: const BorderSide(color: Palette.primary),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      hintStyle: const TextStyle(fontSize: 14, color: Palette.textSecondary),
      labelStyle: const TextStyle(fontSize: 14, color: Palette.textSecondary),
      alignLabelWithHint: true,
      errorMaxLines: 2,
      filled: true,
      fillColor: Palette.secondaryContainer,
    ),
    buttonTheme: ButtonThemeData(
      textTheme: ButtonTextTheme.accent,
      padding: _defaultButtonPadding,
      shape: _defaultButtonShape,
      buttonColor: Palette.primary,
      splashColor: Colors.white10,
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: _defaultButtonShape,
        padding: _defaultButtonPadding,
        side: const BorderSide(color: Palette.primary),
        textStyle: const TextStyle(color: Colors.white),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith(
          (Set<MaterialState> states) {
            return states.contains(MaterialState.disabled)
                ? Palette.primary.withOpacity(.6)
                : Palette.primary;
          },
        ),
        shape: MaterialStateProperty.all(_defaultButtonShape),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        overlayColor: MaterialStateProperty.all<Color>(Colors.white12),
        padding: MaterialStateProperty.all<EdgeInsets>(_defaultButtonPadding),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(_defaultButtonShape),
        padding: MaterialStateProperty.all<EdgeInsets>(_defaultButtonPadding),
        shadowColor: MaterialStateProperty.all(Palette.primaryLight),
        backgroundColor: MaterialStateProperty.resolveWith(
          (Set<MaterialState> states) =>
              states.contains(MaterialState.disabled) ? Palette.primaryLight : Palette.primary,
        ),
        foregroundColor: MaterialStateProperty.resolveWith(
          (Set<MaterialState> states) =>
              states.contains(MaterialState.disabled) ? Palette.textSecondary : Colors.white,
        ),
      ),
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Palette.secondaryVariant,
      selectionHandleColor: Palette.secondary,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Palette.background,
    ),
    sliderTheme: const SliderThemeData(
      activeTrackColor: Palette.secondary,
      thumbColor: Palette.secondary,
    ),
  );
}
