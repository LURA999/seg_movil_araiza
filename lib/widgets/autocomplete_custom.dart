import 'package:app_seguimiento_movil/widgets/popUp_widget.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';
import '../services/services.dart';

class AutocompleteCustom extends StatefulWidget {
  List<String>? goptions;  
  List<int>? goptionsId;
  final bool autocompleteAsync;
  final String? labelText;
  final int? screen;
  final String? formProperty;
  late Map<String, dynamic> formValue;
  final bool onSelect = true;
  Function(dynamic,List<String>)? onFormValueChange;
  
   AutocompleteCustom({
    Key? key,
    required this.autocompleteAsync,
    this.labelText,
    required this.formProperty,
    required this.formValue,
    this.onFormValueChange, 
    required this.screen,
    }) : super(key: key);

  @override
  State<AutocompleteCustom> createState() => __AutocompleteCustomState();
}

class __AutocompleteCustomState extends State<AutocompleteCustom> {
  List<Map<String,dynamic>> arr= [];
  List<String>? tempOptions; // Variable temporal para almacenar los resultados de la base de datos
  VehicleService vService = VehicleService();
  AssistanceService aService = AssistanceService();
  

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => 
      Autocomplete<String>(
        optionsBuilder: (TextEditingValue textEditingValue) async{
          
          if (widget.autocompleteAsync) {              
            // messageError(context, "dentro del if, autocomplete: ${textEditingValue.text}");
            if (textEditingValue.text == '') {
              // messageError(context, "dentro del if, textEditingValue: ${textEditingValue.text}");
              return const Iterable<String>.empty();
            } 
          }
          if (widget.autocompleteAsync) {
            setState(() {
              tempOptions = [];
            });
            await llenarMatAutoComplete(textEditingValue.text);
            setState(() { 
              widget.goptions = tempOptions;
              tempOptions = null; // Reiniciar la variable temporal
            });

            switch (widget.formProperty) {
              case 'course_name':
                widget.formValue[widget.formProperty]!.contenido = textEditingValue.text;
              break;
              default:
            }
          }
          return (widget.goptions!).where((String option) {
            return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
          });
        },
        onSelected: (String selection) async {
        widget.formValue[widget.formProperty]!.contenido = selection;
        if (widget.autocompleteAsync) {
          switch (widget.formProperty) {
          case 'guard':
              // await buscaAutomaticaGuard(value ??'');
            break;
          case 'platesSearch':  
            switch (widget.screen){
            case 1:
              Access r = await vService.findVehicle(selection,context,1);
              widget.onFormValueChange!(r.container,['plates','type_vh','color','employee_name','time_entry','time_exit']);
            break;
            case 2:
              Access r = await vService.findVehicle(selection,context,2);
              widget.onFormValueChange!(r.container,['plates','type_vh','color','employee_name','department']);
            break;
            }
            break;
          case 'nameSearch': 
              widget.onFormValueChange!([arr[widget.goptions!.indexOf(selection)]],['usuario']);
            break;
          case 'course_name':
          break;
          default:
        }
        }
        
          setState(() { });

        },
        optionsViewBuilder: (BuildContext context, AutocompleteOnSelected<String> onSelected,
          Iterable<String> options) {
            List<ListTile> list = options.map((String option) => ListTile(
            title: Text(option,style: getTextStyleText(context,null,null)),
            onTap: () async {
              setState(() {
                onSelected(option);
              });
            },
          )).toList() ;
            return Align(
              alignment: Alignment.topLeft,
              child: SizedBox( 
                height: options.length <4? options.length*65 : 65*3, // Ajusta la altura de la lista desplegable según sea necesario
                width: constraints.maxWidth, // Ajusta el ancho de la lista desplegable según sea necesario
                child:  Material(  
                  elevation: 3.0,
                  child: SingleChildScrollView(
                    child: Column(
                      key: widget.key,
                      children: list,
                    ),
                  ),
                ),
              ),
            );
          }, 
          fieldViewBuilder: (BuildContext context, TextEditingController fieldController,
          FocusNode fieldFocusNode, VoidCallback onFieldSubmitted) {
            return TextFormField(
              controller: fieldController,
              focusNode: fieldFocusNode,
              style: getTextStyleText(context,null,null),
              decoration: InputDecoration(
                hintText: widget.labelText
              ),
              key: widget.key,
              validator: widget.formValue[widget.formProperty]!.obligatorio == true ? (value) {
                if(value == null || value.isEmpty == true || value == ''){
                  return 'Este campo es requerido';
                }
                return null;
              }:null
            );
          },
        ),
    ); 
  }

  @override
  void initState() {
    // TODO: implement initState
    widget.goptions = [];
    widget.goptionsId = [];
    llenarMatAutoComplete(null);
    super.initState();
  }

  Future llenarMatAutoComplete(String? value) async{
  switch (widget.formProperty) {
      case 'guard':
        if (!widget.autocompleteAsync) {
          await llenarOpcionesGuard();
        }else{
          await buscaAutomaticaGuard(value ??'*?');
        }
        
        break;
      case 'platesSearch':
        if (widget.autocompleteAsync) {
          await buscaAutomaticaPlatesSearch(value ??'*?');
        }
        break;
      case 'nameSearch':
          await buscaAutomaticaEmployeesSearch(value ??'*?');
        break;
      case 'course_name':
        await buscarAutomaticaCoursesSearch(value ?? '*?');
      break;
      default:
    }
  }

  Future llenarOpcionesGuard() async {
  VehicleService vs = VehicleService();
  setState(() { widget.goptionsId = []; });
  arr=  await vs.namesGuard(context);
    for (var i = 0; i < arr.length; i++) {
      widget.goptions!.add(arr[i]['name']);
      widget.goptionsId!.add(int.parse(arr[i]['id']));
    }
    setState(() { });
  }

  Future<List<Map<String,dynamic>>> buscaAutomaticaGuard(String value) async {
  VehicleService vs = VehicleService();
  arr= await vs.nameGuard(value.toLowerCase(),context);
    for (var i = 0; i < arr.length; i++) {
      if (tempOptions !=null) {
          tempOptions!.add(arr[i]['name']);
      }
    }
    setState(() { });
    return arr;  
  }

  Future<List<Map<String,dynamic>>> buscaAutomaticaPlatesSearch(String value) async {
  VehicleService vs = VehicleService();
  arr= await vs.showPlateRegister(value.toLowerCase(),context);
    for (var i = 0; i < arr.length; i++) {
      if (tempOptions !=null) {
        tempOptions!.add(arr[i]['plates']);
      }
    }
    setState(() { });
    return arr;  
  }

  Future<List<Map<String,dynamic>>> buscaAutomaticaEmployeesSearch(String value) async {
  AssistanceService vs = AssistanceService();
  arr= await vs.showEmployeeAssistance(value.toLowerCase(),context);
    for (var i = 0; i < arr.length; i++) {
      if (tempOptions !=null) {
        tempOptions!.add(arr[i]['complete_name']);
      }
    }
    setState(() { });
    return arr;  
  }

  Future<List<Map<String,dynamic>>> buscarAutomaticaCoursesSearch(String value) async {
  AssistanceService vs = AssistanceService();
  arr= await vs.showCoursesAssistance(value.toLowerCase(),context);
    for (var i = 0; i < arr.length; i++) {
      if (tempOptions !=null) {
        tempOptions!.add(arr[i]['course_name']);
      }
    }
    setState(() { });
    return arr;  
  }
}

