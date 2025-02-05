import 'package:flutter/widgets.dart';

class NeusHubIcons {
  NeusHubIcons._();

  static const _kFontFamIcons = 'icons',
      _kFontFamOffline = 'offline',
      _kFontFamSign = 'sign';

  static const IconData facebook = IconData(0xe800, fontFamily: _kFontFamIcons);
  static const IconData x = IconData(0xe801, fontFamily: _kFontFamIcons);
  static const IconData linkedin = IconData(0xe802, fontFamily: _kFontFamIcons);

  static const IconData offline =
      IconData(0xe800, fontFamily: _kFontFamOffline);

  static const IconData name = IconData(0xe800, fontFamily: _kFontFamSign);
  static const IconData email = IconData(0xe801, fontFamily: _kFontFamSign);
  static const IconData eye = IconData(0xe802, fontFamily: _kFontFamSign);
  static const IconData lock = IconData(0xe803, fontFamily: _kFontFamSign);
}
