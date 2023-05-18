import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';


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


Future<void> jsonToExcel(String jsonStr, String fileName, BuildContext context) async {
  bool storagePermissionGranted = false;
  if (Platform.isAndroid || Platform.isIOS) {
  await requestPermission((bool granted) {
    storagePermissionGranted = granted;
  }); 
   
  if (!storagePermissionGranted) {
    throw Exception('No se han concedido los permisos de almacenamiento.');
  }

  // Decodifica el JSON
  final List<Map<String, dynamic>> json = List<Map<String, dynamic>>.from(jsonDecode(jsonStr));
  
  // Crea el archivo Excel
  final workbook = Workbook();
  final sheet = workbook.worksheets[0];
// Agrega las celdas de encabezado



List<String> headers = json[0].keys.toList();
for (var i = 0; i < headers.length; i++) {
  sheet.getRangeByIndex(1, i+1).setText(headers[i]);
}

for (var i = 0; i < json.length; i++) {
  var keys = json[i].keys.toList();
  var values = json[i].values.toList();
  for (var j = 0; j < keys.length; j++) {
    var cell = sheet.getRangeByIndex(i + 2, j + 1);
    cell.setText(values[j].toString());
  }
}

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

String? path =  await pickDownloadDirectory(context);

  Directory directory = Directory(path!);
    if (await directory.exists()) {
     final file = File('$path/$fileName');  
     try {
      
      await file.writeAsBytes(workbook.saveAsStream());
      ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Archivo guardado en $file')),
      );
      Navigator.pop(context);

     } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$e')),
      );
      Navigator.pop(context);
     }
     
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('La carpeta seleccionada no existe')),
    );
      //path = await getDownloadDirectoryPath();
    }
      
    }
}