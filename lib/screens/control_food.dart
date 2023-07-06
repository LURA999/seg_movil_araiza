import 'package:flutter/material.dart';
import 'package:app_seguimiento_movil/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../models/multi_inputs_model.dart';
import '../services/letter_mediaquery.dart';
import '../services/services.dart';


class DiningRoom extends StatefulWidget {
  const DiningRoom({Key? key}) : super(key: key);

  @override
  State<DiningRoom> createState() => _DiningRoomState();
}


class _DiningRoomState extends State<DiningRoom> {
 @override
  Widget build(BuildContext context) {
    
    bool salir = false;
    //Nombre del campo :  contenido, ¿obligatorio?, ¿select?, ¿enabled?
    
    //Fecha se inserta automaticamente
    final Map<String, MultiInputsForm> formValuesInicioTur = {
      'plate' : MultiInputsForm(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),// 'plate':['',true,false, true],
      'garrison' : MultiInputsForm(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),// 'garrison':['',true,false, true],
      'dessert' : MultiInputsForm(contenido: '', obligatorio: false, select: false, enabled: true, paintSignature: false,uploadFile: false),// 'dessert':['',false,false, true],
      'received_number' : MultiInputsForm(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),// 'received_number':['',true,false, true]
      'picture' :  MultiInputsForm(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: true),
    };

    //fecha se inserta manualmente
    final Map<String, MultiInputsForm> formValuesRegistroMan = {
      'employee_number' : MultiInputsForm(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),   // 'employee_number':['',true,false, true],
      'name' : MultiInputsForm(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),   // 'name': ['',true,false, true],
      'type_contract' : MultiInputsForm(contenido: '', obligatorio: true, select: true, enabled: true, paintSignature: false,uploadFile: false),   // 'type_contract': ['',true,true, true],
    };

    final Map<String, MultiInputsForm> formValuesObservacion = {
      'description': MultiInputsForm(contenido: '',obligatorio: true,select: false,enabled: true, paintSignature: false,uploadFile: false)// ['',true,false, true],
    };

    final Map<String, MultiInputsForm> formValuesDescRepor = {
      'guard': MultiInputsForm(contenido: '', obligatorio: false, select: false, enabled: true, paintSignature: false,uploadFile: false),  // ['',false,false, true],
      'date_start_hour': MultiInputsForm(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false), // ['',true,false, true],
      'date_final_hour': MultiInputsForm(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false), // ['',true,false, true],
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
                        controller: controller,
                        control: 2,
                        textButton: 'Inicio turno',
                        btnPosition: 1,
                        field: const [
                          'Iniciar Turno',
                          'Platillo',
                          'Guarnición',
                          'Postre',
                          'Número de platillos recibidos',
                          'Subir imagen'
                        ],
                        formValue: formValuesInicioTur,
                        enabled: true),
                    const ButtonScreen(
                        textButton: 'Escaner QR', 
                        btnPosition: 1
                      ),
                    ButtonForm(
                        controller: controller,
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
                        formValue: formValuesRegistroMan,
                        enabled: false),
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
                                      title: Text('Cerrar Turno',style:  MediaQuery.of(context).size.height < 960 && MediaQuery.of(context).size.width <600  ?
                                      //para celulares
                                      TextStyle(fontSize: MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.015),fontWeight: FontWeight.bold):
                                      //para tablets
                                      TextStyle(fontSize: MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .02: 0.015),fontWeight: FontWeight.bold,)),
                                      content: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children:[
                                          ElevatedButton(onPressed: (Provider.of<VarProvider>(context).varSalir) == false ? () async {
                                            Provider.of<VarProvider>(context,listen: false).updateVarSalir(true);
                                            Provider.of<VarProvider>(context,listen: false).updateVariable(false);
                                            DepartamentService dpser = DepartamentService();
                                              await dpser.postCloseTurnFood();
                                              setState(() {
                                                Navigator.of(context).pop(context);
                                                Navigator.of(context).pushNamed('home');
                                              });
                                            }: null, child: Text('Aceptar',style: getTextStyleButtonField(context))
                                          ),
                                          ElevatedButton(onPressed: (Provider.of<VarProvider>(context).varSalir) == false ? (){
                                            Navigator.of(context).pop(context);

                                          }: null,child: Text('Cancelar', style: getTextStyleButtonField(context)),
                                          )
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
                        child: Text('Cerrar turno',style: getTextStyleButtonField(context))),
                    ),
                    ButtonForm(
                        controller: controller,
                        control: 2,
                        textButton: 'Agregar observaciones',
                        btnPosition: 3,
                        field: const ['Enviar', 'Agregue una descripción...'],
                        formValue: formValuesObservacion,
                        enabled: false),
                    ButtonForm(
                        controller: controller,
                        control: 0,
                        textButton: 'Descargar reporte',
                        btnPosition: 4,
                        field: const [
                          'Descargar reporte',
                          'Guardia',
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
