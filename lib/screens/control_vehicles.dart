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
  
  double keyboardHeightRatio = 0.0;

  
  @override
  Widget build(BuildContext context) {
    
    //Nombre del campo :  contenido, ¿obligatorio?, ¿!select?, ¿!enabled?
     
    //Fecha se inserta automaticamente
    final Map<String, MultiInputs> MultiInputssInicioTur = {
      'name': MultiInputs(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false)/* ['',true,false, true] */,
      'turn': MultiInputs(contenido: '', obligatorio: true, select: true, enabled: true, paintSignature: false,uploadFile: false)/* ['',true,false, true] */,
      'sign': MultiInputs(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: true,uploadFile: false)/* ['',true,false, true] */,
    };


    //fecha se inserta manualmente
    final Map<String, MultiInputs> MultiInputssRegistroMan = {
      'plates' : MultiInputs(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),// 'plates':['',true,false, true],
      'typevh' : MultiInputs(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),// 'typevh': ['',true,false, true],
      'color' : MultiInputs(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),// 'color': ['',true,false, true],
      'employeeName' : MultiInputs(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),// 'employeeName': ['',true,false, true],
      'departament' : MultiInputs(contenido: '', obligatorio: false, select: false, enabled: true, paintSignature: false,uploadFile: false),// 'departament': ['',false,false, true]
    };

    final Map<String, MultiInputs> MultiInputssObservacion = {
      'descripcion' : MultiInputs(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false)// 'description': ['',true,false, true],
    };

    final Map<String, MultiInputs> MultiInputssDescRepor = {
      'guard' : MultiInputs(contenido: '', obligatorio: false, select: false, enabled: true, paintSignature: false,uploadFile: false),// 'guard': ['',false,false, true],
      'date_start_hour' : MultiInputs(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),// 'date_start_hour': ['',true,false, true],
      'date_final_hour' : MultiInputs(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),// 'date_final_hour': ['',true,false, true],
    };

    final Map<String, MultiInputs> MultiInputssBuscarVh = {
      'placas' :MultiInputs(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),// 'placas': ['',true,false, true],
      'tipo_vehiculo' :MultiInputs(contenido: '', obligatorio: false, select: false, enabled: true, paintSignature: false,uploadFile: false),// 'tipo_vehiculo': ['',false, false,false],
      'color' :MultiInputs(contenido: '', obligatorio: false, select: false, enabled: true, paintSignature: false,uploadFile: false),// 'color': ['',false, false,false],
      'nombre' :MultiInputs(contenido: '', obligatorio: false, select: false, enabled: true, paintSignature: false,uploadFile: false),// 'nombre': ['',false, false,false],
      'entrada' :MultiInputs(contenido: '', obligatorio: false, select: false, enabled: true, paintSignature: false,uploadFile: false),// 'entrada': ['',false, false,false],
      'salida' :MultiInputs(contenido: '', obligatorio: false, select: false, enabled: true, paintSignature: false,uploadFile: false),// 'salida': ['',false, false,false]
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
                  padding: const EdgeInsets.all(20),
                  child: Column(children: [
                    ButtonForm(
                        control: 1,
                        textButton: 'Inicio turno',
                        btnPosition: 1,
                        controller: controller,
                        field: const [
                          'Iniciar Turno',
                          'Nombre del guardia',
                          'Turno',
                          'Firma'
                        ],
                        MultiInputss: MultiInputssInicioTur,
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
                        controller: controller,
                        field: const [
                          'Registro Manual',
                          'placas',
                          'Tipo de vehículo',
                          'Color',
                          'Nombre',
                          'Departamento'
                        ],
                        MultiInputss: MultiInputssRegistroMan,
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
                                    TextStyle(fontSize: MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .02: 0.015),),
                                    ),
                                    content: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children:[
                                        ElevatedButton(onPressed: () async {
                                          Provider.of<VarProvider>(context,listen: false).updateVariable(false);
                                          DepartamentService dpser = DepartamentService();
                                          await dpser.postCloseTurnVehicle();
                                          Navigator.of(context).pop(context);
                                          Navigator.of(context).pushNamed('home');
                                        }, child: Text('Aceptar', style: MediaQuery.of(context).size.height < 960 && MediaQuery.of(context).size.width <600  ?
                                        //para celulares
                                        TextStyle(fontSize: MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .03: 0.015)):
                                        //para tablets
                                        TextStyle(fontSize: MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .02: 0.015),),
                                        )),
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
                        child:  Text('Cerrar turno',style: MediaQuery.of(context).size.height < 960 && MediaQuery.of(context).size.width <600  ?
                        //para celulares
                        TextStyle(fontSize: MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .03: 0.015)):
                        //para tablets
                        TextStyle(fontSize: MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .02: 0.015),),)),
                    ),
                    ButtonForm(
                        control: 1,
                        textButton: 'Agregar observaciones',
                        btnPosition: 3,
                        controller: controller,
                        field: const ['Enviar', 'Agregue una descripción...'],
                        MultiInputss: MultiInputssObservacion,
                        enabled: false),
                    ButtonForm(
                        control: 0,
                        controller: controller,
                        textButton: 'Descargar reporte',
                        btnPosition: 4,
                        field: const [
                          'Descargar reporte',
                          'Guardia',
                          'Fecha inicial y hora',
                          'Fecha final y hora'
                        ],
                        MultiInputss: MultiInputssDescRepor,
                        enabled: true),
                    ButtonForm(
                      control: 1,
                      controller: controller,
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
                      MultiInputss: MultiInputssBuscarVh,
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
