import 'package:flutter/material.dart';

class OnboardPageModel {
  final Color primeColor;
  final Color accentColor;
  final Color nextAccentColor;
  final int pageNumber;
  final IconData imagePath;
  final String subhead;
  final String description;

  OnboardPageModel(this.primeColor, this.accentColor, this.nextAccentColor,
      this.pageNumber, this.imagePath, this.subhead, this.description);
}
