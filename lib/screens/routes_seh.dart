import 'package:flutter/material.dart';

import '../models/models.dart';
import '../services/services.dart';
import '../widgets/widgets.dart';

class RoutesSeh extends StatelessWidget {
  const RoutesSeh({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
     List<Option> opciones = [
      Option(
        title: 'Enero - Marzo',
        description: 'Acta de recorrido 2023',
        img: null,
        width : 0.3,
        navigator: () {
          Navigator.of(context).pushNamed('tour_seh', arguments: {
            'periodo': 1,
          });
        }
      ), 
      Option(
        title: 'Abril - Junio',
        description: 'Acta de recorrido 2023',
        img: null,
        width : 0.3,
        navigator: () {
          Navigator.of(context).pushNamed('tour_seh', arguments: {
            'periodo': 2,
          });
        }
      ),
      Option(
        title: 'Julio - Septiembre',
        description: 'Acta de recorrido 2023',
        img: null,
        width : 0.3,
        navigator: () {
          Navigator.of(context).pushNamed('tour_seh', arguments: {
            'periodo': 3,
          });
        }
      ),
      Option(
        title: 'Octubre - Diciembre',
        description: 'Acta de recorrido 2023',
        img: null,
        width : 0.3,
        navigator: () {
          Navigator.of(context).pushNamed('tour_seh', arguments: {
            'periodo': 4,
          });
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
}
