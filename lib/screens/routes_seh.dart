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
  @override
  void initState() { 
    super.initState();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }
  @override
  Widget build(BuildContext context) {
     List<Option> opciones = [
      Option(
        title: 'Enero - Marzo',
        description: 'Acta de recorrido 2023',
        img: null,
        width : 0.3,
        navigator: () {
          List<void Function()> functions =[
            (){
            Navigator.of(context).pushNamed('tour_seh', arguments: {
              'periodo': 1,
              'recorrido' : 1
            });
            },
            (){
            Navigator.of(context).pushNamed('tour_seh', arguments: {
              'periodo': 1,
              'recorrido' : 2  
            });
            },
            (){
            Navigator.of(context).pushNamed('tour_seh', arguments: {
              'periodo': 1,
              'recorrido' : 3
            });
            },
          ];
          selectedArea(context,functions);
          
        }
      ), 
      Option(
        title: 'Abril - Junio',
        description: 'Acta de recorrido 2023',
        img: null,
        width : 0.3,
        navigator: () {
          List<void Function()> functions =[
            (){
            Navigator.of(context).pushNamed('tour_seh', arguments: {
              'periodo': 2,
              'recorrido' : 1
            });
            },
            (){
            Navigator.of(context).pushNamed('tour_seh', arguments: {
              'periodo': 2,
              'recorrido' : 2  
            });
            },
            (){
            Navigator.of(context).pushNamed('tour_seh', arguments: {
              'periodo': 2,
              'recorrido' : 3
            });
            },
          ];
          selectedArea(context,functions);
        
        }
      ),
      Option(
        title: 'Julio - Septiembre',
        description: 'Acta de recorrido 2023',
        img: null,
        width : 0.3,
        navigator: () {
          List<void Function()> functions =[
            (){
            Navigator.of(context).pushNamed('tour_seh', arguments: {
              'periodo': 3,
              'recorrido' : 1
            });
            },
            (){
            Navigator.of(context).pushNamed('tour_seh', arguments: {
              'periodo': 3,
              'recorrido' : 2  
            });
            },
            (){
            Navigator.of(context).pushNamed('tour_seh', arguments: {
              'periodo': 3,
              'recorrido' : 3
            });
            },
          ];
          selectedArea(context,functions);
        }
      ),
      Option(
        title: 'Octubre - Diciembre',
        description: 'Acta de recorrido 2023',
        img: null,
        width : 0.3,
        navigator: () {
          List<void Function()> functions =[
            (){
            Navigator.of(context).pushNamed('tour_seh', arguments: {
              'periodo': 4,
              'recorrido' : 1
            });
            },
            (){
            Navigator.of(context).pushNamed('tour_seh', arguments: {
              'periodo': 4,
              'recorrido' : 2  
            });
            },
            (){
            Navigator.of(context).pushNamed('tour_seh', arguments: {
              'periodo': 4,
              'recorrido' : 3
            });
            },
          ];
          selectedArea(context,functions);
        }
      )
     ];
    return Scaffold(
      body: Column(
        children: [

          Expanded(child: 
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * .05,
                    MediaQuery.of(context).size.height * .0,
                    MediaQuery.of(context).size.width * .05,
                    MediaQuery.of(context).size.height * .0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: MediaQuery.of(context).orientation == Orientation.landscape? 
                        MediaQuery.of(context).size.height * 0.2:
                        MediaQuery.of(context).size.width * 0.2,
                        child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text('Recorridos de Seguridad e Higiene',style: getTextStyleTitle(context,null)),          
                        )
                      ),
                    TableCustom(opciones: opciones),
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
                  title: Text('Selecciona el area',style: getTextStyleText(context, null) ),
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
