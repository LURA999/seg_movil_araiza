import 'package:app_seguimiento_movil/models/models.dart';
import 'package:flutter/material.dart';
import '../services/services.dart';
import '../widgets/widgets.dart';

class QuestRoute extends StatelessWidget {
  const QuestRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    SehTourService seht= SehTourService();
    final Map<String, dynamic> param = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    // Accede a los parámetros individualmente
    int periodo = param['periodo'];
    int recorrido = param['recorrido'];
    double responsiveHeight = MediaQuery.of(context).size.height * 0.1;
    double widthPreguntas = MediaQuery.of(context).size.width * .3;
    double widthLineTable = 0.5;
    int form = param['form'];
    String area = "";
    List<String> preguntasVerticales= [];    
    List<String> preguntasHeaders = [];
    List<String> comments = [];

    List<String> formPropertyComment = [];
    String titleDescription = "";
    String titleDescription2 = "";
    List<Map<String,dynamic>> formValue =[];
    

    Future<List<List<dynamic>>> fetchData() async {
      List<int> answers = await seht.getAnswer(form, context);
      List<Map<String,dynamic>> comments = await seht.getComments(form, context);
      List<Map<String,dynamic>> descriptions = await seht.getDescriptions(form, context);
      return [answers, comments, descriptions];
    }

    return FutureBuilder<List<List<dynamic>>>(
      future: fetchData(),
      builder: (context, snapshot) {
      
 

      List<int> transformEnumArrayToInteger(List<rateRoute> enumArray) {
        // El método map realiza el mapeo automáticamente sin necesidad de recorrer explícitamente
        return enumArray.map((element) {
          switch (element) {
            case rateRoute.none:
              return 0; // Puedes asignar el valor entero que desees para cada elemento de la enumeración
            case rateRoute.bueno:
              return 1;
            case rateRoute.regular:
              return 2;
            case rateRoute.malo:
              return 3;
            default:
              return 0; // Opción por defecto si hay algún valor inesperado en la enumeración
          }
        }).toList(); // Convertimos el iterable resultante en una lista de enteros
      }

       List<rateRoute> transIntegerformToEnumArray(List<int> enumArray) {
        // El método map realiza el mapeo automáticamente sin necesidad de recorrer explícitamente
        return enumArray.map((element) {
          switch (element) {
            case  0:
              return rateRoute.none; // Puedes asignar el valor entero que desees para cada elemento de la enumeración
            case 1 :
              return rateRoute.bueno;
            case 2:
              return rateRoute.regular;
            case 3:
              return rateRoute.malo;
            default:
              return rateRoute.none; // Opción por defecto si hay algún valor inesperado en la enumeración
          }
        }).toList(); // Convertimos el iterable resultante en una lista de enteros
      }

      switch (recorrido) {
        case 1:
          area = "Area A";
        break;
        case 2:
          area = "Area B";
        break;
        case 3:
          area = "Area C";
        break;    
      }

      switch(periodo) {
      case 1:
      titleDescription = "Posturas correctas/forzadas\nRFSHMAT.ART.102";
      titleDescription2 = "Fuerza manual extrema\nRFSHMAT.ART.101";
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
        switch(recorrido) {
          //Enero-Marzo
          //Area A
          case 1:
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
        titleDescription = "Levantamiento pesado frecuente o forzado\nRFSHMAT.ART.102";
        titleDescription2 = "Uso de equipo de proteccion personal\nRFSHMAT.ART.101";
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
      switch(recorrido) {
        //Abr-jun
        //Area A
        case 1:
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
      titleDescription = "";
      titleDescription2 = "";
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
      switch(recorrido) {
        //Jul - sep
        //Area A
        case 1:
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
      
        titleDescription = "Movimiento repetido extremo\nRFSHMAT.ART.102";
        titleDescription2 = "Impacto repetido\nRFSHMAT.ART.101";
        preguntasVerticales = [
          "Funcionamiento de detectores de humo. (NOM-002-STPS-2010)",
          "Funcionamiento de sistema de bombeo de hidrantes. (NOM-004-STPS-1999)",
          "Funcionamiento de Alarma General. NOM-002-STPS-2010",
          "Funcionamiento del sistema eléctrico. NOM-004-STPS-1999"
        ];
      switch(recorrido) {
        //oct-dic
        //Area A
        case 1:
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
    // print(snapshot.data == null?  [] : snapshot.data![1] as List<Map<String,dynamic>>);
    // List<rateRoute> rateRoutes = transIntegerformToEnumArray(snapshot.data!);
    List<rateRoute> rateRoutes = snapshot.data ==null ? List.generate(preguntasVerticales.length * preguntasHeaders.length, 
    (index) => rateRoute.none ): transIntegerformToEnumArray(snapshot.data![0] as List<int>) ; 



    int index = 0;
    List<Column> temas =[];

    if (!snapshot.hasData && !snapshot.hasError) {
      return Scaffold(
        body: Center(
          child: FractionallySizedBox(
            widthFactor: MediaQuery.of(context).orientation == Orientation.portrait ? 0.1 : 0.05,
            heightFactor: MediaQuery.of(context).orientation == Orientation.portrait ? 0.05 : 0.1,
            child: const CircularProgressIndicator(),
          ),
        ),
      );
    
    } else if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else {

 if (snapshot.hasData) {
        
    for (var i = 0; i < preguntasHeaders.length; i++) {
      if (periodo != 3) {  
        formPropertyComment.add("comment$i");
        print(snapshot.data![2]);
        if (i == 0 ) {
        formValue.add({
          'comment$i':  MultiInputsForm(contenido: snapshot.data == null?  '' : (snapshot.data![1] as List<Map<String,dynamic>>)[i]['comment_text'] ?? '' , obligatorio: false),
          'description1':  MultiInputsForm(contenido: snapshot.data == null?  '' : (snapshot.data![2] as List<Map<String,dynamic>>)[0]['description1']?? '', obligatorio: false),
          'description2':  MultiInputsForm(contenido: snapshot.data == null?  '' : (snapshot.data![2] as List<Map<String,dynamic>>)[0]['description2']?? '', obligatorio: false)
        });
        }else{
        formValue.add({
          'comment$i':  MultiInputsForm(contenido: snapshot.data == null?  '' : (snapshot.data![1] as List<Map<String,dynamic>>)[i]['comment_text'] ?? '' , obligatorio: false),
        });
        }
        

      }

      temas.add(
        Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10,bottom: 10),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(preguntasHeaders[i], style: getTextStyleTitle2(context, null),),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...preguntasVerticales.map((e) {
                    index++;
                    return Column(
                      children: [
                        Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: widthPreguntas,
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(MediaQuery.of(context).size.height * .01) ,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black, width: widthLineTable)
                              ),
                              child: Text(e, style: getTextStyleText(context, null))
                            ),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child:  RadioInputRateRoute(titulo: const ["Bueno","Regular","Malo"],index: index-1,tipoEnum: 3,rateRoutes: rateRoutes,  )
                            ),
                          )
                        ],
                        ),
                      ],
                    );
                }),
                 const SizedBox(height: 15,),
                 if(periodo != 3)
                 Column(
                  children: [
                    Text('Comentarios',style: getTextStyleTitle2(context, null),),
                     Padding(
                      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
                      child: MultiInputs( formProperty: formPropertyComment[i], formValue: formValue[i], maxLines: 4, autofocus: false,  controller: null, ),
                     ),
                  ],
                 )
                ],
              ),
            ],
          )
      );
    }
 
}
}

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(height: responsiveHeight,),
                      ElevatedButton(onPressed: () async { 
                        await seht.postForm(transformEnumArrayToInteger(rateRoutes), form, context);
                        for (var i = 0; i < formValue.length; i++) {
                          comments.add(formValue[i]['comment$i']);
                        }
                        await seht.postComments(comments, form, context);
                      },
                      child: const Text('Guardar'),
                      ),
                      ElevatedButton(onPressed: () { 
                        
                      },
                      child: const Text('Descargar'),
                      )
                    ],
                  ), 
                ...temas,

                if( periodo !=3)
                Column(
                  children: [
                  Text(titleDescription,style: getTextStyleTitle2(context, null),),
                    Padding(
                    padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
                    child: MultiInputs( formProperty: "description1", formValue: formValue[0], maxLines: 4, autofocus: false ,  controller: null),
                    ),
                  Text(titleDescription2,style: getTextStyleTitle2(context, null),),
                    Padding(
                    padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
                    child: MultiInputs( formProperty: "description2", formValue: formValue[0], maxLines: 4, autofocus: false,  controller: null ),
                    ),
                  ],
                ),
                    
                  Row(
                  children: [
                    ElevatedButton(onPressed: () async { 
                      await seht.postForm(transformEnumArrayToInteger(rateRoutes), form, context);
                      // await seht.postComments(transformEnumArrayToInteger(rateRoutes), form, context);
                    },
                    child: const Text('Guardar'),
                    ),
                    ElevatedButton(onPressed: () { 
                      transformEnumArrayToInteger(rateRoutes);
                    },
                    child: const Text('Descargar'),
                    )
                  ],
                  ),
                ],
              ),
            ),
          ),
         const SizedBox(child: Navbar(contexto2: 'tour_seh',))
        ],
      )
       );
      // Si no hay datos o error, puedes mostrar un mensaje o un widget vacío
    
  });
    
  }
}
