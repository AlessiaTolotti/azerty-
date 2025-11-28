import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'dart:math';

part 'color_changer.g.dart';

@riverpod
class ColorChanger extends _$ColorChanger {
  @override
  Color build() {
    return Colors.white;
  }

  void changeColor(Color newColor) {
    state = newColor;
  }

  void setRandomColor() {
    final random = Random();
    int index = random.nextInt(Colors.primaries.length);
    state = Colors.primaries[index];
  }
}