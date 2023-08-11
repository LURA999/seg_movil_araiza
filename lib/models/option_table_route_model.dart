class OptionRoute {
  final String title;
  final String description;
  final String? img;
  final double width;
  final List<void Function()> navigator;
  final int monthInitial;
  final int monthFinal;

  OptionRoute({
    required this.monthInitial,
    required this.monthFinal,
    required this.title,
    required this.description,
    required this.img,
    required this.width,
    required this.navigator,
  });
}