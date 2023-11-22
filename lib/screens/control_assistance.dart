import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:app_seguimiento_movil/widgets/widgets.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import '../models/multi_inputs_model.dart';
import '../services/services.dart';
import 'package:http/http.dart' as http;


class ControlAssistance extends StatefulWidget {
  const ControlAssistance({Key? key}) : super(key: key) ;



  @override
  State<ControlAssistance> createState() => _ControlAssistanceState();
}


class _ControlAssistanceState extends State<ControlAssistance> {    
  
  final List<Map<String, dynamic>> arrList = [];
  final storage = FlutterSecureStorage();

  //Nombre del campo :  contenido, ¿obligatorio?, ¿select?, ¿enabled?
    
    //Fecha se inserta automaticamente
    final Map<String, MultiInputsForm> formValuesInicioTur = {
      'course_name' : MultiInputsForm(contenido: '', obligatorio: true, autocomplete: true, autocompleteAsync: true),
      'schedule' : MultiInputsForm(contenido: '', obligatorio: true),
    };

    //fecha se inserta manualmente
    final Map<String, MultiInputsForm> formValuesRegistroMan = {
      'employee_number' : MultiInputsForm(contenido: '', obligatorio: true),   
      'nameSearch' : MultiInputsForm(contenido: '', obligatorio: false, autocomplete: true, autocompleteAsync: true),   
      'hotel' : MultiInputsForm(contenido: '', obligatorio: false, select: true, activeListSelect: true),
    };

    final Map<String, MultiInputsForm> formValuesObservacion = {
      'descriptionAssistance': MultiInputsForm(contenido: '',obligatorio: true,select: false,enabled: true)
    };

    final Map<String, MultiInputsForm> formValuesDescRepor = {
      'course_name': MultiInputsForm(contenido: '', obligatorio: false, autocomplete: true, autocompleteAsync: true),
      'date_start_hour': MultiInputsForm(contenido: '', obligatorio: false, activeClock: true, keyboardType: TextInputType.datetime, enabled: true), 
      'date_final_hour': MultiInputsForm(contenido: '', obligatorio: false, activeClock: true, keyboardType: TextInputType.datetime, enabled: true), 
    };

    final TextEditingController controller = TextEditingController();
    bool cargarDatos = true;
 @override
  Widget build(BuildContext context) {
    double responsiveHeight = MediaQuery.of(context).size.height * 0.02;
    double responsivePadding = MediaQuery.of(context).orientation == Orientation.portrait ? MediaQuery.of(context).size.width * 0.02 : MediaQuery.of(context).size.height * 0.02;

    

    return FutureBuilder<List<Map<String, dynamic>>>(
      future: recolectandoLocales(),
      builder: (context, snapshot) {
      if (snapshot.hasData) {
        return Scaffold(
          body: Column(
          children: [
            Expanded(
              child: Container(
                color: const Color.fromRGBO(246, 247, 252, 1),
                child: Align(
                  alignment: Alignment.center,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: 
                      MediaQuery.of(context).orientation == Orientation.portrait ? 
                      EdgeInsets.only(left: MediaQuery.of(context).size.width*0.08 ,right:  MediaQuery.of(context).size.width*0.08) :
                      EdgeInsets.only(left: MediaQuery.of(context).size.width*0.08 ,right: MediaQuery.of(context).size.width*0.08, top: MediaQuery.of(context).size.height*0.1),
                      child: Column(children: [
                        SizedBox(
                          child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Asistencia a curso',style: getTextStyleTitle(context,null)),          
                          )
                        ),
                        SizedBox(height: responsiveHeight),
                        ButtonForm(
                            controller: controller,
                            control: 3,
                            textButton: 'Inicio tomar de asistencia',
                            btnPosition: 1,
                            field: const [
                              'Iniciar toma de asistencia',
                              'Iniciar',
                              'Nombre del curso',
                              'Horario',
                              'Fecha'
                            ], 
                            formValue: formValuesInicioTur,
                            enabled: true),
                        SizedBox(height: responsiveHeight),
                        const ButtonScreen(
                            textButton: 'Escaner QR', 
                            btnPosition: 1,
                            screen:'scanner_qr_assistance'
                          ),
                        SizedBox(height: responsiveHeight),
                        ButtonForm(
                            controller: controller,
                            control: 3,
                            textButton: 'Registro Manual',
                            listSelectForm: snapshot.data,
                            btnPosition: 2,
                            field: const [
                              'Registro Manual',
                              'Registrar',
                              'Número de empleado',
                              'Nombre de empleado',
                              'Hotel'
                            ],
                            formValue: formValuesRegistroMan,
                            enabled: false),
                        SizedBox(height: responsiveHeight),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            onPressed: (Provider.of<VarProvider>(context).varControl || false) ? () {
                              showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return  GestureDetector(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SingleChildScrollView(
                                        child: AlertDialog(
                                          title: Text('Cerrar Turno',style: getTextStyleTitle2(context,null)),
                                          content: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children:[
                                              ElevatedButton(onPressed:  (){
                                                  Navigator.of(context).pop(context);
                                                },child: Text('Cancelar', style: getTextStyleButtonField(context)),
                                              ),
                                              ElevatedButton(onPressed: (Provider.of<VarProvider>(context).varSalir) == false ? () async {
                                              Provider.of<VarProvider>(context,listen: false).updateVariable(false);
                                              Provider.of<VarProvider>(context,listen: false).updateVarSalir(true);
                                                AssistanceService fs = AssistanceService();
                                                  var salirInt =  await fs.postCloseTurnAssistance(context);
                                                   if (salirInt) {
                                                    Provider.of<VarProvider>(context,listen: false).updateVarSalir(false);
                                                    Navigator.of(context).pop(context);
                                                    Navigator.of(context).pushNamed('home');
                                                  }else{
                                                    Provider.of<VarProvider>(context,listen: false).updateVariable(true);
                                                    Provider.of<VarProvider>(context,listen: false).updateVarSalir(false);
                                                  }
                                                }: null, child: Text('Aceptar',style: getTextStyleButtonField(context))
                                              ),
                                            ]
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }
                              );
                            }:null,
                            child: Padding(
                              padding: EdgeInsets.all(responsivePadding),
                              child: Text('Finalizar toma de asistencia',style: getTextStyleButtonField(context)),
                            )),
                        ),
                        SizedBox(height: responsiveHeight),
                        ButtonForm(
                            controller: controller,
                            control: 3,
                            textButton: 'Agregar observaciones',
                            btnPosition: 3,
                            field: const ['Enviar','Enviar', 'Agregue una descripción...'],
                            formValue: formValuesObservacion,
                            enabled: false),
                        SizedBox(height: responsiveHeight),
                        ButtonForm(
                            controller: controller,
                            control: 3,
                            textButton: 'Descargar reporte',
                            btnPosition: 4,
                            field: const [
                              'Descargar reporte',
                              'Descargar',
                              'Buscar curso',
                              'Fecha inicial y hora',
                              'Fecha final y hora'
                            ],
                            formValue: formValuesDescRepor,
                            enabled: true),
                      ]),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(child: Navbar(contexto2: 'control_assistance',))
          ],
        ));
      }
      return Scaffold(
      body: Center(
          child: FractionallySizedBox(
            widthFactor: MediaQuery.of(context).orientation == Orientation.portrait ? 0.1 : 0.05,
            heightFactor: MediaQuery.of(context).orientation == Orientation.portrait ? 0.05 : 0.1,
            child: const CircularProgressIndicator(),
          ),
        ),
    );
    });
  
  }

Future<List<Map<String, dynamic>>> recolectandoLocales() async {
  if (cargarDatos) {
    cargarDatos = false;
    LocalService lc = LocalService();
      final locals = await lc.getLocal(context);
      for (var el in locals.container) {
        if (int.parse(el['idLocal']) > 0) {
          arrList.add(el);
        }
      }
    formValuesRegistroMan['hotel']!.contenido =  await storage.read(key: 'idHotelRegister');

    VarProvider vh = VarProvider();
    await vh.arrSharedPreferences().then((Map<String, dynamic> sharedPrefsData) async { 
    if (sharedPrefsData['course_name'] == null) {
      SessionManager sm = SessionManager();
        await sm.clearSession().then((value) async {
          if (sharedPrefsData['dish'] == null) {
            final url = Uri.parse('https://www.comunicadosaraiza.com/movil_scan_api_prueba2/API/turn_vehicle.php?idTurn=true');
           await (http.post(url, body: json.encode({'idTurn': sharedPrefsData["idTurn"] }))).then((value) {
            Provider.of<VarProvider>(context,listen: false).updateVariable(false);
            setState(() { });
          });
          } else { 
            //food
            final url = Uri.parse('https://www.comunicadosaraiza.com/movil_scan_api_prueba2/API/turn_food.php?cerrarSess=true');
            await http.post(url, body: json.encode({'local': ( await storage.read(key: 'idHotelRegister')) })).then((value) {
            Provider.of<VarProvider>(context,listen: false).updateVariable(false);
            setState(() { });
            });
          }
      });
    }
    }).catchError((error) {
      //
    }).then((value) {
    });
  }
  return arrList;
}


  @override
  initState() { 
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.initState();
  }
}
