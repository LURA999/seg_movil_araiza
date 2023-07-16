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
import '../services/letter_mediaquery.dart';

class ButtonForm extends StatelessWidget {
  final String textButton;
  final List<String> field;
  final Map<String, MultiInputsForm> formValue;
  final bool enabled;
  final List<List<String>>? listSelect;
  final int btnPosition;
  final int control;
  final TextEditingController? controller;
  final List<TextEditingController> controllerArr = []; 

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
              Provider.of<VarProvider>(context, listen: false).varControl == true && btnPosition == 1 ? null : 
              //de otra forma se desactivan los otros 4 botones (en este caso solo se desactivan 2 botones, porqe los otros dos, no pertencen a esta clase)
              ((Provider.of<VarProvider>(context, listen: false).varControl || enabled)
                  ? () {
                     newMethod(context, formValue, btnPosition);
                    }
                  : null),
          child: Text(textButton, style: getTextStyleButtonField(context))
          
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

    inputFields.add(const SizedBox(height: 15));
    formValue.forEach((key, value) {
      TextEditingController? controllerAux = TextEditingController();
      //Esto es para ayudar al formulario, para que sea mas dinamico
      //Si es nulo, entonces no seran validados los campos
      if (controller == null) {
        controllerAux = controller;
      } 
      if (key.substring(0, 4) == "date") {
        inputFields.add(
          MultiInputs(
            maxLines: 1,
            controller:controllerAux,
            autofocus: i == 1 ? true : false,
            labelText: field[i],
            formProperty: key,
            formValue: formValue,
            keyboardType: TextInputType.datetime),
        );
      } else {
        if (formValue[key]!.paintSignature == true) {
          inputFields.add(
            Column(
            children: [
              Text( field[i]),
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
          labelText: field[i], 
          controller: controllerAux,
          autofocus: i == 1 ? true : false,
          formProperty: key,
          suffixIcon: value.suffixIcon,
          listSelect: listSelect,
          autocompleteAsync: value.autocompleteAsync,
          formValue: formValue,
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
                          child: Text(field[0],
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
                        DepartamentService dpser = DepartamentService();
                        switch (control) {
                          case 1:
                             //Inicio turno
                            if (btnPosition == 1) {
                              if (sign == null || formValue['name']!.contenido == '' || formValue['name']!.contenido == null || formValue['sign']!.contenido == '' || formValue['sign']!.contenido == null) {
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
                                  t.name = formValue['name']!.contenido.toString().trim().replaceAll(RegExp('  +'), ' ');
                                  t.sign = formValue['sign']!.contenido;
                                  t.turn = formValue['turn']!.contenido;
                                  if((await dpser.postTurnVehicle(t)).status == 404){
                                    return;
                                  }
                                Provider.of<VarProvider>(context, listen: false).updateVariable(true);
                                }else {
                                  return ; 
                                }
                                Navigator.pop(context);
                              }
                            }
        
                            //registro 
                            if (btnPosition == 2) {
                              RegisterVehicle r= RegisterVehicle();
                              r.color = formValue['color']!.contenido;
                              r.employeeName = formValue['employeeName']!.contenido;
                              r.plates = formValue['plates']!.contenido;
                              r.typevh = formValue['typevh']!.contenido;
                              r.departament = formValue['departament']!.contenido;
                              await dpser.postRegisterVehicle(r);
                              Navigator.pop(context);
                            }
        
                            //Agregar observaciones
                            if (btnPosition == 3) {
                              TurnVehicle t= TurnVehicle();
                              t.description = formValue['description']!.contenido;
                              await dpser.postObvVehicle(t);
                              Navigator.pop(context);
                            }

                            if (btnPosition == 5) {
                              int i = 0;
                              if (formValue['placas']!.contenido != null && formValue['placas']!.contenido != '') {
                                Access r = await dpser.findVehicle(formValue['placas']!.contenido!);
                                if (r.container != null) {
                                  for (var rc in r.container) {
                                    formValue['placas']!.contenido = rc['plates'];
                                    formValue['tipo_vehiculo']!.contenido = rc['type_vh'];
                                    formValue['color']!.contenido = rc['color'];
                                    formValue['nombre']!.contenido = rc['employee_name'];
                                    // formValue['salida']!.contenido = rc['timeExit'];
                                    formValue['entrada']!.contenido = rc['time_entry'];
                                    formValue['salida']!.contenido = '';
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
                                t.plate = formValue['plate']!.contenido;
                                t.garrison = formValue['garrison']!.contenido;
                                t.dessert = formValue['dessert']!.contenido;
                                t.received = formValue['received_number']!.contenido;
                                await dpser.postTurnFood(t);
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
                              switch (formValue['type_contract']!.contenido) {
                                case 'Sindicalizado':
                                  r.contract = '1';
                                  break;
                                case 'No sindicalizado':
                                  r.contract = '2';
                                  break;
                                case 'Corporativo':
                                  r.contract = '3';
                                  break;  
                                default:
                              }
                              await dpser.postRegisterFood(r);
                              Navigator.pop(context);
                            }
        
                            //Agregar observaciones
                            if (btnPosition == 3) {
                              TurnFood t= TurnFood();
                              t.description = formValue['description']!.contenido;
                              await dpser.postObvFood(t);
                              Navigator.pop(context);
                            }
                            break;
                          default:
                          //Descargar reporte
                            if(btnPosition == 4) {
                              DateExcel de = DateExcel();
                              de.dateStart = formValue['date_start_hour']!.contenido!; 
                              de.dateFinal = formValue['date_final_hour']!.contenido!;
                              de.turn = formValue['turn']!.contenido!;
                              de.guard = formValue['guard']!.contenido;
                              List<Map<String, dynamic>> jsonStr = await dpser.selectDate(de);
                                if (jsonStr.isNotEmpty) {
                                  DateTime now = DateTime.now();
                                  String formattedDate = DateFormat('yyyyMMddss').format(now);
                                  String fileName = '$formattedDate.xlsx';
                                   await jsonToExcel(
                                   jsonStr,
                                   ['TIPO VEHICULO','COLOR','PLACAS','NOMBRE EMPLEADO', 'DEPARTAMENTO','ENTRADA','SALIDA'], 
                                   fileName, 
                                   context);  
                                }
                               Navigator.pop(context);
                            } 
                            break;
                        }
                      },
                      child: Text(field[0],style: getTextStyleButtonField(context)),
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

}
