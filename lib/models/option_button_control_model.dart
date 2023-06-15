import 'dart:ui';

class Opcion {
  final String title;
  final String description;
  final String img;
  final double width;
  final VoidCallback? navigator;

  Opcion({
    required this.title,
    required this.description,
    required this.img,
    required this.width,
    this.navigator,
  });
}