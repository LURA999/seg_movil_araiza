// ignore_for_file: use_build_context_synchronously

import 'package:app_seguimiento_movil/models/date_excel_assistance.dart';
import 'package:app_seguimiento_movil/models/models.dart';
import 'package:app_seguimiento_movil/models/qr_assistance.dart';
import 'package:app_seguimiento_movil/widgets/widgets.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
final List<Map<String,dynamic>>? listSelectForm;
const ButtonForm({
super.key,
required this.textButton,
required this.btnPosition,
this.listSelect,
required this.field,
required this.formValue,
required this.enabled, 
required this.control, 
this.controller, 
this.listSelectForm,    
});

@override
State<ButtonForm> createState() => _ButtonFormState();
}

class _ButtonFormState extends State<ButtonForm> {
final List<TextEditingController> controllerArr = []; 
final storage = FlutterSecureStorage();

@override
Widget build(BuildContext context) {
double responsivePadding = MediaQuery.of(context).orientation == Orientation.portrait ? MediaQuery.of(context).size.width * 0.02 : MediaQuery.of(context).size.height * 0.02;

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
      child: Padding(
        padding: EdgeInsets.all(responsivePadding),
        child: Text(widget.textButton, style: getTextStyleButtonField(context)),
      )
      
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
int i = 2;

onFormValueChange(dynamic value,List<String> keyValue) {
  int ivalue = 0;
  //se llena los inputs  y su respectivo formvalue, llenarlo solo en el formvalue no es suficiente
  for (var i = 0; i < inputFields.length; i++) {
    if (inputFields[i].runtimeType.toString() == 'MultiInputs') {
      (inputFields[i] as MultiInputs).controller!.text = value[0][keyValue[ivalue]] ?? '';
      formValue[(inputFields[i] as MultiInputs).formProperty]!.contenido = value[0][keyValue[ivalue]];
      // print('${keyValue[ivalue]} : ${value[0][keyValue[ivalue]]} = ${formValue[(inputFields[i] as MultiInputs).formProperty]!.contenido}');
      ivalue++;
    }
  } 

 
  setState(() { });
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
        keyboardType: TextInputType.datetime
        ),
    );
  } else {
    if (formValue[key]!.paintSignature == true) {
      inputFields.add(
        Column(
        children: [
          Text( widget.field[i], style: getTextStyleText(context,null,null),),
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
        listSelectButton: widget.listSelect,
        listSelectForm: widget.listSelectForm,
        activeListSelect : value.activeListSelect,
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

bool desactivarButton =false;
return showDialog<String>(
  context: context,
  builder: (BuildContext context ) => StatefulBuilder(
  builder: (BuildContext context, StateSetter setState) {

  return Dialog(
    insetPadding: 
    MediaQuery.of(context).size.height < 960 && MediaQuery.of(context).size.width <900  ?
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
                          style: getTextStyleTitle(context,null)),
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
                    onPressed: !desactivarButton ? () async {
                    var connectivityResult = await (Connectivity().checkConnectivity());
                    if (connectivityResult == ConnectivityResult.none) {
                      // No hay conexión a Internet
                      messageError(context,'No hay conexión a Internet.', 'Error');
                      
                    } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
                    
                    if(!myFormKey.currentState!.validate()){
                      return ;
                    }
                    AssistanceService aService = AssistanceService();
                    FoodService fService = FoodService();
                    VehicleService vService = VehicleService();
                    switch (widget.control) {
                      case 1:
                        //TRAFICO
                        //Inicio turno
                        if (btnPosition == 1) {
                          if (sign == null || formValue['guard']!.contenido == '' || formValue['guard']!.contenido == null || formValue['sign']!.contenido == '' || formValue['sign']!.contenido == null) {
                            showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Por favor acomplete todos los campos',style:  MediaQuery.of(context).size.height < 960 && MediaQuery.of(context).size.width <900  ?
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
                            var connectivityResult = await (Connectivity().checkConnectivity());
                            if (connectivityResult == ConnectivityResult.none) {
                              // No hay conexión a Internet
                              messageError(context,'No hay conexión a Internet.', 'Error');
                              
                            } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
                            
                            final image = await sign!.getData();
                            var data = await image.toByteData(format: ui.ImageByteFormat.png);
                            final encoded = base64.encode(data!.buffer.asUint8List());
                            formValue['sign']!.contenido = encoded;
                            TurnVehicle t= TurnVehicle();
                            if (formValue['sign']!.contenido != '' && formValue['sign']!.contenido != null) {
                              t.guard = formValue['guard']!.contenido.toString().trim().replaceAll(RegExp('  +'), ' ');
                              t.sign = formValue['sign']!.contenido;
                              t.turn = formValue['turn']!.contenido;
                              setState((){
                                desactivarButton = true;
                              });
                              

                              return showDialog(
                            context: context,
                            builder: (BuildContext context) => Stack(
                              children: [
                                const ModalBarrier(
                                  dismissible: false,
                                  color:  Color.fromARGB(80, 0, 0, 0),
                                ),
                                StatefulBuilder(
                                builder: (BuildContext context, StateSetter setState) {
                                    return Align(
                                    alignment: Alignment.center,
                                      child: SingleChildScrollView(
                                        child: AlertDialog(
                                        actionsAlignment: MainAxisAlignment.center,
                                          title: Text('¿Desea continuar?',style: getTextStyleTitle2(context, null)),
                                          content: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children:[
                                            Text('Nombre:', style: getTextStyleText(context,FontWeight.bold,null),),
                                            Text(t.guard!, style: getTextStyleText(context,null,null),),
                                            const SizedBox(height: 10,),
                                            Text('Turno:', style: getTextStyleText(context,FontWeight.bold,null)),
                                            Text(t.turn! == '1'?'Primer Turno':t.turn! == '2'?'Segundo Turno': 'Tercer Turno', style: getTextStyleText(context,null,null), )
                                            ]
                                          ),
                                          actions: [
                                            ElevatedButton(
                                              onPressed: desactivarButton == true? () {
                                                Navigator.pop(context);
                                                setState((){
                                                  desactivarButton = false;
                                                });
                                              }:null,
                                              child: Text('Cancelar',style: getTextStyleButtonField(context)),
                                            ),
                                            ElevatedButton(
                                              
                                              onPressed: desactivarButton == true? () async {
                                                setState((){
                                                    desactivarButton = false;
                                                  });
                                                  if((await vService.postTurnVehicle(t,context)).status != 200){
                                                  Navigator.pop(context);
                                                }else{
                                                  Navigator.pop(context);
                                                  Provider.of<VarProvider>(context, listen: false).updateVariable(true);
                                                  Navigator.pop(context);
                                                }
                                              } : null,
                                              child: Text('Aceptar',style: getTextStyleButtonField(context)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                }),
                              ],
                            ));
                            }
                            }else {
                              return ; 
                            }
                          }
                        }
    
                        //registro 
                        if (btnPosition == 2) {
                          RegisterVehicle r= RegisterVehicle();
                          VarProvider vh = VarProvider();
                          final json = await vh.arrSharedPreferences();
                          json['sign'] = [];
                          r.turn = json['turn'].toString();
                          r.fkTurn = json['idTurn'].toString();
                          r.color = formValue['color']!.contenido ;
                          r.employeeName = formValue['employeeName']!.contenido;
                          r.platesSearch = formValue['platesSearch']!.contenido;
                          r.typevh = formValue['typevh']!.contenido;
                          r.modelvh = formValue['modelvh']!.contenido;
                          r.departament = formValue['departament']!.contenido;  
                          r.local = formValue['hotel']!.contenido;
                          setState((){
                              desactivarButton = true;
                          });
                        AccessMap res =  await vService.postRegisterVehicle(r,context);
 
                        if(res.status == 200){
                            Navigator.pop(context);
                        }else{
                          setState((){
                            desactivarButton = false;
                        });
                        }
                        }
    
                        //Agregar observaciones
                        if (btnPosition == 3) {
                          setState((){
                            desactivarButton = true;
                          });
                          TurnVehicle t= TurnVehicle();
                          t.description = formValue['descriptionVehicle']!.contenido;
                          if(await vService.postObvVehicle(t,context)){
                          Navigator.pop(context);
                          }else{
                            setState((){
                              desactivarButton = false;
                            });
                          }
                        }

                          if(btnPosition == 4) {
                            if ((formValue['date_start_hour']!.contenido! != '') || formValue['date_final_hour']!.contenido! !=''){
                              setState((){
                              desactivarButton = true;
                            });
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
                                ['MARCA VEHICULO', 'MODELO VEHICULO','COLOR','PLACAS','NOMBRE EMPLEADO', 'DEPARTAMENTO','ENTRADA'], 
                              jsonStrObs,
                              null,
                              dataGuard,
                              null,
                              1,
                              fileName, 
                              context);
                              Navigator.pop(context);
                            }else{
                              setState((){
                              desactivarButton = false;
                            });
                            
                              showDialog(
                            context: context,
                            builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Mensaje',style: getTextStyleText(context,FontWeight.bold,null)),
                                  content: Text('No tiene vehiculos registrados', style: getTextStyleText(context,null,null),),
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
                          }else{
                              setState((){
                              desactivarButton = false;
                            });
                            showDialog(
                            context: context,
                            builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Mensaje',style: getTextStyleText(context,FontWeight.bold,null)),
                                  content: Text('Por favor llene los campos necesarios', style: getTextStyleText(context,null,null),),
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

                        //Descargar excel
                        if (btnPosition == 5) {
                          int i = 0;

                          if (formValue['platesSearch']!.contenido != null && formValue['platesSearch']!.contenido != '') {
                            setState((){
                              desactivarButton = true;
                            });
                            Access r = await vService.findVehicle(formValue['platesSearch']!.contenido!, int.parse((await storage.read(key: 'idHotelRegister')).toString()) ,context,1);
                            if (r.container != null) {
                              for (var rc in r.container) {
                                formValue['platesSearch']!.contenido = rc['plates'];
                                formValue['typevh']!.contenido = rc['type_vh'];
                                formValue['modelvh']!.contenido = rc['model_vh'];
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

                            setState((){
                              desactivarButton = false;
                            });
                          }
                        }

                        break;
                      case 2:
                        //COMEDOR                        
                        //Inicio turno
                        if (btnPosition == 1) {
                          TurnFood t= TurnFood();

                          if(formValue['picture']!.contenido != '' && formValue['picture']!.contenido != null){
                            setState((){
                              desactivarButton = true;
                            });
                            t.picture = formValue['picture']!.contenido;
                            t.dish = formValue['dish']!.contenido;
                            t.garrison = formValue['garrison']!.contenido;
                            t.dessert = formValue['dessert']!.contenido;
                            t.received = formValue['received_number']!.contenido;
                            t.menu_portal = formValue['menu_portal']!.contenido;

                            return showDialog(
                            context: context,
                            builder: (BuildContext context) => Stack(
                              children: [
                                const ModalBarrier(
                                  dismissible: false,
                                  color:  Color.fromARGB(80, 0, 0, 0),
                                ),
                                StatefulBuilder(
                                builder: (BuildContext context, StateSetter setState) {
                                    return Align(
                                    alignment: Alignment.center,
                                      child: SingleChildScrollView(
                                        child: AlertDialog(
                                        actionsAlignment: MainAxisAlignment.center,
                                          title: Text('¿Desea continuar?',style: getTextStyleTitle2(context, null)),
                                          content: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children:[
                                            Text('Platillo:', style: getTextStyleText(context,FontWeight.bold,null),),
                                            Text(t.dish!, style: getTextStyleText(context,null,null),),
                                            const SizedBox(height: 10,),
                                            Text('Guarnicion:', style: getTextStyleText(context,FontWeight.bold,null)),
                                            Text(t.garrison!, style: getTextStyleText(context,null,null), ),
                                            const SizedBox(height: 10,),
                                            Text('Postre:', style: getTextStyleText(context,FontWeight.bold,null)),
                                            Text(t.dessert! == '' || t.dessert == null ?'N/A': t.dessert!, style: getTextStyleText(context,null,null), ),
                                            const SizedBox(height: 10,),
                                            Text('Cantidad recibida:', style: getTextStyleText(context,FontWeight.bold,null)),
                                            Text(t.received!, style: getTextStyleText(context,null,null), ),
                                            const SizedBox(height: 10,),
                                            Text('Menu de Hoy (Portal de Comunicación):', style: getTextStyleText(context,FontWeight.bold,null)),
                                            Text(t.menu_portal!, style: getTextStyleText(context,null,null), )
                                            ]
                                          ),
                                          actions: [
                                            ElevatedButton(
                                              onPressed: desactivarButton == true? () {
                                                Navigator.pop(context);
                                                setState((){
                                                  desactivarButton = false;
                                                });
                                              } : null,
                                              child: Text('Cancelar',style: getTextStyleButtonField(context)),
                                            ),
                                            ElevatedButton(
                                              onPressed: desactivarButton == true? () async {
                                                var connectivityResult = await (Connectivity().checkConnectivity());
                                                if (connectivityResult == ConnectivityResult.none) {
                                                  // No hay conexión a Internet
                                                  messageError(context,'No hay conexión a Internet.', 'Error');
                                                  
                                                } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
                                                setState((){
                                                    desactivarButton = false;
                                                  });
                                                  if(( await fService.postTurnFood(t,context)).status != 200){
                                                  Navigator.pop(context);
                                                  }else{
                                                    Navigator.pop(context);
                                                    Provider.of<VarProvider>(context, listen: false).updateVariable(true);
                                                    Navigator.pop(context);
                                                  }
                                                }
                                              } : null,
                                              child: Text('Aceptar',style: getTextStyleButtonField(context)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                }),
                              ],
                            ));
                        

                          }else{
                            setState((){
                              desactivarButton = true;
                            });
                            return showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title:  Text('Llene todos los campos', style: getTextStyleText(context,FontWeight.bold,null),),
                                  content: Text('Por favor suba una foto del platillo.', style: getTextStyleText(context,null,null),),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () async { 
                                          
                                      setState((){
                                        desactivarButton = false;
                                      });
                                        Navigator.pop(context);
                                      },
                                      child: Text('Aceptar',style: getTextStyleButtonField(context)),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        }
    
                        //registro
                        if (btnPosition == 2) {
                          setState((){
                            desactivarButton = true;
                          });
                          RegisterFood r= RegisterFood();
                          r.numEmployee = formValue['employee_number']!.contenido;
                          r.name = '';
                          r.contract = '3';
                          r.local = formValue['hotel']!.contenido;
                        if(await fService.postRegisterFood(r,context)){
                          Navigator.pop(context);
                          }else{
                          setState((){
                            desactivarButton = false;
                          });
                          }
                        }
    
                        //Agregar observaciones
                        if (btnPosition == 3) {
                          setState((){
                            desactivarButton = true;
                          });
                          TurnFood t= TurnFood();
                          t.description = formValue['descriptionFood']!.contenido;
                          t.local = await storage.read(key: 'idHotelRegister');
                          if(await fService.postObvFood(t,context)){
                          Navigator.pop(context);
                          }else{
                          setState((){
                            desactivarButton = false;
                          });
                          }
                        }

                        //descargar excel
                        if(btnPosition == 4) {
                          if ((formValue['date_start_hour']!.contenido! != '') || formValue['date_final_hour']!.contenido! !=''){
                          setState((){
                            desactivarButton = true;
                          });
                          DateExcelFood de = DateExcelFood();
                          de.dateStart = formValue['date_start_hour']!.contenido!; 
                          de.dateFinal = formValue['date_final_hour']!.contenido!;
                          de.dish = formValue['dish']!.contenido!.toString();
                          de.local = (await storage.read(key: 'idHotelRegister')) ;
                          List<Map<String, dynamic>> jsonStr = await fService.selectDateFood(de, context);
                          List<Map<String, dynamic>> jsonStrObs = await fService.selectObsFood(de, context);
                          List<Map<String, dynamic>> jsonStrMenu = await fService.selectFoodMenu(de, context);
                          List<Map<String, dynamic>> jsonStrCom = await fService.selectDateFoodComment(de, context);
                            if (jsonStr.isNotEmpty) {
                              DateTime now = DateTime.now();
                              String formattedDate = DateFormat('yyyyMMddss').format(now);
                              String fileName = '$formattedDate.xlsx';
                                await jsonToExcel(
                                jsonStr,
                                ['Numero de empleado','Nombre','Contrato','Fecha comida'], 
                                jsonStrObs,
                                jsonStrMenu,
                                null,
                                jsonStrCom,
                                2,
                                fileName, 
                                context);  
                            Navigator.pop(context);
                            setState((){
                              desactivarButton = false;
                            });
                            }else{
                            setState((){
                              desactivarButton = false;
                            });
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
                        } else{
                          setState((){
                            desactivarButton = false;
                          });
                          showDialog(
                          context: context,
                          builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Mensaje',style: getTextStyleText(context,FontWeight.bold,null)),
                                content: Text('Por favor llene los campos necesarios', style: getTextStyleText(context,null,null),),
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
                      //ASISTENCIA
                      if(btnPosition == 1){
                        TurnAssistance t= TurnAssistance();
                          setState((){
                            desactivarButton = true;
                          });
                          t.course_name = formValue['course_name']!.contenido;
                          t.schedule = formValue['schedule']!.contenido;
                          //t.time = formValue['garrison']!.contenido;
                        
                          return showDialog(
                          context: context,
                          builder: (BuildContext context) => Stack(
                            children: [
                              const ModalBarrier(
                                dismissible: false,
                                color:  Color.fromARGB(80, 0, 0, 0),
                              ),
                              StatefulBuilder(
                              builder: (BuildContext context, StateSetter setState) {
                                  return Align(
                                  alignment: Alignment.center,
                                    child: SingleChildScrollView(
                                      child: AlertDialog(
                                      actionsAlignment: MainAxisAlignment.center,
                                        title: Text('¿Desea continuar?',style: getTextStyleTitle2(context, null)),
                                        content: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children:[
                                            Text('Curso:', style: getTextStyleText(context,FontWeight.bold,null),),
                                            Text(t.course_name!, style: getTextStyleText(context,null,null),),
                                            const SizedBox(height: 10,),
                                            Text('Horario:', style: getTextStyleText(context,FontWeight.bold,null)),
                                            Text(t.schedule!, style: getTextStyleText(context,null,null), ),
                                          ]
                                        ),
                                        actions: [
                                          ElevatedButton(
                                            onPressed: desactivarButton == true? () {
                                              Navigator.pop(context);
                                              setState((){
                                                desactivarButton = false;
                                              });
                                            } : null,
                                            child: Text('Cancelar',style: getTextStyleButtonField(context)),
                                          ),
                                          ElevatedButton(
                                            onPressed: desactivarButton == true? () async {
                                              var connectivityResult = await (Connectivity().checkConnectivity());
                                                if (connectivityResult == ConnectivityResult.none) {
                                                  // No hay conexión a Internet
                                                  messageError(context,'No hay conexión a Internet.', 'Error');
                                                } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
                                                setState((){
                                                    desactivarButton = false;
                                                  });
                                                  if(( await aService.postTurnAssistance(t,context)).status != 200){
                                                  Navigator.pop(context);
                                                }else{
                                                  Navigator.pop(context);
                                                  Provider.of<VarProvider>(context, listen: false).updateVariable(true);
                                                  Navigator.pop(context);
                                                }
                                              }
                                            } : null,
                                            child: Text('Aceptar',style: getTextStyleButtonField(context)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                              }),
                            ],
                          ));
                        }

                          //Agregar observaciones
                        if (btnPosition == 3) {
                          setState((){
                            desactivarButton = true;
                          });
                          
                          TurnAssistance t= TurnAssistance();
                          t.description = formValue['descriptionAssistance']!.contenido;
                          if(await aService.postObvAssistance(t,context)){
                          Navigator.pop(context);
                          }else{
                          setState((){
                            desactivarButton = false;
                          });
                          }
                        }

                        //Registro manual
                          if (btnPosition == 2) {
                          QrAssistance r= QrAssistance();
                          VarProvider vh = VarProvider();
                          final json = await vh.arrSharedPreferences();
                          r.idTurn = json['idTurn'].toString();
                          r.employee_num = formValue['employee_number']!.contenido;
                          r.local = formValue['hotel']!.contenido;
                          // r.local = formValue[]
                          setState((){
                              desactivarButton = true;
                          });

                          if(await aService.postRegisterAssistance(r,context)){
                          Navigator.pop(context);
                           ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Empleado registrado'),backgroundColor: Colors.green),
                            );
                          }else{
                          setState((){
                            desactivarButton = false;
                          });
                          }
                        }

                        //descargar excel
                        if(btnPosition == 4) {
                          if (/* (formValue['date_start_hour']!.contenido! != '') || formValue['date_final_hour']!.contenido! !='' */ myFormKey.currentState!.validate()){
                          setState((){
                            desactivarButton = true;
                          });
                          DateExcelAssistance de = DateExcelAssistance();
                          de.dateStart = formValue['date_start_hour']!.contenido!; 
                          de.dateFinal = formValue['date_final_hour']!.contenido!;
                          de.course_name = formValue['course_name']!.contenido!.toString().split('-')[0].trim();
                          de.local = (await storage.read(key: 'idHotelRegister')).toString();
                          
                          List<Map<String, dynamic>> jsonStr = await aService.selectDateAssistance(de, context);
                          List<Map<String, dynamic>> jsonStrObs = await aService.selectDateAssistanceObservations(de, context);
                       
                            if (jsonStr.isNotEmpty) {
                              DateTime now = DateTime.now();
                              String formattedDate = DateFormat('yyyyMMddss').format(now);
                              String fileName = ' assistencia_$formattedDate.xlsx';
                                await jsonToExcel(
                                jsonStr,
                                ["Numero de empleado", "Nombre completo", "Nombre del curso", "Horario", "Hora y Fecha de asistencia"], 
                                jsonStrObs,
                                null,
                                null,
                                null,
                                3,
                                fileName, 
                                context);  
                            Navigator.pop(context);
                            setState((){
                              desactivarButton = false;
                            });
                            }else{
                            setState((){
                              desactivarButton = false;
                            });
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
                        } else{
                          setState((){
                            desactivarButton = false;
                          });
                          showDialog(
                          context: context,
                          builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Mensaje',style: getTextStyleText(context,FontWeight.bold,null)),
                                content: Text('Por favor llene los campos necesarios', style: getTextStyleText(context,null,null),),
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
                    }
                    }
                  }:null,
                  child: Text(widget.field[1],style: getTextStyleButtonField(context)),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
})
);
}
}
