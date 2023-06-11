import 'package:app_seguimiento_movil/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RhControl extends StatelessWidget {
  const RhControl({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> opciones = [
      {
        'title': 'Comedor de Empleados',
        'description': 'Registro de número de platillos y comensales.',
        'img': 'assets/images/main/comedor_logo.svg',
      },
      {
        'title': 'Asistencia de cursos',
        'description': 'Registro de colaboradores participantes.',
        'img': 'assets/images/main/asistencia_comedor_logo.svg',
      }
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
      backgroundColor: const Color.fromRGBO(246, 247, 252, 2),
      body: Container(
        padding: EdgeInsets.fromLTRB(
            MediaQuery.of(context).size.width * .05,
            MediaQuery.of(context).size.height * .05,
            MediaQuery.of(context).size.width * .05,
            MediaQuery.of(context).size.height * 0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * .02),
              child: Align(
                alignment: Alignment.topLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /**  probado en celulares
                     * .08: 0.04
                     * .04: 0.02
                     */
                  Text('Recursos Humanos',style: myTextStyleTitle.copyWith(fontSize: MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .030: 0.025) )),
                  Text('Selecciona una opcion',style: myTextStyleSubtitule.copyWith(fontSize: MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .025: 0.020) )),
                  ]
                ),
              ),
            ),
            TableCustom(opciones: opciones),
             const SizedBox(child: Navbar(contexto2: 'control_rh'))
          ],
        ),
      ),
    );
  }
}

class TableCustom extends StatefulWidget {
  const TableCustom({
    super.key,
    required this.opciones,
  });

  final List<Map<String, dynamic>> opciones;

  @override
  State<TableCustom> createState() => _TableCustomState();
}

class _TableCustomState extends State<TableCustom> {
  TextStyle myTextStyleTitle = const TextStyle(
    color: Color(0xFF293641),
    fontFamily: 'Inter',
    fontWeight: FontWeight.w600,
  );

  TextStyle myTextStyleDescription = const TextStyle(
    color: Color(0xFF293641),
    fontFamily: 'Inter',
    fontWeight: FontWeight.normal,
  );

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            TableRow(children: [
              Container(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * .02),
                child: Ink(
                  height: 100,
                  decoration: BoxDecoration(
                      color: Colors.white, // Color de fondo del Ink
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.282),
                          spreadRadius: 0.5,
                          blurRadius: 1,
                          offset: Offset(0, 1),
                        ),
                      ]),
                  child: InkWell(
                    
                      onTap: () {
                        setState(() {
                          Navigator.of(context).pushNamed('control_food');
                        });
                      },
                      child: Row(children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(
                              'assets/images/main/asistencia_comedor_logo.svg',
                              width: MediaQuery.of(context).size.width * 0.3
                            ),
                          )),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? 0.5 : 0.65),                            
                          child: 
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.opciones[0]['title'],
                              softWrap: true,style: myTextStyleTitle.copyWith(fontSize: MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .030: 0.025) )),
                              Text(widget.opciones[0]['description'],
                              softWrap: true,style: myTextStyleDescription.copyWith(fontSize: MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .025: 0.020) ))
                            ],
                          )),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.1,
                          child: SvgPicture.asset(
                          'assets/images/main/arrow_rh.svg',
                          ),
                        )
                      ])),
                ),
              )
            ]),
            TableRow(children: [
              Container(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * .02),
                child: Ink(
                  height: 100,
                  decoration: BoxDecoration(
                      color: Colors.white, // Color de fondo del Ink
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.282),
                          spreadRadius: 0.5,
                          blurRadius: 1,
                          offset: Offset(0, 1),
                        ),
                      ]),
                  child: InkWell(
                      onTap:null,
                      child: Row(
                        children: [
                          Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SvgPicture.asset(
                                  'assets/images/main/comedor_logo.svg',
                                  width: MediaQuery.of(context).size.width * 0.3
                                ),
                              )),
                          SizedBox(
                          width: MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? 0.5 : 0.65),                            
                          child: 
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.opciones[1]['title'],
                              softWrap: true,style: myTextStyleTitle.copyWith(fontSize: MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .035: 0.015) )),
                              Text(widget.opciones[1]['description'],
                              softWrap: true,style: myTextStyleDescription.copyWith(fontSize: MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .03: 0.015) ))
                            ],
                          )),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.1,
                            child: SvgPicture.asset(
                              'assets/images/main/arrow_rh.svg',
                            ),
                          )
                        ],
                      )),
                ),
              )
            ])
          ]),
    );
  }
}
