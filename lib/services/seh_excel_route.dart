import 'dart:async'; 
import 'package:app_seguimiento_movil/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';

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


Future<void> jsonToExcelSehExcel(List<String> preguntas,List<String> headers,List<int> res,String area,  List<String> comments, DescriptionsSeh descriptionsSeh, String fileName, BuildContext context) async {
  bool storagePermissionGranted = false;
  if (Platform.isAndroid || Platform.isIOS) {
  await requestPermission((bool granted) {
    storagePermissionGranted = granted;
  }); 
   
  if (!storagePermissionGranted) {
    throw Exception('No se han concedido los permisos de almacenamiento.');
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

  for (var i = 0; i < headers.length; i++) {
     // Obtenemos el índice del header actual y los siguientes dos headers
    int startIdx = 3 + (i * 3);
    int endIdx = 5 + (i * 3);

    // Fusionamos las celdas de los tres headers
    final Range mergedHeader = sheet.getRangeByIndex(1, startIdx, 1, endIdx);
    mergedHeader.merge();
    
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
  for (var i = 0; i < headers.length *3; i++) {
    final Range brm = sheet.getRangeByIndex(2, 3+i);
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

  for (var i = 0; i < preguntas.length; i++) {
    //indice
    final Range indice = sheet.getRangeByIndex(3+i, 1);
    indice.setText((i+1).toString());
    indice.cellStyle.fontSize = 11;
    indice.cellStyle.fontName = 'Arial';

    //pregunta
    final Range ptrevision = sheet.getRangeByIndex(3+i, 2);
    ptrevision.setText(preguntas[i]);
    ptrevision.cellStyle.bold = true;
    ptrevision.cellStyle.fontSize = 10;
    ptrevision.cellStyle.fontName = 'Arial';

  }

  //respuesta
    int r = 0;
    for (var z = 0; z < headers.length; z++) {
      for (var i = 0; i < preguntas.length; i++) {
        if (res[r] != 0 ) {
          var cell1 = sheet.getRangeByIndex(i+3, (res[r] + (z>0 ? z*3 + 1 : 1)) +1 );
          cell1.setText('X');
          cell1.cellStyle.fontSize = 10;
          cell1.cellStyle.fontName = 'Arial';
         
        }
         r++;
      }
    }


  

 final Range headerSecond = sheet.getRangeByIndex(preguntas.length + 6,2);
  headerSecond.setText("COMENTARIOS");
  headerSecond.cellStyle.bold = true;
  headerSecond.cellStyle.fontSize = 20;
  headerSecond.cellStyle.fontName = 'Calibri';

  int reng = 0;
  for (var i = 0; i < headers.length; i++) {
    final Range preguntasRange = sheet.getRangeByIndex(preguntas.length + 7 + i + reng, 2);
    preguntasRange.setText(headers[i]);
    preguntasRange.cellStyle.bold = true;
    preguntasRange.cellStyle.fontSize = 10;
    preguntasRange.cellStyle.fontName = 'Calibri';

    final Range commentsRange = sheet.getRangeByIndex(preguntas.length + 8 + i + reng, 2);
    commentsRange.setText(comments[i]);
    commentsRange.cellStyle.fontSize = 11;
    commentsRange.cellStyle.fontName = 'Calibri';

    reng ++;    
  }


  
  sheet.autoFitColumn(1);
  sheet.autoFitColumn(2);
  sheet.autoFitRow(preguntas.length + 6);

/*   //Contenido de las cabeceras agregadas
  for (var i = 0; i < jsonStr.length; i++) {
    var keys = jsonStr[i].keys.toList();
    var values = jsonStr[i].values.toList();
    for (var j = 0; j < keys.length; j++) {
      var cell = sheet.getRangeByIndex(i + 1, j + 1);
      cell.setText(values[j].toString());
    }
  }
 */
  sheet.autoFitColumn(1);
  sheet.autoFitColumn(2);
  sheet.autoFitColumn(3);
  sheet.autoFitColumn(4);
  sheet.autoFitColumn(5);
  sheet.autoFitColumn(6);
  sheet.autoFitColumn(7);
  

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