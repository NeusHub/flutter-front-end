import 'package:flutter/material.dart';

abstract final class NeusHubColors {
  static final Color purple = Color(0xFF792ecc),
      grey = Color(0xFFb3b3b3),
      greyDark = Color(0xFF121212),
      white = Colors.white,
      black = Colors.black,
      blackLight = Color(0xFFb3b3b3).withAlpha(128),
      blackDark = Color(0xFFE5E5E5),
      transparent = Colors.transparent,
      error = Color(0xFFFF0000),
      dialog = Color(0xFFB3B3B3);
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
  fontFamily: 'rubik',
  appBarTheme: AppBarTheme(
    backgroundColor: NeusHubColors.white,
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
  popupMenuTheme: PopupMenuThemeData(
    position: PopupMenuPosition.under,
    color: NeusHubColors.white,
    shadowColor: NeusHubColors.transparent,
    surfaceTintColor: NeusHubColors.transparent,
    menuPadding: EdgeInsets.symmetric(vertical: 10),
    shape: BorderDirectional(
      bottom: BorderSide(
        color: NeusHubColors.blackLight,
      ),
      start: BorderSide(
        color: NeusHubColors.blackLight,
      ),
      end: BorderSide(
        color: NeusHubColors.blackLight,
      ),
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    overlayColor: WidgetStatePropertyAll(NeusHubColors.transparent),
    side: BorderSide.none,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
      side: BorderSide.none,
    ),
    checkColor: WidgetStatePropertyAll(NeusHubColors.grey),
    fillColor: WidgetStatePropertyAll(NeusHubColors.transparent),
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
    onSurface: NeusHubColors.blackDark,
    surfaceContainer: NeusHubColors.dialog,
    primaryContainer: NeusHubColors.transparent,
  ),
  dialogBackgroundColor: NeusHubColors.white,
  dialogTheme: DialogTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5),
    ),
  ),
);

const Size mobileSize = Size(850, 0);
