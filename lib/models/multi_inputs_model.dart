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

/// TODOS LOS CAMPOS SIGUIENTES SON PARA HABILITAR FUNCIONALIDADES.
/// 
/// contenido: para designar el contenido principal que se mostrara en el input
/// enabled: es para dsahibilitar el inpit
/// paintSignature : para habilitar el touchpaint
/// uploadfile: para subir archivos
/// suffixIcon: es para asingar o no, un suffix
/// autocomplete : es para habilitar el autocomplete
/// autocompleteasync : va junto con el autocomplete y aqui se designa si es o no, asincrono
/// screen: por el momento solo esta habilitado junto con el autocomplete, se usa para habilitar la opcion de
/// buscar consultas diferentes con la mismo nombre del input asignado un ejemplo es el "platesSearch" en control_vehicles
/// y aparte tambien se puede usar con una funcion para rellenar el formulario, cuando
/// seleccionas la opcion del autocomplete


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
  int? screen;
  int? maxLength;
  bool? activeClock;
  List<Map<String,dynamic>>? listselect;
  TextInputType? keyboardType;
  

  MultiInputsForm({
    this.maxLength,
    this.suffixIcon,
    this.autocomplete,
    this.autocompleteAsync,
    this.uploadFile,
    this.contenido,
    this.obligatorio,
    this.select,
    this.enabled,
    this.paintSignature,
    this.activeClock,
    this.screen,
    this.listselect,
    this.keyboardType
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

