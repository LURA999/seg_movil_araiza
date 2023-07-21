// ignore_for_file: use_build_context_synchronously

import 'package:app_seguimiento_movil/models/models.dart';
import 'package:app_seguimiento_movil/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_signature_pad/flutter_signature_pad.dart';
import 'package:provider/provider.dart';
import 'package:app_seguimiento_movil/services/services.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;
import 'dart:convert';
import '../theme/app_theme.dart';

class ButtonForm extends StatefulWidget {
  final String textButton;
  final List<String> field;
  final Map<String, MultiInputsForm> formValue;
  final bool enabled;
  final List<List<String>>? listSelect;
  final int btnPosition;
  final int control;
  final TextEditingController? controller;

  ButtonForm({
    super.key,
    required this.textButton,
    required this.btnPosition,
    this.listSelect,
    required this.field,
    required this.formValue,
    required this.enabled, 
    required this.control, 

    this.controller,     
  });

  @override
  State<ButtonForm> createState() => _ButtonFormState();
}

class _ButtonFormState extends State<ButtonForm> {
  final List<TextEditingController> controllerArr = []; 
 
  @override
  Widget build(BuildContext context) {
    
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
            ),
          ),
          onPressed:
              //primer filtro para saber que si el usuario tiene iniciado sesion entonces, se desactiva el primer boton
              Provider.of<VarProvider>(context, listen: false).varControl == true && widget.btnPosition == 1 ? null : 
              //de otra forma se desactivan los otros 4 botones (en este caso solo se desactivan 2 botones, porqe los otros dos, no pertencen a esta clase)
              ((Provider.of<VarProvider>(context, listen: false).varControl || widget.enabled)
                  ? ()  {
                    
                     newMethod(context, widget.formValue, widget.btnPosition);
                    }
                  : null),
          child: Text(widget.textButton, style: getTextStyleButtonField(context))
          
          )
        );      
      }


  Future<String?> newMethod(BuildContext context,
    Map<String, MultiInputsForm> formValue, int btnPosition) {

   

    //vars para el touch paint  
    final sign0 = GlobalKey<SignatureState>();
    ByteData img = ByteData(0);
    SignatureState? sign;
    
    final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();
    List<Widget> inputFields = [];
    int i = 1;

    onFormValueChange(dynamic value,List<String> keyValue) {
    int ivalue = 0;

    //se llena los inputs  y su respectivo formvalue, llenarlo solo en el formvalue no es suficiente
      for (var i = 0; i < inputFields.length; i++) {
        if (inputFields[i].runtimeType.toString() == 'MultiInputs') {
          setState(() {
            (inputFields[i] as MultiInputs).controller!.text = value[0][keyValue[ivalue]] ?? '';
            formValue[(inputFields[i] as MultiInputs).formProperty]!.contenido = value[0][keyValue[ivalue]];
            ivalue++;
          });
        }
      } 
      
        
      }

    inputFields.add(const SizedBox(height: 15));
    formValue.forEach((key, value) {
      TextEditingController? controllerAux = TextEditingController();
      //Esto es para ayudar al formulario, para que sea mas dinamico
      //Si es nulo, entonces no seran validados los campos
      if (widget.controller == null) {
        controllerAux = widget.controller;
      } 
      if (key.substring(0, 4) == "date") {
        inputFields.add(
          MultiInputs(
            maxLines: 1,
            controller:controllerAux,
            autofocus: i == 1 ? true : false,
            labelText: widget.field[i],
            formProperty: key,
            formValue: formValue,
            keyboardType: TextInputType.datetime),
        );
      } else {
        if (formValue[key]!.paintSignature == true) {
          inputFields.add(
            Column(
            children: [
              Text( widget.field[i]),
              SizedBox(
                height: MediaQuery.of(context).size.height *.3,
                width: MediaQuery.of(context).size.width,
                child: Container( 
                  decoration: BoxDecoration(
                  border: Border.all(color: AppTheme.primary)
                ),
                  child: Signature(
                    key: sign0,
                    onSign: () async {
                      sign = sign0.currentState;
                      formValue[key]!.contenido = sign.toString();
                    },
                    color: Colors.black,
                    strokeWidth: 3,
                  ),
                ),
              ),
              img.buffer.lengthInBytes == 0 ? Container() : LimitedBox(maxHeight: 200.0, child: Image.memory(img.buffer.asUint8List())),
              ElevatedButton.icon(
                icon: const Icon(Icons.delete),
                onPressed: () async {
                  sign = sign0.currentState;
                  sign!.clear();
                  img = ByteData(0);
                  formValue[key]!.contenido = null;
                },
                label: Text('Borrar',style: getTextStyleButtonField(context)),
              ),
            ],
          )
          );
        } else {
        inputFields.add(
        MultiInputs(
          maxLines: key.contains("description")? 8 : 1 ,
          labelText: widget.field[i], 
          controller: controllerAux,
          autofocus: i == 1 ? true : false,
          formProperty: key,
          suffixIcon: value.suffixIcon,
          listSelect: widget.listSelect,
          autocompleteAsync: value.autocompleteAsync,
          formValue: formValue,
          screen: value.screen,
          onFormValueChange: onFormValueChange,
          keyboardType: key.contains("number")? TextInputType.number : TextInputType.text)
          );
        }
      }

      if (controllerAux != null) {
        controllerArr.add(controllerAux);
      }

      i++;
      inputFields.add(const SizedBox(height: 15));

      
    });

    return showDialog<String>(
      context: context,
      builder: (BuildContext context ) => Dialog(
        insetPadding: 
        MediaQuery.of(context).size.height < 960 && MediaQuery.of(context).size.width <600  ?
          //para celulares
          EdgeInsets.fromLTRB(
          MediaQuery.of(context).size.width * .07,
          MediaQuery.of(context).size.height * .07,
          MediaQuery.of(context).size.width * .07,
          MediaQuery.of(context).size.height * .07,
        ):
          //para tablets
          EdgeInsets.fromLTRB(
          MediaQuery.of(context).size.width * .07,
          MediaQuery.of(context).size.height * .0,
          MediaQuery.of(context).size.width * .07,
          MediaQuery.of(context).size.height * .0,
          ),
        child: GestureDetector(
          onTap: () {
            SystemChannels.textInput.invokeMethod('TextInput.hide');
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width * .07,
                      MediaQuery.of(context).size.height * .1,
                      MediaQuery.of(context).size.width * .1,
                      MediaQuery.of(context).size.height * .07,
                    ),
                    child: Form(
                      key: myFormKey,
                      child: Column(children: [
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(widget.field[0],
                              style: getTextStyleTitle(context)),
                        ),
                        ...inputFields,
                      ]),
                    ),
                  ),
                ),
              ),
              SizedBox(
                child: ButtonBar(
                  alignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child:  Text('Cerrar',style: getTextStyleButtonField(context)),
                    ),
                    ElevatedButton(
                        onPressed: () async {
                        if(!myFormKey.currentState!.validate()){
                          return ;
                        }
                        FoodService fService = FoodService();
                        VehicleService vService = VehicleService();

                        switch (widget.control) {
                          case 1:
                             //Inicio turno
                            if (btnPosition == 1) {
                              if (sign == null || formValue['guard']!.contenido == '' || formValue['guard']!.contenido == null || formValue['sign']!.contenido == '' || formValue['sign']!.contenido == null) {
                                showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                 return AlertDialog(
                                    title: Text('Por favor acomplete todos los campos',style:  MediaQuery.of(context).size.height < 960 && MediaQuery.of(context).size.width <600  ?
                                    //para celulares
                                    TextStyle(fontSize: MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.015),fontWeight: FontWeight.bold):
                                    //para tablets
                                    TextStyle(fontSize: MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .02: 0.015),fontWeight: FontWeight.bold,)),
                                    content: ElevatedButton(onPressed: () {
                                        Navigator.of(context).pop(context);
                                    },
                                    child: Text('Aceptar',style: getTextStyleButtonField(context))
                                    )
                                  );
                                  }
                                 );
                              }else{
                                final image = await sign!.getData();
                                var data = await image.toByteData(format: ui.ImageByteFormat.png);
                                final encoded = base64.encode(data!.buffer.asUint8List());
                                formValue['sign']!.contenido = encoded;
                                TurnVehicle t= TurnVehicle();
                                if (formValue['sign']!.contenido != '' && formValue['sign']!.contenido != null) {
                                  t.guard = formValue['guard']!.contenido.toString().trim().replaceAll(RegExp('  +'), ' ');
                                  t.sign = formValue['sign']!.contenido;
                                  t.turn = formValue['turn']!.contenido;

                                  if((await vService.postTurnVehicle(t,context)).status == 404){
                                    return;
                                  }

                                  return showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                   return Align(
                                    alignment: Alignment.center,
                                     child: SingleChildScrollView(
                                       child: AlertDialog(
                                        actionsAlignment: MainAxisAlignment.center,
                                          title: const Text('¿Esta seguro de continuar con estos datos?'),
                                          content: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children:[
                                            const Text('Nombre', style: TextStyle(fontWeight: FontWeight.bold),),
                                            Text(t.guard!),
                                            const Text('Turno', style: TextStyle(fontWeight: FontWeight.bold)),
                                            Text(t.turn! == '1'?'Primer Turno':t.turn! == '2'?'Segundo Turno': 'Tercer Turno' )
                                            ]
                                          ),
                                          actions: [

                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                Provider.of<VarProvider>(context, listen: false).updateVariable(true);
                                                Navigator.pop(context);
                                              },
                                              child: Text('Aceptar',style: getTextStyleButtonField(context)),
                                            ),ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text('Cancelar',style: getTextStyleButtonField(context)),
                                            ),
                                          ],
                                        ),
                                     ),
                                   );
                                });


                                }else {
                                  return ; 
                                }
                              }
                            }
        
                            //registro 
                            if (btnPosition == 2) {
                              print(btnPosition);
                              RegisterVehicle r= RegisterVehicle();
                              VarProvider vh = VarProvider();
                              final json = await vh.arrSharedPreferences();
                              r.turn = json['turn'].toString();
                              r.color = formValue['color']!.contenido ;
                              r.employeeName = formValue['employeeName']!.contenido ;
                              r.platesSearch = formValue['platesSearch']!.contenido ;
                              r.typevh = formValue['typevh']!.contenido;
                              r.departament = formValue['departament']!.contenido ;
                              await vService.postRegisterVehicle(r,context);
                              Navigator.pop(context);
                            }
        
                            //Agregar observaciones
                            if (btnPosition == 3) {
                              TurnVehicle t= TurnVehicle();
                              t.description = formValue['description']!.contenido;
                              await vService.postObvVehicle(t,context);
                              Navigator.pop(context);
                            }

                              if(btnPosition == 4) {
                              DateExcelVehicle de = DateExcelVehicle();
                              de.dateStart = formValue['date_start_hour']!.contenido!; 
                              de.dateFinal = formValue['date_final_hour']!.contenido!;
                              de.turn = formValue['turn']!.contenido!;
                              de.guard = formValue['guard']!.contenido;
                              List<Map<String, dynamic>> jsonStr = await vService.selectDateVehicle(de,context);
                              List<Map<String, dynamic>> jsonStrObs = await vService.selectObsVehicle(de,context);
                              List<Map<String, dynamic>> dataGuard = await vService.dataGuard(de.guard!,context);

                                if (jsonStr.isNotEmpty) {
                                  DateTime now = DateTime.now();
                                  String formattedDate = DateFormat('yyyyMMddss').format(now);
                                  String fileName = '$formattedDate.xlsx';

                                   await jsonToExcel(
                                   jsonStr,
                                   ['TIPO VEHICULO','COLOR','PLACAS','NOMBRE EMPLEADO', 'DEPARTAMENTO','ENTRADA'], 
                                  jsonStrObs,
                                  dataGuard,
                                  1,
                                  fileName, 
                                  context);
                                  Navigator.pop(context);
                                }else{
                                  showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                   return AlertDialog(
                                      title: const Text('Mensaje'),
                                      content: const Text('No tiene vehiculos registrados'),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('Aceptar',style: getTextStyleButtonField(context)),
                                        ),
                                      ],
                                    );
                                });
                                }
                            } 

                            if (btnPosition == 5) {
                              int i = 0;

                              if (formValue['platesSearch']!.contenido != null && formValue['platesSearch']!.contenido != '') {
                                Access r = await vService.findVehicle(formValue['platesSearch']!.contenido!,context,1);
                                if (r.container != null) {
                                  for (var rc in r.container) {
                                    formValue['platesSearch']!.contenido = rc['plates'];
                                    formValue['typevh']!.contenido = rc['type_vh'];
                                    formValue['color']!.contenido = rc['color'];
                                    formValue['employeeName']!.contenido = rc['employee_name'];
                                    // formValue['salida']!.contenido = rc['timeExit'];
                                    formValue['entry']!.contenido = rc['time_entry'];
                                    formValue['outt']!.contenido = '';
                                  } 
                                }
                                
                                formValue.forEach((key, value) {
                                  controllerArr[i].text = formValue[key]!.contenido!;
                                  i++;
                                });
                              }
                            }

                            break;
                          case 2:                        
                            //Inicio turno
                            if (btnPosition == 1) {
                              TurnFood t= TurnFood();
                              if(formValue['picture']!.contenido != '' && formValue['picture']!.contenido != null){
                                t.picture = formValue['picture']!.contenido;
                                t.dish = formValue['dish']!.contenido;
                                t.garrison = formValue['garrison']!.contenido;
                                t.dessert = formValue['dessert']!.contenido;
                                t.received = formValue['received_number']!.contenido;
                                await fService.postTurnFood(t,context);
                              }else{
                                return showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Llene todos los campos'),
                                      content: const Text('Por favor suba una foto del platillo.'),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('Aceptar',style: getTextStyleButtonField(context)),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            Provider.of<VarProvider>(context, listen: false).updateVariable(true);
                            Navigator.pop(context);
                            }
        
                            //registro
                            if (btnPosition == 2) {
                              RegisterFood r= RegisterFood();
                              r.numEmployee = formValue['employee_number']!.contenido;
                              r.name = formValue['name']!.contenido;
                              r.contract = formValue['type_contract']!.contenido;

                              await fService.postRegisterFood(r,context);
                              Navigator.pop(context);
                            }
        
                            //Agregar observaciones
                            if (btnPosition == 3) {
                              TurnFood t= TurnFood();
                              t.description = formValue['description']!.contenido;
                              await fService.postObvFood(t,context);
                              Navigator.pop(context);
                            }


                            if(btnPosition == 4) {
                              DateExcelFood de = DateExcelFood();
                              de.dateStart = formValue['date_start_hour']!.contenido!; 
                              de.dateFinal = formValue['date_final_hour']!.contenido!;
                              de.dish = formValue['dish']!.contenido!.toString();
                              List<Map<String, dynamic>> jsonStr = await fService.selectDateFood(de, context);
                              List<Map<String, dynamic>> jsonStrObs = await fService.selectObsFood(de, context);

                                if (jsonStr.isNotEmpty) {
                                  DateTime now = DateTime.now();
                                  String formattedDate = DateFormat('yyyyMMddss').format(now);
                                  String fileName = '$formattedDate.xlsx';
                                   await jsonToExcel(
                                   jsonStr,
                                   ['Numero de empleado','Nombre','Contrato','Fecha comida'], 
                                   jsonStrObs,
                                   null,
                                   2,
                                   fileName, 
                                   context);  
                                Navigator.pop(context);
                                }else{
                                  showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                   return AlertDialog(
                                      title: const Text('Mensaje'),
                                      content: const Text('No tiene empleados registrados'),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('Aceptar',style: getTextStyleButtonField(context)),
                                        ),
                                      ],
                                    );
                                });
                                }
                            } 
                            break;
                          default:
                            
                            break;
                        }
                      },
                      child: Text(widget.field[0],style: getTextStyleButtonField(context)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Future observation() async {
    VehicleService vs = VehicleService();

    AccessMap r = (await vs.getObservation(context));

    print(r.container);
  }
}
