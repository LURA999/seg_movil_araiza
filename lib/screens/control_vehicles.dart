import 'package:app_seguimiento_movil/models/models.dart';
import 'package:app_seguimiento_movil/services/services.dart';
import 'package:flutter/material.dart';
import 'package:app_seguimiento_movil/widgets/widgets.dart';
import 'package:provider/provider.dart';

class ControlVehicles extends StatefulWidget {
  const ControlVehicles({Key? key}) : super(key: key);
  
  @override
  State<ControlVehicles> createState() => _ControlVehiclesState();
}

class _ControlVehiclesState extends State<ControlVehicles> {
  @override
  Widget build(BuildContext context) {
    
    //Nombre del campo :  contenido, ¿obligatorio?, ¿!select?, ¿!enabled?
     
    //Fecha se inserta automaticamente
    final Map<String, List<Object?>> formValuesInicioTur = {
      'name': ['',true,false, true,true],
      'turn': ['',true,true, true,true],
      'sign': ['',true,false, true,true],
    };

    //fecha se inserta manualmente
    final Map<String, List<Object?>> formValuesRegistroMan = {
      'plates':['',true,false, true,true],
      'typevh': ['',true,false, true,true],
      'color': ['',true,false, true,true],
      'employeeName': ['',true,false, true,true],
      'departament': ['',false,false, true,true]
    };

    final Map<String, List<Object?>> formValuesObservacion = {
      'description': ['',true,false, true,true],
    };

    final Map<String, List<Object?>> formValuesDescRepor = {
      'guard': ['',false,false, true,true],
      'date_start_hour': ['',true,false, true,true],
      'date_final_hour': ['',true,false, true,true],
    };

    final Map<String, List<Object?>> formValuesBuscarVh = {
      'placas': ['',true,false, true,true],
      'tipo_vehiculo': ['',false, false,false],
      'color': ['',false, false,false],
      'nombre': ['',false, false,false],
      'entrada': ['',false, false,false],
      'salida': ['',false, false,false]
    };

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
                  padding: const EdgeInsets.all(20),
                  child: Column(children: [
                    ButtonForm(
                        control: 1,
                        textButton: 'Inicio turno',
                        btnPosition: 1,
                        field: const [
                          'Iniciar Turno',
                          'Nombre del guardia',
                          'Turno',
                          'Firma'
                        ],
                        formValues: formValuesInicioTur,
                        listSelect: const [['Primer Turno', 'Segundo Turno', 'Tercer turno'],[]],
                        enabled: true),
                    const ButtonScreen(
                        textButton: 'Escaner QR', 
                        btnPosition: 1
                      ),
                    ButtonForm(
                        control: 1,
                        textButton: 'Registro Manual',
                        btnPosition: 2,
                        field: const [
                          'Registro Manual',
                          'placas',
                          'Tipo de vehículo',
                          'Color',
                          'Nombre',
                          'Departamento'
                        ],
                        formValues: formValuesRegistroMan,
                        enabled: false),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: (Provider.of<VarProvider>(context).myGlobalVariable || false) ? () {
                          showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return  Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SingleChildScrollView(
                                  child: AlertDialog(
                                    title: const Text('Cerrar Turno'),
                                    content: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children:[
                                        ElevatedButton(onPressed: () async {
                                          Provider.of<VarProvider>(context,listen: false).updateVariable(false);
                                          DepartamentService dpser = DepartamentService();
                                          await dpser.postCloseTurnVehicle();
                                          Navigator.of(context).pop(context);
                                          Navigator.of(context).pushNamed('home');
                                        }, child: const Text('Aceptar')),
                                        ElevatedButton(onPressed:(){
                                          Navigator.of(context).pop(context);
                                        },child: const Text('Cancelar'))
                                      ]
                                    ),
                                  ),
                                )
                              ],
                            );
                          }
                          );
                        }:null,
                        child: const Text('Cerrar turno')),
                    ),
                    ButtonForm(
                        control: 1,
                        textButton: 'Agregar observaciones',
                        btnPosition: 3,
                        field: const ['Enviar', 'Agregue una descripción...'],
                        formValues: formValuesObservacion,
                        enabled: false),
                    ButtonForm(
                        control: 0,
                        textButton: 'Descargar reporte',
                        btnPosition: 4,
                        field: const [
                          'Descargar reporte',
                          'Guardia',
                          'Fecha inicial y hora',
                          'Fecha final y hora'
                        ],
                        formValues: formValuesDescRepor,
                        enabled: true),
                    ButtonForm(
                      control: 1,
                      textButton: 'Buscar vehículo',
                      btnPosition: 5,
                      field: const [
                        'Buscar vehículo',
                        'Placas',
                        'Tipo de vehículo',
                        'Color',
                        'Nombre',
                        'Entrada',
                        'Salida'
                      ],
                      formValues: formValuesBuscarVh,
                      enabled: true,
                    ),
                  ]),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(child: Navbar(contexto2: 'control_vehicles',))
      ],
    ));
  }
  
  @override
  initState() { 
    super.initState();
   VarProvider vh = VarProvider()
  ..arrSharedPreferences().then((Map<String, dynamic> sharedPrefsData) {
    if (sharedPrefsData['turn'] == null) {
      SessionManager sm = SessionManager()
        ..clearSession().then((value) {
          DepartamentService dpser = DepartamentService()
            ..postCloseTurnFood().then((value) {
              //cerrar turno anterior
              Provider.of<VarProvider>(context,listen: false).updateVariable(false);
            });
        });
    }
  }).catchError((error) {
    //
  });
  }
}
