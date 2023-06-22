import 'dart:io';
import 'package:app_seguimiento_movil/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;




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
  final fontData = await rootBundle.load('assets/fonts/Gotham-Font/Gotham-Regular.ttf');
  final customFont = pw.Font.ttf(fontData.buffer.asByteData());
  
  double allFirstWidthTabHead = PdfPageFormat.letter.width * .12;
  double heightTabIlHead = PdfPageFormat.letter.height * 0.095 ;
  double heightReng = PdfPageFormat.letter.height * 0.025;
  pw.TextStyle capLetterStyle = pw.TextStyle(fontSize: 10,font: pw.Font.times());
  pw.TextStyle littleLetterStyle = pw.TextStyle(fontSize: 7,font: pw.Font.times());
  
  double widthLineTable = 0.5;
  
  pw.Container buildTableHereditaryBackground() {
    allFirstWidthTabHead = PdfPageFormat.letter.width * .085;

    List<Map<String,String>> family =[
        {'rowName': 'Padre:', 'Buena_salud': '','Mala_Salud': '', 'Finado': '','Alergia': '', 'Diabetes': '', 'Presion_alta':'','Colesterol':'','Enf_Corazon':'','Cancer':'','Anemia':''},
        {'rowName': 'Madre:', 'Buena_salud': '','Mala_Salud': '', 'Finado': '','Alergia': '', 'Diabetes': '', 'Presion_alta':'','Colesterol':'','Enf_Corazon':'','Cancer':'','Anemia':''},
        {'rowName': 'Hermanos:', 'Buena_salud': '','Mala_Salud': '', 'Finado': '','Alergia': '', 'Diabetes': '', 'Presion_alta':'','Colesterol':'','Enf_Corazon':'','Cancer':'','Anemia':''},
        {'rowName': '', 'Buena_salud': '','Mala_Salud': '', 'Finado': '','Alergia': '', 'Diabetes': '', 'Presion_alta':'','Colesterol':'','Enf_Corazon':'','Cancer':'','Anemia':''},
        {'rowName': 'Pareja:', 'Buena_salud': '','Mala_Salud': '', 'Finado': '','Alergia': '', 'Diabetes': '', 'Presion_alta':'','Colesterol':'','Enf_Corazon':'','Cancer':'','Anemia':''},
        {'rowName': 'Hijos:', 'Buena_salud': '','Mala_Salud': '', 'Finado': '','Alergia': '', 'Diabetes': '', 'Presion_alta':'','Colesterol':'','Enf_Corazon':'','Cancer':'','Anemia':''},
    ];

    return pw.Container(
    child: pw.Column(
      children: [
        pw.Row(
          children: [
            pw.SizedBox(
              width: allFirstWidthTabHead,
              child: pw.Container(
                alignment: pw.Alignment.center,
                child: pw.Text(''),
                height: heightReng,
                padding: const pw.EdgeInsets.only(top: 5,bottom: 5),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.white)
                )
              ),
            ),
            pw.SizedBox(
              width: allFirstWidthTabHead,
              child: pw.Container(
                alignment: pw.Alignment.center,
                height: heightReng,
                padding: const pw.EdgeInsets.only(top: 5,bottom: 5),
                child: pw.Text('Buena\nsalud',
                style: capLetterStyle),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black, width: widthLineTable)
                ),
              ),
            ),
            pw.SizedBox(
              width: allFirstWidthTabHead,
              child: pw.Container(
                alignment: pw.Alignment.center,
                height: heightReng,
                padding: const pw.EdgeInsets.only(top: 5,bottom: 5),
                child: pw.Text('Mala\nsalud',
                style: capLetterStyle),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black, width: widthLineTable)
                ),
              ),
            ),
            pw.SizedBox(
              width: allFirstWidthTabHead,
              child: pw.Container(
                alignment: pw.Alignment.center,
                height: heightReng,
                padding: const pw.EdgeInsets.only(top: 5,bottom: 5),
                child: pw.Text('Finado',
                style: capLetterStyle),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black, width: widthLineTable)
                ),
              ),
            ),
            pw.SizedBox(
              width: allFirstWidthTabHead,
              child: pw.Container(
                alignment: pw.Alignment.center,
                height: heightReng,
                padding: const pw.EdgeInsets.only(top: 5,bottom: 5),
                child: pw.Text('Alergía',
                style: capLetterStyle),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black, width: widthLineTable)
                ),
              ),
            ),
            pw.SizedBox(
              width: allFirstWidthTabHead,
              child: pw.Container(
                alignment: pw.Alignment.center,
                height: heightReng,
                padding: const pw.EdgeInsets.only(top: 5,bottom: 5),
                child: pw.Text('Diabetes',
                style: capLetterStyle),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black, width: widthLineTable)
                ),
              ),
            ),
            pw.SizedBox(
              width: allFirstWidthTabHead,
              child: pw.Container(
                alignment: pw.Alignment.center,
                height: heightReng,
                padding: const pw.EdgeInsets.only(top: 5,bottom: 5),
                child: pw.Text('Presión\nAlta',
                style: capLetterStyle),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black, width: widthLineTable)
                ),
              ),
            ),
            pw.SizedBox(
              width: allFirstWidthTabHead,
              child: pw.Container(
                alignment: pw.Alignment.center,
                height: heightReng,
                padding: const pw.EdgeInsets.only(top: 5,bottom: 5),
                child: pw.Text('Colesterol',
                style: capLetterStyle),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black, width: widthLineTable)
                ),
              ),
            ),
            pw.SizedBox(
              width: allFirstWidthTabHead,
              child: pw.Container(
                alignment: pw.Alignment.center,
                height: heightReng,
                padding: const pw.EdgeInsets.only(top: 5,bottom: 5),
                child: pw.Text('Enf.\nCorazón',
                style: capLetterStyle),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black, width: widthLineTable)
                ),
              ),
            ),
            pw.SizedBox(
              width: allFirstWidthTabHead,
              child: pw.Container(
                alignment: pw.Alignment.center,
                height: heightReng,
                padding: const pw.EdgeInsets.only(top: 5,bottom: 5),
                child: pw.Text('Cáncer',
                style: capLetterStyle),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black, width: widthLineTable)
                ),
              ),
            ),
            pw.SizedBox(
              width: allFirstWidthTabHead,
              child: pw.Container(
                alignment: pw.Alignment.center,
                height: heightReng,
                padding: const pw.EdgeInsets.only(top: 5,bottom: 5),
                child: pw.Text('Anemia',
                style: capLetterStyle),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black, width: widthLineTable)
                ),
              ),
            ),
          ],
        ),
        ...family.map((e) {
          return pw.Row(
          children: [
            pw.SizedBox(
              width: allFirstWidthTabHead,
              child: pw.Container(
                alignment: pw.Alignment.center,
                child: pw.Text(e['rowName'].toString(), style: capLetterStyle),
                height: heightReng,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black, width: widthLineTable)
                )
              ),
            ),
            pw.SizedBox(
              width: allFirstWidthTabHead,
              child: pw.Container(
                alignment: pw.Alignment.center,
                height: heightReng,
                child: pw.Text(e['Buena_salud'].toString(),
                style: capLetterStyle),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black, width: widthLineTable)
                ),
              ),
            ),
            pw.SizedBox(
              width: allFirstWidthTabHead,
              child: pw.Container(
                alignment: pw.Alignment.center,
                height: heightReng,
                child: pw.Text(e['Mala_Salud'].toString(),
                style: capLetterStyle),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black, width: widthLineTable)
                ),
              ),
            ),
            pw.SizedBox(
              width: allFirstWidthTabHead,
              child: pw.Container(
                alignment: pw.Alignment.center,
                height: heightReng,
                child: pw.Text(e['Finado'].toString(),
                style: capLetterStyle),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black, width: widthLineTable)
                ),
              ),
            ),
            pw.SizedBox(
              width: allFirstWidthTabHead,
              child: pw.Container(
                alignment: pw.Alignment.center,
                height: heightReng,
                child: pw.Text(e['Alergia'].toString(),
                style: capLetterStyle),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black, width: widthLineTable)
                ),
              ),
            ),
            pw.SizedBox(
              width: allFirstWidthTabHead,
              child: pw.Container(
                alignment: pw.Alignment.center,
                height: heightReng,
                child: pw.Text(e['Diabetes'].toString(),
                style: capLetterStyle),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black, width: widthLineTable)
                ),
              ),
            ),
            pw.SizedBox(
              width: allFirstWidthTabHead,
              child: pw.Container(
                alignment: pw.Alignment.center,
                height: heightReng,
                child: pw.Text(e['Presion_alta'].toString(),
                style: capLetterStyle),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black, width: widthLineTable)
                ),
              ),
            ),
            pw.SizedBox(
              width: allFirstWidthTabHead,
              child: pw.Container(
                alignment: pw.Alignment.center,
                height: heightReng,
                child: pw.Text(e['Colesterol'].toString(),
                style: capLetterStyle),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black, width: widthLineTable)
                ),
              ),
            ),
            pw.SizedBox(
              width: allFirstWidthTabHead,
              child: pw.Container(
                alignment: pw.Alignment.center,
                height: heightReng,
                child: pw.Text(e['Enf_Corazon'].toString(),
                style: capLetterStyle),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black, width: widthLineTable)
                ),
              ),
            ),
            pw.SizedBox(
              width: allFirstWidthTabHead,
              child: pw.Container(
                alignment: pw.Alignment.center,
                height: heightReng,
                child: pw.Text(e['Cancer'].toString(),
                style: capLetterStyle),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black, width: widthLineTable)
                ),
              ),
            ),
            pw.SizedBox(
              width: allFirstWidthTabHead,
              child: pw.Container(
                alignment: pw.Alignment.center,
                height: heightReng,
                child: pw.Text(e['Anemia'].toString(),
                style: capLetterStyle),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black, width: widthLineTable)
                ),
              ),
            ),
        ],
        );
      }) 
      ],
    ),
  );
  }
 pw.Container buildTableEmployment_History() {
  double firstTabHead = PdfPageFormat.letter.height * 0.025;
  double secondTabHead = PdfPageFormat.letter.height * 0.07;
  double firstCellWidthTabHead = PdfPageFormat.letter.width * 0.18;
  return pw.Container(
    child: pw.Column(
      children: [
        pw.Row(
          children: [
            pw.SizedBox(
              width: firstCellWidthTabHead,
              child: pw.Container(
                alignment: pw.Alignment.center,
                child: pw.Text(
                  'Empresa',
                  style: capLetterStyle,
                ),
                height: heightTabIlHead,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(
                    color: PdfColors.black,
                    width: widthLineTable,
                  ),
                ),
              ),
            ),
            pw.SizedBox(
              width: allFirstWidthTabHead,
              child: pw.Container(
                alignment: pw.Alignment.center,
                child: pw.Text(
                  'Puestos',
                  style: littleLetterStyle,
                ),
                height: heightTabIlHead,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(
                    color: PdfColors.black,
                    width: widthLineTable,
                  ),
                ),
              ),
            ),
            pw.SizedBox(
              width: allFirstWidthTabHead,
              child: pw.Container(
                alignment: pw.Alignment.center,
                child: pw.Text(
                  'Tiempo',
                  style: littleLetterStyle,
                ),
                height: heightTabIlHead,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(
                    color: PdfColors.black,
                    width: widthLineTable,
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
                  style: capLetterStyle,
                ),
                height: firstTabHead,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(
                    color: PdfColors.black,
                    width: widthLineTable,
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
                        style: littleLetterStyle,
                        textAlign: pw.TextAlign.center,
                      ),
                      height: secondTabHead,
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(
                          color: PdfColors.black,
                          width: widthLineTable,
                        ),
                      ),
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Container(
                      alignment: pw.Alignment.center,
                      child: pw.Text(
                        'Rotación de puesto',
                        style: littleLetterStyle,
                        textAlign: pw.TextAlign.center,
                      ),
                      height: secondTabHead,
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(
                          color: PdfColors.black,
                          width: widthLineTable,
                        ),
                      ),
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Container(
                      alignment: pw.Alignment.center,
                      child: pw.Text(
                        'Químicos Solventes',
                        style: littleLetterStyle,
                        textAlign: pw.TextAlign.center,
                      ),
                      height:  secondTabHead,
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(
                          color: PdfColors.black,
                          width: widthLineTable,
                        ),
                      ),
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Container(
                      alignment: pw.Alignment.center,
                      child: pw.Text(
                        'Humos',
                        style: littleLetterStyle,
                        textAlign: pw.TextAlign.center,
                      ),
                      height:  secondTabHead,
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(
                          color: PdfColors.black,
                          width: widthLineTable,
                        ),
                      ),
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Container(
                      alignment: pw.Alignment.center,
                      child: pw.Text(
                        'Vapores',
                        style: littleLetterStyle,
                        textAlign: pw.TextAlign.center,
                      ),
                      height:  secondTabHead,
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(
                          color: PdfColors.black,
                          width: widthLineTable,
                        ),
                      ),
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Container(
                      alignment: pw.Alignment.center,
                      child: pw.Text(
                        'Polvos',
                        style: littleLetterStyle,
                        textAlign: pw.TextAlign.center,
                      ),
                      height:  secondTabHead,
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(
                          color: PdfColors.black,
                          width: widthLineTable,
                        ),
                      ),
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Container(
                      alignment: pw.Alignment.center,
                      child: pw.Text(
                        'Ruido',
                        style: littleLetterStyle,
                        textAlign: pw.TextAlign.center,
                      ),
                      height:  secondTabHead,
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(
                          color: PdfColors.black,
                          width: widthLineTable,
                        ),
                      ),
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Container(
                      alignment: pw.Alignment.center,
                      child: pw.Text(
                        'Carga de material',
                        style: littleLetterStyle,
                        textAlign: pw.TextAlign.center,
                      ),
                      height:  secondTabHead,
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(
                          color: PdfColors.black,
                          width: widthLineTable,
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
            width: firstCellWidthTabHead,
            child: pw.Container(
              alignment: pw.Alignment.center,
              child: pw.Text(
                '',
                style: littleLetterStyle,
                textAlign: pw.TextAlign.center,
              ),
              height: heightReng,
              decoration: pw.BoxDecoration(
                border: pw.Border.all(
                  color: PdfColors.black,
                  width: widthLineTable,
                ),
              ),
            ),
          ),
          pw.SizedBox(
            width: allFirstWidthTabHead,
            child: pw.Container(
              alignment: pw.Alignment.center,
              child: pw.Text(
                '',
                style: littleLetterStyle,
                textAlign: pw.TextAlign.center,
              ),
              height: heightReng,
              decoration: pw.BoxDecoration(
                border: pw.Border.all(
                  color: PdfColors.black,
                  width: widthLineTable,
                ),
              ),
            ),
          ),
          pw.SizedBox(
            width: allFirstWidthTabHead,
            child: pw.Container(
              alignment: pw.Alignment.center,
              child: pw.Text(
                '',
                style: littleLetterStyle,
                textAlign: pw.TextAlign.center,
              ),
              height: heightReng,
              decoration: pw.BoxDecoration(
                border: pw.Border.all(
                  color: PdfColors.black,
                  width: widthLineTable,
                ),
              ),
            ),
          ),
          pw.Expanded(
            child: pw.Container(
              alignment: pw.Alignment.center,
              child: pw.Text(
                '',
                style: littleLetterStyle,
                textAlign: pw.TextAlign.center,
              ),
              height: heightReng,
              decoration: pw.BoxDecoration(
                border: pw.Border.all(
                  color: PdfColors.black,
                  width: widthLineTable,
                ),
              ),
            ),
          ),
          pw.Expanded(
            child: pw.Container(
              alignment: pw.Alignment.center,
              child: pw.Text(
                '',
                style: littleLetterStyle,
                textAlign: pw.TextAlign.center,
              ),
              height: heightReng,
              decoration: pw.BoxDecoration(
                border: pw.Border.all(
                  color: PdfColors.black,
                  width: widthLineTable,
                ),
              ),
            ),
          ),
          pw.Expanded(
            child: pw.Container(
              alignment: pw.Alignment.center,
              child: pw.Text(
                '',
                style: littleLetterStyle,
                textAlign: pw.TextAlign.center,
              ),
              height: heightReng,
              decoration: pw.BoxDecoration(
                border: pw.Border.all(
                  color: PdfColors.black,
                  width: widthLineTable,
                ),
              ),
            ),
          ),
          pw.Expanded(
            child: pw.Container(
              alignment: pw.Alignment.center,
              child: pw.Text(
                '',
                style: littleLetterStyle,
                textAlign: pw.TextAlign.center,
              ),
              height: heightReng,
              decoration: pw.BoxDecoration(
                border: pw.Border.all(
                  color: PdfColors.black,
                  width: widthLineTable,
                ),
              ),
            ),
          ),
          pw.Expanded(
            child: pw.Container(
              alignment: pw.Alignment.center,
              child: pw.Text(
                '',
                style: littleLetterStyle,
                textAlign: pw.TextAlign.center,
              ),
              height: heightReng,
              decoration: pw.BoxDecoration(
                border: pw.Border.all(
                  color: PdfColors.black,
                  width: widthLineTable,
                ),
              ),
            ),
          ),
          pw.Expanded(
            child: pw.Container(
              alignment: pw.Alignment.center,
              child: pw.Text(
                '',
                style: littleLetterStyle,
                textAlign: pw.TextAlign.center,
              ),
              height: heightReng,
              decoration: pw.BoxDecoration(
                border: pw.Border.all(
                  color: PdfColors.black,
                  width: widthLineTable,
                ),
              ),
            ),
          ),
          pw.Expanded(
            child: pw.Container(
              alignment: pw.Alignment.center,
              child: pw.Text(
                '',
                style: littleLetterStyle,
                textAlign: pw.TextAlign.center,
              ),
              height: heightReng,
              decoration: pw.BoxDecoration(
                border: pw.Border.all(
                  color: PdfColors.black,
                  width: widthLineTable,
                ),
              ),
            ),
          ),
          pw.Expanded(
            child: pw.Container(
              alignment: pw.Alignment.center,
              child: pw.Text(
                '',
                style: littleLetterStyle,
                textAlign: pw.TextAlign.center,
              ),
              height: heightReng,
              decoration: pw.BoxDecoration(
                border: pw.Border.all(
                  color: PdfColors.black,
                  width: widthLineTable,
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

pw.Container buildTableAccident_Illness() {
  double secondallFirstWidthTabHead = PdfPageFormat.letter.width * .06;
  double firstCellWidthTabHead = PdfPageFormat.letter.width * .20;
  double lastWidthTabHead = PdfPageFormat.letter.width * .14;

  return pw.Container(
    child: pw.Column(
      children: [
        pw.Row(
          children: [
            pw.SizedBox(
              width: firstCellWidthTabHead,
              child: pw.Container(
                alignment: pw.Alignment.center,
                child: pw.Text(
                  'Nombre de la empresa',
                  style: capLetterStyle,
                  textAlign: pw.TextAlign.center,
                ),
                height: heightTabIlHead,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(
                    color: PdfColors.black,
                    width: widthLineTable,
                  ),
                ),
              ),
            ),
            pw.SizedBox(
              width: allFirstWidthTabHead,
              child: pw.Container(
                alignment: pw.Alignment.center,
                child: pw.Text(
                  'Fecha',
                  style: capLetterStyle,
                  textAlign: pw.TextAlign.center,
                ),
                height: heightTabIlHead,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(
                    color: PdfColors.black,
                    width: widthLineTable,
                  ),
                ),
              ),
            ),
            pw.SizedBox(
              width: allFirstWidthTabHead,
              child: pw.Container(
                alignment: pw.Alignment.center,
                child: pw.Text(
                  'Puesto',
                  style: capLetterStyle,
                  textAlign: pw.TextAlign.center,
                ),
                height: heightTabIlHead,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(
                    color: PdfColors.black,
                    width: widthLineTable,
                  ),
                ),
              ),
            ),
            pw.Expanded(
              child: pw.Column(children: [
              pw.Row(children: 
              [
                pw.SizedBox(
                  width: allFirstWidthTabHead,
                  child: pw.Container(
                    alignment: pw.Alignment.center,
                    child: pw.Text(
                      'Causa',
                      style: capLetterStyle,
                      textAlign: pw.TextAlign.center,
                    ),
                    height: 50,
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(
                        color: PdfColors.black,
                        width: widthLineTable,
                      ),
                    ),
                  )
                ),
                pw.SizedBox(
                  width: allFirstWidthTabHead,
                  child: pw.Container(
                  alignment: pw.Alignment.center,
                  child: pw.Text(
                    'Nombre de la lesión o enfermedad',
                    style: capLetterStyle,
                    textAlign: pw.TextAlign.center,
                  ),
                  height: 50,
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(
                      color: PdfColors.black,
                      width: widthLineTable,
                    ),
                  ),
                ),
              ),
              pw.SizedBox(
                  width: allFirstWidthTabHead,
                child: pw.Container(
                alignment: pw.Alignment.center,
                child: pw.Text(
                  'Incapacidad',
                  style: capLetterStyle,
                  textAlign: pw.TextAlign.center,
                ),
                height: 50,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(
                    color: PdfColors.black,
                    width: widthLineTable,
                  ),
                ),
              ),
              ),
              pw.SizedBox(
                width: lastWidthTabHead,
                child: pw.Container(
                alignment: pw.Alignment.bottomCenter,
                padding: const pw.EdgeInsets.only(top: 25),
                child: pw.Text(
                  'Número de dias de incapacidad',
                  style: capLetterStyle,
                  textAlign: pw.TextAlign.center,
                ),
                height: 50,
                decoration:  pw.BoxDecoration(
                      border:  pw.Border(
                      top:pw.BorderSide(width: widthLineTable, color: PdfColors.black),
                      left:pw.BorderSide(width: widthLineTable, color: PdfColors.black),
                      right:pw.BorderSide(width: widthLineTable, color: PdfColors.black),
                    ),
                  ),
                ),
              ),
              ]
              ),
              pw.Row(
                children: [
                  pw.SizedBox(
                    width: secondallFirstWidthTabHead,
                    child: pw.Container(
                      alignment: pw.Alignment.center,
                      child: pw.Text(
                        'Enf',
                        style: littleLetterStyle,
                        textAlign: pw.TextAlign.center,
                      ),
                      height: 25,
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(
                          color: PdfColors.black,
                          width: widthLineTable,
                        ),
                      ),
                    ),
                  ),
                  pw.SizedBox(
                    width: secondallFirstWidthTabHead,
                    child: pw.Container(
                      alignment: pw.Alignment.center,
                      child: pw.Text(
                        'Acc',
                        style: littleLetterStyle,
                        textAlign: pw.TextAlign.center,
                      ),
                      height: 25,
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(
                          color: PdfColors.black,
                          width: widthLineTable,
                        ),
                      ),
                    ),
                  ),
                  pw.SizedBox(
                    width: allFirstWidthTabHead,
                    child: pw.Container(
                      alignment: pw.Alignment.center,
                      child: pw.Text(
                        '',
                        style: littleLetterStyle,
                        textAlign: pw.TextAlign.center,
                      ),
                      height: 25,
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(
                          color: PdfColors.black,
                          width: widthLineTable,
                        ),
                      ),
                    ),
                  ),
                  pw.SizedBox(
                    width: secondallFirstWidthTabHead,
                    child: pw.Container(
                      alignment: pw.Alignment.center,
                      child: pw.Text(
                        'Si',
                        style: littleLetterStyle,
                        textAlign: pw.TextAlign.center,
                      ),
                      height: 25,
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(
                          color: PdfColors.black,
                          width: widthLineTable,
                        ),
                      ),
                    ),
                  ),
                  pw.SizedBox(
                     width: secondallFirstWidthTabHead,
                    child: pw.Container(
                      alignment: pw.Alignment.center,
                      child: pw.Text(
                        'No',
                        style: littleLetterStyle,
                        textAlign: pw.TextAlign.center,
                      ),
                      height: 25,
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(
                          color: PdfColors.black,
                          width: widthLineTable,
                        ),
                      ),
                    ),
                  ), pw.SizedBox(
                      width: lastWidthTabHead,
                    child: pw.Container(
                    alignment: pw.Alignment.center,
                    child: pw.Text(
                      '',
                      style: capLetterStyle,
                      textAlign: pw.TextAlign.center,
                    ),
                    height: 25,
                    decoration: pw.BoxDecoration(
                      border:  pw.Border(
                        bottom:pw.BorderSide(width: widthLineTable, color: PdfColors.black),
                        left:pw.BorderSide(width: widthLineTable, color: PdfColors.black),
                        right:pw.BorderSide(width: widthLineTable, color: PdfColors.black),
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
            width: firstCellWidthTabHead,
            child: pw.Container(
              alignment: pw.Alignment.center,
              child: pw.Text(
                '',
                style: littleLetterStyle,
                textAlign: pw.TextAlign.center,
              ),
              height: heightReng,
              decoration: pw.BoxDecoration(
                border: pw.Border.all(
                  color: PdfColors.black,
                  width: widthLineTable,
                ),
              ),
            ),
          ),
          pw.SizedBox(
            width: allFirstWidthTabHead,
            child: pw.Container(
              alignment: pw.Alignment.center,
              child: pw.Text(
                '',
                style: littleLetterStyle,
                textAlign: pw.TextAlign.center,
              ),
              height: heightReng,
              decoration: pw.BoxDecoration(
                border: pw.Border.all(
                  color: PdfColors.black,
                  width: widthLineTable,
                ),
              ),
            ),
          ),
          pw.SizedBox(
            width: allFirstWidthTabHead,
            child: pw.Container(
              alignment: pw.Alignment.center,
              child: pw.Text(
                '',
                style: littleLetterStyle,
                textAlign: pw.TextAlign.center,
              ),
              height: heightReng,
              decoration: pw.BoxDecoration(
                border: pw.Border.all(
                  color: PdfColors.black,
                  width: widthLineTable,
                ),
              ),
            ),
          ),
          pw.SizedBox(
            width: secondallFirstWidthTabHead,
            child: pw.Container(
              alignment: pw.Alignment.center,
              child: pw.Text(
                '',
                style: littleLetterStyle,
                textAlign: pw.TextAlign.center,
              ),
              height: heightReng,
              decoration: pw.BoxDecoration(
                border: pw.Border.all(
                  color: PdfColors.black,
                  width: widthLineTable,
                ),
              ),
            ),
          ),
          pw.SizedBox(
            width: secondallFirstWidthTabHead,
            child: pw.Container(
              alignment: pw.Alignment.center,
              child: pw.Text(
                '',
                style: littleLetterStyle,
                textAlign: pw.TextAlign.center,
              ),
              height: heightReng,
              decoration: pw.BoxDecoration(
                border: pw.Border.all(
                  color: PdfColors.black,
                  width: widthLineTable,
                ),
              ),
            ),
          ),
          pw.SizedBox(
            width: allFirstWidthTabHead,
            child: pw.Container(
              alignment: pw.Alignment.center,
              child: pw.Text(
                '',
                style: littleLetterStyle,
                textAlign: pw.TextAlign.center,
              ),
              height: heightReng,
              decoration: pw.BoxDecoration(
                border: pw.Border.all(
                  color: PdfColors.black,
                  width: widthLineTable,
                ),
              ),
            ),
          ),
          pw.SizedBox(
            width: secondallFirstWidthTabHead,
            child: pw.Container(
              alignment: pw.Alignment.center,
              child: pw.Text(
                '',
                style: littleLetterStyle,
                textAlign: pw.TextAlign.center,
              ),
              height: heightReng,
              decoration: pw.BoxDecoration(
                border: pw.Border.all(
                  color: PdfColors.black,
                  width: widthLineTable,
                ),
              ),
            ),
          ),
          pw.SizedBox(
            width: secondallFirstWidthTabHead,
            child: pw.Container(
              alignment: pw.Alignment.center,
              child: pw.Text(
                '',
                style: littleLetterStyle,
                textAlign: pw.TextAlign.center,
              ),
              height: heightReng,
              decoration: pw.BoxDecoration(
                border: pw.Border.all(
                  color: PdfColors.black,
                  width: widthLineTable,
                ),
              ),
            ),
          ),
          pw.SizedBox(
            width: lastWidthTabHead,
            child: pw.Container(
              alignment: pw.Alignment.center,
              child: pw.Text(
                '',
                style: littleLetterStyle,
                textAlign: pw.TextAlign.center,
              ),
              height: heightReng,
              decoration: pw.BoxDecoration(
                border: pw.Border.all(
                  color: PdfColors.black,
                  width: widthLineTable,
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

pw.TextStyle letterBold12 =  pw.TextStyle(fontSize: 12,font: pw.Font.timesBold());
pw.TextStyle letterText12 =  pw.TextStyle(fontSize: 12,font: pw.Font.times());
pw.TextStyle letterText =  pw.TextStyle(fontSize: 9,font: pw.Font.times());

pw.TextStyle letterText10 =  pw.TextStyle(fontSize: 10,font: pw.Font.times());


Stopwatch stopwatch = Stopwatch();
stopwatch.start();

/** PAGINA 1 */
pdf.addPage(
  pw.Page(
    pageFormat: PdfPageFormat.letter,
    margin: const pw.EdgeInsets.all(20),
    build: (pw.Context context) {
      return 
      pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      mainAxisAlignment: pw.MainAxisAlignment.start, 
      children: [
      pw.Container(
        margin: const pw.EdgeInsets.only(top: 40),
        width: double.infinity,
        decoration: pw.BoxDecoration(color: PdfColors.grey200, border: pw.Border.all(color: PdfColors.black, width: 0.5)),
        child: pw.Text('EXAMEN MÉDICO LABORAL: INICIAL (  ) PRE INGRESO (  )', style:letterBold12,textAlign: pw.TextAlign.center)
      ),
      pw.Text('PARTE 1: PARA SER LLENADA POR EL PACIENTE', style: letterBold12,textAlign: pw.TextAlign.center),
      pw.SizedBox(height: PdfPageFormat.letter.height * 0.01),
      pw.Row(
      children: [
        pw.Text('FECHA: ',style: letterBold12), 
        pw.Container(
          child: pw.Text('15 DE JUNIO DEL 2023'),
            decoration: pw.BoxDecoration(
              border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
            )
          ) 
        ),
        pw.Spacer(),
        pw.Text('DEPARTAMENTO: ',style: letterBold12), 
        pw.Container(
          child: pw.Text('RECURSOS HUMANOS'),
            decoration: pw.BoxDecoration(
              border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
            )
          ) 
        ),
        ]
      ),
      pw.Row(
      children: [
        pw.Text('PUESTO: ',style: letterBold12), 
        pw.Container(
          child: pw.Text('PROGRAMADOR RH'),
            decoration: pw.BoxDecoration(
              border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
            )
          ) 
        ),
        ]
      ),
      pw.Text('1.-FICHA PERSONAL',style: letterBold12),
      pw.Container(
        width: double.infinity,
        decoration: pw.BoxDecoration(border: pw.Border.all(color: PdfColors.black, width: 0.5)),
        child: 
        pw.Container(
          padding: const pw.EdgeInsets.all(5),
          child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          mainAxisAlignment: pw.MainAxisAlignment.start, 
          children: [
          pw.Row(
          children: [
            pw.Text('Nombre: ',style: letterText), 
            pw.Container(
              padding: const pw.EdgeInsets.all(2),
              child: pw.Text('Jorge Alonso Luna Rivera',style: letterText),
                decoration: pw.BoxDecoration(
                  border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                )
              ) 
            ),
            pw.Spacer(),
            pw.Text('Sexo: ',style: letterText), 
            pw.Container(
              padding: const pw.EdgeInsets.all(2),
              child: pw.Text('M',style: letterText),
                decoration: pw.BoxDecoration(
                  border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                )
              ) 
            ),
            pw.Spacer(),
            pw.Text('Edad: ',style: letterText), 
            pw.Container(
              padding: const pw.EdgeInsets.all(2),
              child: pw.Text('24',style: letterText),
                decoration: pw.BoxDecoration(
                  border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                )
              ) 
            ),
            pw.Spacer(),
            pw.Text('Edo. Civil: ',style: letterText), 
            pw.Container(
              padding: const pw.EdgeInsets.all(2),
              child: pw.Text('Soltero',style: letterText),
                decoration: pw.BoxDecoration(
                  border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                )
              ) 
            ),
            ]
          ),
          pw.Row(
          children: [
            pw.Text('Domicilio: ',style: letterText),
            pw.Container(
              padding: const pw.EdgeInsets.all(2),
              child: pw.Text('Calle Isaba  numero 548, Colonia Del prado, Mexicali Baja California',style: letterText),
                decoration: pw.BoxDecoration(
                  border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                )
              ) 
            ),
            pw.Spacer(),
            pw.Text('Tel. fijo y/o cel: ',style: letterText),
            pw.Container(
              padding: const pw.EdgeInsets.all(2),
              child: pw.Text('6861448196',style: letterText),
                decoration: pw.BoxDecoration(
                  border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                )
              ) 
            ),
            ]
          ),
          pw.Row(
          children: [
            pw.Text('Lugar y fecha de nacimiento:',style: letterText), 
            pw.Container(
              padding: const pw.EdgeInsets.all(2),
              child: pw.Text('Mexicali Baja California, 9 de febrero del 1999',style: letterText),
                decoration: pw.BoxDecoration(
                  border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                )
              ) 
            ),
            pw.Spacer(),
            pw.Text('Actividad extra a su trabajo:',style: letterText), 
            pw.Container(
              padding: const pw.EdgeInsets.all(2),
              child: pw.Text('Mexicali, B.C. 9 de febrero del 1999',style: letterText),
                decoration: pw.BoxDecoration(
                  border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                )
              ) 
            ),
            ]
          ),
          pw.Row(
          children: [
            pw.Text('Escolaridad:',style: letterText), 
            pw.Container(
              padding: const pw.EdgeInsets.all(2),
              child: pw.Text('Universidad',style: letterText),
                decoration: pw.BoxDecoration(
                  border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                )
              )
            ),
            pw.Spacer(),
            pw.Text('Carrera universitaria:',style: letterText), 
            pw.Container(
              padding: const pw.EdgeInsets.all(2),
              child: pw.Text('Ingenieria en sistemas computacionales',style: letterText),
                decoration: pw.BoxDecoration(
                  border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                )
              )
            ),
            pw.Spacer(),
            pw.Text('Núm. de hijos:',style: letterText), 
            pw.Container(
              padding: const pw.EdgeInsets.all(2),
              child: pw.Text(' 0 ',style: letterText),
                decoration: pw.BoxDecoration(
                  border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                )
              )
            ),
            ]
          )
        ],)
        )
        
      ),
      pw.Text('2.- HISTORIAL LABORAL',style: letterBold12),
      buildTableEmployment_History(),
      pw.Text('3.- ACCIDENTES Y ENFERMEDADES DE TRABAJO Anote SOLO Accidentes de trabajo',style: letterBold12),
      buildTableAccident_Illness(),
      pw.Text('4.- ANTECEDENTES HEREDITARIOS Y FAMILIARES DE SALUD (Con una X anote los datos positivos según sea el caso)',style: letterBold12),
      buildTableHereditaryBackground(),
      pw.SizedBox(height: PdfPageFormat.letter.height * .01),
      pw.Row(children: [ pw.Text('Revisión jul 2021', style: letterText), pw.Spacer(),pw.Text('pág. 1', style: letterText)])
     
      ]);
    },
  ),
);

  double widthContainer = 120;
  double marginContainer = 5;

  pw.Expanded buildGridCustom(){
  return   pw.Expanded(
    child: pw.Row(
    crossAxisAlignment: pw.CrossAxisAlignment.center,
    mainAxisAlignment: pw.MainAxisAlignment.center,
    children: [
      pw.Column(
        children: [
          pw.Container(
            margin: pw.EdgeInsets.all(marginContainer),
            width: widthContainer,
            // decoration: pw.BoxDecoration(border: pw.Border.all()),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                pw.Row(
                  children: [
                    pw.Text('GENERAL ',style: letterText10.copyWith(fontWeight: pw.FontWeight.bold)),
                    pw.SizedBox(width: 10),
                    pw.Text('DLN',style: letterText10.copyWith(fontWeight: pw.FontWeight.bold)),
                  ],
                ),
                pw.Text('Actitud',style: letterText10),
                pw.Text('Marcha',style: letterText10),
                pw.Text('Apariencia',style: letterText10),
                pw.Text('Edo. ánimo',style: letterText10),
              ]
            )
          ),
        pw.Container(
            margin: pw.EdgeInsets.all(marginContainer),
            width: widthContainer,
            // decoration: pw.BoxDecoration(border: pw.Border.all()),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                pw.Row(
                  children: [
                    pw.Text('OÍDOS',style: letterText10.copyWith(fontWeight: pw.FontWeight.bold)),
                    pw.SizedBox(width: 10),
                    pw.Text('DLN',style: letterText10.copyWith(fontWeight: pw.FontWeight.bold)),
                  ],
                ),
                pw.Row(
                  children: [
                    pw.Text('Oreja   ',style: letterText10),
                    pw.Text('D',style: letterText10),
                    pw.SizedBox(width: 10),
                    pw.Text('I',style: letterText10),
                    pw.SizedBox(width: 10),
                  ],
                ),
                pw.Row(
                  children: [
                    pw.Text('C A E   ',style: letterText10),
                    pw.Text('D',style: letterText10),
                    pw.SizedBox(width: 10),
                    pw.Text('I',style: letterText10),
                    pw.SizedBox(width: 10),
                  ],
                ),
                pw.Row(
                  children: [
                    pw.Text('Tímpano   ',style: letterText10),
                    pw.Text('D',style: letterText10),
                    pw.SizedBox(width: 10),
                    pw.Text('I',style: letterText10),
                    pw.SizedBox(width: 10),
                  ],
                ),
              ]
            )
          ),
          pw.Container(
            margin: pw.EdgeInsets.all(marginContainer),
            width: widthContainer,
            // decoration: pw.BoxDecoration(border: pw.Border.all()),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                pw.Row(
                  children: [
                    pw.Text('CABEZA',style: letterText10.copyWith(fontWeight: pw.FontWeight.bold)),
                    pw.SizedBox(width: 10),
                    pw.Text('DLN',style: letterText10.copyWith(fontWeight: pw.FontWeight.bold)),
                  ],
                ),
                pw.Text('Cabello',style: letterText10),
                pw.Text('Superficie',style: letterText10),
                pw.Text('Forma',style: letterText10),
                pw.Text('Senos PN',style: letterText10),
              ]
            )
          ),
          pw.Container(
            margin: pw.EdgeInsets.all(marginContainer),
            width: widthContainer,
            // decoration: pw.BoxDecoration(border: pw.Border.all()),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                pw.Row(
                  children: [
                    pw.Text('OJOS',style: letterText10.copyWith(fontWeight: pw.FontWeight.bold)),
                    pw.SizedBox(width: 10),
                    pw.Text('DLN',style: letterText10.copyWith(fontWeight: pw.FontWeight.bold)),
                  ],
                ),
                pw.Text('Reflejos',style: letterText10),
                pw.Text('Pupilares',style: letterText10),
                pw.Text('Fondo de Ojo',style: letterText10),
                pw.Row(
                  children: [
                    pw.Text('Pterigion   ',style: letterText10),
                    pw.Text('D',style: letterText10),
                    pw.SizedBox(width: 10),
                    pw.Text('I',style: letterText10),
                    pw.SizedBox(width: 10),
                  ],
                ),
              ]
            )
          ),
          pw.Container(
            margin: pw.EdgeInsets.all(marginContainer),
            width: widthContainer,
              // decoration: pw.BoxDecoration(border: pw.Border.all()),
              child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisAlignment: pw.MainAxisAlignment.start,
                  children: [
                    pw.Row(
                      children: [
                        pw.Text('NEUROLÓGICO',style: letterText10.copyWith(fontWeight: pw.FontWeight.bold)),
                        pw.SizedBox(width: 10),
                        pw.Text('DLN',style: letterText10.copyWith(fontWeight: pw.FontWeight.bold)),
                      ],
                    ),
                    pw.Text('Reflejos OT',style: letterText10),
                    pw.Text('Romberg',style: letterText10),
                    pw.Text('Talón Rodilla ',style: letterText10),
                  ]
                )
              ),
        ]
      ),
      pw.Column(
        children: [
          pw.Container(
            margin: pw.EdgeInsets.all(marginContainer),
            width: widthContainer,
            // decoration: pw.BoxDecoration(border: pw.Border.all()),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                pw.Row(
                  children: [
                    pw.Text('BOCA/FARINGE ',style: letterText10.copyWith(fontWeight: pw.FontWeight.bold)),
                    pw.SizedBox(width: 10),
                    pw.Text('DLN',style: letterText10.copyWith(fontWeight: pw.FontWeight.bold)),
                  ],
                ),
                pw.Text('Labios',style: letterText10),
                pw.Text('Aliento',style: letterText10),
                pw.Text('Lengua',style: letterText10),
                pw.Text('Faringe',style: letterText10),
                pw.Text('Amígdalas',style: letterText10),
                pw.Text('Dientes',style: letterText10),
              ]
            )
          ),
          pw.Container(
            margin: pw.EdgeInsets.all(marginContainer),
            width: widthContainer,
            // decoration: pw.BoxDecoration(border: pw.Border.all()),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                pw.Row(
                  children: [
                    pw.Text('TÓRAX  RESP.',style: letterText10.copyWith(fontWeight: pw.FontWeight.bold)),
                    pw.SizedBox(width: 10),
                    pw.Text('DLN',style: letterText10.copyWith(fontWeight: pw.FontWeight.bold)),
                  ],
                ),
                pw.Text('Forma',style: letterText10),
                pw.Text('Diafragma',style: letterText10),
                pw.Text('Frotes',style: letterText10),
                pw.Text('Ventilación',style: letterText10),
                pw.Text('Estertores',style: letterText10),
              ]
            )
          ),
          pw.Container(
            margin: pw.EdgeInsets.all(marginContainer),
            width: widthContainer,
            // decoration: pw.BoxDecoration(border: pw.Border.all()),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                pw.Row(
                  children: [
                    pw.Text('ABDOMEN',style: letterText10.copyWith(fontWeight: pw.FontWeight.bold)),
                    pw.SizedBox(width: 10),
                    pw.Text('DLN',style: letterText10.copyWith(fontWeight: pw.FontWeight.bold)),
                  ],
                ),
                pw.Text('Forma',style: letterText10),
                pw.Text('Dolor',style: letterText10),
                pw.Text('Masas',style: letterText10),
                pw.Row(
                  children: [
                    pw.Text('Hernia   ',style: letterText10),
                    pw.Text('D',style: letterText10),
                    pw.SizedBox(width: 10),
                    pw.Text('I',style: letterText10),
                    pw.SizedBox(width: 10),
                  ],
                ),
              ]
            )
          ),pw.Container(
            margin: pw.EdgeInsets.all(marginContainer),
            width: widthContainer,
            // decoration: pw.BoxDecoration(border: pw.Border.all()),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                pw.Row(
                  children: [
                    pw.Text('NARIZ',style: letterText10.copyWith(fontWeight: pw.FontWeight.bold)),
                    pw.SizedBox(width: 10),
                    pw.Text('DLN',style: letterText10.copyWith(fontWeight: pw.FontWeight.bold)),
                  ],
                ),
                pw.Text('Septum',style: letterText10),
                pw.Row(
                  children: [
                    pw.Text('Mucosa   ',style: letterText10),
                    pw.Text('D',style: letterText10),
                    pw.SizedBox(width: 10),
                    pw.Text('I',style: letterText10),
                    pw.SizedBox(width: 10),
                  ],
                ),
                pw.Text('Ventilación',style: letterText10),
              ]
            )
          ),
        ]
      ),
      pw.Column(
        children: [
          pw.Container(
            margin: pw.EdgeInsets.all(marginContainer),
            width: widthContainer,
            // decoration: pw.BoxDecoration(border: pw.Border.all()),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                pw.Row(
                  children: [
                    pw.Text('ÁREA PRECORDIAL',style: letterText10.copyWith(fontWeight: pw.FontWeight.bold)),
                    pw.SizedBox(width: 10),
                    pw.Text('DLN',style: letterText10.copyWith(fontWeight: pw.FontWeight.bold)),
                  ],
                ),
                pw.Text('Frecuencia',style: letterText10),
                pw.Text('Ritmo',style: letterText10),
                pw.Text('Tonos',style: letterText10),
                pw.Text('Frotes',style: letterText10),
                pw.Text('Soplos',style: letterText10),
              ]
            )
          ),
          
          pw.Container(
            margin: pw.EdgeInsets.all(marginContainer),
            width: widthContainer,
            // decoration: pw.BoxDecoration(border: pw.Border.all()),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                pw.Row(
                  children: [
                    pw.Text('PIEl',style: letterText10.copyWith(fontWeight: pw.FontWeight.bold)),
                    pw.SizedBox(width: 10),
                    pw.Text('DLN',style: letterText10.copyWith(fontWeight: pw.FontWeight.bold)),
                  ],
                ),
                pw.Text('Cicatrices',style: letterText10),
                pw.Text('Textura',style: letterText10),
                pw.Text('Diaforesis',style: letterText10),
                pw.Text('Otras Lesiones',style: letterText10),
              ]
            )
          ),
          pw.Container(
            margin: pw.EdgeInsets.all(marginContainer),
            width: widthContainer,
            // decoration: pw.BoxDecoration(border: pw.Border.all()),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                pw.Row(
                  children: [
                    pw.Text('EXTREMIDADES',style: letterText10.copyWith(fontWeight: pw.FontWeight.bold)),
                    pw.SizedBox(width: 10),
                    pw.Text('DLN',style: letterText10.copyWith(fontWeight: pw.FontWeight.bold)),
                  ],
                ),
                pw.Row(
                  children: [
                    pw.Text('Articular   ',style: letterText10),
                    pw.Text('D',style: letterText10),
                    pw.SizedBox(width: 10),
                    pw.Text('I',style: letterText10),
                    pw.SizedBox(width: 10), 
                  ],
                ),
                pw.Row(
                  children: [
                    pw.Text('Muscular   ',style: letterText10),
                    pw.Text('D',style: letterText10),
                    pw.SizedBox(width: 10),
                    pw.Text('I',style: letterText10),
                    pw.SizedBox(width: 10),
                  ],
                ),
                pw.Row(
                  children: [
                    pw.Text('Nervioso   ',style: letterText10),
                    pw.Text('D',style: letterText10),
                    pw.SizedBox(width: 10),
                    pw.Text('I',style: letterText10),
                    pw.SizedBox(width: 10),
                  ],
                ),
                pw.Container(
                margin: pw.EdgeInsets.all(marginContainer),
                width: widthContainer,
                // decoration: pw.BoxDecoration(border: pw.Border.all()),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  children: [
                  pw.Text('M.I.',style: letterText10.copyWith(fontWeight: pw.FontWeight.bold)),
                  pw.Row(
                      children: [
                        pw.Text('Articular   ',style: letterText10),
                        pw.Text('D',style: letterText10),
                        pw.SizedBox(width: 10),
                        pw.Text('I',style: letterText10),
                        pw.SizedBox(width: 10),
                      ]
                  ),
                  pw.Row(
                      children: [
                        pw.Text('Muscular   ',style: letterText10),
                        pw.Text('D',style: letterText10),
                        pw.SizedBox(width: 10),
                        pw.Text('I',style: letterText10),
                        pw.SizedBox(width: 10),
                      ]
                  ),
                  ]
                )
              ),
              pw.Container(
                margin: pw.EdgeInsets.all(marginContainer),
                width: widthContainer,
                // decoration: pw.BoxDecoration(border: pw.Border.all()),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  children: [
                    pw.Row(
                      children: [
                        pw.Text('Columna',style: letterText10.copyWith(fontWeight: pw.FontWeight.bold)),
                        pw.SizedBox(width: 10),
                      ],
                    ),
                  ]
                )
              ),
              ]
            )
          )
        ]
      )
      
    ]
    )
    );
    
  }

  /**PAGINA 2 */
  pdf.addPage(
  pw.Page(
    pageFormat: PdfPageFormat.letter,
    margin: const pw.EdgeInsets.only(top: 40, bottom: 30, left: 20, right: 20),
    build: (pw.Context context) {
      return 
      pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      mainAxisAlignment: pw.MainAxisAlignment.start, 
      children: [
      pw.Text('5.- ANTECEDENTES PENALES (Con una X anote los datos positivos según sea el caso)',style: letterBold12),
      pw.Container(
        width: double.infinity,
        padding: const pw.EdgeInsets.only(top: 10, bottom: 20, left: 5, right: 5),
        decoration: pw.BoxDecoration(border: pw.Border.all(width: widthLineTable, color: PdfColors.black)),
        child:  pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        mainAxisAlignment: pw.MainAxisAlignment.start, 
          children: [
            pw.Container(
              padding: const pw.EdgeInsets.only(bottom: 10),
              child: pw.Text('5.1.-ANTECEDENTES PERSONALES NO PATOLÓGICOS                                      Diestro(   ) Zurdo(   ) Ambos(   )',style: letterText10)
            ),
            pw.Row(
              children: [
                pw.Text('Tabaquismo   No ',style: letterText10), 
                pw.Container(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(' X ',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                ),
                pw.Text(' Si',style: letterText10), 
                pw.Container(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(' X ',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                ),
                pw.Spacer(),
                pw.Text('Edad de inicio: ',style: letterText10), 
                pw.Container(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text('',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                ),
                pw.Spacer(),
                pw.Text('Cantidad de cigarrillos al día: ',style: letterText10), 
                pw.Container(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text('',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                ),
                pw.Spacer(),
                pw.Text('Ingesta de alcohol   No ',style: letterText10), 
                pw.Container(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(' X ',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                ),
                pw.Text(' Si ',style: letterText10), 
                pw.Container(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(' X ',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                )
              ],
            ),
            pw.Row(
              children: [
                pw.Text('Edad de Inicio: ',style: letterText10), 
                pw.Container(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(' ',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                ),
                pw.Spacer(),
                pw.Text('Frecuencia: ',style: letterText10), 
                pw.Container(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text('',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                ),
                pw.Spacer(),
                pw.Text('Toxicomanías   No ',style: letterText10), 
                pw.Container(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(' X ',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                ),
                pw.Text(' Si ',style: letterText10), 
                pw.Container(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(' X ',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                ),
                pw.Spacer(),
                pw.Text('Edad de inicio: ',style: letterText10), 
                pw.Container(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(' ',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                )
              ],
            ),
            pw.Row(
              children: [
                pw.Text('Tipo y frecuencia: ',style: letterText10), 
                pw.Container(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text('',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                ),
                pw.Spacer(),
                pw.Text('Alergias a medicamentos   No ',style: letterText10), 
                pw.Container(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(' X ',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                ),
                pw.Text(' Si ',style: letterText10), 
                pw.Container(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(' X ',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                ),
                pw.Spacer(),
                pw.Text(' ¿A cuál? ',style: letterText10), 
                pw.Container(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text('',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                )
              ],
            ),
            pw.Row(
              children: [
                pw.Text('Alergias a alimentos   No ',style: letterText10), 
                pw.Container(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(' X ',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                ),
                pw.Text(' Si ',style: letterText10), 
                pw.Container(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(' X ',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                ),
                pw.Spacer(),
                pw.Text(' ¿A cuál? ',style: letterText10), 
                pw.Container(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text('',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                )
              ],
            ),

            /**
             * cuando hay una "x", se pone en "right: 2,left: 2" en el padding, y en el margin 0
             * cuando no hay una "x" se pone 4 en el padding, y en el margin 4 
             */
            pw.Row(
              children: [
                pw.Text('Vacunas en los últimos 12 meses: COVID-19 :   Si ',style: letterText10), 
                pw.Container(
                margin: const pw.EdgeInsets.all(4),
                padding: const pw.EdgeInsets.all(4),
                child: pw.Text('',style: letterText10),
                  decoration: pw.BoxDecoration(
                    border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                  )
                ),
                pw.Text(' No ',style: letterText10), 
                pw.Container(
                margin: const pw.EdgeInsets.all(4),
                padding: const pw.EdgeInsets.all(4),
                child: pw.Text('',style: letterText10),
                  decoration: pw.BoxDecoration(
                    border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                  )
                ),
                pw.Text('   Tétanos:   Si ',style: letterText10), 
                  pw.Container(
                  margin: const pw.EdgeInsets.all(4),
                  padding: const pw.EdgeInsets.all(4),
                  child: pw.Text('',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                    )
                  ),
                  pw.Text(' Si ',style: letterText10), 
                  pw.Container(
                  margin: const pw.EdgeInsets.all(4),
                  padding: const pw.EdgeInsets.all(4),
                  child: pw.Text('',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                    )
                  ),
                pw.Text('   Hepatitis:   Si ',style: letterText10), 
                  pw.Container(
                  margin: const pw.EdgeInsets.all(4),
                  padding: const pw.EdgeInsets.all(4),
                  child: pw.Text('',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                    )
                  ),
                  pw.Text(' Si ',style: letterText10), 
                  pw.Container(
                  margin: const pw.EdgeInsets.all(4),
                  padding: const pw.EdgeInsets.all(4),
                  child: pw.Text('',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                    )
                  )
              ],
            ),
            pw.Row(
              children: [
                pw.Text('Neumococo:   Si ',style: letterText10), 
                  pw.Container(
                  margin: const pw.EdgeInsets.all(4),
                  padding: const pw.EdgeInsets.all(4),
                  child: pw.Text('',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                    )
                  ),
                  pw.Text(' No ',style: letterText10), 
                  pw.Container(
                  margin: const pw.EdgeInsets.all(4),
                  padding: const pw.EdgeInsets.all(4),
                  child: pw.Text('',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                    )
                  ),
                pw.Text('             Otras: ',style: letterText10), 
                  pw.Container(
                  margin: const pw.EdgeInsets.all(0),
                  padding: const pw.EdgeInsets.all(4),
                  child: pw.Text('',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ),
                )
              ],
            ),
            pw.Row(
              children: [
                pw.Text('¿Practica algún deporte?   No ',style: letterText10), 
                pw.Container(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text('  ',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                ),
                pw.Text(' Si ',style: letterText10), 
                pw.Container(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(' X ',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                ),
                pw.Spacer(),
                pw.Text(' ¿A cuál? ',style: letterText10), 
                pw.Container(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text('',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                ),
                pw.Spacer(),
                pw.Text(' ¿Con qué frecuencia? ',style: letterText10), 
                pw.Container(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text('',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                ),
              ],
            ),
            /**
             * En este caso eliminamos el margin cuando se cuenta con letras en el renglon 
             * y le dejamos el padding
             */
            pw.Container(
              margin: const pw.EdgeInsets.only(top: 25, bottom: 4),
              child: pw.Text('ANTECEDENTES GINECOLÓGICOS (SOLO SE APLICA A MUJERES)',style: letterText10),
            ),
            pw.Row(
              children: [
                pw.Text('Edad de su primera menstruación: ',style: letterText10), 
                pw.Container(
                  margin: null,
                  padding:  const pw.EdgeInsets.all(2),
                  child: pw.Text('12',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                ),
                pw.Spacer(),
                pw.Text('Edad de inicio de vida sexual: ',style: letterText10), 
                pw.Container(
                  margin: const pw.EdgeInsets.all(6),
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text('',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                ),
                pw.Spacer(),
                pw.Text('Número de Embarazos: ',style: letterText10), 
                pw.Container(
                  margin: const pw.EdgeInsets.all(6),
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text('',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                ),
                pw.Spacer(),
                pw.Text('Partos: ',style: letterText10), 
                pw.Container(
                  margin: const pw.EdgeInsets.all(6),
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text('',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                )
              ]
            ),
            pw.Row(
              children: [
                pw.Text('Cesáreas: ',style: letterText10), 
                pw.Container(
                  margin: const pw.EdgeInsets.all(6),
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text('',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                ),
                pw.Spacer(),
                pw.Text('Abortos: ',style: letterText10), 
                pw.Container(
                  margin: const pw.EdgeInsets.all(6),
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text('',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                ),
                pw.Spacer(),
                pw.Text('Fecha de Ultima Regla: ',style: letterText10), 
                pw.Container(
                  margin: const pw.EdgeInsets.all(6),
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text('',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                ),
                pw.Spacer(),
                pw.Text('Ritmo: ',style: letterText10), 
                pw.Container(
                  margin: const pw.EdgeInsets.all(6),
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text('',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                )
              ]
            ),
            pw.Row(
              children: [
                pw.Text('Método anticonceptivo actual: Pastillas: ',style: letterText10), 
                pw.Container(
                  margin: const pw.EdgeInsets.all(6),
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text('',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                ),
                pw.Spacer(),
                pw.Text('Dispositivo: ',style: letterText10), 
                pw.Container(
                  margin: const pw.EdgeInsets.all(6),
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text('',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                ),
                pw.Spacer(),
                pw.Text('Condón: ',style: letterText10), 
                pw.Container(
                  margin: const pw.EdgeInsets.all(6),
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text('',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                ),
                pw.Spacer(),
                pw.Text('OTB: ',style: letterText10), 
                pw.Container(
                  margin: const pw.EdgeInsets.all(6),
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text('',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                ),
                pw.Spacer(),
                pw.Text('Inyección: ',style: letterText10), 
                pw.Container(
                  margin: const pw.EdgeInsets.all(6),
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text('',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                )
              ]
            ),
            pw.Row(
              children: [
                pw.Text('Implante: ',style: letterText10), 
                pw.Container(
                  margin: const pw.EdgeInsets.all(6),
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text('',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                ),
                pw.Spacer(),
                pw.Text('Fecha de Último Papanicolaou: ',style: letterText10), 
                pw.Container(
                  margin: const pw.EdgeInsets.all(6),
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text('',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                ),
                pw.Spacer(),
                pw.Text('Resultado: ',style: letterText10), 
                pw.Container(
                  margin: const pw.EdgeInsets.all(6),
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text('',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                ),
                pw.Spacer(),
                pw.Text('Fecha de Mamografía: ',style: letterText10), 
                pw.Container(
                  margin: const pw.EdgeInsets.all(6),
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text('',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                )
              ]
            ),
            pw.Row(
              children: [
                pw.Text('Resultado: ',style: letterText10), 
                pw.Container(
                  margin: const pw.EdgeInsets.all(6),
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text('',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                ),
                pw.SizedBox(width: PdfPageFormat.letter.width * 0.025),
                pw.Text('Lactancia: ',style: letterText10), 
                pw.Container(
                  margin: const pw.EdgeInsets.all(6),
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text('',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                )
              ]
            ),

            /**
             * cuando hay una "x", se pone en .5 en el padding, y en el margin 2
             * cuando no hay una "x" se pone 4 en el padding, y en el margin 4 
             */

            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisAlignment: pw.MainAxisAlignment.start, 
              children: [
                pw.Container(
                  padding: const pw.EdgeInsets.only(bottom: 10, top: 13),
                  child: pw.Text('5.2.-ANTECEDENTES PERSONALES PATOLÓGICOS',style: letterText10)
                ),
                pw.Container(
                  padding: const pw.EdgeInsets.only(bottom: 10),
                  child: pw.Text('Marque SI o NO con una X al lado de cualquiera de las siguientes enfermedades que usted haya padecido o padezca',style: letterText10)
                ),
                pw.Row(
                  children: [
                    pw.Text('Artritis               Si ',style: letterText10), 
                    pw.Container(
                    margin: const pw.EdgeInsets.all(4),
                    padding: const pw.EdgeInsets.all(4),
                    child: pw.Text('',style: letterText10),
                      decoration: pw.BoxDecoration(
                        border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                      )
                    ),
                    pw.Text(' No ',style: letterText10), 
                    pw.Container(
                    margin: const pw.EdgeInsets.all(4),
                    padding: const pw.EdgeInsets.all(4),
                    child: pw.Text('',style: letterText10),
                      decoration: pw.BoxDecoration(
                        border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                      )
                    ),
                    pw.Text('    Enfs. de la piel:         Si ',style: letterText10), 
                      pw.Container(
                      margin: const pw.EdgeInsets.all(4),
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text('',style: letterText10),
                        decoration: pw.BoxDecoration(
                          border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                        )
                      ),
                      pw.Text(' No ',style: letterText10), 
                      pw.Container(
                      margin: const pw.EdgeInsets.all(4),
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text('',style: letterText10),
                        decoration: pw.BoxDecoration(
                          border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                        )
                      ),
                    pw.Text('     Ginecológicas:       Si ',style: letterText10), 
                      pw.Container(
                      margin: const pw.EdgeInsets.all(4),
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text('',style: letterText10),
                        decoration: pw.BoxDecoration(
                          border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                        )
                      ),
                      pw.Text(' No ',style: letterText10), 
                      pw.Container(
                      margin: const pw.EdgeInsets.all(4),
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text('',style: letterText10),
                        decoration: pw.BoxDecoration(
                          border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                        )
                      ),
                    pw.Text('     Neumonía:       Si ',style: letterText10), 
                      pw.Container(
                      margin: const pw.EdgeInsets.all(4),
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text('',style: letterText10),
                        decoration: pw.BoxDecoration(
                          border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                        )
                      ),
                      pw.Text(' No ',style: letterText10), 
                      pw.Container(
                      margin: const pw.EdgeInsets.all(4),
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text('',style: letterText10),
                        decoration: pw.BoxDecoration(
                          border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                        )
                      )
                  ],
                ),
                pw.Row(
                  children: [
                    pw.Text('Asma                Si ',style: letterText10), 
                    pw.Container(
                    margin: const pw.EdgeInsets.all(4),
                    padding: const pw.EdgeInsets.all(4),
                    child: pw.Text('',style: letterText10),
                      decoration: pw.BoxDecoration(
                        border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                      )
                    ),
                    pw.Text(' No ',style: letterText10), 
                    pw.Container(
                    margin: const pw.EdgeInsets.all(4),
                    padding: const pw.EdgeInsets.all(4),
                    child: pw.Text('',style: letterText10),
                      decoration: pw.BoxDecoration(
                        border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                      )
                    ),
                    pw.Text('    Enfs. de la tiroides:   Si ',style: letterText10), 
                      pw.Container(
                      margin: const pw.EdgeInsets.all(4),
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text('',style: letterText10),
                        decoration: pw.BoxDecoration(
                          border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                        )
                      ),
                      pw.Text(' No ',style: letterText10), 
                      pw.Container(
                      margin: const pw.EdgeInsets.all(4),
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text('',style: letterText10),
                        decoration: pw.BoxDecoration(
                          border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                        )
                      ),
                    pw.Text('     Hemorroides:         Si ',style: letterText10), 
                      pw.Container(
                      margin: const pw.EdgeInsets.all(4),
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text('',style: letterText10),
                        decoration: pw.BoxDecoration(
                          border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                        )
                      ),
                      pw.Text(' No ',style: letterText10), 
                      pw.Container(
                      margin: const pw.EdgeInsets.all(4),
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text('',style: letterText10),
                        decoration: pw.BoxDecoration(
                          border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                        )
                      ),
                    pw.Text('     Tuberculosis:   Si ',style: letterText10), 
                      pw.Container(
                      margin: const pw.EdgeInsets.all(4),
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text('',style: letterText10),
                        decoration: pw.BoxDecoration(
                          border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                        )
                      ),
                      pw.Text(' No ',style: letterText10), 
                      pw.Container(
                      margin: const pw.EdgeInsets.all(4),
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text('',style: letterText10),
                        decoration: pw.BoxDecoration(
                          border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                        )
                      )
                  ],
                ),
                pw.Row(
                  children: [
                    pw.Text('Bronquitis         Si ',style: letterText10), 
                    pw.Container(
                    margin: const pw.EdgeInsets.all(4),
                    padding: const pw.EdgeInsets.all(4),
                    child: pw.Text('',style: letterText10),
                      decoration: pw.BoxDecoration(
                        border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                      )
                    ),
                    pw.Text(' No ',style: letterText10), 
                    pw.Container(
                    margin: const pw.EdgeInsets.all(4),
                    padding: const pw.EdgeInsets.all(4),
                    child: pw.Text('',style: letterText10),
                      decoration: pw.BoxDecoration(
                        border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                      )
                    ),
                    pw.Text('    Hernias:                     Si ',style: letterText10), 
                      pw.Container(
                      margin: const pw.EdgeInsets.all(4),
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text('',style: letterText10),
                        decoration: pw.BoxDecoration(
                          border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                        )
                      ),
                      pw.Text(' No ',style: letterText10), 
                      pw.Container(
                      margin: const pw.EdgeInsets.all(4),
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text('',style: letterText10),
                        decoration: pw.BoxDecoration(
                          border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                        )
                      ),
                    pw.Text('    Úlceras:                  Si ',style: letterText10), 
                      pw.Container(
                      margin: const pw.EdgeInsets.all(4),
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text('',style: letterText10),
                        decoration: pw.BoxDecoration(
                          border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                        )
                      ),
                      pw.Text(' No ',style: letterText10), 
                      pw.Container(
                      margin: const pw.EdgeInsets.all(4),
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text('',style: letterText10),
                        decoration: pw.BoxDecoration(
                          border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                        )
                      ),
                    pw.Text('     Colitis:              Si ',style: letterText10), 
                      pw.Container(
                      margin: const pw.EdgeInsets.all(4),
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text('',style: letterText10),
                        decoration: pw.BoxDecoration(
                          border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                        )
                      ),
                      pw.Text(' No ',style: letterText10), 
                      pw.Container(
                      margin: const pw.EdgeInsets.all(4),
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text('',style: letterText10),
                        decoration: pw.BoxDecoration(
                          border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                        )
                      )
                  ],
                ),
                pw.Row(
                  children: [
                    pw.Text('Hepatitis           Si ',style: letterText10), 
                    pw.Container(
                    margin: const pw.EdgeInsets.all(4),
                    padding: const pw.EdgeInsets.all(4),
                    child: pw.Text('',style: letterText10),
                      decoration: pw.BoxDecoration(
                        border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                      )
                    ),
                    pw.Text(' No ',style: letterText10), 
                    pw.Container(
                    margin: const pw.EdgeInsets.all(4),
                    padding: const pw.EdgeInsets.all(4),
                    child: pw.Text('',style: letterText10),
                      decoration: pw.BoxDecoration(
                        border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                      )
                    ),
                    pw.Text('    Lumbalgia:                 Si ',style: letterText10), 
                      pw.Container(
                      margin: const pw.EdgeInsets.all(4),
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text('',style: letterText10),
                        decoration: pw.BoxDecoration(
                          border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                        )
                      ),
                      pw.Text(' No ',style: letterText10), 
                      pw.Container(
                      margin: const pw.EdgeInsets.all(4),
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text('',style: letterText10),
                        decoration: pw.BoxDecoration(
                          border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                        )
                      ),
                    pw.Text('    Várices:                  Si ',style: letterText10), 
                      pw.Container(
                      margin: const pw.EdgeInsets.all(4),
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text('',style: letterText10),
                        decoration: pw.BoxDecoration(
                          border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                        )
                      ),                
                      pw.Text(' No ',style: letterText10), 
                      pw.Container(
                      margin: const pw.EdgeInsets.all(4),
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text('',style: letterText10),
                        decoration: pw.BoxDecoration(
                          border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                        )
                      ),
                    pw.Text('     Depresión:       Si ',style: letterText10), 
                      pw.Container(
                      margin: const pw.EdgeInsets.all(4),
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text('',style: letterText10),
                        decoration: pw.BoxDecoration(
                          border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                        )
                      ),
                      pw.Text(' No ',style: letterText10), 
                      pw.Container(
                      margin: const pw.EdgeInsets.all(4),
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text('',style: letterText10),
                        decoration: pw.BoxDecoration(
                          border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                        )
                      )
                  ],
                ),
                pw.Row(
                  children: [
                    pw.Text('COVID              Si ',style: letterText10), 
                    pw.Container(
                    margin: const pw.EdgeInsets.all(4),
                    padding: const pw.EdgeInsets.all(4),
                    child: pw.Text('',style: letterText10),
                      decoration: pw.BoxDecoration(
                        border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                      )
                    ),
                    pw.Text(' No ',style: letterText10), 
                    pw.Container(
                    margin: const pw.EdgeInsets.all(4),
                    padding: const pw.EdgeInsets.all(4),
                    child: pw.Text('',style: letterText10),
                      decoration: pw.BoxDecoration(
                        border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                      )
                    ),
                    pw.Text('    DIABETES:                Si ',style: letterText10), 
                      pw.Container(
                      margin: const pw.EdgeInsets.all(4),
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text('',style: letterText10),
                        decoration: pw.BoxDecoration(
                          border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                        )
                      ),
                      pw.Text(' No ',style: letterText10), 
                      pw.Container(
                      margin: const pw.EdgeInsets.all(4),
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text('',style: letterText10),
                        decoration: pw.BoxDecoration(
                          border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                        )
                      ),
                    pw.Text('    OTRAS: ',style: letterText10), 
                    pw.Column(
                      children: [
                      pw.Container(
                        width: 100,
                        height: 0.5,
                        margin: const pw.EdgeInsets.only(top: 10),
                        color: PdfColors.black,
                      ),
                      /* pw.Container(
                      margin:const pw.EdgeInsets.all(4),
                      padding: const pw.EdgeInsets.all(2),
                      child: pw.Text('',style: letterText10),
                        decoration: pw.BoxDecoration(
                         border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black)), 
                        )
                      ) */
                      ]
                    )
                  ],
                ),
                pw.Row(
                  children: [
                    pw.Text('Enfs. de riñón   Si ',style: letterText10), 
                    pw.Container(
                    margin: const pw.EdgeInsets.all(4),
                    padding: const pw.EdgeInsets.all(4),
                    child: pw.Text('',style: letterText10),
                      decoration: pw.BoxDecoration(
                        border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                      )
                    ),
                    pw.Text(' No ',style: letterText10), 
                    pw.Container(
                    margin: const pw.EdgeInsets.all(4),
                    padding: const pw.EdgeInsets.all(4),
                    child: pw.Text('',style: letterText10),
                      decoration: pw.BoxDecoration(
                        border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                      )
                    ),
                    pw.Text('    Gastritis:                     Si ',style: letterText10), 
                      pw.Container(
                      margin: const pw.EdgeInsets.all(4),
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text('',style: letterText10),
                        decoration: pw.BoxDecoration(
                          border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                        )
                      ),
                      pw.Text(' No ',style: letterText10), 
                      pw.Container(
                      margin: const pw.EdgeInsets.all(4),
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text('',style: letterText10),
                        decoration: pw.BoxDecoration(
                          border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                        )
                      ),
                    pw.Text('    HIPERTENSIÓN:   Si ',style: letterText10), 
                      pw.Container(
                      margin: const pw.EdgeInsets.all(4),
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text('',style: letterText10),
                        decoration: pw.BoxDecoration(
                          border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                        )
                      ),
                      pw.Text(' No ',style: letterText10), 
                      pw.Container(
                      margin: const pw.EdgeInsets.all(4),
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text('',style: letterText10),
                        decoration: pw.BoxDecoration(
                          border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                        )
                      )
                  ],
                ),
              ]
            ),

            //Ultimas preguntas de la pagina 2
            pw.Container(
              margin: const pw.EdgeInsets.only(top: 40),
              child: pw.Column(
              children: [
                pw.Row(
                children: [
                  pw.Text('Hospitalizaciones:   No ',style: letterText10), 
                  pw.Container(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Text(' X ',style: letterText10),
                      decoration: pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                      )
                    ) 
                  ),
                  pw.Text(' Si',style: letterText10), 
                  pw.Container(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Text(' X ',style: letterText10),
                      decoration: pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                      )
                    ) 
                  ),
                  pw.Spacer(),
                  pw.Text('Motivo: ',style: letterText10), 
                  pw.Container(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Text('',style: letterText10),
                      decoration: pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                      )
                    ) 
                  ),
                  pw.Spacer(),
                  pw.Text('Cirugías   No ',style: letterText10), 
                  pw.Container(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Text(' X ',style: letterText10),
                      decoration: pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                      )
                    ) 
                  ),
                  pw.Text(' Si ',style: letterText10), 
                  pw.Container(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Text(' X ',style: letterText10),
                      decoration: pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                      )
                    ) 
                  ),
                  pw.Text(' ¿Cuál? ',style: letterText10), 
                  pw.Container(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Text(' X ',style: letterText10),
                      decoration: pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                      )
                    ) 
                  )
                ],
              ),
              pw.Row(
                children: [
                  pw.Text('Transfusiones:   No ',style: letterText10), 
                  pw.Container(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Text(' X ',style: letterText10),
                      decoration: pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                      )
                    ) 
                  ),
                  pw.Text(' Si',style: letterText10), 
                  pw.Container(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Text(' X ',style: letterText10),
                      decoration: pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                      )
                    ) 
                  ),
                  pw.Spacer(),
                  pw.Text('Motivo: ',style: letterText10), 
                  pw.Container(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Text('',style: letterText10),
                      decoration: pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                      )
                    ) 
                  ),
                  pw.Spacer(),
                  pw.Text('Traumatismos y Fracturas   No ',style: letterText10), 
                  pw.Container(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Text(' X ',style: letterText10),
                      decoration: pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                      )
                    ) 
                  ),
                  pw.Text(' Si ',style: letterText10), 
                  pw.Container(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Text(' X ',style: letterText10),
                      decoration: pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                      )
                    ) 
                  )
                ],
              ),
              pw.Row(
                children: [
                  pw.Text('Parte del cuerpo: ',style: letterText10),                 
                  pw.Container(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Text('',style: letterText10),
                      decoration: pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                      )
                    ) 
                  ),
                  pw.Spacer(),
                  pw.Text('Complicaciones: No ',style: letterText10), 
                  pw.Container(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Text(' X ',style: letterText10),
                      decoration: pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                      )
                    ) 
                  ),
                  pw.Text(' Si ',style: letterText10), 
                  pw.Container(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Text(' X ',style: letterText10),
                      decoration: pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                      )
                    ) 
                  ),
                  pw.Text(' ¿Cuál? ',style: letterText10), 
                  pw.Container(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Text('',style: letterText10),
                      decoration: pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                      )
                    ) 
                  )
                ],
              ),
              pw.Row(
                children: [
                  pw.Text('Enfermedades crónicas:   No ',style: letterText10), 
                  pw.Container(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Text(' X ',style: letterText10),
                      decoration: pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                      )
                    ) 
                  ),
                  pw.Text(' Si',style: letterText10), 
                  pw.Container(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Text(' X ',style: letterText10),
                      decoration: pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                      )
                    ) 
                  ),
                  pw.Spacer(),
                  pw.Text('¿Cuál?: ',style: letterText10), 
                  pw.Container(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Text('',style: letterText10),
                      decoration: pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                      )
                    ) 
                  ),
                  pw.Text(' Tratamiento actual ',style: letterText10), 
                  pw.Container(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Text('',style: letterText10),
                      decoration: pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                      )
                    ) 
                  )
                ],
              ),
              ]
            )
            )
          ],
        )
      ),

      pw.Container(
        margin: const pw.EdgeInsets.only(top: 15),
        child: pw.Column(
          children: [
            pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.start, 
              children: [
              pw.Text('Nombre y firma del paciente: ',style: pw.TextStyle(fontSize: 11)),
              pw.Container(
              padding: const pw.EdgeInsets.all(2),
              child:pw.Text('sdfsdfsfsdfsdfdsf',style: letterText),
                decoration: pw.BoxDecoration(
                  border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                )
              ) 
            ),
            ]
          ),
          pw.RichText(
            text: pw.TextSpan(
              children: [
                pw.TextSpan(
                  text: 'Estoy consciente que todo lo que manifiesto es verídico y se me apercibe que de lo contrario se me aplicará lo estipulado por el Artículo 47 de la Ley Federal del Trabajo, que a la letra dice: Artículo 47.-',
                  style: pw.TextStyle(fontSize: 7, fontWeight: pw.FontWeight.bold),
                ),
                const pw.TextSpan(
                  text: ' Son causas de rescisión de la relación de trabajo, sin responsabilidad para el patrón: I. Engañarlo el trabajador o en su caso, el sindicato que lo hubiese propuesto o recomendado con certificados falsos o referencias en los que se atribuyan al trabajador capacidad, aptitudes o facultades de que carezca.',
                  style: pw.TextStyle(fontSize: 7)
                ),
              ],
            ),
          )
          ]
        )
      )]
      );
    }
    )
  );


  /** PAGINA 3 */
  pdf.addPage(
  pw.Page(
    pageFormat: PdfPageFormat.letter,
    margin: const pw.EdgeInsets.all(20),
    build: (pw.Context context) {
      return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      mainAxisAlignment: pw.MainAxisAlignment.start, 
        children: [
          pw.Container(
            margin: const pw.EdgeInsets.only(top: 40),
            height: 40,
            width: double.infinity,
            alignment: pw.Alignment.bottomCenter,
            padding: const pw.EdgeInsets.only(bottom: 2),
            decoration: pw.BoxDecoration(
              color: PdfColors.grey300,
              border: pw.Border.all(width: 0.5)
            ),
            child: pw.Text('PARTE 2: PARA SER LLENADO POR EL MÉDICO',style: letterBold12,),
          ),
          pw.Container(
            margin: const pw.EdgeInsets.only(top: 20),
            child: pw.Text('6.- INTERROGATORIO POR APARATOS Y SISTEMAS.',style: letterBold12),
          ),
          pw.Container(
            padding: const pw.EdgeInsets.all(10),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: 0.5)
            ),
            child:pw.Column(
            children: [
              pw.Row(
                children: [
                pw.Text('Sentidos ', style: letterText12,),
                pw.Container(
                  width: 430,
                  height: 0.5,
                  margin: const pw.EdgeInsets.only(top: 10),
                  color: PdfColors.black,
                ),
                ]
              ),
              pw.SizedBox(height: 10),
              pw.Row(
                children: [
                pw.Text('Digestivo ', style: letterText12),
                pw.Container(
                  width: 430,
                  height: 0.5,
                  margin: const pw.EdgeInsets.only(top: 10),
                  color: PdfColors.black,
                ),
                ]
              ),
              pw.SizedBox(height: 10),
              pw.Row(
                children: [
                pw.Text('Respiratorio ', style: letterText12),
                pw.Container(
                  width: 430,
                  height: 0.5,
                  margin: const pw.EdgeInsets.only(top: 10),
                  color: PdfColors.black,
                ),
                ]
              ),
              pw.SizedBox(height: 10),
              pw.Row(
                children: [
                pw.Text('Circulatorio ', style: letterText12),
                pw.Container(
                  width: 430,
                  height: 0.5,
                  margin: const pw.EdgeInsets.only(top: 10),
                  color: PdfColors.black,
                ),
                ]
              ),
              pw.SizedBox(height: 10),
              pw.Row(
                children: [
                pw.Text('Genitourinario ', style: letterText12),
                pw.Container(
                  width: 430,
                  height: 0.5,
                  margin: const pw.EdgeInsets.only(top: 10),
                  color: PdfColors.black,
                ),
                ]
              ),
              pw.SizedBox(height: 10),
              pw.Row(
                children: [
                pw.Text('Músculo /Esquéletico ', style: letterText12),
                pw.Container(
                  width: 430,
                  height: 0.5,
                  margin: const pw.EdgeInsets.only(top: 10),
                  color: PdfColors.black,
                ),
                ]
              ),
              pw.SizedBox(height: 10),
              pw.Row(
                children: [
                  pw.Text('Nervioso ', style: letterText12),
                  pw.Container(
                    width: 430,
                    height: 0.5,
                    margin: const pw.EdgeInsets.only(top: 10),
                    color: PdfColors.black,
                  )
                ] 
              )
            ]
            )
          ),
          pw.Text('7.-EXPLORACIÓN FÍSICA.',style: letterBold12),
          pw.Container(
            padding: const pw.EdgeInsets.all(10),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: 0.5)
            ),
            child:pw.Container(
            child: 
              pw.Row(
                children:[
                  pw.Text('T/A ', style: letterText),
                  pw.Container(
                    width: 40,
                    height: 0.5,
                    margin: const pw.EdgeInsets.only(top: 10),
                    color: PdfColors.black,
                  ),
                  pw.Text('mmhg  ', style: letterText),
                  pw.Text('F/C ', style: letterText),
                  pw.Container(
                    width: 40,
                    height: 0.5,
                    margin: const pw.EdgeInsets.only(top: 10),
                    color: PdfColors.black,
                  ),
                  pw.Text('  Peso ', style: letterText),
                  pw.Container(
                    width: 40,
                    height: 0.5,
                    margin: const pw.EdgeInsets.only(top: 10),
                    color: PdfColors.black,
                  ),
                  pw.Text('Kg ', style: letterText),
                  pw.Text(' Talla ', style: letterText),
                  pw.Container(
                    width: 40,
                    height: 0.5,
                    margin: const pw.EdgeInsets.only(top: 10),
                    color: PdfColors.black,
                  ),
                  pw.Text('cm  ', style: letterText),
                  pw.Text('P.abd ', style: letterText),
                  pw.Container(
                    width: 40,
                    height: 0.5,
                    margin: const pw.EdgeInsets.only(top: 10),
                    color: PdfColors.black,
                  ),
                  pw.Text(' F/R ', style: letterText),
                  pw.Container(
                    width: 40,
                    height: 0.5,
                    margin: const pw.EdgeInsets.only(top: 10),
                    color: PdfColors.black,
                  ),
                  pw.Text(' Temp. ', style: letterText),
                  pw.Container(
                    width: 40,
                    height: 0.5,
                    margin: const pw.EdgeInsets.only(top: 10),
                    color: PdfColors.black,
                  ),
                  pw.Text(' I.M.C. ', style: letterText),
                  pw.Container(
                    width: 40,
                    height: 0.5,
                    margin: const pw.EdgeInsets.only(top: 10),
                    color: PdfColors.black,
                  ),
                ] 
              )
            )
          ),
          pw.SizedBox(height: 10,),
          buildGridCustom()
        ]
      );
      
    }
  )
  );

  /**PAGINA 4 */
  pdf.addPage(
  pw.Page(
    pageFormat: PdfPageFormat.letter,
    margin: const pw.EdgeInsets.all(20),
    build: (pw.Context context) {
      return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      mainAxisAlignment: pw.MainAxisAlignment.start, 
        children: [
          pw.Container(
            margin: const pw.EdgeInsets.only(left: 60,right: 60,top: 40),
            decoration: pw.BoxDecoration(border: pw.Border.all(width: 0.5)),
            padding: const pw.EdgeInsets.all(10),
            child: pw.Column(
              children: [
                pw.Row(
                  children: [
                    pw.Text('DE CERCA A 30CM', style: letterText12),
                    pw.Spacer(),
                    pw.Text('OD JAEGUER J', style: letterText12),
                    pw.Spacer(),
                    pw.Text('OD ROSENBAUN 20/', style: letterText12)
                  ]
                ),
                pw.Row(
                  children: [
                    pw.Text('LENTES SI ', style: letterText12),
                    pw.Text('NO ', style: letterText12),
                    pw.Spacer(),
                    pw.Text('OI JAEGUER J', style: letterText12),
                    pw.Spacer(),
                    pw.Text('OD ROSENBAUN 20/', style: letterText12)
                  ]
                ),
                pw.SizedBox(height: 20),
                pw.Row(
                  children: [
                    pw.Text('DE LEJOS SNELLEN OD 20/', style: letterText12),
                    pw.Text('  ', style: letterText12),
                    pw.Text('OI 20/', style: letterText12),
                    pw.Text('  ', style: letterText12)
                  ]
                ),
                pw.Row(
                  children: [
                    pw.Text('LENTES  ', style: letterText12),
                    pw.Text(' SI ', style: letterText12),
                    pw.Text(' NO ', style: letterText12),
                  ]
                ),
                pw.Row(
                  children: [
                    pw.Text('CAMPIMETRIA  ', style: letterText12),
                    pw.Text(' OD ', style: letterText12),
                    pw.Text(' OI ', style: letterText12),
                    pw.Text(' COLOR ', style: letterText12),
                  ]
                ),
                pw.SizedBox(height: 20),
                pw.Row(
                  children: [
                    pw.Text('AMSLER NORMAL ', style: letterText12),
                    pw.Text(' SI ', style: letterText12),
                    pw.Text(' NO ', style: letterText12)
                  ]
                )
              ]
            ),
          ),
          pw.SizedBox(height: 20),
          pw.Text('8.-ANÁLISIS DE LABORATORIO',style: letterBold12),
          pw.Container(
            width: double.infinity,
            decoration: pw.BoxDecoration(border: pw.Border.all(width: 0.5)),
            padding: const pw.EdgeInsets.all(10),
            child: pw.Column(
              children: [
                pw.Row(
                  children: [
                    pw.Text('Resultados ', style: letterText12),
                    pw.Container(
                      width: 450,
                      height: 0.5,
                      margin: const pw.EdgeInsets.only(top: 10),
                      color: PdfColors.black,
                    )
                  ]
                ),
                pw.Row(
                  children: [
                    pw.Text('Drogas ', style: letterText12),
                    pw.Container(
                      width: 450,
                      height: 0.5,
                      margin: const pw.EdgeInsets.only(top: 10),
                      color: PdfColors.black,
                    ),
                  ]
                )
              ]
            )
          ),
          pw.SizedBox(height: 20),
          pw.Text('9.-ESTUDIOS DE GABINETE',style: letterBold12),
          pw.Container(
            decoration: pw.BoxDecoration(border: pw.Border.all(width: 0.5)),
            padding: const pw.EdgeInsets.all(10),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                pw.Text('Telerradiografía de Tórax', style: letterText12),
                pw.Text('', style: letterText12),
                pw.Text('RX Columna Lumbar', style: letterText12),
                pw.Text('', style: letterText12),
                pw.Text('Otros', style: letterText12),
                pw.Row(
                  children: [
                    pw.Text('Espirometria: ( - ) ( + )   ', style: letterText12),
                    pw.Text('Audiometria: ( - ) ( + )   ', style: letterText12),
                    pw.Text('Prueba covid-19 ( - ) ( + )   ', style: letterText12),
                    pw.Text('Embarazo: ( - ) ( + )', style: letterText12)
                  ]
                ),
                pw.Text('Antidoping: ( - ) ( + )', style: letterText12),
                
              ]
            )
          ),
          pw.SizedBox(height: 20),
          pw.Text('DICTAMEN MÉDICO', style: letterBold12.copyWith(fontSize: 10)),
          pw.Row(
            children: [
              pw.Text('  Apto: ', style: letterText12),
              pw.Container(
                width: 100,
                height: 0.5,
                margin: const pw.EdgeInsets.only(top: 10),
                color: PdfColors.black,
              ),
              pw.Text('  No Apto: ', style: letterText12),
              pw.Container(
                width: 100,
                height: 0.5,
                margin: const pw.EdgeInsets.only(top: 10),
                color: PdfColors.black,
              ),
              pw.Text('  Apto Con reserva: ', style: letterText12),
              pw.Container(
                width: 100,
                height: 0.5,
                margin: const pw.EdgeInsets.only(top: 10),
                color: PdfColors.black,
              ),
            ]
          ),
          pw.SizedBox(height: 30),
          pw.Container(
            padding: pw.EdgeInsets.only(top: 20, bottom: 20),
            width: double.infinity,
            decoration: pw.BoxDecoration(border: pw.Border(top: pw.BorderSide(color: PdfColors.black, width: 2), bottom: pw.BorderSide(color: PdfColors.black,width: 2))),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                pw.Text('CONDICIONES Y OBSERVACIONES', style: letterText10),
                pw.Container(
                width: double.infinity,
                height: 0.5,
                margin: const pw.EdgeInsets.only(top: 10),
                color: PdfColors.black,
                child: pw.Text('')
              ),
              ]
            )
          ),
          pw.SizedBox(height: 45),
          pw.Container(
            child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Spacer(),
                pw.Container(
                  alignment: pw.Alignment.center,
                  child: pw.Column(
                    children: [
                      pw.Text('_______________________________',style:letterText10),
                      pw.Text('Firma de Aspirante',style:letterText10)
                    ]
                  )
                ),
                pw.Spacer(),
                pw.Container(
                  alignment: pw.Alignment.center,
                  child: pw.Column(
                    children: [
                      pw.Text('_______________________________',style:letterText10),
                      pw.Text('Nombre, Firma y Ced. Prof. del Médico\nDr. Alfredo Gruel Culebro',style:letterText10)
                    ]
                  )
                ),
                pw.Spacer(),
              ]
            ),
          )
        ]
      );
  })
  );
  stopwatch.stop();
  print(' El Tiempo de renderizado del pdf es de : ${stopwatch.elapsedMilliseconds} milisegundos');





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





