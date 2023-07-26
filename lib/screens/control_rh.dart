import 'package:app_seguimiento_movil/services/services.dart';
import 'package:app_seguimiento_movil/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:app_seguimiento_movil/models/models.dart';


class RhControl extends StatelessWidget {
  const RhControl({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Option> opciones = [
      Option(
        title: 'Comedor de Empleados',
        description: 'Registro de número de platillos y comensales.',
        img: 'assets/images/main/comedor_logo.svg',
        width : 0.3,
        navigator: () {
          Navigator.of(context).pushNamed('control_food');
        }
      ),
       Option(
        title: 'Asistencia de cursos',
        description: 'Registro de colaboradores participantes.',
        img: 'assets/images/main/asistencia_comedor_logo.svg',
        width :  0.1,
        navigator: null
       )
    ];


    return Scaffold(
      resizeToAvoidBottomInset:false,
      backgroundColor: const Color.fromRGBO(246, 247, 252, 2),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(
            MediaQuery.of(context).size.width * .05,
            MediaQuery.of(context).size.height * .05,
            MediaQuery.of(context).size.width * .05,
            MediaQuery.of(context).size.height * .02),
            child: Align(
              alignment: Alignment.topLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text('Recursos Humanos',style: getTextStyleTitle(context, null)),
                Text('Selecciona una opción:',style: getTextStyleTitle2(context, null)),
                ]
              ),
            ),
          ),
        Expanded(
          child: Container(
            padding: EdgeInsets.fromLTRB(
            MediaQuery.of(context).size.width * .05,
            MediaQuery.of(context).size.height * .0,
            MediaQuery.of(context).size.width * .05,
            MediaQuery.of(context).size.height * .0),
            child:  TableCustom(opciones: opciones),
          ),
        ),
           const SizedBox(child: Navbar(contexto2: 'control_rh'))
        ],
      ),
    );
  }
}
