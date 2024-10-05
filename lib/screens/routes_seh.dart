import 'package:app_seguimiento_movil/theme/app_theme.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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

  ChangeLocal changeLocal = ChangeLocal();
  final TextEditingController controller = TextEditingController(); 
  ExamIniPreService eips = ExamIniPreService();
  List<MedicalRecord> files = [ ];

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
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed('tour_seh_tr1_a', arguments: {
                'periodo': 1,
                'recorrido' : 1,
                'form':1,
                'nameContext' : 'tour_seh_tr1_a',
                'title' : '1er trimestre - Área A'
              });
            },   
            () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('tour_seh_tr1_b', arguments: {
                  'periodo': 2,
                  'recorrido' : 2,
                  'form':2,
                  'nameContext' : 'tour_seh_tr1_b',
                  'title' : '1er trimestre - Área B'
                });
              
            },   
            () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed('tour_seh_tr1_c', arguments: {
                'periodo': 3,
                'recorrido' : 3,
                'form':3,
                'nameContext' : 'tour_seh_tr1_c',
                'title' : '1er trimestre - Área C'
                }
              );
            },   
             () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed('tour_seh_tr1_d', 
                arguments: {
                  'periodo': 4,
                  'recorrido' : 4,
                  'form': 13,
                  'nameContext' : 'tour_seh_tr1_d',
                  'title' : '1er trimestre - Área D'
                }
              );
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
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed('tour_seh_tr2_a', arguments: {
                'periodo': 4,
                'recorrido' : 1,
                'form':4,
                'nameContext' : 'tour_seh_tr2_a',
                'title' : '2do trimestre - Área A'
              });
            },
            () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed('tour_seh_tr2_b', arguments: {
                'periodo': 5,
                'recorrido' : 2,
                'form':5,
                'nameContext' : 'tour_seh_tr2_b',
                'title' : '2do trimestre - Área B'
              });
            },
            () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed('tour_seh_tr2_c', arguments: {
                'periodo': 6,
                'recorrido' : 3,
                'form':6,
                'nameContext' : 'tour_seh_tr2_c',
                'title' : '2do trimestre - Área C'
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
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed('tour_seh_tr3_a', arguments: {
                'periodo': 7,
                'recorrido' : 1,
                'form':7,
                'nameContext' : 'tour_seh_tr3_a',
                'title' : '3er trimestre - Área A'
              });
            },
            () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed('tour_seh_tr3_b', arguments: {
                'periodo': 8,
                'recorrido' : 2,
                'form':8,
                'nameContext' : 'tour_seh_tr3_b',
                'title' : '3er trimestre - Área B'
              });
            },
            () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed('tour_seh_tr3_c', arguments: {
                'periodo': 9,
                'recorrido' : 3,
                'form':9,
                'nameContext' : 'tour_seh_tr3_c',
                'title' : '3er trimestre - Área C'
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
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed('tour_seh_tr4_a', arguments: {
                'periodo': 10,
                'recorrido' : 1,
                'form':10,
                'nameContext': 'tour_seh_tr4_a',
                'title' : '4to trimestre - Área A'
              });
            },
            () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed('tour_seh_tr4_b', arguments: {
                'periodo': 11,
                'recorrido' : 2,
                'form':11,
                'nameContext': 'tour_seh_tr4_b',
                'title' : '4to trimestre - Área B'
              });
            },
            () {
              Navigator.of(context).pop();
                Navigator.of(context).pushNamed('tour_seh_tr4_c', arguments: {
                'periodo': 12,
                'recorrido' : 3,
                'form':12,
                'nameContext': 'tour_seh_tr4_c',
                'title' : '4to trimestre - Área C'
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
                        child: 
                        Row(
                          children: [
                            Text('Recorrido de áreas',style: getTextStyleTitle(context,null)), 
                            const Spacer(),
                                IconButton(onPressed: () async {
                                  await changeLocal.chargeHotel(context);
                                  controller.clear();
                                  final list = await eips.getAllExamListSearch(context,'');
                                  files.clear();
                                  setState(() { }); 

                                  for (var el in list) {
                                    files.add(
                                    MedicalRecord(
                                      id: int.parse(el['numEmployee']) == 0 ? 'N/A' :int.parse(el['numEmployee']).toString(), 
                                      name: el['name'] == '' ? 'N/A' : el['name'], 
                                      date: el['datetime_modification'], 
                                      type: el['examName'] ?? 'N/A', 
                                      lastModify: el['datetime_modification'],
                                      exam: int.parse(el['idExam'])
                                      )
                                    );
                                  }
                                  setState(() { }); 
                                }, icon: Icon(Icons.settings))
                          ],
                        )
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
                                  messageError(context,'No hay conexión a Internet.', 'Error');
                                } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
                                  if(e.monthInitial <= month && month <= e.monthFinal){
                                    selectedArea(context,e.navigator, e.monthInitial);
                                  }else{
                                     SystemChannels.textInput.invokeMethod('TextInput.hide');
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
                                                selectedArea(context,e.navigator, e.monthInitial ); // Cierra el diálogo
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

  Future<dynamic> selectedArea(BuildContext context,List<void Function()> function, int monthInitial ) async {
    
    final storage = FlutterSecureStorage();
    int local = int.parse(await storage.read(key: 'idHotelRegister') as String);
    
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
                      )),
                      
                      if( local == 4 && monthInitial == 1)
                      ElevatedButton(onPressed: function[3],
                      child: Text('Area D', style: getTextStyleButtonField(context)
                      ))
                    ]
                  ),
                ),
              )
            ],
          );
        });
  }
}
