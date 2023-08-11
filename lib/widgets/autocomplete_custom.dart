import 'package:flutter/material.dart';

import '../models/models.dart';
import '../services/services.dart';

class AutocompleteCustom extends StatefulWidget {
  List<String>? goptions;  
  List<int>? goptionsId;
  final bool autocompleteAsync;
  final String? labelText;
  final int screen;
  final String? formProperty;
  late Map<String, dynamic> formValue;
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
  List<String>? tempOptions; // Variable temporal para almacenar los resultados de la base de datos
  VehicleService vService = VehicleService();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => 
      Autocomplete<String>(
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (widget.autocompleteAsync) {
            if (textEditingValue.text == '') {
              return const Iterable<String>.empty();
            } 
          }
          return (tempOptions ?? widget.goptions ?? []).where((String option) {
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
              onTap: ()  async {
                final String value =  fieldController.text;
                if (widget.autocompleteAsync) {
                setState(() { 
                  tempOptions = [];
                });

                  await llenarMatAutoComplete(value);  
                  // widget.formValue[widget.formProperty]!.contenido = value;
                
                  setState(() {
                    widget.goptions = tempOptions;
                    tempOptions = null; // Reiniciar la variable temporal
                  });
                }else{
                  // widget.formValue[widget.formProperty]!.contenido = value;

                }

              },
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
          await buscaAutomaticaGuard(value ??'');
        }
        
        break;
      case 'platesSearch':
        if (widget.autocompleteAsync) {
          await buscaAutomaticaPlatesSearch(value ??'');
        }
        break;
      default:
    }
  }

  Future llenarOpcionesGuard() async {
  VehicleService vs = VehicleService();
  List<Map<String,dynamic>> arr=  await vs.namesGuard(context);
    for (var i = 0; i < arr.length; i++) {
      widget.goptions!.add(arr[i]['name']);
      widget.goptionsId!.add(int.parse(arr[i]['id']));
    }
  }

  Future<List<Map<String,dynamic>>> buscaAutomaticaGuard(String value) async {
  VehicleService vs = VehicleService();
  List<Map<String,dynamic>> arr= await vs.nameGuard(value.toLowerCase(),context);
    for (var i = 0; i < arr.length; i++) {
      if (tempOptions !=null) {
        setState(() { 
          tempOptions!.add(arr[i]['name']);
        });
      }
    }
    return arr;  
  }

  Future<List<Map<String,dynamic>>> buscaAutomaticaPlatesSearch(String value) async {
  VehicleService vs = VehicleService();
  List<Map<String,dynamic>> arr= await vs.showPlateRegister(value.toLowerCase(),context);
    for (var i = 0; i < arr.length; i++) {
      if (tempOptions !=null) {
        setState(() { 
          tempOptions!.add(arr[i]['plates']);
        });
      }
    }
    return arr;  
  }

  
}

