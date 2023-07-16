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


Future<void> jsonToExcel(List<Map<String, dynamic>> jsonStr, List<String> headersPerso, String fileName, BuildContext context) async {
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
  
  String base64Image = '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';

List<int> imageData = base64Decode(base64Image);
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
  pictureLogo.width = 150; // Ancho de la imagen en unidades de 1/256 de un carácter
  pictureLogo.height = 90; 
  
  // AJUSTANDO TITULO
  sheet.getRangeByIndex(2,3).setText('CONTROL DE VEHICULOS EMPLEADOS');
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
  
  var cell = sheet.getRangeByIndex(jsonStr.length + 7 + beginRow,1);
  cell.setText('JORGE ALONSO LUNA RIVERA');

  var cell2 = sheet.getRangeByIndex(jsonStr.length + 8 + beginRow,1);
  cell2.setText('ESTA ES UNA DESCRIPCION');

  var cell3 = sheet.getRangeByIndex(jsonStr.length + 6 + beginRow,7);
  final Picture picture = sheet.pictures.addStream(jsonStr.length + 6 + beginRow, 7, imageData);
  cell3.setText( 'FIRMA');
  picture.width = 120; // Ancho de la imagen en unidades de 1/256 de un carácter
  picture.height = 60; // Altura de la imagen en unidades de 1/20 de un punto

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