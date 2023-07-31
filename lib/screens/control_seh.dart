import 'package:app_seguimiento_movil/services/services.dart';
import 'package:app_seguimiento_movil/widgets/widgets.dart';
import 'package:flutter/material.dart';
import '../models/models.dart';

class SehControl extends StatelessWidget {
  const SehControl({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
   List<Option> opciones = [
      Option(
        title: 'Recorrido de áreas',
        description: 'Revisión de las instalaciones por el comité de Seguridad e Higiene.',
        img: 'assets/images/main/tour_of_areas.svg',
        width : 0.3,
        navigator: () {
          Navigator.of(context).pushNamed('routes_seh');
        }
      ),
       Option(
        title: 'Examen médico',
        description: 'Creación y consulta de expedientes de colaboradores.',
        img: 'assets/images/main/medical_exam.svg',
        width :  0.1,
        navigator:  () {
          Navigator.of(context).pushNamed('medical_records');
        }
       )
    ];


    return Scaffold(
      
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
                Text('Seguridad e Higiene',style: getTextStyleTitle(context, null) ),
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
          const SizedBox(child: Navbar(contexto2: 'control_seh'))
        ],
      ),
    );
  }
}

