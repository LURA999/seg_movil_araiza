class MultiInputs {
  late String? contenido;
  final bool obligatorio;
  final bool select;
  final bool enabled;
  final bool paintSignature;
  final bool uploadFile;

  MultiInputs({
    required this.uploadFile,
    required this.contenido,
    required this.obligatorio,
    required this.select,
    required this.enabled,
    required this.paintSignature
  });

}
