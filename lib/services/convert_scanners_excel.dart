import 'dart:async';
import 'dart:convert';
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

//dataguard es para los de trafico
//jsonStrFood es para el comedor
Future<void> jsonToExcel(List<Map<String, dynamic>> jsonStr, List<String> headersPerso,List<Map<String, dynamic>> jsonStrObs,List<Map<String, dynamic>>? jsonStrFood, List<Map<String,dynamic>>? dataGuard, List<Map<String,dynamic>>? dataComments, int screen, String fileName, BuildContext context) async {
  bool storagePermissionGranted = false;
  if (Platform.isAndroid || Platform.isIOS) {
  await requestPermission((bool granted) {
    storagePermissionGranted = granted;
  }); 
   
  if (!storagePermissionGranted) {
    throw Exception('No se han concedido los permisos de almacenamiento.');
  }
  // // Decodifica el JSON
  //  final List<Map<String, dynamic>> jsonOf = List<Map<String, dynamic>>.from(jsonStr);
  
  
  // final session = await vp.arrSharedPreferences();

  // Crea el archivo Excel
  final workbook = Workbook();
  final sheet = workbook.worksheets[0];
  DateTime dateToday = DateTime.now();
  var formatter =  DateFormat("yyyy-MM-dd");
  String formattedDate = formatter.format(dateToday);

  int beginRow = 5;
  
 
// ByteData bytes = ByteData.view(Uint8List.fromList(imageData).buffer);
// Uint8List imageData = bytes.buffer.asUint8List(); 

  /**
  //Esto es para cargar imagenes normales
  final ByteData bytes = await rootBundle.load('assets/images/main/Recursos Humanos.png');
  final Uint8List imageData = bytes.buffer.asUint8List(); 
  */
  // AJUSTANDO LOGO
  final ByteData bytes = await rootBundle.load('assets/images/logo_report_vehicle.png');
  final Uint8List imageLogo = bytes.buffer.asUint8List(); 
  final Picture pictureLogo = sheet.pictures.addStream(1, 1, imageLogo);
  pictureLogo.width = 130; // Ancho de la imagen en unidades de 1/256 de un carácter
  pictureLogo.height = 70; 
  
 



  // Agrega las celdas de encabezado
  List<String> headers = jsonStr[0].keys.toList();
  for (var i = 0; i < headers.length; i++) {
   final Range header = sheet.getRangeByIndex(beginRow, i+1);
   header.setText(headersPerso[i]);
   header.cellStyle.bold = true;
  }

  //Contenido de las cabeceras agregadas
  for (var i = 0; i < jsonStr.length; i++) {
    var keys = jsonStr[i].keys.toList();
    var values = jsonStr[i].values.toList();
    for (var j = 0; j < keys.length; j++) {
      var cell = sheet.getRangeByIndex(i + 1 + beginRow, j + 1);
      cell.setText(values[j].toString());
    }
  }

  sheet.autoFitColumn(1);
  sheet.autoFitColumn(2);
  sheet.autoFitColumn(3);
  sheet.autoFitColumn(4);
  sheet.autoFitColumn(5);
  sheet.autoFitColumn(6);
  sheet.autoFitColumn(7);
  
  //TRAFICO
  if (screen == 1) {
    //AJUSTANDO FECHA
    sheet.getRangeByIndex(4,6).setText('Fecha: $formattedDate');

    // AJUSTANDO TITULO
    sheet.getRangeByIndex(2,3).setText('CONTROL DE VEHICULOS EMPLEADOS'); // Fusionar celdas
    final Range rangeTitle = sheet.getRangeByName('B2:F2');
    rangeTitle.cellStyle.bold = true;
    rangeTitle.cellStyle.fontSize = 16;
    rangeTitle.merge();
    rangeTitle.cellStyle.hAlign = HAlignType.center;
    rangeTitle.cellStyle.vAlign = VAlignType.center;
    String base64Image = dataGuard!.length == 1?  dataGuard[0]['sign'] : 'iVBORw0KGgoAAAANSUhEUgAAAMgAAADICAYAAACtWK6eAAAAAXNSR0IArs4c6QAABSJJREFUeF7t1bERwDAMxLB4/6UzgV2wfaRXIci8nM9HgMBV4LAhQOAuIBCvg8BDQCCeBwGBeAMEmoA/SHMzNSIgkJFDW7MJCKS5mRoREMjIoa3ZBATS3EyNCAhk5NDWbAICaW6mRgQEMnJoazYBgTQ3UyMCAhk5tDWbgECam6kRAYGMHNqaTUAgzc3UiIBARg5tzSYgkOZmakRAICOHtmYTEEhzMzUiIJCRQ1uzCQikuZkaERDIyKGt2QQE0txMjQgIZOTQ1mwCAmlupkYEBDJyaGs2AYE0N1MjAgIZObQ1m4BAmpupEQGBjBzamk1AIM3N1IiAQEYObc0mIJDmZmpEQCAjh7ZmExBIczM1IiCQkUNbswkIpLmZGhEQyMihrdkEBNLcTI0ICGTk0NZsAgJpbqZGBAQycmhrNgGBNDdTIwICGTm0NZuAQJqbqREBgYwc2ppNQCDNzdSIgEBGDm3NJiCQ5mZqREAgI4e2ZhMQSHMzNSIgkJFDW7MJCKS5mRoREMjIoa3ZBATS3EyNCAhk5NDWbAICaW6mRgQEMnJoazYBgTQ3UyMCAhk5tDWbgECam6kRAYGMHNqaTUAgzc3UiIBARg5tzSYgkOZmakRAICOHtmYTEEhzMzUiIJCRQ1uzCQikuZkaERDIyKGt2QQE0txMjQgIZOTQ1mwCAmlupkYEBDJyaGs2AYE0N1MjAgIZObQ1m4BAmpupEQGBjBzamk1AIM3N1IiAQEYObc0mIJDmZmpEQCAjh7ZmExBIczM1IiCQkUNbswkIpLmZGhEQyMihrdkEBNLcTI0ICGTk0NZsAgJpbqZGBAQycmhrNgGBNDdTIwICGTm0NZuAQJqbqREBgYwc2ppNQCDNzdSIgEBGDm3NJiCQ5mZqREAgI4e2ZhMQSHMzNSIgkJFDW7MJCKS5mRoREMjIoa3ZBATS3EyNCAhk5NDWbAICaW6mRgQEMnJoazYBgTQ3UyMCAhk5tDWbgECam6kRAYGMHNqaTUAgzc3UiIBARg5tzSYgkOZmakRAICOHtmYTEEhzMzUiIJCRQ1uzCQikuZkaERDIyKGt2QQE0txMjQgIZOTQ1mwCAmlupkYEBDJyaGs2AYE0N1MjAgIZObQ1m4BAmpupEQGBjBzamk1AIM3N1IiAQEYObc0mIJDmZmpEQCAjh7ZmExBIczM1IiCQkUNbswkIpLmZGhEQyMihrdkEBNLcTI0ICGTk0NZsAgJpbqZGBAQycmhrNgGBNDdTIwICGTm0NZuAQJqbqREBgYwc2ppNQCDNzdSIgEBGDm3NJiCQ5mZqREAgI4e2ZhMQSHMzNSIgkJFDW7MJCKS5mRoREMjIoa3ZBATS3EyNCAhk5NDWbAICaW6mRgQEMnJoazYBgTQ3UyMCAhk5tDWbgECam6kRAYGMHNqaTUAgzc3UiIBARg5tzSYgkOZmakRAICOHtmYTEEhzMzUiIJCRQ1uzCQikuZkaERDIyKGt2QQE0txMjQgIZOTQ1mwCAmlupkYEBDJyaGs2AYE0N1MjAgIZObQ1m4BAmpupEQGBjBzamk1AIM3N1IiAQEYObc0mIJDmZmpEQCAjh7ZmExBIczM1IiCQkUNbswkIpLmZGhEQyMihrdkEBNLcTI0ICGTk0NZsAgJpbqZGBAQycmhrNgGBNDdTIwICGTm0NZuAQJqbqREBgYwc2ppNQCDNzdSIgEBGDm3NJiCQ5mZqREAgI4e2ZhMQSHMzNSIgkJFDW7MJCKS5mRoR+AErVADJkrjltgAAAABJRU5ErkJggg==';
    List<int> imageData = base64Decode(base64Image);

    var cellNombre = sheet.getRangeByIndex(jsonStr.length + 6 + beginRow,1);
    cellNombre.setText('NOMBRE');
    cellNombre.cellStyle.bold = true;
    var cell = sheet.getRangeByIndex(jsonStr.length + 7 + beginRow,1);
    cell.setText(dataGuard.length == 1?  dataGuard[0]['name'] : 'S/N');

    var cellObservacion = sheet.getRangeByIndex(jsonStr.length + 8 + beginRow,1);
    cellObservacion.setText('OBSERVACIONES');
    cellObservacion.cellStyle.bold = true;
    for (var i = 0; i < jsonStrObs.length; i++) {
      var cell2 = sheet.getRangeByIndex(jsonStr.length + 9 + i + beginRow,1);
      cell2.setText( jsonStrObs[i]['date']+' - '+jsonStrObs[i]['observation']);
      Range obs =   sheet.getRangeByName('A${jsonStr.length + 9 + i + beginRow}:D${jsonStr.length + 9 + i + beginRow}');
      obs.merge();
    }
    var cell3 = sheet.getRangeByIndex(jsonStr.length + 6 + beginRow,6);
    cell3.cellStyle.bold = true;
    cell3.setText( 'FIRMA');
    final Picture picture = sheet.pictures.addStream(jsonStr.length + 7 + beginRow, 6, imageData);
    picture.width = 140; // Ancho de la imagen en unidades de 1/256 de un carácter
    picture.height = 70; // Altura de la imagen en unidades de 1/20 de un punto
  } else {
    //COMEDOR

    // AJUSTANDO TITULO
    sheet.getRangeByIndex(2,4).setText('CONTROL DEL COMEDOR DE EMPLEADOS'); // Fusionar celdas
    final Range rangeTitle = sheet.getRangeByName('D2:H2');
    rangeTitle.cellStyle.bold = true;
    rangeTitle.cellStyle.fontSize = 16;
    rangeTitle.merge();
    rangeTitle.cellStyle.hAlign = HAlignType.center;
    rangeTitle.cellStyle.vAlign = VAlignType.center;
    var cellObservacion = sheet.getRangeByIndex(jsonStr.length + 8 + beginRow,1);
    cellObservacion.setText('OBSERVACION(ES)');
    cellObservacion.cellStyle.bold = true;
    for (var i = 0; i < jsonStrObs.length; i++) {
      var cell2 = sheet.getRangeByIndex(jsonStr.length + 9 + i + beginRow,1);
      cell2.setText(jsonStrObs[i]['description']);
      Range obs =   sheet.getRangeByName('A${jsonStr.length + 9 + i + beginRow}:E${jsonStr.length + 9 + i + beginRow}');
      obs.merge();
    }
    
    var cellComentarios = sheet.getRangeByIndex(beginRow-1,7);
    cellComentarios.setText('COMENTARIOS');
    cellComentarios.cellStyle.bold = true;
    var headComentarios4 = sheet.getRangeByIndex(beginRow,7);
    headComentarios4.setText('Numero de empleado');
    headComentarios4.cellStyle.bold = true;
    var headComentarios1 = sheet.getRangeByIndex(beginRow,8);
    headComentarios1.setText('Calificación');
    headComentarios1.cellStyle.bold = true;
    var headComentarios3 = sheet.getRangeByIndex(beginRow,9);
    headComentarios3.setText('Comentario');
    headComentarios3.cellStyle.bold = true;
    var headComentarios2 = sheet.getRangeByIndex(beginRow,10);
    headComentarios2.setText('¿Que platillo le gustaría?');
    headComentarios2.cellStyle.bold = true;
    

    if (dataComments != null) {
      for (var i = 0; i < dataComments.length; i++) {
        var cell1 = sheet.getRangeByIndex(beginRow + (i+1),7);
        cell1.setText(dataComments[i]['employee_num']);
        var cell2 = sheet.getRangeByIndex(beginRow + (i+1),8);
        cell2.setText(dataComments[i]['rate']);
        var cell4 = sheet.getRangeByIndex(beginRow + (i+1),9);
        cell4.setText(dataComments[i]['comment']);
        var cell3 = sheet.getRangeByIndex(beginRow + (i+1),10);
        cell3.setText(dataComments[i]['suggestion']);
      }

      sheet.autoFitColumn(7);
      sheet.autoFitColumn(8);
      sheet.autoFitColumn(9);
      sheet.autoFitColumn(10);
      
    } else {
      var cell3 = sheet.getRangeByIndex(6,7);
      cell3.setText("No hay comentarios registrados");
    }
    

    var cellComida = sheet.getRangeByIndex(beginRow-1,13);
    cellComida.setText('COMPARAR COMIDA');
    cellComida.cellStyle.bold = true;
    var cellComida1 = sheet.getRangeByIndex(beginRow,13);
    cellComida1.setText('Fecha');
    cellComida1.cellStyle.bold = true;
    var cellComida2 = sheet.getRangeByIndex(beginRow,14);
    cellComida2.setText('Comida que se presento');
    cellComida2.cellStyle.bold = true;
    var cellComida3 = sheet.getRangeByIndex(beginRow,15);
    cellComida3.setText('Comida que se sirvio');
    cellComida3.cellStyle.bold = true;
    

    if (jsonStrFood != null) {
      for (var i = 0; i < jsonStrFood.length; i++) {
        var cell0 = sheet.getRangeByIndex(beginRow + (i+1),13);
        cell0.setText(jsonStrFood[i]['fecha']);
        var cell1 = sheet.getRangeByIndex(beginRow + (i+1),14);
        cell1.setText(jsonStrFood[i]['menu_portal']);
        var cell2 = sheet.getRangeByIndex(beginRow + (i+1),15);
        cell2.setText(jsonStrFood[i]['menu_movil']);
      }

      sheet.autoFitColumn(13);
      sheet.autoFitColumn(14);
      sheet.autoFitColumn(15);
      
    } else {
      var cell3 = sheet.getRangeByIndex(6,13);
      cell3.setText("No hay comidas registradas");
    }


  }
  

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