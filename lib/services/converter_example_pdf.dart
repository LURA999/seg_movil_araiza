import 'dart:io';
import 'dart:typed_data';
import 'package:app_seguimiento_movil/services/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';




void generatePDF( BuildContext context, bool save) async {
  
  bool storagePermissionGranted = false;
  if (Platform.isAndroid || Platform.isIOS) {
  await requestPermission((bool granted) {
    storagePermissionGranted = granted;
  }); 
   
  if (!storagePermissionGranted) {
    throw Exception('No se han concedido los permisos de almacenamiento.');
  }

  final pdf = pw.Document();
  // Cargar la fuente personalizada desde un archivo .ttf
  final fontData = await rootBundle.load('assets/fonts/Gotham-Font/GothamBold.ttf');
  final customFont = pw.Font.ttf(fontData.buffer.asByteData());

pw.Container buildTable() {
  return pw.Container(
    decoration: pw.BoxDecoration(
      border: pw.Border.all(width: 1, color: PdfColors.black),
    ),
    child: pw.Column(
      children: [
        pw.Row(
          children: [
            pw.Expanded(
              child: pw.Container(
                padding: pw.EdgeInsets.all(8),
                alignment: pw.Alignment.center,
                child: pw.Text('TABLA DE RESPUESTAS'),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black, width: 1)
                ),
              ),
            ),
          ],
        ),
        pw.Row(
          children: [
            pw.Expanded(
              child: pw.Container(
                padding: pw.EdgeInsets.all(8),
                alignment: pw.Alignment.center,
                child: pw.Text('Preguntas'),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black, width: 1)
                ), 
              ),
            ),
            pw.Expanded(
              child: pw.Container(
                padding: pw.EdgeInsets.all(8),
                alignment: pw.Alignment.center,
                child: pw.Text('Respuestas'),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black, width: 1)
                ),
              ),
            ),
          ],
        ),
        pw.Row(
          children: [
            pw.Expanded(
              child: pw.Container(
                padding: pw.EdgeInsets.all(8),
                alignment: pw.Alignment.center,
                child: pw.Text('Pregunta 1'),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black, width: 1)
                ),
              ),
            ),
            pw.Expanded(
              child: pw.Container(
                alignment: pw.Alignment.center,
                child: pw.Row(
                  children: [
                      pw.Expanded(
                        child: pw.Container(child: pw.Text('Falso'),
                        padding: const pw.EdgeInsets.all(8),
                        alignment: pw.Alignment.center,
                        decoration: pw.BoxDecoration(
                          border: pw.Border.all(color: PdfColors.black, width: 1),
                        ),
                      )
                    )
                    ,
                     pw.Expanded(
                        child: pw.Container(child: pw.Text('Verdadero'),
                        padding: const pw.EdgeInsets.all(8),
                        alignment: pw.Alignment.center,
                        decoration: pw.BoxDecoration(
                          border: pw.Border.all(color: PdfColors.black, width: 1)
                        ),
                      )
                    ),
                  ],
                )
              ),
            )
          ],
        ),
        // Agregar más filas según sea necesario
      ],
    ),
  );
}

pdf.addPage(
  pw.Page(
    build: (pw.Context context) {
      return pw.Center(
        child: buildTable(),
      );
    },
  ),
);


final Uint8List bytes = await pdf.save();
  var fileName = "personalizado2";

  if(save) {
    String? path =  await pickDownloadDirectory(context);
      Directory directory = Directory(path!);
        if (await directory.exists()) {
        final file = File('$path/$fileName.pdf');  
        try {
          await file.writeAsBytes(bytes);
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
    }else{
      String path = "";
      if (Platform.isAndroid) {
        path = await getDownloadDirectoryPath();
      } else if (Platform.isIOS) {
        path = (await getApplicationDocumentsDirectory()).path;
      } else {
        throw UnsupportedError('Plataforma no compatible');
      }
        final file = File('$path/$fileName.pdf');  
        await file.writeAsBytes(bytes);
    }
  }
}





