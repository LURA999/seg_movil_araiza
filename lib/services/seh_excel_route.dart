import 'dart:async'; 
import 'package:app_seguimiento_movil/models/models.dart';
import 'package:download/download.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:universal_platform/universal_platform.dart';

Future<String> getDownloadDirectoryPath() async {
  String path = '';
  
  if (Platform.isAndroid) {
    const platform = MethodChannel('flutter_android_directory');
    try {
      path = await platform.invokeMethod('getDownloadsDirectory');
    } catch (e) {
      path = (await getExternalStorageDirectory())!.path;
    }
  } else {
    final directory = await getApplicationDocumentsDirectory();
    path = directory.path;
  }
  return path;
}

Future<String?> pickDownloadDirectory(BuildContext context) async {
  final result = await FilePicker.platform.getDirectoryPath();
  if (result != null) {
    return result;
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('No se seleccionó ninguna carpeta')),
    );
    return null;
  }
}


Future<void> requestPermission(Function(bool) onPermissionResult) async {
  var status = await Permission.storage.status;
  if (status.isGranted || status.isDenied ) {
    // Si los permisos no han sido concedidos o fueron denegados, los solicita al usuario
    status = await Permission.storage.request();  
    final granted = status.isGranted;
    onPermissionResult(granted);
  }

  if (status.isDenied) {
    // Si el usuario deniega los permisos, muestra un mensaje de error
    throw Exception('El usuario denegó los permisos de almacenamiento.');
  }

}


Future<void> jsonToExcelSehExcel(List<String> preguntas,List<String> headers, List<String> preguntas2,List<List<int>> res,
String area, List<Map<String,dynamic>> comments,List<String> Titlecomments, DescriptionsSeh descriptionsSeh, String fileName, 
BuildContext context) async {
  
  
  bool storagePermissionGranted = false;
  if(!UniversalPlatform.isWeb){
    if (Platform.isAndroid || Platform.isIOS) {
    await requestPermission((bool granted) {
      storagePermissionGranted = granted;
    }); 
    
    if (!storagePermissionGranted) {
      throw Exception('No se han concedido los permisos de almacenamiento.');
    }
  }
  }

  // Crea el archivo Excel
  final workbook = Workbook();
  final sheet = workbook.worksheets[0];
  // DateTime dateToday = DateTime.now();
  // var formatter =  DateFormat("yyyy-MM-dd");
  // String formattedDate = formatter.format(dateToday);

  // Agrega las celdas de encabezado
 final Range headerFirst = sheet.getRangeByIndex(1, 1, 1, 2);
  headerFirst.setText(area);
  headerFirst.cellStyle.bold = true;
  headerFirst.cellStyle.fontSize = 26;
  headerFirst.cellStyle.fontName = 'Arial';
  headerFirst.merge();

  int recorrerColumna  = 0; 
  int espacioColumn = 0;
  if (preguntas2.isNotEmpty) {
    //En esta linea de codigo, decido en que columna se van a incrustar las preguntas verticales
    recorrerColumna = headers.length - 1;  
    espacioColumn = 1;
  }

  //Esta variable es para tener un mejor control para imprimir los cabeceras, y poder respetar la columna extra
  int indexAuxHeader = 0;

  for (var i = 0; i < headers.length + espacioColumn; i++) {
    // Obtenemos el índice del header actual y los siguientes dos headers
    int startIdx = 3 + (i * 3);
    int endIdx = 5 + (i * 3);

    // Fusionamos las celdas de los tres headers
    final Range mergedHeader = sheet.getRangeByIndex(1, startIdx, 1, endIdx);
    mergedHeader.merge();
    
  if (preguntas2.isNotEmpty) {
    //creando la columna vacia
    // Establecemos el texto del header correspondiente a cada grupo de celdas fusionadas
    final Range headerCell = sheet.getRangeByIndex(1, startIdx);

    if (recorrerColumna == i) {
      headerCell.setText("");
    } else{
      headerCell.setText(headers[indexAuxHeader]);
      indexAuxHeader++;
    }
    headerCell.cellStyle.bold = true;
    headerCell.cellStyle.fontSize = 11;
    headerCell.cellStyle.fontName = 'Calibri';
    headerCell.cellStyle.rotation = 90;
    headerCell.cellStyle.hAlign = HAlignType.center;
    headerCell.cellStyle.vAlign = VAlignType.center;


  }else{
    // Establecemos el texto del header correspondiente a cada grupo de celdas fusionadas
    final Range headerCell = sheet.getRangeByIndex(1, startIdx);
    headerCell.setText(headers[i]);
    headerCell.cellStyle.bold = true;
    headerCell.cellStyle.fontSize = 11;
    headerCell.cellStyle.fontName = 'Calibri';
    headerCell.cellStyle.rotation = 90;
    headerCell.cellStyle.hAlign = HAlignType.center;
    headerCell.cellStyle.vAlign = VAlignType.center;
  }


  }

  sheet.autoFitRow(1);


//Preguntas verticales

   final Range ptrevision = sheet.getRangeByIndex(2, 1, 2, 2);
  ptrevision.setText('Puntos de revision');
  ptrevision.cellStyle.bold = true;
  ptrevision.cellStyle.fontSize = 10;
  ptrevision.cellStyle.backColor = '#c0bcbc';
  ptrevision.cellStyle.fontName = 'Arial';
  ptrevision.merge();


  List<String> brmArr = ['B','R','M'];
  
  int x =0;
  for (var i = 0; i < (headers.length + espacioColumn) *3 ; i++) {

    final Range brm = sheet.getRangeByIndex(2, 3+i);

    if (preguntas2.isNotEmpty) {
      if (i >= (recorrerColumna) * 3 && i < (recorrerColumna + espacioColumn) *3 ) {
        brm.setText("");
      }else{  
        brm.setText(brmArr[x]);
      }

      brm.cellStyle.bold = true;
      brm.cellStyle.fontSize = 14;
      brm.cellStyle.fontName = 'Calibri';
      sheet.autoFitColumn(3+i);
      if(x==2){
        x = 0;
      }else{
        x++;
      }
    }else{
      brm.setText(brmArr[x]);
      brm.cellStyle.bold = true;
      brm.cellStyle.fontSize = 14;
      brm.cellStyle.fontName = 'Calibri';
      sheet.autoFitColumn(3+i);
      if(x==2){
        x = 0;
      }else{
        x++;
      }
    }
  }

  int indexPreguntas2 = 0;
  for (var i = 0; i < preguntas.length + preguntas2.length; i++) {
    //indice
    final Range indice = sheet.getRangeByIndex(3+i, 1);
    indice.setText(i<preguntas.length?(i+1).toString(): '');
    indice.cellStyle.fontSize = 11;
    indice.cellStyle.fontName = 'Arial';

    if (preguntas2.isNotEmpty) {
      if (i >=preguntas.length ) {
        //pregunta extras
        final Range ptrevision = sheet.getRangeByIndex(3+indexPreguntas2, (recorrerColumna+espacioColumn)*3, 3+indexPreguntas2,((recorrerColumna+espacioColumn)*3)+2);
        ptrevision.setText(preguntas2[indexPreguntas2]);
        ptrevision.cellStyle.wrapText = true;
        ptrevision.cellStyle.bold = true;
        ptrevision.cellStyle.fontSize = 10;
        ptrevision.cellStyle.fontName = 'Arial';
        ptrevision.merge();
        indexPreguntas2 ++;
      }else{
        //pregunta iniciales
        final Range ptrevision = sheet.getRangeByIndex(3+i, 2);
        ptrevision.setText(preguntas[i]);
        ptrevision.cellStyle.bold = true;
        ptrevision.cellStyle.fontSize = 10;
        ptrevision.cellStyle.fontName = 'Arial';
      }
    }else{
      //pregunta
      final Range ptrevision = sheet.getRangeByIndex(3+i, 2);
      ptrevision.setText(preguntas[i]);
      ptrevision.cellStyle.bold = true;
      ptrevision.cellStyle.fontSize = 10;
      ptrevision.cellStyle.fontName = 'Arial';
    }

  }

  //En este apartado se imprimen todas las respuestas de todas preguntas

    //en estos fors se imprimen las preguntas verticales que no se imprimen en medio de la tabla
    int r = 0;

    /**
     z es el indice principal,  si z es mayor a 0 entonces me dara la posicion en donde se pondra la x multiplicado por 3,
     con el fin de que me dara a entender que ya no esta en las primeras 3 poiciones, si no en sus multiplos (o demas headers o areas), 
     le agrege el + 1, para recorrer la posicion de la celda hacia la derecha en el dado caso que no sea igual a 0 
     solo se le pone el 1, indicando que son las primeras 3 posiciones, el  "res[r]" es la respuesta y este se representa con un numero
     por lo tanto lo que sucede es que el resto del codigo inicializa la CELDAS (en plural) y el "res[r]" lo inserta en cualquiera
     de las 3 posibles respuestas (B,R,M).
     */
    for (var z = 0; z < headers.length - espacioColumn; z++) {
      for (var i = 0; i < preguntas.length; i++) {
        if (res[r][0] != 0 ) {
          var cell1 = sheet.getRangeByIndex(i+3, (res[r][0] + (z>0 ? z*3 + 1 : 1)) +1 );
          cell1.setText('X');
          cell1.cellStyle.fontSize = 10;
          cell1.cellStyle.fontName = 'Arial';
         
        }
         r++;
      }
    }
    /* 
    en este caso solo hay una columna extra y este lo puse como constante porque aun no tengo lo tengo definido como una variable
    por que este no cambia de valor, unicamente en un excel en especifico, por lo tanto no es necesario definirlo como una variable
    */

    for (var i = 0; i < preguntas2.length; i++) {
      if (res[r][0] != 0 ) {
        var cell1 = sheet.getRangeByIndex(i+3, res[r][0] + (((recorrerColumna+2) * 3))-1 );
        cell1.setText('X');
        cell1.cellStyle.fontSize = 10;
        cell1.cellStyle.fontName = 'Arial';
      }
      r++;
    }

//COMENTARIOS

 final Range headerSecond = sheet.getRangeByIndex(preguntas.length + 6,2);
  headerSecond.setText("COMENTARIOS");
  headerSecond.cellStyle.bold = true;
  headerSecond.cellStyle.fontSize = 20;
  headerSecond.cellStyle.fontName = 'Calibri';
  int reng = 0;

  /**
   * se agarra preguntas length para que sobrepase la informacion principal y para que sea dinamico al mismo tiempo el + 7 (o +8) ya es por 
   * gusto y el + i es para que se imprima de manera vertical todos los comentarios, y el reng, es para que respete la fila extra del comentario
   * de parte del header y del comentario para que este pueda tener otro renglon
   */
  for (var i = 0; i < headers.length; i++) {
    final Range preguntasRange = sheet.getRangeByIndex(preguntas.length + 7 + i + reng, 2);
    preguntasRange.setText(headers[i]);
    preguntasRange.cellStyle.bold = true;
    preguntasRange.cellStyle.fontSize = 10;
    preguntasRange.cellStyle.fontName = 'Calibri';

    final Range commentsRange = sheet.getRangeByIndex(preguntas.length + 8 + i + reng, 2,preguntas.length + 8 + i + reng + 1,2);
    commentsRange.setText(comments[i]['comment_text']);
    commentsRange.cellStyle.fontSize = 11;
    commentsRange.cellStyle.fontName = 'Calibri';
    commentsRange.cellStyle.vAlign = VAlignType.center;
    commentsRange.cellStyle.wrapText = true;
    commentsRange.merge();

    reng += 2;    
  }



sheet.autoFitRow(preguntas.length + 6);
  sheet.autoFitColumn(1);
  sheet.autoFitColumn(2);
  sheet.autoFitColumn(3);
  sheet.autoFitColumn(4);
  sheet.autoFitColumn(5);
  sheet.autoFitColumn(6);
  sheet.autoFitColumn(7);
  
//DESCRIPCIONES

if (Titlecomments.isNotEmpty ) {
  final Range headerThird = sheet.getRangeByIndex(preguntas.length + 6,5,preguntas.length + 6, 15);
  headerThird.setText("ACTOS INSEGUROS");
  headerThird.cellStyle.bold = true;
  headerThird.cellStyle.fontSize = 10;
  headerThird.cellStyle.fontName = 'Arial';
  headerThird.merge();

final Range act1 = sheet.getRangeByIndex(preguntas.length + 7,5,preguntas.length + 9, 15);
  act1.setText(Titlecomments[0]);
  act1.cellStyle.fontSize = 10;
  act1.cellStyle.fontName = 'Arial';
  act1.cellStyle.vAlign = VAlignType.center;
  act1.merge();

  final Range act2 = sheet.getRangeByIndex(preguntas.length + 10,5,preguntas.length + 12, 15);
  act2.setText(Titlecomments[1]);
  act2.cellStyle.fontSize = 10;
  act2.cellStyle.fontName = 'Arial';
  act2.cellStyle.vAlign = VAlignType.center;
  act2.merge();

final Range headerThird2 = sheet.getRangeByIndex(preguntas.length + 6,16,preguntas.length + 6,28);
  headerThird2.setText("DESCRIPCIÓN");
  headerThird2.cellStyle.bold = true;
  headerThird2.cellStyle.fontSize = 10;
  headerThird2.cellStyle.fontName = 'Arial';
  headerThird2.merge();

final Range desc1 = sheet.getRangeByIndex(preguntas.length + 7,16,preguntas.length + 9,28);
    desc1.setText(descriptionsSeh.description1 ?? '');
  if (desc1.text != null && desc1.text != '') {
    desc1.cellStyle.fontSize = 10;
    desc1.cellStyle.fontName = 'Arial';
    desc1.cellStyle.vAlign = VAlignType.center;
    desc1.cellStyle.wrapText = true;
  }
  desc1.merge();

  final Range desc2 = sheet.getRangeByIndex(preguntas.length + 10,16,preguntas.length + 12,28);
    desc2.setText(descriptionsSeh.description2 ?? '');
  if (desc2.text != null && desc2.text != '') {
    desc2.cellStyle.fontSize = 10;
    desc2.cellStyle.fontName = 'Arial';
    desc2.cellStyle.vAlign = VAlignType.center;
    desc2.cellStyle.wrapText = true;
  }
  desc2.merge();
}

  //String? directorio = await FilePicker.platform.getDirectoryPath();
  if(UniversalPlatform.isWeb){
    Stream<int> pdf = Stream.fromIterable(workbook.saveAsStream());
    download(pdf, '$fileName.xlsx'); 
  }else{
    String? path =  await pickDownloadDirectory(context);
    Directory directory = Directory(path!);
    if (await directory.exists()) {
     final file = File('$path/$fileName');  
     try {
      await file.writeAsBytes(workbook.saveAsStream());
      ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Archivo guardado en $file')),
      );
     } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$e')),
      );
     }
     
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('La carpeta seleccionada no existe')),
    );
      //path = await getDownloadDirectoryPath();
    }
  } 
}