import 'package:app_seguimiento_movil/services/services.dart';
import 'package:flutter/material.dart';
import 'package:app_seguimiento_movil/widgets/widgets.dart';
import 'package:provider/provider.dart';

class ControlVehiculos extends StatefulWidget {
  const ControlVehiculos({Key? key}) : super(key: key);
  
  @override
  State<ControlVehiculos> createState() => _ControlVehiculosState();
}

class _ControlVehiculosState extends State<ControlVehiculos> {
  @override
  Widget build(BuildContext context) {
    
    //Fecha se inserta automaticamente
    final Map<String, List<Object?>> formValuesInicioTur = {
      'name': ['','1',false],
      'turn': ['','1',true],
      'sign': ['','1',false],
    };

    //fecha se inserta manualmente
    final Map<String, List<Object?>> formValuesRegistroMan = {
      'placas':['','1',false],
      'tipo_vehiculo': ['','1',false],
      'color': ['','1',false],
      'nombre': ['','1',false],
      'departamento': ['','0',false]
    };

    final Map<String, List<Object?>> formValuesObservacion = {
      'descripcion': ['','1',false],
    };

    final Map<String, List<Object?>> formValuesDescRepor = {
      'guardia': ['','0',false],
      'date_inicial_y_hora': ['','1',false],
      'date_final_y_hora': ['','1',false],
    };

    final Map<String, List<Object?>> formValuesBuscarVh = {
      'placas': ['','1',false],
      'tipo_vehiculo': ['','1',false],
      'color': ['','1',false],
      'nombre': ['','1',false],
      'entrada': ['','1',false],
      'salida': ['','1',false]
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
                        textButton: 'Inicio turno',
                        btnPosition: 1,
                        field: const [
                          'Iniciar Turno',
                          'Turno',
                          'Firma',
                          'Nombre del guardia'
                        ],
                        formValues: formValuesInicioTur,
                        listSelect: const ['Primer Turno', 'Segundo Turno', 'Tercer turno'],
                        enabled: true),
                    const ButtonScreen(
                        textButton: 'Escaner QR', 
                        btnPosition: 1
                      ),
                    ButtonForm(
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
                                        ElevatedButton(onPressed: (){
                                          Provider.of<VarProvider>(context,listen: false).updateVariable(false);
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
                        textButton: 'Agregar observaciones',
                        btnPosition: 3,
                        field: const ['Observaciones', 'Agregue una descripción...'],
                        formValues: formValuesObservacion,
                        enabled: false),
                    ButtonForm(
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
        const SizedBox(child: Navbar(contexto2: 'control_vehiculos',))
      ],
    ));
  }
}

class ButtonScreen extends StatelessWidget {
  final String textButton;
  final int btnPosition;

  const ButtonScreen({
    super.key,
    required this.textButton,
    required this.btnPosition,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: Provider.of<VarProvider>(context).myGlobalVariable
            ? () {
                if (btnPosition == 1) {
                Navigator.of(context).pushNamed('scanner_qr');
                }
              }
            : null,
        child: Text(textButton),
      ),
    );
  }
}
