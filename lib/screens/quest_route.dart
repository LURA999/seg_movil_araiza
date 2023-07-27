import 'package:app_seguimiento_movil/models/models.dart';
import 'package:flutter/material.dart';

import '../services/services.dart';
import '../theme/app_theme.dart';
import '../widgets/widgets.dart';

class QuestRoute extends StatelessWidget {
  const QuestRoute({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> param = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    // Accede a los parámetros individualmente
    int periodo = param['periodo'];
    int recorrido = param['recorrido'];
    double widthOptions = MediaQuery.of(context).size.width * .12;
    double widthPreguntas = MediaQuery.of(context).size.width * .3;
    double widthLineTable = 0.5;
    List<rateRoute> rateRoutes = [rateRoute.none];
    String area = "";

    EdgeInsets paddingCell = EdgeInsets.fromLTRB(
    MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .005: .01),
    MediaQuery.of(context).size.height * (MediaQuery.of(context).orientation == Orientation.portrait ? .005: .01),
    MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .005: .01),
    MediaQuery.of(context).size.height * (MediaQuery.of(context).orientation == Orientation.portrait ? .005: .01));


    TextStyle myTextSyleBody = const TextStyle(
      color: Color(0xFF293641),
      fontFamily: 'Inter',
      fontWeight: FontWeight.normal
    );



    List<String> preguntasVerticales= [];
    List<String> preguntasHeaders = [];

      switch (recorrido) {
        case 1:
          area = "Area A";
          break;
        case 2:
          area = "Area B";
          break;
        case 3:
          area = "Area C";
      }

      switch(periodo) {
      case 1:
        switch(recorrido) {
          //Enero-Marzo
          //Area A
          case 1:
          preguntasVerticales = [
            "Verificar aseo y orden (NOM-001-STPS-2008)",
            "Inspección de las herramientas de trabajo RFSMAT, ART. 95",
            "Verificar iluminación RFSMAT, ART. 95",
            "Verificación de la existencia de botiquín. NOM-005-STPS-1998",
            "Verificar la existencia del Plan de prevención contra incendios. NOM-004-STPS-1999",
            "Estado de las herramientas de trabajo NOM-004-STPS-1999",
            "Revisión de pisos NOM-001-STPS-2008",
            "Revisión de paredes NOM-001-STPS-2008",
            "Revisión de techos NOM-001-STPS-2008",
            "Revisión de puertas NOM-001-STPS-2008",
            "Revisión de las instalaciones de agua NOM-001-STPS-2008",
            ];
          preguntasHeaders = [
            "Torre A",			
            "Bodega Torre A",			
            "Gimnasio",			
            "Area de descansa",			
            "Lavanderia",			
            "Cuarto de maquinas",			
            "Bodega de alberca",			
            "Cuarto A/C chiller",			
            "Suites",			
            "Oficina Corporativo",			
            "Oficinas Sistemas/Direccion",			
            "Caseta #2"		
          ];
          break;
          //Enero-Marzo
          //Area B
          case 2:
          preguntasVerticales = [ 
            "Verificar aseo y orden (NOM-001-STPS-2008)",
            "Inspección de las herramientas de trabajo RFSMAT, ART. 95",
            "Verificar iluminación RFSMAT, ART. 95",
            "Verificación de la existencia de botiquín. NOM-005-STPS-1998",
            "Verificar la existencia del Plan de prevención contra incendios. NOM-004-STPS-1999",
            "Estado de las herramientas de trabajo NOM-004-STPS-1999",
            "Revisión de pisos NOM-001-STPS-2008",
            "Revisión de paredes NOM-001-STPS-2008",
            "Revisión de techos NOM-001-STPS-2008",
            "Revisión de puertas NOM-001-STPS-2008",
            "Revisión de las instalaciones de agua NOM-001-STPS-2008"];
          preguntasHeaders = [
            "Torre B",			
            "Recepcion",			
            "Lobby Bar",			
            "Ama de llaves",			
            "Oficina de banquetes",			
            "Oficina de Ventas",			
            "Oficina de AyB",			
            "Oficina Araiza Diamante",			
            "Oficina Gerencia General",			
            "Almacen",			
            "Oficina Mantenimiento",			
            "Comedor de empleados"		
          ];
          break;
          //Enero-Marzo
          //Area C
          case 3:
          preguntasVerticales = [
            "Verificar aseo y orden (NOM-001-STPS-2008)",
            "Inspección de las herramientas de trabajo RFSMAT, ART. 95",
            "Verificar iluminación RFSMAT, ART. 95",
            "Verificación de la existencia de botiquín. NOM-005-STPS-1998",
            "Verificar la existencia del Plan de prevención contra incendios. NOM-004-STPS-1999",
            "Estado de las herramientas de trabajo NOM-004-STPS-1999",
            "Revisión de pisos NOM-001-STPS-2008",
            "Revisión de paredes NOM-001-STPS-2008",
            "Revisión de techos NOM-001-STPS-2008",
            "Revisión de puertas NOM-001-STPS-2008",
            "Revisión de las instalaciones de agua NOM-001-STPS-2008"
          ];
          preguntasHeaders = [
              "PUNTOS A REVISIÓN"
              "Centro de convenciones",			
              "Fonda / Privado",			
              "Salon Guaycura",			
              "Salones Mexicali",			
              "Oficina RH",			
              "Oficina Contraloria",			
              "Oficina Reclutamiento",			
              "Oficina compras",			
              "Taller Mantenimiento",			
              "Cuarto de Boylers",			
              "Caseta #1",			
              "Cocina empleados y cocina general" 		
            ];
          break;
        }
      break;
      case 2:
      switch(recorrido) {
        //Abr-jun
        //Area A
        case 1:
        preguntasVerticales = [
          "Aseo y limpieza (NOM-001-STPS-2008)",
          "Contactos no sobrecargados (NOM-002-STPS-2010)",
          "Accesos libres de obstáculos (NOM-002-STPS-2010)",
          "Iluminación y ventilación (RFSHMAT.ART.95)",
          "Condiciones de sanitarios (NOM-001-STPS-2008)",
          "Ventilación (RFSHMAT.ART.95)",
          "Funcionamiento de detectores de humo (NOM-004-STPS-1999)",
          "Ubicación de extintores de fuego y su recarga (NOM-002-STPS-2010)",
          "Color y señalizacion (NOM-026-STPS-2008)"
        ];
        preguntasHeaders = [
          "Torre A",			
          "Bodega Torre A",			
          "Gimnasio",			
          "Area de descansa",			
          "Lavanderia",			
          "Cuarto de maquinas",			
          "Bodega de alberca",			
          "Cuarto A/C chiller",			
          "Suites",			
          "Oficina Corporativo",			
          "Oficinas Sistemas/Direccion",			
          "Caseta #2"		
        ];

        break;
        //Abr-jun
        //Area B
        case 2:
        preguntasVerticales = [ 
          "Aseo y limpieza (NOM-001-STPS-2008)",
          "Contactos no sobrecargados (NOM-002-STPS-2010)",
          "Accesos libres de obstáculos (NOM-002-STPS-2010)",
          "Iluminación y ventilación (RFSHMAT.ART.95)",
          "Condiciones de sanitarios (NOM-001-STPS-2008)",
          "Ventilación (RFSHMAT.ART.95)",
          "Funcionamiento de detectores de humo (NOM-004-STPS-1999)",
          "Ubicación de extintores de fuego y su recarga (NOM-002-STPS-2010)",
          "Color y señalizacion (NOM-026-STPS-2008)"
        ];
        preguntasHeaders = [
          "Torre B",			
          "Recepcion",			
          "Lobby Bar",			
          "Ama de llaves",			
          "Oficina de banquetes",			
          "Oficina de Ventas",			
          "Oficina de AyB",			
          "Oficina Araiza Diamante", 			
          "Oficina Gerencia General",			
          "Almacen",			
          "Oficina Mantenimiento",			
          "Comedor de empleados"		
        ];

        break;
        //Abr-jun
        //Area C
        case 3:
        preguntasVerticales = [
          "Aseo y limpieza (NOM-001-STPS-2008)",
          "Contactos no sobrecargados (NOM-002-STPS-2010)",
          "Accesos libres de obstáculos (NOM-002-STPS-2010)",
          "Iluminación y ventilación (RFSHMAT.ART.95)",
          "Condiciones de sanitarios (NOM-001-STPS-2008)",
          "Ventilación (RFSHMAT.ART.95)",
          "Funcionamiento de detectores de humo (NOM-004-STPS-1999)",
          "Ubicación de extintores de fuego y su recarga (NOM-002-STPS-2010)",
          "Color y señalizacion (NOM-026-STPS-2008)"
         ];

         preguntasHeaders = [
          "Cocina",			
          "Cocina comedor de empleados",			
          "Centro de convenciones",			
          "Fonda / Privado",			
          "Salon Guaycura",			
          "Salones Mexicali",			
          "Oficina RH",			
          "Oficina Contraloria",			
          "Oficina Reclutamiento",			
          "Oficina compras",			
          "Taller Mantenimiento",			
          "Cuarto de Boylers",			
          "Caseta #1"		
         ];
        break;
      }
      break;
      case 3:
      switch(recorrido) {
        //Jul - sep
        //Area A
        case 1:
          preguntasVerticales = [
          "Verificación de la ubicación de extintores. (NOM-002-STPS-2010)",
          " Verificación de la vigencia de los extintores. (NOM-002-STPS-2010)",
          "Verificación de ventilación (RFSHMAT, ART. 99)",
          "Verificación de tableros eléctricos (NOM-004-STPS-1999)",
          "Verificación de instalaciones y elementos estructurales. (NOM-001-STPS-2008)",
          "Existencia de indicadores de corriente eléctrica en tomacorrientes (NOM-026-STPS-2008)",
          "Aseo y limpieza (NOM-001-STPS-2008)",
          "Existencia de plagas (NOM-001-STPS-2008)",
          "Estado físico de escalones (NOM-001-STPS-2008)",
          "Funcionamiento de luz de emergencia (NOM-004-STPS-1999)"];
        preguntasHeaders = [
          "Torre A",			
          "Bodega Torre A",			
          "Gimnasio",			
          "Area de descansa",			
          "Lavanderia",			
          "Cuarto de maquinas",			
          "Bodega de alberca",			
          "Cuarto A/C chiller",			
          "Suites",			
          "Oficina Corporativo",			
          "Oficinas Sistemas/Direccion",			
          "Caseta #2"		
        ];
          
        break;
        //Jul - sep
        //Area B
        case 2:
         preguntasVerticales = [ 
          "Verificación de la ubicación de extintores. (NOM-002-STPS-2010)",
          "Verificación de la vigencia de los extintores. (NOM-002-STPS-2010)",
          "Verificación de ventilación (RFSHMAT, ART. 99)",
          "Verificación de tableros eléctricos (NOM-004-STPS-1999)",
          "Verificación de instalaciones y elementos estructurales. (NOM-001-STPS-2008)",
          "Existencia de indicadores de corriente eléctrica en tomacorrientes (NOM-026-STPS-2008)",
          "Aseo y limpieza (NOM-001-STPS-2008)",
          "Existencia de plagas (NOM-001-STPS-2008)",
          "Estado físico de escalones (NOM-001-STPS-2008)",
          "Funcionamiento de luz de emergencia (NOM-004-STPS-1999)"];

          preguntasHeaders =[
            "Torre B",			
            "Recepcion",			
            "Lobby Bar",			
            "Ama de llaves",			
            "Oficina de banquetes",			
            "Oficina de Ventas",			
            "Oficina de AyB",			
            "Oficina Araiza Diamante", 			
            "Oficina Gerencia General",			
            "Almacen",			
            "Oficina Mantenimiento",			
            "Comedor de empleados"		
          ];
        break;
        case 3:
        //Jul - sep
        //Area C
       preguntasVerticales = [ 
        "Verificación de la ubicación de extintores. (NOM-002-STPS-2010)",
        "Verificación de la vigencia de los extintores. (NOM-002-STPS-2010)",
        "Verificación de ventilación (RFSHMAT, ART. 99)",
        "Verificación de tableros eléctricos (NOM-004-STPS-1999)",
        "Verificación de instalaciones y elementos estructurales. (NOM-001-STPS-2008)"
        "Existencia de indicadores de corriente eléctrica en tomacorrientes (NOM-026-STPS-2008)",
        "Aseo y limpieza (NOM-001-STPS-2008)",
        "Existencia de plagas (NOM-001-STPS-2008)",
        "Estado físico de escalones (NOM-001-STPS-2008)",
        "Funcionamiento de luz de emergencia (NOM-004-STPS-1999)"];
       preguntasHeaders = [
            "Cocina",			
            "Cocina comedor de empleados",			
            "Centro de convenciones",			
            "Fonda / Privado",			
            "Salon Guaycura",			
            "Salones Mexicali",			
            "Oficina RH",			
            "Oficina Contraloria"			
            "Oficina Reclutamiento",			
            "Oficina compras",			
            "Taller Mantenimiento",			
            "Cuarto de Boylers",			
            "Caseta #1"		
          ];
        break;
      }
      break;
      case 4:
      switch(recorrido) {
        //oct-dic
        //Area A
        case 1:
        preguntasVerticales = [
          "Funcionamiento de detectores de humo. (NOM-002-STPS-2010)",
          "Funcionamiento de sistema de bombeo de hidrantes. (NOM-004-STPS-1999)",
          "Funcionamiento de Alarma General. NOM-002-STPS-2010",
          "Funcionamiento del sistema eléctrico. NOM-004-STPS-1999"
        ];
        preguntasHeaders =[
          "Torre A",			
          "Bodega Torre A",			
          "Gimnasio",			
          "Area de descansa",			
          "Lavanderia",			
          "Cuarto de maquinas",			
          "Bodega de alberca",			
          "Cuarto A/C chiller",			
          "Suites",			
          "Oficina Corporativo",			
          "Oficinas Sistemas/Direccion",			
          "Caseta #2"		
        ];
        break;
        //oct-dic
        //Area B
        case 2:
        preguntasVerticales = [
          "Funcionamiento de detectores de humo. (NOM-002-STPS-2010)",
          "Funcionamiento de sistema de bombeo de hidrantes. (NOM-004-STPS-1999)",
          "Funcionamiento de Alarma General. NOM-002-STPS-2010",
          "Funcionamiento del sistema eléctrico. NOM-004-STPS-1999"
        ];
        preguntasHeaders =[
          "Torre B",			
          "Recepcion",			
          "Lobby Bar",			
          "Ama de llaves",			
          "Oficina de banquetes",			
          "Oficina de Ventas",			
          "Oficina de AyB",			
          "Oficina Araiza Diamante", 			
          "Oficina Gerencia General",			
          "Almacen General",			
          "Oficina Mantenimiento",			
          "Comedor de empleados"		
        ];
        break;
        //oct-dic
        //Area C
        case 3:
        preguntasVerticales = [
          "Funcionamiento de detectores de humo. (NOM-002-STPS-2010)",
          "Funcionamiento de sistema de bombeo de hidrantes. (NOM-004-STPS-1999)",
          "Funcionamiento de Alarma General. NOM-002-STPS-2010",
          "Funcionamiento del sistema eléctrico. NOM-004-STPS-1999"
        ];
        preguntasHeaders =[
          "Cocina",			
          "Cocina comedor de empleados",			
          "Centro de convenciones",			
          "Fonda / Privado",			
          "Salon Guaycura",			
          "Salones Mexicali",			
          "Oficina RH",			
          "Oficina Contraloria",			
          "Oficina Reclutamiento",			
          "Oficina compras",			
          "Taller Mantenimiento",			
          "Cuarto de Boylers",			
          "Caseta #1"		
        ];
        break;
      }
      break;
      default:
        preguntasVerticales= [];
      break;
    }

    List<String> segundaLinea  = ["PUNTOS A REVISIÓN"];
    List<String> respuestas = ["B","R","M"];

    for (var i = 0; i < preguntasHeaders.length; i++) {
      for (var i = 0; i < 3; i++) {
        segundaLinea.add(respuestas[i]);
      }
    }

    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return AppTheme.primary;
      }
      return AppTheme.primary;
      }

    // Color? colorBack;
    // int i = 0;
    // int i2 = 0;
    // int i3 = 0;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: widthPreguntas,
                          child: Container(
                            alignment: Alignment.center,
                            height: 70,
                            padding: const EdgeInsets.only(top: 5,bottom: 5),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)
                            ),
                            child: const Text('Preguntas')
                          ),
                        ),
                      ],
                    ),
                  ),
                  ...preguntasVerticales.map((e) {
                    return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: widthPreguntas,
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(e, style:TextStyle(color:Colors.black)),
                          height: 70,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: widthLineTable)
                          )
                        ),
                      ),
                      RadioInputRateRoute(titulo: const ["Bueno","Regular","Malo"],index: 0,tipoEnum: 3,rateRoutes: rateRoutes ),

                    ],
                  );
                }) 
                ],
              ),
            ),
          ),
        const SizedBox(child: Navbar(contexto2: 'tour_seh',))
        ],
      )

      
    );


  }
  
}
