import 'package:flutter/material.dart';
import 'package:app_seguimiento_movil/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../services/services.dart';


class DiningRoom extends StatefulWidget {
  const DiningRoom({Key? key}) : super(key: key);

  @override
  State<DiningRoom> createState() => _DiningRoomState();
}

class _DiningRoomState extends State<DiningRoom> {
 @override
  Widget build(BuildContext context) {
    
    //Nombre del campo :  contenido, ¿obligatorio?, ¿select?, ¿enabled?
     
    //Fecha se inserta automaticamente
    final Map<String, List<Object?>> formValuesInicioTur = {
      'plate':['',true,false, true,true],
      'garrison':['',true,false, true,true],
      'dessert':['',false,false, true,true],
      'received_number':['',true,false, true,true]
    };

    //fecha se inserta manualmente
    final Map<String, List<Object?>> formValuesRegistroMan = {
      'employee_number':['',true,false, true,true],
      'name': ['',true,false, true,true],
      'type_contract': ['',true,true, true,true],
    };

    final Map<String, List<Object?>> formValuesObservacion = {
      'description': ['',true,false, true,true],
    };

    final Map<String, List<Object?>> formValuesDescRepor = {
      'guard': ['',false,false, true],
      'date_start_hour': ['',true,false, true,true],
      'date_final_hour': ['',true,false, true,true],
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
                        control: 2,
                        textButton: 'Inicio turno',
                        btnPosition: 1,
                        field: const [
                          'Iniciar Turno',
                          'Platillo',
                          'Guarnición',
                          'Postre',
                          'Número de platillos recibidos'
                        ],
                        formValues: formValuesInicioTur,
                        enabled: true),
                    const ButtonScreen(
                        textButton: 'Escaner QR', 
                        btnPosition: 1
                      ),
                    ButtonForm(
                        control: 2,
                        textButton: 'Registro Manual',
                        btnPosition: 2,
                        field: const [
                          'Registro Manual',
                          'Número de empleado',
                          'Nombre',
                          'Tipo de contrato'
                        ],
                        listSelect: const [['Sindicalizado','No sindicalizado','Corporativo']],
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
                                    title: Text('Cerrar Turno',style: MediaQuery.of(context).size.height < 960 && MediaQuery.of(context).size.width <600  ?
                                    //para celulares
                                    TextStyle(fontSize: MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .03: 0.015)):
                                    //para tablets
                                    TextStyle(fontSize: MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .02: 0.015),),),
                                    content: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children:[
                                        ElevatedButton(onPressed: () async {
                                          Provider.of<VarProvider>(context,listen: false).updateVariable(false);
                                          DepartamentService dpser = DepartamentService();
                                          await dpser.postCloseTurnFood();
                                          setState(() {
                                            Navigator.of(context).pop(context);
                                            Navigator.of(context).pushNamed('home');
                                          });
                                        }, child: Text('Aceptar',style: MediaQuery.of(context).size.height < 960 && MediaQuery.of(context).size.width <600  ?
                                          //para celulares
                                          TextStyle(fontSize: MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .03: 0.015)):
                                          //para tablets
                                          TextStyle(fontSize: MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .02: 0.015),)
                                          ,)),
                                        ElevatedButton(onPressed:(){
                                          Navigator.of(context).pop(context);
                                        },child: Text('Cancelar', style: MediaQuery.of(context).size.height < 960 && MediaQuery.of(context).size.width <600  ?
                                        //para celulares
                                        TextStyle(fontSize: MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .03: 0.015)):
                                        //para tablets
                                        TextStyle(fontSize: MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .02: 0.015),),
                                        ))
                                      ]
                                    ),
                                  ),
                                )
                              ],
                            );
                          }
                          );
                        }:null,
                        child: Text('Cerrar turno',style: MediaQuery.of(context).size.height < 960 && MediaQuery.of(context).size.width <600  ?
                        //para celulares
                        TextStyle(fontSize: MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .03: 0.015)):
                        //para tablets
                        TextStyle(fontSize: MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .02: 0.015),),)),
                    ),
                    ButtonForm(
                        control: 2,
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
   VarProvider vh = VarProvider()
  ..arrSharedPreferences().then((Map<String, dynamic> sharedPrefsData) {
    if (sharedPrefsData['plate'] == null) {
      SessionManager sm = SessionManager()
        ..clearSession().then((value) {
          DepartamentService dpser = DepartamentService()
            ..postCloseTurnVehicle().then((value) {
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
