import 'package:app_seguimiento_movil/theme/app_theme.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/models.dart';
import '../services/services.dart';
import '../widgets/widgets.dart';

class RoutesSeh extends StatefulWidget {
  const RoutesSeh({Key? key}) : super(key: key);

  @override
  State<RoutesSeh> createState() => _RoutesSehState();
}

class _RoutesSehState extends State<RoutesSeh> {
  final month = DateTime.now().month;

  TextStyle myTextStyleTitle = const TextStyle(
    color: Colors.white,
    fontFamily: 'GothamMedium',
    fontWeight: FontWeight.w700,
  );

  TextStyle myTextStyleDescription = const TextStyle(
    color: Colors.white,
    fontFamily: 'GothamBook',
    fontWeight: FontWeight.bold,
  );

  @override
  void initState() { 
    super.initState();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }
  @override
  Widget build(BuildContext context) {
     List<OptionRoute> opciones = [
      OptionRoute(
        title: '1er trimestre',
        description: 'enero - marzo',
        monthInitial: 1,
        monthFinal: 3,
        img: null,
        width : 0.3,
        navigator: [
            ()  {
              Navigator.of(context).pushNamed('tour_seh', arguments: {
                'periodo': 1,
                'recorrido' : 1,
                'form':1,
              });
            },   
            () {
                Navigator.of(context).pushNamed('tour_seh', arguments: {
                  'periodo': 1,
                  'recorrido' : 2,
                  'form':2,
                });
              
            },   
            () {
              Navigator.of(context).pushNamed('tour_seh', arguments: {
                'periodo': 1,
                'recorrido' : 3,
                'form':3,
              });
            },   
          ]
      ), 
      OptionRoute(
        title: '2do trimestre',
        description: 'abril - junio',
        monthInitial: 4,
        monthFinal: 6,
        img: null,
        width : 0.3,
        navigator:  [
            () {
              Navigator.of(context).pushNamed('tour_seh', arguments: {
                'periodo': 2,
                'recorrido' : 1,
                'form':4,
              });
            },
            () {
              Navigator.of(context).pushNamed('tour_seh', arguments: {
                'periodo': 2,
                'recorrido' : 2,
                'form':5,
              });
            },
            () {
              Navigator.of(context).pushNamed('tour_seh', arguments: {
                'periodo': 2,
                'recorrido' : 3,
                'form':6,
              });
            },
          ]
      ),
      OptionRoute(
        title: '3er trimestre',
        description: 'julio - septiembre',
        monthInitial: 7,
        monthFinal: 9,
        img: null,
        width : 0.3,
        navigator: [
            () {
              Navigator.of(context).pushNamed('tour_seh', arguments: {
                'periodo': 3,
                'recorrido' : 1,
                'form':7,
              });
            },
            () {
              Navigator.of(context).pushNamed('tour_seh', arguments: {
                'periodo': 3,
                'recorrido' : 2,
                'form':8,
              });
            },
            () {
              Navigator.of(context).pushNamed('tour_seh', arguments: {
                'periodo': 3,
                'recorrido' : 3,
                'form':9,
              });
            },
          ]
      ),
      OptionRoute(
        title: '4to trimestre',
        description: 'octubre - diciembre',
        monthInitial: 10,
        monthFinal: 12,
        img: null,
        width : 0.3,
        navigator: [
            () {
              Navigator.of(context).pushNamed('tour_seh', arguments: {
                'periodo': 4,
                'recorrido' : 1,
                'form':10,
              });
            },
            () {
              Navigator.of(context).pushNamed('tour_seh', arguments: {
                'periodo': 4,
                'recorrido' : 2,
                'form':11,
              });
            },
            () {
                Navigator.of(context).pushNamed('tour_seh', arguments: {
                'periodo': 4,
                'recorrido' : 3,
                'form':12,
              });
            
            },
          ]
      )
     ];
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: 
            SingleChildScrollView(
              child: Padding(
                padding: 
                MediaQuery.of(context).orientation == Orientation.portrait ? 
                EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * .05,
                    MediaQuery.of(context).size.height * .05,
                    MediaQuery.of(context).size.width * .05,
                    MediaQuery.of(context).size.height * .02)
                    :
                    EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * .05,
                    MediaQuery.of(context).size.height * .1,
                    MediaQuery.of(context).size.width * .05,
                    MediaQuery.of(context).size.height * .02),
                child: Column(
                  children: [
                    SizedBox(
                        child: Align(
                        alignment: Alignment.center,
                        child: Text('Recorrido de áreas',style: getTextStyleTitle(context,null)),          
                        )
                      ),
                    Container(
                       padding: EdgeInsets.fromLTRB(
                        MediaQuery.of(context).size.width * .0,
                        MediaQuery.of(context).size.height * .02,
                        MediaQuery.of(context).size.width * .0,
                        MediaQuery.of(context).size.height * .0),
                      child:  
                      Column(children: opciones.map((e) {
                         return Container(
                          padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * .02),
                          child: Ink(
                            height: MediaQuery.of(context).size.height < 960 && MediaQuery.of(context).size.width <500  ?
                              //para celulares
                              ( MediaQuery.of(context).size.height * (MediaQuery.of(context).orientation == Orientation.landscape ? .3 : .08))
                              :
                              //para tablets 
                              (MediaQuery.of(context).size.height * (MediaQuery.of(context).orientation == Orientation.landscape ? .15 : .1) ),

                            decoration: const BoxDecoration(
                              color: AppTheme.primary,
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.282),
                                  spreadRadius: 0.5,
                                  blurRadius: 1,
                                  offset: Offset(0, 1),
                                ),
                              ],
                            ),
                            child: InkWell(
                              onTap: () async {
                              var connectivityResult = await (Connectivity().checkConnectivity());  
                                if (connectivityResult == ConnectivityResult.none) {
                                  // No hay conexión a Internet
                                  messageError(context,'No hay conexión a Internet.');
                                } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
                                  if(e.monthInitial <= month && month <= e.monthFinal){
                                    selectedArea(context,e.navigator);
                                  }else{
                                     return showDialog(
                                      context: context, // Accede al contexto del widget actual
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title:  Text('Iniciar ${e.title}',style: getTextStyleText(context,FontWeight.bold,null),),
                                          content: Text('¿Estás seguro que deseas iniciar el trimestre aunque el mes actual no coincida?', style: getTextStyleText(context,null,null)),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context); // Cierra el diálogo
                                              },
                                              child:  Text('Cancelar', style: getTextStyleButtonField(context),),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context); 
                                                selectedArea(context,e.navigator); // Cierra el diálogo
                                              },
                                              child:  Text('Aceptar', style: getTextStyleButtonField(context),),
                                            ),
                                          ],
                                        );
                                      });
                                  }
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column( 
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                  Text(
                                    e.title,
                                    softWrap: true,
                                    style: myTextStyleTitle.copyWith(
                                      fontSize: MediaQuery.of(context).size.width *
                                          (MediaQuery.of(context).orientation ==
                                                  Orientation.portrait
                                              ? .035
                                              : 0.015),
                                    ),
                                  ),
                                  const SizedBox(height: 1),
                                  Text(
                                    e.description,
                                    softWrap: true,
                                    style: myTextStyleDescription.copyWith(
                                      fontSize: MediaQuery.of(context).size.width *
                                          (MediaQuery.of(context).orientation ==
                                                  Orientation.portrait
                                              ? .03
                                              : 0.015),
                                    ),
                                  ),
                                  ]
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                        }).toList(),
                      )
                    ),
                  ],
                ),
              ),
            )
          ),
          
        const SizedBox(child: Navbar(contexto2: 'routes_seh',))
        ],
      ),
    );
  }

  Future<dynamic> selectedArea(BuildContext context,List<void Function()> function ) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SingleChildScrollView(
                child: AlertDialog(
                  title: Text('Selecciona el área',style: getTextStyleTitle2(context, null)),
                  content: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children:[
                      ElevatedButton(
                      onPressed: function[0]
                      ,child: Text('Area A ', style: getTextStyleButtonField(context)
                      )),
                      const SizedBox(width: 8),
                      ElevatedButton(onPressed: function[1]
                      ,child: Text('Area B', style: getTextStyleButtonField(context)
                      )),
                      ElevatedButton(onPressed: function[2],
                      child: Text('Area C', style: getTextStyleButtonField(context)
                      ))
                    ]
                  ),
                ),
              )
            ],
          );
        }
        );
  }
}
