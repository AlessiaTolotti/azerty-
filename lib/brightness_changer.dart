import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'brightness_changer.g.dart';

@riverpod
class BrightnessChanger extends _$BrightnessChanger {
  @override
  Brightness build() {
    return Brightness.light;
  }

  void toggleBrightness(bool isDark) {
    state = isDark ? Brightness.dark : Brightness.light;
  }
}