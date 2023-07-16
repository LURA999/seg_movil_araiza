import 'package:flutter/material.dart';

abstract class BaseInputsForm {
  late String? contenido;
  final bool? enabled;

  BaseInputsForm({
    required this.contenido,
    required this.enabled,
  });

}

class MultiInputsForm implements BaseInputsForm {

 @override
  late String? contenido;
  @override
  bool? enabled;
  bool? paintSignature;
  bool? uploadFile;
  bool? select;
  bool? obligatorio;
  IconData? suffixIcon;
  bool? autocomplete;
  bool? autocompleteAsync;

  MultiInputsForm({
    this.suffixIcon,
    this.autocomplete,
    this.autocompleteAsync,
    this.uploadFile,
    this.contenido,
    this.obligatorio,
    this.select,
    this.enabled,
    this.paintSignature
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

