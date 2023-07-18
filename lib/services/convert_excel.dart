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


Future<void> jsonToExcel(List<Map<String, dynamic>> jsonStr, List<String> headersPerso,List<Map<String, dynamic>> jsonStrObs, List<Map<String,dynamic>>? dataGuard, int Screen, String fileName, BuildContext context) async {
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
  pictureLogo.width = 160; // Ancho de la imagen en unidades de 1/256 de un carácter
  pictureLogo.height = 90; 
  
  // AJUSTANDO TITULO
  sheet.getRangeByIndex(2,3).setText('');
  // Fusionar celdas
  final Range rangeTitle = sheet.getRangeByName('B2:F2');
  rangeTitle.cellStyle.bold = true;
  rangeTitle.cellStyle.fontSize = 16;
  rangeTitle.merge();
  rangeTitle.cellStyle.hAlign = HAlignType.center;
  rangeTitle.cellStyle.vAlign = VAlignType.center;

  //AJUSTANDO FECHA
  sheet.getRangeByIndex(4,7).setText('Fecha: $formattedDate');

  // Agrega las celdas de encabezado
  List<String> headers = jsonStr[0].keys.toList();
  for (var i = 0; i < headers.length; i++) {
   final Range header = sheet.getRangeByIndex(beginRow, i+1);
   header.setText(headersPerso[i]);
   header.cellStyle.bold = true;
  }

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
  if (Screen == 1) {
    // AJUSTANDO TITULO
    sheet.getRangeByIndex(2,3).setText('CONTROL DE VEHICULOS EMPLEADOS');
    String base64Image = dataGuard![0]['sign'] ?? 'iVBORw0KGgoAAAANSUhEUgAAAMgAAADICAYAAACtWK6eAAAAAXNSR0IArs4c6QAABSJJREFUeF7t1bERwDAMxLB4/6UzgV2wfaRXIci8nM9HgMBV4LAhQOAuIBCvg8BDQCCeBwGBeAMEmoA/SHMzNSIgkJFDW7MJCKS5mRoREMjIoa3ZBATS3EyNCAhk5NDWbAICaW6mRgQEMnJoazYBgTQ3UyMCAhk5tDWbgECam6kRAYGMHNqaTUAgzc3UiIBARg5tzSYgkOZmakRAICOHtmYTEEhzMzUiIJCRQ1uzCQikuZkaERDIyKGt2QQE0txMjQgIZOTQ1mwCAmlupkYEBDJyaGs2AYE0N1MjAgIZObQ1m4BAmpupEQGBjBzamk1AIM3N1IiAQEYObc0mIJDmZmpEQCAjh7ZmExBIczM1IiCQkUNbswkIpLmZGhEQyMihrdkEBNLcTI0ICGTk0NZsAgJpbqZGBAQycmhrNgGBNDdTIwICGTm0NZuAQJqbqREBgYwc2ppNQCDNzdSIgEBGDm3NJiCQ5mZqREAgI4e2ZhMQSHMzNSIgkJFDW7MJCKS5mRoREMjIoa3ZBATS3EyNCAhk5NDWbAICaW6mRgQEMnJoazYBgTQ3UyMCAhk5tDWbgECam6kRAYGMHNqaTUAgzc3UiIBARg5tzSYgkOZmakRAICOHtmYTEEhzMzUiIJCRQ1uzCQikuZkaERDIyKGt2QQE0txMjQgIZOTQ1mwCAmlupkYEBDJyaGs2AYE0N1MjAgIZObQ1m4BAmpupEQGBjBzamk1AIM3N1IiAQEYObc0mIJDmZmpEQCAjh7ZmExBIczM1IiCQkUNbswkIpLmZGhEQyMihrdkEBNLcTI0ICGTk0NZsAgJpbqZGBAQycmhrNgGBNDdTIwICGTm0NZuAQJqbqREBgYwc2ppNQCDNzdSIgEBGDm3NJiCQ5mZqREAgI4e2ZhMQSHMzNSIgkJFDW7MJCKS5mRoREMjIoa3ZBATS3EyNCAhk5NDWbAICaW6mRgQEMnJoazYBgTQ3UyMCAhk5tDWbgECam6kRAYGMHNqaTUAgzc3UiIBARg5tzSYgkOZmakRAICOHtmYTEEhzMzUiIJCRQ1uzCQikuZkaERDIyKGt2QQE0txMjQgIZOTQ1mwCAmlupkYEBDJyaGs2AYE0N1MjAgIZObQ1m4BAmpupEQGBjBzamk1AIM3N1IiAQEYObc0mIJDmZmpEQCAjh7ZmExBIczM1IiCQkUNbswkIpLmZGhEQyMihrdkEBNLcTI0ICGTk0NZsAgJpbqZGBAQycmhrNgGBNDdTIwICGTm0NZuAQJqbqREBgYwc2ppNQCDNzdSIgEBGDm3NJiCQ5mZqREAgI4e2ZhMQSHMzNSIgkJFDW7MJCKS5mRoREMjIoa3ZBATS3EyNCAhk5NDWbAICaW6mRgQEMnJoazYBgTQ3UyMCAhk5tDWbgECam6kRAYGMHNqaTUAgzc3UiIBARg5tzSYgkOZmakRAICOHtmYTEEhzMzUiIJCRQ1uzCQikuZkaERDIyKGt2QQE0txMjQgIZOTQ1mwCAmlupkYEBDJyaGs2AYE0N1MjAgIZObQ1m4BAmpupEQGBjBzamk1AIM3N1IiAQEYObc0mIJDmZmpEQCAjh7ZmExBIczM1IiCQkUNbswkIpLmZGhEQyMihrdkEBNLcTI0ICGTk0NZsAgJpbqZGBAQycmhrNgGBNDdTIwICGTm0NZuAQJqbqREBgYwc2ppNQCDNzdSIgEBGDm3NJiCQ5mZqREAgI4e2ZhMQSHMzNSIgkJFDW7MJCKS5mRoR+AErVADJkrjltgAAAABJRU5ErkJggg==';
    List<int> imageData = base64Decode(base64Image);

    var cellNombre = sheet.getRangeByIndex(jsonStr.length + 6 + beginRow,1);
    cellNombre.setText('NOMBRE');
    var cell = sheet.getRangeByIndex(jsonStr.length + 7 + beginRow,1);
    cell.setText(dataGuard[0]['name']);

    var cellObservacion = sheet.getRangeByIndex(jsonStr.length + 8 + beginRow,1);
    cellObservacion.setText('OBSERVACION(ES)');
    for (var i = 0; i < jsonStrObs.length; i++) {
      var cell2 = sheet.getRangeByIndex(jsonStr.length + 9 + i + beginRow,1);
      cell2.setText(jsonStrObs[i]['observation']);
      Range obs =   sheet.getRangeByName('A${jsonStr.length + 9 + i + beginRow}:E${jsonStr.length + 9 + i + beginRow}');
      obs.merge();
    }

    var cell3 = sheet.getRangeByIndex(jsonStr.length + 7 + beginRow,7);
    final Picture picture = sheet.pictures.addStream(jsonStr.length + 6 + beginRow, 7, imageData);
    cell3.setText( 'FIRMA');
    picture.width = 150; // Ancho de la imagen en unidades de 1/256 de un carácter
    picture.height = 90; // Altura de la imagen en unidades de 1/20 de un punto
  } else {
    //COMEDOR

    // AJUSTANDO TITULO
    sheet.getRangeByIndex(2,3).setText('CONTROL DEL COMEDOR DE EMPLEADOS');
    var cellObservacion = sheet.getRangeByIndex(jsonStr.length + 8 + beginRow,1);
    cellObservacion.setText('OBSERVACION(ES)');
    for (var i = 0; i < jsonStrObs.length; i++) {
      var cell2 = sheet.getRangeByIndex(jsonStr.length + 9 + i + beginRow,1);
      cell2.setText(jsonStrObs[i]['description']);
      Range obs =   sheet.getRangeByName('A${jsonStr.length + 9 + i + beginRow}:E${jsonStr.length + 9 + i + beginRow}');
      obs.merge();
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