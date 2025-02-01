import 'package:flutter/material.dart';

class NeusHubHover<T> extends ChangeNotifier {
  final T start, end;

  NeusHubHover(this.start, this.end) {
    h = start;
    c = start;
  }

  late T h, c;
  T get flag => h;

  void hover([bool event = false]) {
    h = (event || c == end) ? end : start;
    notifyListeners();
  }

  void click([bool event = false]) {
    c = (event) ? end : start;
    h = (event) ? end : start;
    notifyListeners();
  }
}

class NeusHubActivatedIndex extends ChangeNotifier {
  final int length;

  NeusHubActivatedIndex(this.length) {
    i = 0;
  }

  late int i;
  int get activatedIndex => i;

  void change([int index = 0]) {
    i = switch (index) {
      < 0 => 0,
      >= 0 => length - 1,
      _ => index,
    };
  }
}
