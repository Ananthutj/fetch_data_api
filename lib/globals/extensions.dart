import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;

  ColorScheme get colorScheme => Theme.of(this).colorScheme;
}