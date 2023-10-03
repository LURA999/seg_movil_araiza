import 'package:app_seguimiento_movil/models/models.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/seh_excel_route.dart';
import '../services/services.dart';
import '../widgets/widgets.dart';


class QuestData {
  final List<int> answers;
  final List<Map<String, dynamic>> comments;
  final List<Map<String, dynamic>> descriptions;

  QuestData({
    required this.answers,
    required this.comments,
    required this.descriptions,
  });
}

class QuestRoute extends StatefulWidget {
  const QuestRoute({Key? key}) : super(key: key);

  @override
  State<QuestRoute> createState() => _QuestRouteState();
}

class _QuestRouteState extends State<QuestRoute>  {
  List<TextEditingController> arrEdConComment = [];
  List<TextEditingController> arrEdConDescription = [TextEditingController(),TextEditingController()];
  List<rateRoute> rateRoutes =[];
  bool soloUnaVez= true;
  bool soloUnaVez2= true;
  bool soloUnaVez3= true;
  bool soloUnaVez4FutureBuilder= true;
  List<SizedBox> temas =[];
 SehTourService seht= SehTourService();
  double widthLineTable = 0.5;
  String area = "";
  List<String> preguntasVerticales= [];    
  List<String> preguntasVerticales2= [];    
  List<String> preguntasHeaders = [];
  List<String?> comments = [];
  List<String> formPropertyComment = [];
  String titleDescription = "";
  String titleDescription2 = "";
  List<Map<String,dynamic>> formValue =[];
  int periodo = 0;
  int recorrido = 0;
  String title = '';
  double responsiveHeightTitle = 0;
  double responsiveHeightSub = 0;
  int form = 0;
  bool desactivarbtnsave = false;
  bool desactivarbtndownload = false;
  bool limpiar = false;
  double widthPreguntas = 0;
  Orientation? AuxOrientation ;
  bool isLoading = false;

@override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Accede a los parámetros individualmente y asigna los valores a las variables de clase
     final Map<String, dynamic> param = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
     periodo = param['periodo'];
     recorrido = param['recorrido'];
     title = param['title'];
     responsiveHeightTitle = 
     MediaQuery.of(context).size.height < 960 && MediaQuery.of(context).size.width <500?
     MediaQuery.of(context).size.height * (MediaQuery.of(context).orientation == Orientation.landscape? 0.23 : 0.06)
     :
     MediaQuery.of(context).size.height * (MediaQuery.of(context).orientation == Orientation.landscape? 0.12 : 0.08);
     widthPreguntas = MediaQuery.of(context).size.height * 0.3;

     
     responsiveHeightSub = 
     MediaQuery.of(context).size.height < 960 && MediaQuery.of(context).size.width <500?
     MediaQuery.of(context).size.height * (MediaQuery.of(context).orientation == Orientation.landscape? 0.6 : 0.04)
     :
     MediaQuery.of(context).size.height * (MediaQuery.of(context).orientation == Orientation.landscape? 0.06 : 0.04);
     widthPreguntas = MediaQuery.of(context).size.height * 0.3;

     form = param['form'];

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
            preguntasVerticales2 = [
              "Detectores de humo NOM-002-STPS-2010",
              "Verificación de la ubicación de extintores NOM-002-STPS-2010",
              "Limpieza de pisos y paredes RFSHMAT, ART. 109",
              "Estados de los equipos NOM-004-STPS-1999",
              "Estado y limpieza de cuartos fríos RFSHMAT, ART. 109",
              "Estados de los alimentos RFSHMAT, ART. 109	"
            ];

          preguntasHeaders = [
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
              "Cocina empleados y cocina general",
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
  }


  Future<QuestData> fetchData() async {

    List<int> answers = [];
    List<Map<String,dynamic>> comments = [];
    List<Map<String,dynamic>> descriptions = [];

    if (soloUnaVez4FutureBuilder) {
    answers = await seht.getAnswer(form, context);
    comments = await seht.getComments(form, context);
    descriptions = await seht.getDescriptions(form, context);

    
      for (var i = 0; i < comments.length; i++) {
        arrEdConComment.add(TextEditingController());
        arrEdConComment[i].text = comments[i]['comment_text'];
      }

      arrEdConDescription[0].text = descriptions[0]['description1'];
      arrEdConDescription[1].text = descriptions[0]['description2'];
     

      soloUnaVez4FutureBuilder = false;
    }
   

  return QuestData(answers: answers, comments: comments, descriptions: descriptions);
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuestData>(
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
      Orientation orientation = MediaQuery.of(context).orientation;

    int index = 0;
    if (!snapshot.hasData && !snapshot.hasError || orientation !=  AuxOrientation) {
      
    AuxOrientation = orientation;
         soloUnaVez3 = true;
      return CustomBackBvuttonInterceptor(child:Scaffold(
        body: Center(
          child: FractionallySizedBox(
            widthFactor: MediaQuery.of(context).orientation == Orientation.portrait ? 0.1 : 0.05,
            heightFactor: MediaQuery.of(context).orientation == Orientation.portrait ? 0.05 : 0.1,
            child: const CircularProgressIndicator(),
          ),
        ),
      ));
    
    } else if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else {
    
     if (snapshot.hasData) {
    
     if (soloUnaVez) {
        soloUnaVez = false;
        rateRoutes = snapshot.data ==null ? List.generate((preguntasVerticales.length + preguntasVerticales2.length) * preguntasHeaders.length, 
        (index) => rateRoute.none ): transIntegerformToEnumArray(snapshot.data!.answers) ; 
      }

    if (soloUnaVez2) {
    for (var i = 0; i < preguntasHeaders.length; i++) {
       if (periodo != 3) {  
        
        formPropertyComment.add("comment$i");
    
        if (i == 0 ) {
        formValue.add({
          'comment$i':   arrEdConComment[i].text,
          'description1':   arrEdConDescription[0].text,
          'description2':   arrEdConDescription[1].text
        });
        }else{
        formValue.add({
          'comment$i':   arrEdConComment[i].text ,
        });
        }
        
    
      }else{
        formPropertyComment.add("comment$i");
          formValue.add({
          'comment$i':   arrEdConComment[i].text ,
        });
      }
    
    }
    soloUnaVez2 = false;
    }

  if (soloUnaVez3 ) {
      

    double responsiveRow = MediaQuery.of(context).size.height * (orientation == Orientation.landscape? 
    MediaQuery.of(context).size.height < 960 && MediaQuery.of(context).size.width <900 ? 0.15 :
     0.1 : 0.05 ); 
    double responsiveComment = MediaQuery.of(context).size.height * (orientation == Orientation.landscape? 0.05 : 0.01 ); 

    temas = [];
    llenarFormulario(responsiveRow, index, orientation, responsiveComment);
    soloUnaVez3 = false;
    }

    }
  }
  
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: responsiveHeightTitle,),
                  Column(
                  mainAxisAlignment: MainAxisAlignment.start ,
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,style: getTextStyleTitle(context,null)),
                      Text('Selecciona la opción correcta:',style: getTextStyleTitle2(context,null))
                    ],
                  ),
                  SizedBox(height: responsiveHeightSub,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
                      ElevatedButton(onPressed: desactivarbtnsave == false ? () async { 
                        setState(() {
                        desactivarbtnsave = true;
                      });
                        await seht.postForm(transformEnumArrayToInteger(rateRoutes), form, context);
                        for (var i = 0; i < arrEdConComment.length; i++) {
                          comments.add(arrEdConComment[i].text);
                        }
                        await seht.postComments(comments, form, context);
                        final intf = DescriptionsSeh(
                          description1: arrEdConDescription[0].text,
                          description2: arrEdConDescription[1].text,
                        );

                        await seht.postDescriptions(intf, form, context);
                        comments = [];
                      setState(() {
                        desactivarbtnsave = false;
                      });
                      }:null,
                      child: Text('Guardar', style: getTextStyleButtonField(context)),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
                      ElevatedButton(onPressed: desactivarbtndownload == false? () async { 
                      setState(() {
                        desactivarbtndownload = true;
                      });

                      final intf = DescriptionsSeh(
                        description1: arrEdConDescription[0].text,
                        description2: arrEdConDescription[1].text,
                      );

                      for (var i = 0; i < formValue.length; i++) {
                        comments.add(arrEdConComment[i].text);
                      }

                        DateTime now = DateTime.now();
                        String formattedDate = DateFormat('yyyyMMddss').format(now);
                        String fileName = '$formattedDate.xlsx';                        
                        await jsonToExcelSehExcel(preguntasVerticales,preguntasHeaders,preguntasVerticales2,transformEnumArrayToInteger(rateRoutes),area, comments,[titleDescription,titleDescription2], intf,'Seh_$fileName',context);
                      setState(() {
                        desactivarbtndownload = false;
                      });
                      }: null,
                      child: Text('Descargar', style: getTextStyleButtonField(context)),
                      ),
                     SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
                      ElevatedButton(onPressed: desactivarbtndownload == false? () async { 
                      showDialog(
                          context: context, // Accede al contexto del widget actual
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title:  Text("¿Estás seguro que desea continuar?",style: getTextStyleText(context,FontWeight.bold,null),),
                              content: Text("Los datos no se guardarán automaticamente, los cambios se guardan manualmente.", style: getTextStyleText(context,null,null)),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context); // Cierra el diálogo
                                  },
                                  child:  Text('Cancelar', style: getTextStyleButtonField(context),),
                                ),
                                TextButton(
                                  onPressed: () {
                                    double responsiveRow = MediaQuery.of(context).size.height * (orientation == Orientation.landscape? 
                                    MediaQuery.of(context).size.height < 960 && MediaQuery.of(context).size.width <900 ? 0.15 :
                                    0.1 : 0.05 ); 
                                    double responsiveComment = MediaQuery.of(context).size.height * (orientation == Orientation.landscape? 0.05 : 0.01 ); 
                                  rateRoutes = List.generate((preguntasVerticales.length + preguntasVerticales2.length) * preguntasHeaders.length, 
                                  (index) => rateRoute.none );
                                    temas = [];
                                    comments = [];
                                    for (var i = 0; i < arrEdConComment.length; i++) {
                                      arrEdConComment[i].clear();
                                    }

                                    arrEdConDescription[0].text = '';
                                    arrEdConDescription[1].text = '';

                                    llenarFormulario(responsiveRow, index, orientation, responsiveComment,);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Se ha vaciado el formulario', style: getTextStyleText(context, FontWeight.bold, Colors.white),),backgroundColor: Colors.green),
                                    );
                                    setState(() { });
                                    Navigator.pop(context); // Cierra el diálogo
                                  },
                                  child:  Text('Aceptar', style: getTextStyleButtonField(context),),
                                )
                              ],
                            );
                          });

                      
                      
                      }: null,
                      child:  Text('Limpiar',style: getTextStyleButtonField(context)),
                      ) 
                    ],
                  ), 
                  ...temas,
    
                if( periodo !=3)
                Column(
                  children: [
                  Text( titleDescription,style: getTextStyleTitle2(context, null),),
                    Padding(
                    padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
                    child: TextFormField(
                        controller: arrEdConDescription[0],
                        textCapitalization: TextCapitalization.characters,
                        style: getTextStyleText(context,null,null),
                        maxLines: 4,
                        decoration:  InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0),
                          )
                        )
                      ) ,
                    ),
                  Text(titleDescription2,style: getTextStyleTitle2(context, null),),
                    Padding(
                    padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
                    child: TextFormField(
                        controller: arrEdConDescription[1],
                        textCapitalization: TextCapitalization.characters,
                        style: getTextStyleText(context,null,null),
                        maxLines: 4,
                        decoration:  InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0),
                          )
                        )
                      ),
                    ),
                  ],
                ),
                    
                  Row(
                  children: [
                    ElevatedButton(onPressed: desactivarbtnsave == false ? () async { 
                        setState(() {
                        desactivarbtnsave = true;
                      });
                        await seht.postForm(transformEnumArrayToInteger(rateRoutes), form, context);

                        for (var i = 0; i < formValue.length; i++) {
                          comments.add(arrEdConComment[i].text);
                        }

                        await seht.postComments(comments, form, context);
                        final intf = DescriptionsSeh(
                          description1: arrEdConDescription[0].text,
                          description2: arrEdConDescription[1].text,
                        );
                        await seht.postDescriptions(intf, form, context);
                        comments = [];
                      setState(() {
                        desactivarbtnsave = false;
                      });
                    }:null,
                    child:  Text('Guardar', style: getTextStyleButtonField(context),),
                      ) ,
                      SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
                        ElevatedButton(onPressed: desactivarbtndownload == false? () async { 
                        setState(() {
                          desactivarbtndownload = true;
                        });

                        final intf = DescriptionsSeh(
                            description1: arrEdConDescription[0].text,
                            description2: arrEdConDescription[1].text,
                          );
                        
                          for (var i = 0; i < formValue.length; i++) {
                            comments.add(arrEdConComment[i].text);
                          }
                          DateTime now = DateTime.now();
                          String formattedDate = DateFormat('yyyyMMddss').format(now);
                          String fileName = '$formattedDate.xlsx';                        
                          await jsonToExcelSehExcel(preguntasVerticales,preguntasHeaders, preguntasVerticales2,transformEnumArrayToInteger(rateRoutes),area, comments,[titleDescription,titleDescription2], intf,'Seh_$fileName',context);
                        setState(() {
                          desactivarbtndownload = false;
                        });
                        }: null,
                        child:  Text('Descargar',style: getTextStyleButtonField(context)),
                        ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
                        ElevatedButton(onPressed: () { 
                          
                        double responsiveRow = MediaQuery.of(context).size.height * (orientation == Orientation.landscape? 
                        MediaQuery.of(context).size.height < 960 && MediaQuery.of(context).size.width <900 ? 0.15 :
                        0.1 : 0.05 ); 
                        double responsiveComment = MediaQuery.of(context).size.height * (orientation == Orientation.landscape? 0.05 : 0.01 ); 
                      rateRoutes = List.generate((preguntasVerticales.length + preguntasVerticales2.length) * preguntasHeaders.length, 
                      (index) => rateRoute.none );
                        temas = [];

                        arrEdConDescription[0].text = '';
                        arrEdConDescription[1].text = '';

                        for (var i = 0; i < arrEdConComment.length; i++) {
                        setState(() {
                          arrEdConComment[i].text = '';
                        });
                        }

                        llenarFormulario(responsiveRow, index, orientation, responsiveComment);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Se ha vaciado el formulario', style: getTextStyleText(context, FontWeight.bold, Colors.white),),backgroundColor: Colors.green),
                        );

                        },
                        child:  Text('Limpiar',style: getTextStyleButtonField(context)),
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
    });
    
  }
  Widget columnOrRow(double responsiveRow, String e, int index, Orientation orientation) {
  // Ejemplo de uso:
  
  if (orientation == Orientation.landscape) {
    return Row(
    children: [
      Expanded(
        child: preguntaContainer(responsiveRow, e),
      ),
      Expanded(
        child: respuestasContainer(responsiveRow, index),
      )            
    ],
  );
  }else{
     return Column(
    children: [
      preguntaContainer(responsiveRow, e),
      respuestasContainer(null, index),
    ],
  );
  }
}

  Container respuestasContainer(double? responsiveRow, int index) {
    return Container(
      height: responsiveRow,
      width: (MediaQuery.of(context).size.width ) ,
      alignment: Alignment.center,
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: RadioInputRateRoute(titulo: const ["Bueno","Regular","Malo"],index: index-1,tipoEnum: 3,rateRoutes: rateRoutes,  ))
      );
  }

  Container preguntaContainer(double responsiveRow, String e) {
    return Container(
        height: responsiveRow,
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        child: Text(e, style: getTextStyleText(context, null ,null).copyWith(height:  1.2) ),
      );
  }


  llenarFormulario(double responsiveRow,int index,Orientation orientation, double responsiveComment) {
 for (var i = 0; i < preguntasHeaders.length; i++) {
      temas.add(
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width ,
                  height: MediaQuery.of(context).size.height * 
                  (MediaQuery.of(context).size.height < 960 && MediaQuery.of(context).size.width <900 ?
                  (orientation == Orientation.landscape? 0.16 : 0.07 )
                  :
                  (orientation == Orientation.landscape? 0.1 : 0.05 )),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(156, 39, 50, 1.0)
                    ),
                    margin: const EdgeInsets.only(top: 10,bottom: 10),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(preguntasHeaders[i], style: getTextStyleTitle2(context, Colors.white)),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                     
                    //En esta parte se imprime las preguntas verticales (perono se imprimen las preguntas verticales2)
                      if(i < preguntasHeaders.length - (periodo==1 && recorrido == 3 ? 1 : 0 ))
                      ...preguntasVerticales.map((e) {
                        return columnOrRow(responsiveRow, e, ++index,orientation); 
                    }
                    ),
                    //En esta parte se imprime las preguntas verticales, personalizadas
                      if(i == preguntasHeaders.length - (periodo==1 && recorrido == 3 ? 1 : preguntasHeaders.length -1 ))
                    ...preguntasVerticales2.map((e) {
                        return columnOrRow(responsiveRow, e, ++index,orientation);
                    }
                    ),
                    SizedBox(height: responsiveComment,),
                     Column(
                      children: [
                        Text('Comentarios',style: getTextStyleTitle2(context, null),),
                         Padding(
                           padding: EdgeInsets.all(responsiveComment),
                           child: TextFormField(
                              controller: arrEdConComment[i],
                             textCapitalization: TextCapitalization.characters,
                             style: getTextStyleText(context,null,null),
                             maxLines: 4,
                             decoration:  InputDecoration(
                               border: OutlineInputBorder(
                                 borderRadius: BorderRadius.circular(0),
                               )
                             )
                           ),
                         ),
                      ],
                     )
                    ],
                  ),
                ),
              ],
            ),
        )
      );

    }
  }
}



