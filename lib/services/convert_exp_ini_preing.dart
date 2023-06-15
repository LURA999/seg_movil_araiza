import 'dart:ffi';
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
  double height = 75;
  double heightReng = 20;
  double heightTabIll = 55;


pw.Container BuildTableAccident_Illness() {
  return pw.Container(
    child: pw.Column(
      children: [
        pw.Row(
          children: [
            pw.SizedBox(
              width: MediaQuery.of(context).size.width * .2,
              child: pw.Container(
                alignment: pw.Alignment.center,
                child: pw.Text(
                  'Nombre de la empresa',
                  style: const pw.TextStyle(fontSize: 12),
                  textAlign: pw.TextAlign.center,
                ),
                height: height,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(
                    color: PdfColors.black,
                    width: 1,
                  ),
                ),
              ),
            ),
            pw.SizedBox(
              width: MediaQuery.of(context).size.width * .2,
              child: pw.Container(
                alignment: pw.Alignment.center,
                child: pw.Text(
                  'Fecha',
                  style: const pw.TextStyle(fontSize: 12),
                  textAlign: pw.TextAlign.center,
                ),
                height: height,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(
                    color: PdfColors.black,
                    width: 1,
                  ),
                ),
              ),
            ),
            pw.SizedBox(
              width: MediaQuery.of(context).size.width * .2,
              child: pw.Container(
                alignment: pw.Alignment.center,
                child: pw.Text(
                  'Puesto',
                  style: const pw.TextStyle(fontSize: 12),
                  textAlign: pw.TextAlign.center,
                ),
                height: height,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(
                    color: PdfColors.black,
                    width: 1,
                  ),
                ),
              ),
            ),
            pw.Expanded(
              child: pw.Column(children: [
              pw.Row(children: 
              [
                pw.SizedBox(
                  width: MediaQuery.of(context).size.width * .2,
                  child: pw.Container(
                    alignment: pw.Alignment.center,
                    child: pw.Text(
                      'Causa',
                      style: const pw.TextStyle(fontSize: 12),
                      textAlign: pw.TextAlign.center,
                    ),
                    height: 50,
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(
                        color: PdfColors.black,
                        width: 1,
                      ),
                    ),
                  )
                ),
                pw.SizedBox(
                  width: MediaQuery.of(context).size.width * .2,
                  child: pw.Container(
                  alignment: pw.Alignment.center,
                  child: pw.Text(
                    'Nombre de la lesión o enfermedad',
                    style: const pw.TextStyle(fontSize: 12),
                    textAlign: pw.TextAlign.center,
                  ),
                  height: 50,
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(
                      color: PdfColors.black,
                      width: 1,
                    ),
                  ),
                ),
              ),
              pw.SizedBox(
                  width: MediaQuery.of(context).size.width * .2,
                child: pw.Container(
                alignment: pw.Alignment.center,
                child: pw.Text(
                  'Incapacidad',
                  style: const pw.TextStyle(fontSize: 12),
                  textAlign: pw.TextAlign.center,
                ),
                height: 50,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(
                    color: PdfColors.black,
                    width: 1,
                  ),
                ),
              ),
              ),
              pw.SizedBox(
                  width: MediaQuery.of(context).size.width * .2,
                child: pw.Container(
                alignment: pw.Alignment.bottomCenter,
                child: pw.Text(
                  'Número de dias de incapacidad',
                  style: const pw.TextStyle(fontSize: 12),
                  textAlign: pw.TextAlign.center,
                ),
                height: 50,
                decoration: const pw.BoxDecoration(
                      border:  pw.Border(
                      top:pw.BorderSide(width: 1, color: PdfColors.black),
                      left:pw.BorderSide(width: 1, color: PdfColors.black),
                      right:pw.BorderSide(width: 1, color: PdfColors.black),
                    ),
                  ),
                ),
              ),
              ]
              ),
              pw.Row(
                children: [
                  pw.SizedBox(
                    width: MediaQuery.of(context).size.width * .1,
                    child: pw.Container(
                      alignment: pw.Alignment.center,
                      child: pw.Text(
                        'Enf',
                        style: const pw.TextStyle(fontSize: 7),
                        textAlign: pw.TextAlign.center,
                      ),
                      height: 25,
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(
                          color: PdfColors.black,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                  pw.SizedBox(
                    width: MediaQuery.of(context).size.width * .1,
                    child: pw.Container(
                      alignment: pw.Alignment.center,
                      child: pw.Text(
                        'Acc',
                        style: const pw.TextStyle(fontSize: 7),
                        textAlign: pw.TextAlign.center,
                      ),
                      height: 25,
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(
                          color: PdfColors.black,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                  pw.SizedBox(
                    width: MediaQuery.of(context).size.width * .2,
                    child: pw.Container(
                      alignment: pw.Alignment.center,
                      child: pw.Text(
                        '',
                        style: const pw.TextStyle(fontSize: 7),
                        textAlign: pw.TextAlign.center,
                      ),
                      height: 25,
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(
                          color: PdfColors.black,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                  pw.SizedBox(
                    width: MediaQuery.of(context).size.width * .1,
                    child: pw.Container(
                      alignment: pw.Alignment.center,
                      child: pw.Text(
                        'Si',
                        style: const pw.TextStyle(fontSize: 7),
                        textAlign: pw.TextAlign.center,
                      ),
                      height: 25,
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(
                          color: PdfColors.black,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                  pw.SizedBox(
                     width: MediaQuery.of(context).size.width * .1,
                    child: pw.Container(
                      alignment: pw.Alignment.center,
                      child: pw.Text(
                        'No',
                        style: const pw.TextStyle(fontSize: 7),
                        textAlign: pw.TextAlign.center,
                      ),
                      height: 25,
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(
                          color: PdfColors.black,
                          width: 1,
                        ),
                      ),
                    ),
                  ), pw.SizedBox(
                      width: MediaQuery.of(context).size.width * .2,
                    child: pw.Container(
                    alignment: pw.Alignment.center,
                    child: pw.Text(
                      '',
                      style: const pw.TextStyle(fontSize: 12),
                      textAlign: pw.TextAlign.center,
                    ),
                    height: 25,
                    decoration: const pw.BoxDecoration(
                      border:  pw.Border(
                        bottom:pw.BorderSide(width: 1, color: PdfColors.black),
                        left:pw.BorderSide(width: 1, color: PdfColors.black),
                        right:pw.BorderSide(width: 1, color: PdfColors.black),
                      ),
                    ),
                  ),)
                ])
              ])
            ),
          ],
        ),
        ...List<pw.Row>.generate(4, (int index) {  
        return pw.Row(
        children: [
          pw.SizedBox(
            width: MediaQuery.of(context).size.width * .2,
            child: pw.Container(
              alignment: pw.Alignment.center,
              child: pw.Text(
                '',
                style: const pw.TextStyle(fontSize: 7),
                textAlign: pw.TextAlign.center,
              ),
              height: heightReng,
              decoration: pw.BoxDecoration(
                border: pw.Border.all(
                  color: PdfColors.black,
                  width: 1,
                ),
              ),
            ),
          ),
          pw.SizedBox(
            width: MediaQuery.of(context).size.width * .2,
            child: pw.Container(
              alignment: pw.Alignment.center,
              child: pw.Text(
                '',
                style: const pw.TextStyle(fontSize: 7),
                textAlign: pw.TextAlign.center,
              ),
              height: heightReng,
              decoration: pw.BoxDecoration(
                border: pw.Border.all(
                  color: PdfColors.black,
                  width: 1,
                ),
              ),
            ),
          ),
          pw.SizedBox(
            width: MediaQuery.of(context).size.width * .2,
            child: pw.Container(
              alignment: pw.Alignment.center,
              child: pw.Text(
                '',
                style: const pw.TextStyle(fontSize: 7),
                textAlign: pw.TextAlign.center,
              ),
              height: heightReng,
              decoration: pw.BoxDecoration(
                border: pw.Border.all(
                  color: PdfColors.black,
                  width: 1,
                ),
              ),
            ),
          ),
          pw.SizedBox(
            width: MediaQuery.of(context).size.width * .1,
            child: pw.Container(
              alignment: pw.Alignment.center,
              child: pw.Text(
                '',
                style: const pw.TextStyle(fontSize: 7),
                textAlign: pw.TextAlign.center,
              ),
              height: heightReng,
              decoration: pw.BoxDecoration(
                border: pw.Border.all(
                  color: PdfColors.black,
                  width: 1,
                ),
              ),
            ),
          ),
          pw.SizedBox(
            width: MediaQuery.of(context).size.width * .1,
            child: pw.Container(
              alignment: pw.Alignment.center,
              child: pw.Text(
                '',
                style: const pw.TextStyle(fontSize: 7),
                textAlign: pw.TextAlign.center,
              ),
              height: heightReng,
              decoration: pw.BoxDecoration(
                border: pw.Border.all(
                  color: PdfColors.black,
                  width: 1,
                ),
              ),
            ),
          ),
          pw.SizedBox(
            width: MediaQuery.of(context).size.width * .2,
            child: pw.Container(
              alignment: pw.Alignment.center,
              child: pw.Text(
                '',
                style: const pw.TextStyle(fontSize: 7),
                textAlign: pw.TextAlign.center,
              ),
              height: heightReng,
              decoration: pw.BoxDecoration(
                border: pw.Border.all(
                  color: PdfColors.black,
                  width: 1,
                ),
              ),
            ),
          ),
          pw.SizedBox(
            width: MediaQuery.of(context).size.width * .1,
            child: pw.Container(
              alignment: pw.Alignment.center,
              child: pw.Text(
                '',
                style: const pw.TextStyle(fontSize: 7),
                textAlign: pw.TextAlign.center,
              ),
              height: heightReng,
              decoration: pw.BoxDecoration(
                border: pw.Border.all(
                  color: PdfColors.black,
                  width: 1,
                ),
              ),
            ),
          ),
          pw.SizedBox(
            width: MediaQuery.of(context).size.width * .1,
            child: pw.Container(
              alignment: pw.Alignment.center,
              child: pw.Text(
                '',
                style: const pw.TextStyle(fontSize: 7),
                textAlign: pw.TextAlign.center,
              ),
              height: heightReng,
              decoration: pw.BoxDecoration(
                border: pw.Border.all(
                  color: PdfColors.black,
                  width: 1,
                ),
              ),
            ),
          ),
          pw.SizedBox(
            width: MediaQuery.of(context).size.width * .2,
            child: pw.Container(
              alignment: pw.Alignment.center,
              child: pw.Text(
                '',
                style: const pw.TextStyle(fontSize: 7),
                textAlign: pw.TextAlign.center,
              ),
              height: heightReng,
              decoration: pw.BoxDecoration(
                border: pw.Border.all(
                  color: PdfColors.black,
                  width: 1,
                ),
              ),
            ),
          )
        ]);
        })
      ],
    ),
  );
}

 pw.Container buildTableEmployment_History() {
  return pw.Container(
    child: pw.Column(
      children: [
        pw.Row(
          children: [
            pw.SizedBox(
              width: MediaQuery.of(context).size.width * .2,
              child: pw.Container(
                alignment: pw.Alignment.center,
                child: pw.Text(
                  'Empresa',
                  style: const pw.TextStyle(fontSize: 12),
                ),
                height: height,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(
                    color: PdfColors.black,
                    width: 1,
                  ),
                ),
              ),
            ),
            pw.SizedBox(
              width: MediaQuery.of(context).size.width * .2,
              child: pw.Container(
                alignment: pw.Alignment.center,
                child: pw.Text(
                  'Puestos',
                  style: const pw.TextStyle(fontSize: 7),
                ),
                height: height,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(
                    color: PdfColors.black,
                    width: 1,
                  ),
                ),
              ),
            ),
            pw.SizedBox(
              width: MediaQuery.of(context).size.width * .2,
              child: pw.Container(
                alignment: pw.Alignment.center,
                child: pw.Text(
                  'Tiempo',
                  style: const pw.TextStyle(fontSize: 7),
                ),
                height: height,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(
                    color: PdfColors.black,
                    width: 1,
                  ),
                ),
              ),
            ),
            pw.Expanded(
              child: pw.Column(children: [
              pw.Container(
                alignment: pw.Alignment.center,
                child: pw.Text(
                  'Para ser llenado solo por el médico',
                  style: const pw.TextStyle(fontSize: 12),
                ),
                height: 20,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(
                    color: PdfColors.black,
                    width: 1,
                  ),
                ),
              ),
              pw.Row(
                children: [
                  pw.Expanded(
                    child: pw.Container(
                      alignment: pw.Alignment.center,
                      child: pw.Text(
                        'Cuando salió',
                        style: const pw.TextStyle(fontSize: 7),
                        textAlign: pw.TextAlign.center,
                      ),
                      height: 55,
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(
                          color: PdfColors.black,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                  pw.Expanded(
                    // width: MediaQuery.of(context).size.width * .2,
                    child: pw.Container(
                      alignment: pw.Alignment.center,
                      child: pw.Text(
                        'Rotación de puesto',
                        style: const pw.TextStyle(fontSize: 7),
                        textAlign: pw.TextAlign.center,
                      ),
                      height: 55,
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(
                          color: PdfColors.black,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                  pw.Expanded(
                    // width: MediaQuery.of(context).size.width * .2,
                    child: pw.Container(
                      alignment: pw.Alignment.center,
                      child: pw.Text(
                        'Químicos Solventes',
                        style: const pw.TextStyle(fontSize: 7),
                        textAlign: pw.TextAlign.center,
                      ),
                      height: 55,
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(
                          color: PdfColors.black,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                  pw.Expanded(
                    // width: MediaQuery.of(context).size.width * .2,
                    child: pw.Container(
                      alignment: pw.Alignment.center,
                      child: pw.Text(
                        'Humos',
                        style: const pw.TextStyle(fontSize: 7),
                        textAlign: pw.TextAlign.center,
                      ),
                      height: 55,
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(
                          color: PdfColors.black,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                  pw.Expanded(
                    // width: MediaQuery.of(context).size.width * .2,
                    child: pw.Container(
                      alignment: pw.Alignment.center,
                      child: pw.Text(
                        'Vapores',
                        style: const pw.TextStyle(fontSize: 7),
                        textAlign: pw.TextAlign.center,
                      ),
                      height: 55,
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(
                          color: PdfColors.black,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                  pw.Expanded(
                    // width: MediaQuery.of(context).size.width * .2,
                    child: pw.Container(
                      alignment: pw.Alignment.center,
                      child: pw.Text(
                        'Polvos',
                        style: const pw.TextStyle(fontSize: 7),
                        textAlign: pw.TextAlign.center,
                      ),
                      height: 55,
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(
                          color: PdfColors.black,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                  pw.Expanded(
                    // width: MediaQuery.of(context).size.width * .2,
                    child: pw.Container(
                      alignment: pw.Alignment.center,
                      child: pw.Text(
                        'Ruido',
                        style: const pw.TextStyle(fontSize: 7),
                        textAlign: pw.TextAlign.center,
                      ),
                      height: 55,
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(
                          color: PdfColors.black,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Container(
                      alignment: pw.Alignment.center,
                      child: pw.Text(
                        'Carga de material',
                        style: const pw.TextStyle(fontSize: 7),
                        textAlign: pw.TextAlign.center,
                      ),
                      height: 55,
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(
                          color: PdfColors.black,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                ])
              ])
            ),
          ],
        ),
        ...List<pw.Row>.generate(4, (int index) {  
        return pw.Row(
        children: [
          pw.SizedBox(
            width: MediaQuery.of(context).size.width * .2,
            child: pw.Container(
              alignment: pw.Alignment.center,
              child: pw.Text(
                '',
                style: const pw.TextStyle(fontSize: 7),
                textAlign: pw.TextAlign.center,
              ),
              height: heightReng,
              decoration: pw.BoxDecoration(
                border: pw.Border.all(
                  color: PdfColors.black,
                  width: 1,
                ),
              ),
            ),
          ),
          pw.SizedBox(
            width: MediaQuery.of(context).size.width * .2,
            child: pw.Container(
              alignment: pw.Alignment.center,
              child: pw.Text(
                '',
                style: const pw.TextStyle(fontSize: 7),
                textAlign: pw.TextAlign.center,
              ),
              height: heightReng,
              decoration: pw.BoxDecoration(
                border: pw.Border.all(
                  color: PdfColors.black,
                  width: 1,
                ),
              ),
            ),
          ),
          pw.SizedBox(
            width: MediaQuery.of(context).size.width * .2,
            child: pw.Container(
              alignment: pw.Alignment.center,
              child: pw.Text(
                '',
                style: const pw.TextStyle(fontSize: 7),
                textAlign: pw.TextAlign.center,
              ),
              height: heightReng,
              decoration: pw.BoxDecoration(
                border: pw.Border.all(
                  color: PdfColors.black,
                  width: 1,
                ),
              ),
            ),
          ),
          pw.Expanded(
            child: pw.Container(
              alignment: pw.Alignment.center,
              child: pw.Text(
                '',
                style: const pw.TextStyle(fontSize: 7),
                textAlign: pw.TextAlign.center,
              ),
              height: heightReng,
              decoration: pw.BoxDecoration(
                border: pw.Border.all(
                  color: PdfColors.black,
                  width: 1,
                ),
              ),
            ),
          ),
          pw.Expanded(
            // width: MediaQuery.of(context).size.width * .2,
            child: pw.Container(
              alignment: pw.Alignment.center,
              child: pw.Text(
                '',
                style: const pw.TextStyle(fontSize: 7),
                textAlign: pw.TextAlign.center,
              ),
              height: heightReng,
              decoration: pw.BoxDecoration(
                border: pw.Border.all(
                  color: PdfColors.black,
                  width: 1,
                ),
              ),
            ),
          ),
          pw.Expanded(
            // width: MediaQuery.of(context).size.width * .2,
            child: pw.Container(
              alignment: pw.Alignment.center,
              child: pw.Text(
                '',
                style: const pw.TextStyle(fontSize: 7),
                textAlign: pw.TextAlign.center,
              ),
              height: heightReng,
              decoration: pw.BoxDecoration(
                border: pw.Border.all(
                  color: PdfColors.black,
                  width: 1,
                ),
              ),
            ),
          ),
          pw.Expanded(
            // width: MediaQuery.of(context).size.width * .2,
            child: pw.Container(
              alignment: pw.Alignment.center,
              child: pw.Text(
                '',
                style: const pw.TextStyle(fontSize: 7),
                textAlign: pw.TextAlign.center,
              ),
              height: heightReng,
              decoration: pw.BoxDecoration(
                border: pw.Border.all(
                  color: PdfColors.black,
                  width: 1,
                ),
              ),
            ),
          ),
          pw.Expanded(
            // width: MediaQuery.of(context).size.width * .2,
            child: pw.Container(
              alignment: pw.Alignment.center,
              child: pw.Text(
                '',
                style: const pw.TextStyle(fontSize: 7),
                textAlign: pw.TextAlign.center,
              ),
              height: heightReng,
              decoration: pw.BoxDecoration(
                border: pw.Border.all(
                  color: PdfColors.black,
                  width: 1,
                ),
              ),
            ),
          ),
          pw.Expanded(
            // width: MediaQuery.of(context).size.width * .2,
            child: pw.Container(
              alignment: pw.Alignment.center,
              child: pw.Text(
                '',
                style: const pw.TextStyle(fontSize: 7),
                textAlign: pw.TextAlign.center,
              ),
              height: heightReng,
              decoration: pw.BoxDecoration(
                border: pw.Border.all(
                  color: PdfColors.black,
                  width: 1,
                ),
              ),
            ),
          ),
          pw.Expanded(
            // width: MediaQuery.of(context).size.width * .2,
            child: pw.Container(
              alignment: pw.Alignment.center,
              child: pw.Text(
                '',
                style: const pw.TextStyle(fontSize: 7),
                textAlign: pw.TextAlign.center,
              ),
              height: heightReng,
              decoration: pw.BoxDecoration(
                border: pw.Border.all(
                  color: PdfColors.black,
                  width: 1,
                ),
              ),
            ),
          ),
          pw.Expanded(
            child: pw.Container(
              alignment: pw.Alignment.center,
              child: pw.Text(
                '',
                style: const pw.TextStyle(fontSize: 7),
                textAlign: pw.TextAlign.center,
              ),
              height: heightReng,
              decoration: pw.BoxDecoration(
                border: pw.Border.all(
                  color: PdfColors.black,
                  width: 1,
                ),
              ),
            ),
          ),
        ]);
        })
      ],
    ),
  );
}
pdf.addPage(
  pw.Page(
    pageFormat: PdfPageFormat.letter,
    margin: pw.EdgeInsets.all(20),
    build: (pw.Context context) {
      return pw.Center(
        child: pw.Column(children: [
          pw.Header(level:5,text: '2.- HISTORIAL LABORAL'),
          buildTableEmployment_History(),
          pw.Header(level:5,text: '3.- ACCIDENTES Y ENFERMEDADES DE TRABAJO Anote SOLO Accidentes de trabajo'),
          BuildTableAccident_Illness()
        ])
        
      );
    },
  ),
);



final Uint8List bytes = await pdf.save();
  var fileName = "tabla_medico";

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





