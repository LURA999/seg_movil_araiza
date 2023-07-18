import 'package:app_seguimiento_movil/models/models.dart';
import 'package:app_seguimiento_movil/services/services.dart';
import 'package:flutter/material.dart';
import 'package:app_seguimiento_movil/widgets/widgets.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../services/letter_mediaquery.dart';



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
    final Map<String, MultiInputsForm> formValuesInicioTur = {
      'name': MultiInputsForm(contenido: '', obligatorio: true,autocomplete: true, autocompleteAsync: true),
      'turn': MultiInputsForm(contenido: '', obligatorio: true, select: true),
      'sign': MultiInputsForm(contenido: '', obligatorio: true, paintSignature: true),
    };
    
    //fecha se inserta manualmente
    final Map<String, MultiInputsForm> formValuesRegistroMan = {
      'plates' : MultiInputsForm(contenido: '', obligatorio: true),
      'typevh' : MultiInputsForm(contenido: '', obligatorio: true),
      'color' : MultiInputsForm(contenido: '', obligatorio: true),
      'employeeName' : MultiInputsForm(contenido: '', obligatorio: true),
      'departament' : MultiInputsForm(contenido: '',obligatorio: true),
    };

    final Map<String, MultiInputsForm> formValuesObservacion = {
      'description' : MultiInputsForm(contenido: '', obligatorio: true)
    };

    final Map<String, MultiInputsForm> formValuesDescRepor = {
      'guard' : MultiInputsForm(contenido: '',obligatorio: true,autocomplete: true,autocompleteAsync: false),
      'turn': MultiInputsForm(contenido: '', obligatorio: true, select: true),
      'date_start_hour' : MultiInputsForm(contenido: '', obligatorio: true),
      'date_final_hour' : MultiInputsForm(contenido: '', obligatorio: true),
    };

    final Map<String, MultiInputsForm> formValuesBuscarVh = {
      'placas' :MultiInputsForm(contenido: '', obligatorio: true,suffixIcon: Icons.search_outlined),
      'tipo_vehiculo' :MultiInputsForm(contenido: '', enabled: false),
      'color' :MultiInputsForm(contenido: '', enabled: false),
      'nombre' :MultiInputsForm(contenido: '', enabled: false),
      'entrada' :MultiInputsForm(contenido: '', enabled: false),
      'salida' :MultiInputsForm(contenido: '', enabled: false),
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
                        formValue: formValuesInicioTur,
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
                        formValue: formValuesRegistroMan,
                        enabled: false),
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
                                    title: Text('Cerrar Turno',style: MediaQuery.of(context).size.height < 960 && MediaQuery.of(context).size.width <600  ?
                                    //para celulares
                                    TextStyle(fontSize: MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.015),fontWeight: FontWeight.bold):
                                    //para tablets
                                    TextStyle(fontSize: MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .02: 0.015),fontWeight: FontWeight.bold,)
                                    ),
                                    content: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children:[
                                        ElevatedButton(onPressed: (Provider.of<VarProvider>(context).varSalir) == false ?() async {
                                          DepartamentService dpser = DepartamentService();
                                          var salirInt = (await dpser.postCloseTurnVehicle(context));
                                          if (salirInt) {
                                            Provider.of<VarProvider>(context,listen: false).updateVariable(false);
                                            Provider.of<VarProvider>(context,listen: false).updateVarSalir(true);
                                            Navigator.of(context).pop(context);
                                            Navigator.of(context).pushNamed('home');
                                            Provider.of<VarProvider>(context,listen: false).updateVarSalir(false);
                                          }
                                        }: null, child: Text('Aceptar', style: getTextStyleButtonField(context)
                                        )),
                                        ElevatedButton(onPressed:(Provider.of<VarProvider>(context).varSalir) == false ?(){
                                          Navigator.of(context).pop(context);
                                        }: null,child: Text('Cancelar', style: getTextStyleButtonField(context)
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
                        child:  Text('Cerrar turno',style: getTextStyleButtonField(context)
                        )
                      ),
                    ),
                    ButtonForm(
                        control: 1,
                        textButton: 'Agregar observaciones',
                        btnPosition: 3,
                        controller: controller,
                        field: const ['Enviar', 'Agregue una descripción...'],
                        formValue: formValuesObservacion,
                        enabled: false),
                    ButtonForm(
                        control: 1,
                        controller: controller,
                        textButton: 'Descargar reporte',
                        btnPosition: 4,
                        field: const [
                          'Descargar reporte',
                          'Guardia',
                          'Turno',
                          'Fecha inicial y hora',
                          'Fecha final y hora'
                        ],
                        listSelect: const [['Primer Turno', 'Segundo Turno', 'Tercer turno', 'Todos los turnos'],[]],
                        formValue: formValuesDescRepor,
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
                      formValue: formValuesBuscarVh,
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
    SystemChannels.textInput.invokeMethod('TextInput.hide');

   VarProvider vh = VarProvider()
  ..arrSharedPreferences().then((Map<String, dynamic> sharedPrefsData) {
    if (sharedPrefsData['turn'] == null) {
      SessionManager sm = SessionManager()
        ..clearSession().then((value) {
          DepartamentService dpser = DepartamentService()
            ..postCloseTurnFood(context).then((value) {
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
