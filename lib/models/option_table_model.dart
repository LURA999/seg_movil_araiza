import 'dart:ui';

class Option {
  final String title;
  final String description;
  final String? img;
  final double width;
  final VoidCallback? navigator;

  Option({
    required this.title,
    required this.description,
    required this.img,
    required this.width,
    this.navigator,
  });
}