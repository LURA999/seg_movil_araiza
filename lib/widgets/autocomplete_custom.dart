import 'package:flutter/material.dart';

import '../models/models.dart';
import '../services/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
  final storage = const FlutterSecureStorage();


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

            
          }
          return widget.goptions!.where((String option) {
            return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
          });
        },
        onSelected: (String selection) async {
          

        if (widget.autocompleteAsync) {
          setState(() { });
          switch (widget.formProperty.toString()) {
          case 'guard':
              // await buscaAutomaticaGuard(value ??'');
            break;
          case 'platesSearch':  
            switch (widget.screen){
            case 1:
              Access r = await vService.findVehicle(selection,int.parse((await storage.read(key: 'idHotelRegister')).toString()),context,1);
              widget.onFormValueChange!(r.container,['plates','type_vh','model_vh','color','employee_name','time_entry','time_exit']);
              widget.formValue[widget.formProperty]!.contenido = selection;
           break;
            case 2:
              Access r = await vService.findVehicle(selection,int.parse(widget.formValue['hotel']!.contenido) ,context,2);
              (r.container as List<dynamic>)[0]['hotel'] =  widget.formValue['hotel']!.contenido;
              widget.onFormValueChange!(r.container,['plates','hotel','type_vh', 'model_vh','color','employee_name','department']);
              widget.formValue[widget.formProperty]!.contenido = selection;
            break;
            }
            break;
          case 'nameSearch':
              //[arr[ arr.indexWhere((element) => element["complete_name"] == selection)]] - arr.firstWhere((element) => element["complete_name"] == selection)
              final arrNameSearch = arr.firstWhere((element) => element["complete_name"] == selection);
              // widget.formValue['hotel']!.contenido = arrNameSearch['cveLocal'];
             await widget.onFormValueChange!([arrNameSearch],['usuario']);

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
              switch (widget.formProperty.toString()) {
                case 'course_name':
                /* setState(() {
                  final indiceGuion = option.indexOf(' ');
                  widget.formValue[widget.formProperty]!.contenido = option;
                  onSelected(option.substring(indiceGuion + 3));
                }); */

                setState(() {
                 // final indiceGuion = option.indexOf(' ');
                  widget.formValue[widget.formProperty]!.contenido = option;
                onSelected(option);
                  //onSelected(option.substring(indiceGuion + 3));
                }); 
                break;
              default:
              setState(() {
                widget.formValue[widget.formProperty]!.contenido = option;
                onSelected(option);
              });
              }
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
               // hintText: widget.labelText,
                labelText: widget.labelText,
                labelStyle: getTextStyleText(context,null,null),
              ),
              onChanged: (value) {
              switch (widget.formProperty) {
                  case 'course_name':
                    widget.formValue[widget.formProperty]!.contenido = value;
                  break;
                  case 'guard':
                  if(widget.screen!=null){
                    switch(widget.screen){
                      case 1 :
                      widget.formValue[widget.formProperty]!.contenido = value;
                      break;
                    }
                  }
                  break;
              default:
            }
              },
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
          await buscaAutomaticaEmployeesSearch(value ??'*?', '');
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
  int hotel = 0;
  switch (widget.screen) {
    case 1:
        hotel = int.parse((await storage.read(key: 'idHotelRegister')).toString());
      break;
    case 2:
        hotel = int.parse(widget.formValue['hotel']!.contenido);
      break;
    default:
  }
  arr= await vs.showPlateRegister(value.toLowerCase(),hotel,context);
    for (var i = 0; i < arr.length; i++) {
      if (tempOptions !=null) {
        tempOptions!.add(arr[i]['plates']);
      }
    }
    setState(() { });
    return arr;  
  }

  Future<List<Map<String,dynamic>>> buscaAutomaticaEmployeesSearch(String value, String hotel ) async {
  AssistanceService vs = AssistanceService();
  // print(widget.formValue['hotel']);
  // print(widget.formValue);
  arr= await vs.showEmployeeAssistance(value.toLowerCase(),context,  widget.formValue['hotel']!.contenido
 == '' ?  int.parse((await storage.read(key: 'idHotelRegister')).toString())  : int.parse(widget.formValue['hotel']!.contenido) );
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

