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

    TextStyle myTextStyleTitle = const TextStyle(
      color: Color(0xFF293641),
      fontFamily: 'Inter',
      fontWeight: FontWeight.w900,
    );
    
    TextStyle myTextStyleSubtitule = const TextStyle(
      color: Color(0xFF293641),
      fontFamily: 'Inter',
      fontWeight: FontWeight.normal,
    );

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
                Text('Recursos Humanos',style: myTextStyleTitle.copyWith(fontSize: MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .08: 0.04) )),
                Text('Selecciona una opción:',style: myTextStyleSubtitule.copyWith(fontSize: MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04 : 0.02) )),
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
