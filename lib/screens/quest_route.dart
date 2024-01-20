import 'dart:convert';

import 'package:app_seguimiento_movil/models/models.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/seh_excel_route.dart';
import '../services/services.dart';
import '../widgets/widgets.dart';


class QuestData {
  late final List<List<int>> answers;
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
  List<List<int>> answers=[];
  List<List<int>> answersRespaldo=[];
  List<String> preguntasVerticales= [];    
  List<String> preguntasVerticales2= [];    
  List<String> preguntasHeaders = [];
  List<Map<String,dynamic>> comments = [];  
  List<String> formPropertyComment = [];
  List<String> titleDescription = [];
  List<Map<String,dynamic>> formValue =[];
  int periodo = 0;
  int recorrido = 0;
  String title = '';
  String nameContext = '';
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
     nameContext = param['nameContext'];
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
  }


  Future<QuestData> fetchData() async {

    List<Map<String,dynamic>> descriptions = [];

    if (soloUnaVez4FutureBuilder) {
    answers = await seht.getAnswer(form, context);
    if (answers.isEmpty) {
        Navigator.of(context).pop();
        messageError(context, 'No tiene preguntas registradas', 'Error');
      } 
    preguntasVerticales = await seht.getQuestion(form, context);
    answersRespaldo = (jsonDecode(jsonEncode(answers)) as List)
      .map((dynamic sublist) => (sublist as List).cast<int>())
      .toList();

    if (form==3) {
      preguntasVerticales2 = preguntasVerticales.sublist(preguntasVerticales.length - 6, preguntasVerticales.length );
      for (var i =  0; i < 6 ; i++) {
        preguntasVerticales.removeAt(preguntasVerticales.length - 1);
      }
    } 

    preguntasHeaders = await seht.getTitle(form, context);
    titleDescription = await seht.getTitleDescription(form, context);
    comments = await seht.getComments(form, context);
    descriptions = await seht.getDescriptions(form, context);
      for (var i = 0; i < comments.length; i++) {
        arrEdConComment.add(TextEditingController());
        arrEdConComment[i].text = comments[i]['comment_text'].toString();
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
      List<List<int>> transformEnumArrayToInteger(List<rateRoute> enumArray, List<List<int>> e) {
        int i = 0;
        for (var el in enumArray) {
          switch (el) {
            case rateRoute.none:
              e[i][0] = 0;
            break;
            case rateRoute.bueno:
              e[i][0] = 1;
              break;
            case rateRoute.regular:
              e[i][0] = 2;
            break;
            case rateRoute.malo:
              e[i][0] = 3;
            break;
            default:
              e[i][0] = 0; // Opción por defecto si hay algún valor inesperado en la enumeración
          }
          i++;
        }
        return e;
      }
    
       List<rateRoute> transIntegerformToEnumArray(List<List<int>> enumArray) {
        // El método map realiza el mapeo automáticamente sin necesidad de recorrer explícitamente
        return enumArray.map((element) {
          switch (element[0]) {
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
        (index) => rateRoute.none ): transIntegerformToEnumArray(answers) ; 
      }

    if (soloUnaVez2) {
    for (var i = 0; i < preguntasHeaders.length; i++) {
       if (periodo != 7 && periodo != 8 && periodo != 9) {  
        
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
                        List<List<int>> list = transformEnumArrayToInteger(rateRoutes, answers);

                        for (var i = 0; i < list.length; i++) {
                          if(!const ListEquality().equals(answersRespaldo[i], list[i])){
                            await seht.postForm(list[i], form, context);
                          }
                        }
                        
                        
                        for (var i = 0; i < arrEdConComment.length; i++) {
                          if (comments[i]['comment_text'].toString() != arrEdConComment[i].text.toString()) {
                          comments[i]['comment_text'] = arrEdConComment[i].text.toString();
                          await seht.postComments(comments[i], form, context);
                          }
                        }

                        final intf = DescriptionsSeh(
                          description1: arrEdConDescription[0].text,
                          description2: arrEdConDescription[1].text,
                          local: await storage.read(key: 'idHotelRegister')
                        );

                        await seht.postDescriptions(intf, form, context);
                        // comments = [];                                                                                                           
                      setState(() {
                        desactivarbtnsave = false;
                      });
                      }:null,
                      child: Text('Guardar', style: getTextStyleButtonField(context),),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
                      ElevatedButton(onPressed: desactivarbtndownload == false? () async { 
                      setState(() {
                        desactivarbtndownload = true;
                      });

                      final intf = DescriptionsSeh(
                        description1: arrEdConDescription[0].text,
                        description2: arrEdConDescription[1].text,
                        local: await storage.read(key: 'idHotelRegister')
                      );

                      for (var i = 0; i < formValue.length; i++) {
                        comments[i]['comment_text'] = arrEdConComment[i].text.toString();
                      }

                        DateTime now = DateTime.now();
                        String formattedDate = DateFormat('yyyyMMddss').format(now);
                        String fileName = '$formattedDate.xlsx';                        
                        await jsonToExcelSehExcel(preguntasVerticales,preguntasHeaders,preguntasVerticales2, transformEnumArrayToInteger(rateRoutes,answers),title, comments,titleDescription, intf,'Seh_$fileName',context);
                      setState(() {
                        desactivarbtndownload = false;
                      });
                      }: null,
                      child: Text('Descargar', style: getTextStyleButtonField(context)),
                      ),
                     SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
                      ElevatedButton(onPressed: desactivarbtndownload == false? () async { 
                      await showDialog(
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
                                    comments[0]['comment_text'] = '';
                                    comments[1]['comment_text'] = '';
                                    for (var i = 0; i < arrEdConComment.length; i++) {
                                      arrEdConComment[i].clear();
                                    }

                                    arrEdConDescription[0].text = '';
                                    arrEdConDescription[1].text = '';

                                    llenarFormulario(responsiveRow, index, orientation, responsiveComment,);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Se ha vaciado el formulario', style: getTextStyleText(context, FontWeight.bold, Colors.white),),backgroundColor: Colors.green),
                                    );

                                    Navigator.pop(context); // Cierra el diálogo
                                    setState(() { });
                                  },
                                  child:  Text('Aceptar', style: getTextStyleButtonField(context),),
                                )
                              ],
                            );
                          });
                          setState(() { });

                      }: null,
                      child:  Text('Limpiar',style: getTextStyleButtonField(context)),
                      ) 
                    ],
                  ), 
                  ...temas,
    
                if( periodo != 7 && periodo != 8 && periodo != 9)
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  Text( titleDescription[0],style: getTextStyleTitle2(context, null),),
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
                  Text(titleDescription[1],style: getTextStyleTitle2(context, null),),
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
                        List<List<int>> list = transformEnumArrayToInteger(rateRoutes, answers);

                        for (var i = 0; i < list.length; i++) {
                          if(!const ListEquality().equals(answersRespaldo[i], list[i])){
                            await seht.postForm(list[i], form, context);
                          }
                        }

                        for (var i = 0; i < arrEdConComment.length; i++) {
                          if (comments[i]['comment_text'].toString() != arrEdConComment[i].text.toString()) {
                          comments[i]['comment_text'] = arrEdConComment[i].text.toString();
                          await seht.postComments(comments[i], form, context);
                          }
                        }
                        
                        final intf = DescriptionsSeh(
                          description1: arrEdConDescription[0].text,
                          description2: arrEdConDescription[1].text,
                          local: await storage.read(key: 'idHotelRegister')
                        );

                        await seht.postDescriptions(intf, form, context);
                       // comments = [];                                                                                                           
                      setState(() {
                        desactivarbtnsave = false;
                      });
                        }: null,
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
                            local: await storage.read(key: 'idHotelRegister')
                          );
                        
                          for (var i = 0; i < formValue.length; i++) {
                            comments[i]['comment_text'] = arrEdConComment[i].text.toString();
                          }
                          DateTime now = DateTime.now();
                          String formattedDate = DateFormat('yyyyMMddss').format(now);
                          String fileName = '$formattedDate.xlsx';                        
                          await jsonToExcelSehExcel(preguntasVerticales,preguntasHeaders, preguntasVerticales2, transformEnumArrayToInteger(rateRoutes,answers), title, comments,titleDescription, intf,'Seh_$fileName',context);
                        setState(() {
                          desactivarbtndownload = false;
                        });
                        }: null,
                        child:  Text('Descargar',style: getTextStyleButtonField(context)),
                        ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
                        ElevatedButton(onPressed: () { 
                          
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
                                    comments[0]['comment_text'] = '';
                                    comments[1]['comment_text'] = '';

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
                        },
                        child:  Text('Limpiar',style: getTextStyleButtonField(context)),
                        ) 
                  ],
                  ),
                ],
              ),
            ),
          ),
         SizedBox(child: Navbar(contexto2: nameContext))
        ],
      )
      );
    });
    
  }
  Widget columnOrRow(double responsiveRow, String e, int index, Orientation orientation) {
  // Ejemplo de uso:
     return Column(
    children: [
      preguntaContainer(e,orientation),
      respuestasContainer(null, index),
    ],
  );
  
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
  
  
  double paddingPregunta(Orientation orientation){
    if (MediaQuery.of(context).size.height < 960 && MediaQuery.of(context).size.width <900) {
      if (orientation == Orientation.landscape) {
        return MediaQuery.of(context).size.height *  0.08;
      }else{
        return MediaQuery.of(context).size.height *  0.02;
      }
    }else{
      if (orientation == Orientation.landscape) {
        if (MediaQuery.of(context).size.height > MediaQuery.of(context).size.width ) {
          return MediaQuery.of(context).size.height *  0.01;
        }else{
          return MediaQuery.of(context).size.height *  0.05;
        }
      }else{
        return MediaQuery.of(context).size.height *  0.015;
      }
    }
  }


  LayoutBuilder  preguntaContainer(String e,Orientation orientation) {
    return LayoutBuilder(
  builder: (context, constraints) {
       return Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.black)), 
        width: double.infinity,
        padding: 
        EdgeInsets.all(paddingPregunta(orientation)),
        child: Column(
            children: [ 
              Text(e, style: getTextStyleText(context, null ,null).copyWith(height:  1.2) )
            ],
          ),
      );
      }
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
                  //cellphones
                  (orientation == Orientation.landscape? 0.16 :  0.07 )
                  :
                  //tablets
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
                Column(
                  children: [
                   
                  //En esta parte se imprime las preguntas verticales (perono se imprimen las preguntas verticales2)
                    if(i < preguntasHeaders.length - (periodo==3 && recorrido == 3 ? 1 : 0 ))
                    ...preguntasVerticales.map((e) {
                      return columnOrRow(responsiveRow, e, ++index,orientation); 
                    }
                  ),
                  //En esta parte se imprime las preguntas verticales, personalizadas
                    if(i == preguntasHeaders.length - (periodo==3 && recorrido == 3 ? 1 : preguntasHeaders.length -1 ))
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
              ],
            ),
        )
      );

    }
  }
}



