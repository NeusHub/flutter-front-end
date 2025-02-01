import 'package:flutter/material.dart';

abstract final class NeusHubColors {
  static final Color purple = Color(0xFF792ecc),
      grey = Color(0xFFb3b3b3),
      white = Colors.white,
      black = Colors.black,
      blackLight = Colors.black.withAlpha((60 / 100).round() * 255),
      transparent = Colors.transparent,
      error = Color(0xFFff8080);
}

class NeusHubAppSize {
  final BuildContext context;

  const NeusHubAppSize(this.context);

  Size size() {
    return Size(
      MediaQuery.sizeOf(context).width,
      MediaQuery.sizeOf(context).height,
    );
  }
}

ThemeData theme = ThemeData(
  scaffoldBackgroundColor: NeusHubColors.white,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.transparent,
    foregroundColor: NeusHubColors.black,
    shape: Border(
      bottom: BorderSide(
        color: NeusHubColors.blackLight,
        style: BorderStyle.solid,
      ),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(NeusHubColors.transparent),
        shadowColor: WidgetStatePropertyAll(NeusHubColors.transparent),
        overlayColor: WidgetStatePropertyAll(NeusHubColors.transparent),
        padding: WidgetStatePropertyAll(EdgeInsets.zero)),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      padding: WidgetStatePropertyAll(EdgeInsets.zero),
      shadowColor: WidgetStatePropertyAll(NeusHubColors.transparent),
      overlayColor: WidgetStatePropertyAll(NeusHubColors.transparent),
      minimumSize: WidgetStatePropertyAll(Size.zero),
    ),
  ),
  primaryColor: NeusHubColors.black,
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: NeusHubColors.black,
    onPrimary: NeusHubColors.purple,
    secondary: NeusHubColors.grey,
    onSecondary: NeusHubColors.purple,
    error: NeusHubColors.error,
    onError: NeusHubColors.transparent,
    surface: NeusHubColors.white,
    onSurface: NeusHubColors.transparent,
  ),
  dialogBackgroundColor: NeusHubColors.white,
  dialogTheme: DialogTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  ),
);

const Size mobileSize = Size(520, 0);
