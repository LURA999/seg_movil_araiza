import 'dart:async'; 
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


Future<void> jsonToExcel(List<Map<String, dynamic>> jsonStr, List<String> headers,List<Map<String, dynamic>> jsonStrObs, List<Map<String,dynamic>>? dataComments, String fileName, BuildContext context) async {
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
  DateTime dateToday = DateTime.now();
  var formatter =  DateFormat("yyyy-MM-dd");
  String formattedDate = formatter.format(dateToday);

  // Agrega las celdas de encabezado

  for (var i = 0; i < headers.length; i++) {
    if (i == 0) {
       final Range header = sheet.getRangeByIndex(1, i);
        header.setText(headers[i]);
        header.cellStyle.bold = true;
        header.cellStyle.fontSize = 26;
        header.cellStyle.fontName = 'Arial';
    } else if(i == headers.length-1) {
        final Range header = sheet.getRangeByIndex(1,1);
        header.setText(headers[i]);
        header.cellStyle.bold = true;
        header.cellStyle.fontSize = 20;
        header.cellStyle.fontName = 'Calibri (Cuerpo)';
        header.merge();
    }
   
  }

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