abstract class BaseInputsForm {
  late String? contenido;
  final bool enabled;

  BaseInputsForm({
    required this.contenido,
    required this.enabled,
  });

}

class MultiInputsForm implements BaseInputsForm {

 @override
  late String? contenido;
  @override
  final bool enabled;

  final bool paintSignature;
  final bool uploadFile;
  final bool select;
  final bool obligatorio;

  MultiInputsForm({
    required this.uploadFile,
    required this.contenido,
    required this.obligatorio,
    required this.select,
    required this.enabled,
    required this.paintSignature
  });

}


class RadioInputForm implements BaseInputsForm {
  
 @override
  late String? contenido;
  @override
  final bool enabled;

  late String? contenidoDef;


  RadioInputForm({
    required this.contenido,
    required this.contenidoDef,
    required this.enabled,
  });

}

