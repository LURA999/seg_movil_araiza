import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:app_seguimiento_movil/widgets/widgets.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../models/multi_inputs_model.dart';
import '../services/services.dart';


class DiningRoom extends StatefulWidget {
  const DiningRoom({Key? key}) : super(key: key);

  @override
  State<DiningRoom> createState() => _DiningRoomState();
}


class _DiningRoomState extends State<DiningRoom> {
 @override
  Widget build(BuildContext context) {
    double responsiveHeight = MediaQuery.of(context).size.height * 0.02;
    double responsivePadding = MediaQuery.of(context).orientation == Orientation.portrait ? MediaQuery.of(context).size.width * 0.02 : MediaQuery.of(context).size.height * 0.02;

    //Nombre del campo :  contenido, ¿obligatorio?, ¿select?, ¿enabled?
    
    //Fecha se inserta automaticamente
    final Map<String, MultiInputsForm> formValuesInicioTur = {
      'dish' : MultiInputsForm(contenido: '', obligatorio: true),
      'garrison' : MultiInputsForm(contenido: '', obligatorio: true),
      'dessert' : MultiInputsForm(contenido: '', obligatorio: false),
      'received_number' : MultiInputsForm(contenido: '', obligatorio: true),
      'menu_portal' : MultiInputsForm(contenido: '', obligatorio: true),
      'picture' :  MultiInputsForm(contenido: '', obligatorio: true,uploadFile: true),
    };

    //fecha se inserta manualmente
    final Map<String, MultiInputsForm> formValuesRegistroMan = {
      'employee_number' : MultiInputsForm(contenido: '', obligatorio: true), 
      'name' : MultiInputsForm(contenido: '', obligatorio: true),   
      'type_contract' : MultiInputsForm(contenido: '', obligatorio: true, select: true), 
    };

    final Map<String, MultiInputsForm> formValuesObservacion = {
      'descriptionFood': MultiInputsForm(contenido: '',obligatorio: true,select: false,enabled: true)
    };

    final Map<String, MultiInputsForm> formValuesDescRepor = {
      'dish': MultiInputsForm(contenido: '', obligatorio: false),
      'date_start_hour': MultiInputsForm(contenido: '', obligatorio: true, activeClock: false), 
      'date_final_hour': MultiInputsForm(contenido: '', obligatorio: true, activeClock: false), 
    };
    final TextEditingController controller = TextEditingController();

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
                      child: Text('Control de empleados',style: getTextStyleTitle(context,null)),          
                      )
                    ),
                    SizedBox(height: responsiveHeight),
                    ButtonForm(
                        controller: controller,
                        control: 2,
                        textButton: 'Inicio turno',
                        btnPosition: 1,
                        field: const [
                          'Iniciar Turno',
                          'Iniciar',
                          'Platillo',
                          'Guarnición',
                          'Postre',
                          'Número de platillos recibidos',
                          'Menu de Hoy (Portal de Comunicación)',
                          'Subir imagen'
                        ],
                        formValue: formValuesInicioTur,
                        enabled: true),
                    SizedBox(height: responsiveHeight),
                    const ButtonScreen(
                        textButton: 'Escaner QR', 
                        btnPosition: 1
                      ),
                    SizedBox(height: responsiveHeight),
                    ButtonForm(
                        controller: controller,
                        control: 2,
                        textButton: 'Registro Manual',
                        btnPosition: 2,
                        field: const [
                          'Registro Manual',
                          'Registrar',
                          'Número de empleado',
                          'Nombre',
                          'Tipo de contrato'
                        ],
                        listSelect: const [['Proveedor','Externo','Empleado']],
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
                                            FoodService fs = FoodService();
                                              var salirInt =  await fs.postCloseTurnFood(context);
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
                          child: Text('Cerrar turno',style: getTextStyleButtonField(context)),
                        )),
                    ),
                    SizedBox(height: responsiveHeight),
                    ButtonForm(
                        controller: controller,
                        control: 2,
                        textButton: 'Agregar observaciones',
                        btnPosition: 3,
                        field: const ['Enviar','Enviar', 'Agregue una descripción...'],
                        formValue: formValuesObservacion,
                        enabled: false),
                    SizedBox(height: responsiveHeight),
                    ButtonForm(
                        controller: controller,
                        control: 2,
                        textButton: 'Descargar reporte',
                        btnPosition: 4,
                        field: const [
                          'Descargar reporte',
                          'Descargar',
                          'Busca un postre,platillo o guarnición',
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
        const SizedBox(child: Navbar(contexto2: 'control_food',))
      ],
    ));
  }

  @override
  initState() { 
    super.initState();
    SystemChannels.textInput.invokeMethod('TextInput.hide');

   VarProvider vh = VarProvider()
  ..arrSharedPreferences().then((Map<String, dynamic> sharedPrefsData) {
    if (sharedPrefsData['dish'] == null) {
      SessionManager sm = SessionManager()
        ..clearSession().then((value) {
          if (sharedPrefsData['turn'] == null) {
            final url = Uri.parse('https://www.comunicadosaraiza.com/movil_scan_api_prueba/API/turn_assistance.php?idTurn=true');
            (http.post(url, body: json.encode({'idTurn': sharedPrefsData["idTurn"] }))).then((value) {
            print(value);
            Provider.of<VarProvider>(context,listen: false).updateVariable(false);
            setState(() { });
          });
          }else{
           final url = Uri.parse('https://www.comunicadosaraiza.com/movil_scan_api_prueba/API/turn_vehicle.php?idTurn=true');
           (http.post(url, body: json.encode({'idTurn': sharedPrefsData["idTurn"] }))).then((value) {
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
}
