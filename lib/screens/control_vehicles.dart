import 'dart:convert';

import 'package:app_seguimiento_movil/models/models.dart';
import 'package:app_seguimiento_movil/services/services.dart';
import 'package:flutter/material.dart';
import 'package:app_seguimiento_movil/widgets/widgets.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class ControlVehicles extends StatefulWidget {
  const ControlVehicles({Key? key}) : super(key: key);
  
  
  @override
  State<ControlVehicles> createState() => _ControlVehiclesState();
}

class _ControlVehiclesState extends State<ControlVehicles> {
  
  double keyboardHeightRatio = 0.0;    
  final List<Map<String, dynamic>> arrList = [];
  final storage = FlutterSecureStorage();
  bool cargarLocales = true;
  //Nombre del campo :  contenido, ¿obligatorio?, ¿!select?, ¿!enabled?
    //Fecha se inserta automaticamente
    final Map<String, MultiInputsForm> formValuesInicioTur = {
      'guard': MultiInputsForm(contenido: '', obligatorio: true,autocomplete: true, autocompleteAsync: true,screen:0),
      'turn': MultiInputsForm(contenido: '', obligatorio: true, select: true, activeListSelect: false),
      'sign': MultiInputsForm(contenido: '', obligatorio: true, paintSignature: true),
    };
    
    //fecha se inserta manualmente
    final Map<String, MultiInputsForm> formValuesRegistroMan = {
      'platesSearch' : MultiInputsForm(contenido: '', obligatorio: true,autocomplete: true, autocompleteAsync: true,screen:  2),
      'hotel': MultiInputsForm(contenido: '', obligatorio: false, select: true, activeListSelect: true),
      'typevh' : MultiInputsForm(contenido: '', obligatorio: true),
      'modelvh' : MultiInputsForm(contenido: '', obligatorio: true),
      'color' : MultiInputsForm(contenido: '', obligatorio: true),
      'employeeName' : MultiInputsForm(contenido: '', obligatorio: true, enabled:  false),
      'departament' : MultiInputsForm(contenido: '',obligatorio: true, enabled:  false),
    };

    final Map<String, MultiInputsForm> formValuesObservacion = {
      'descriptionVehicle' : MultiInputsForm(contenido: '', obligatorio: true,)
    };

    final Map<String, MultiInputsForm> formValuesDescRepor = {
      'guard' : MultiInputsForm(contenido: '',obligatorio: false,autocomplete: true, autocompleteAsync: true, screen: 1),
      'turn': MultiInputsForm(contenido: '', obligatorio: true, select: true, activeListSelect: false),
      'date_start_hour' : MultiInputsForm(contenido: '', obligatorio: true, activeClock: true),
      'date_final_hour' : MultiInputsForm(contenido: '', obligatorio: true, activeClock: true),
    };

    final Map<String, MultiInputsForm> formValuesBuscarVh = {
      'platesSearch' :MultiInputsForm(contenido: '', obligatorio: true,autocomplete: true, autocompleteAsync: true, 
      suffixIcon: Icons.search_outlined, screen:  1),
      'typevh' :MultiInputsForm(contenido: '', enabled: false),
      'modelvh' :MultiInputsForm(contenido: '', enabled: false),
      'color' :MultiInputsForm(contenido: '', enabled: false),
      'employeeName' :MultiInputsForm(contenido: '', enabled: false),
      'entry' :MultiInputsForm(contenido: '', enabled: false),
      'outt' :MultiInputsForm(contenido: '', enabled: false),
    };
  
  bool cargarDatos = true;

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
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
                          child: Text('Control de vehículos',style: getTextStyleTitle(context,null) ),          
                          )
                        ),
                        SizedBox(height: responsiveHeight),
                        ButtonForm(
                            control: 1,
                            textButton: 'Inicio turno',
                            btnPosition: 1,
                            controller: controller,
                            field: const [
                              'Iniciar Turno',
                              'Iniciar',
                              'Nombre del guardia',
                              'Turno',
                              'Firma'
                            ],
                            formValue: formValuesInicioTur,
                            listSelect: const [['Primer Turno', 'Segundo Turno', 'Tercer turno'],[]],
                            enabled: true),
                        SizedBox(height: responsiveHeight),
                        const ButtonScreen(
                            textButton: 'Escaner QR', 
                            btnPosition: 1,
                            screen: 'scanner_qr_vehicles',
                          ),
                        SizedBox(height: responsiveHeight),
                        ButtonForm(
                            controller: controller,
                            control: 1,
                            textButton: 'Registro Manual',
                            btnPosition: 2,
                            field: const [
                              'Registro Manual',
                              'Registrar',
                              'placas',
                              'Hotel',
                              'Marca del vehículo',
                              'Modelo del vehículo',
                              'Color',
                              'Nombre',
                              'Departamento'
                            ],
                            formValue: formValuesRegistroMan,
                            listSelectForm: snapshot.data,
                            enabled: false),
                        SizedBox(height: responsiveHeight,),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            onPressed: (Provider.of<VarProvider>(context).varControl || false) ? () {
                              showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return  Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SingleChildScrollView(
                                      child: AlertDialog(
                                        title: Text('Cerrar Turno',style: getTextStyleText(context, null,null) ),
                                        content: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children:[
                                            ElevatedButton(onPressed:(){
                                              Navigator.of(context).pop(context);
                                            },child: Text('Cancelar', style: getTextStyleButtonField(context)
                                            )),
                                            const SizedBox(width: 8),
                                            ElevatedButton(onPressed: (Provider.of<VarProvider>(context).varSalir) == false?() async {
                                              VehicleService vs = VehicleService();
                                              Provider.of<VarProvider>(context,listen: false).updateVariable(false);
                                              Provider.of<VarProvider>(context,listen: false).updateVarSalir(true);
                                              var salirInt = (await vs.postCloseTurnVehicle(context));
                                              if (salirInt) {
                                                Provider.of<VarProvider>(context,listen: false).updateVarSalir(false);
                                                Navigator.of(context).pop(context);
                                                Navigator.of(context).pushNamed('home');
                                                
                                              }else{
                                                Provider.of<VarProvider>(context,listen: false).updateVariable(true);
                                                Provider.of<VarProvider>(context,listen: false).updateVarSalir(false);
                                              }
                                            }: null, child: Text('Aceptar', style: getTextStyleButtonField(context)
                                            )),
                                          ]
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              }
                              );
                            }:null,
                            child:  Padding(
                              padding: EdgeInsets.all(responsivePadding),
                              child: Text('Cerrar turno',style: getTextStyleButtonField(context)
                              ),
                            )
                          ),
                        ),
                        SizedBox(height: responsiveHeight),
                        ButtonForm(
                            control: 1,
                            textButton: 'Agregar observaciones',
                            btnPosition: 3,
                            controller: controller,
                            field: const ['Enviar','Enviar', 'Agregue una descripción...'],
                            formValue: formValuesObservacion,
                            enabled: false),
                        SizedBox(height: responsiveHeight),
                        ButtonForm(
                            control: 1,
                            controller: controller,
                            textButton: 'Descargar reporte',
                            btnPosition: 4,
                            field: const [
                              'Descargar reporte',
                              'Descargar',
                              'Guardia',
                              'Turno',
                              'Fecha inicial y hora',
                              'Fecha final y hora'
                            ],
                            listSelect: const [['Primer Turno', 'Segundo Turno', 'Tercer turno', 'Todos los turnos'],[]],
                            formValue: formValuesDescRepor,
                            enabled: true),
                        SizedBox(height: responsiveHeight),
                        ButtonForm(
                          control: 1,
                          controller: controller,
                          textButton: 'Buscar vehículo',
                          btnPosition: 5,
                          field: const [
                            'Buscar vehículo',
                            'Buscar',
                            'Placas',
                            'Marca del vehículo',
                            'Modelo del vehículo',
                            'Color',
                            'Nombre',
                            'Entrada',
                            'Salida'
                          ],
                          formValue: formValuesBuscarVh,
                          enabled: true,
                        ),
                      ]),
                    ),
                  ),
                ),
              ),
            ),
          const SizedBox(child: Navbar(contexto2: 'control_vehicles'))
          ],
          )
    );
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
    formValuesRegistroMan['hotel']!.contenido =  await storage.read(key: 'idHotelRegister') ;
     VarProvider vh = VarProvider();
  await vh.arrSharedPreferences().then((Map<String, dynamic> sharedPrefsData) async {
      if (sharedPrefsData['turn'] == null) {
      SessionManager sm = SessionManager();
        await sm.clearSession().then((value) async {
          if (sharedPrefsData['dish'] == null) {
            final url = Uri.parse('https://www.comunicadosaraiza.com/movil_scan_api_prueba2/API/turn_assistance.php?idTurn=true');
              await (http.post(url, body: json.encode({'idTurn': sharedPrefsData["idTurn"] }))).then((value) {
              Provider.of<VarProvider>(context,listen: false).updateVariable(false);
              setState(() { });
            });
          }else{
            final url = Uri.parse('https://www.comunicadosaraiza.com/movil_scan_api_prueba2/API/turn_food.php?cerrarSess=true');
            await http.post(url, body: json.encode({'local': (await storage.read(key: 'idHotelRegister')) })).then((value) {
            Provider.of<VarProvider>(context,listen: false).updateVariable(false);
            setState(() { });
            });
          }
        });
      }
    }).catchError((error) {
      //
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
