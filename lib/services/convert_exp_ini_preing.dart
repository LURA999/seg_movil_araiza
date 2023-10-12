import 'dart:convert';
import 'dart:io';
import 'package:app_seguimiento_movil/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../models/models.dart';


String departamentName(List<Map<String,dynamic>> arrDepartaments, List<String>? multiInputArr) {
final List<String> claves = arrDepartaments[0].keys.toList();

  if (multiInputArr != null){
    return arrDepartaments[arrDepartaments.indexWhere((el) => int.parse(el[claves[0]]) == int.parse(multiInputArr[1]))][claves[1]];
  }else{
    return ' N/A';
  }
}

//background heredity
String BackHeredity(int x, int y, List<List<bool>>? arr) {
  if (arr !=null) {
    if (arr[x][y] == true) {
      return 'X';
    } else {
      return '';
    }
  } else {
    return '';
  }
    
}

String YesNotFunction(int x, List<YesNot>? arr , int type) {
  if (arr !=null) {
    if (arr[x] == YesNot.si && type == 1 || arr[x] == YesNot.no && type == 2) {
      return 'X';
    } else {
      return '';
    }
  } else {
    return '';
  }
    
}

void generatePDF( BuildContext context, bool save,List<Map<String,dynamic>> arrDepartaments, List<String>? multiInputArr ,
List<String>? multiInputHArr, List<String>? multiInputAEArr, List<List<bool>>? checkBoxArr, List<YesNot>? yestNotEnumArr, 
List<List<bool>>? checkboxDLNArr, List<Cause>? causeDiseaseArr, List<YesNot>? yestNotEnumArrDisease,List<ManoDominante>? manoArr,
List<MetodoAnti>? methodArr) async {
  
int multiInputC = 1; 
int multiInputCH = 0; 
int multiInputCAE = 0; 
int radioButtonC = 0; 
int radioButtonCDisease = 0; 
int radioButtonCDiseaseYN = 0; 

List months = 
['ENERO', 'FEBRERO', 'MARZO', 'ABRIL', 'MAYO','JUNIO','JULIO','AGOSTO','SEPTIEMBRE','OCTUBRE','NOVIEMBRE','DICIEMBRE'];
  final DateTime now = DateTime.now();
  bool storagePermissionGranted = false;
  if (Platform.isAndroid || Platform.isIOS) {
  await requestPermission((bool granted) {
    storagePermissionGranted = granted;
  }); 
   
  if (!storagePermissionGranted) {
    try {
      throw Exception('No se han concedido los permisos de almacenamiento.');      
    } catch (e) {
    //  print(e);
    }
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
        {'rowName': 'Padre:', 'Buena_salud ': BackHeredity(0,0,checkBoxArr),'Mala_Salud ': BackHeredity(0,1,checkBoxArr), 'Finado': BackHeredity(0,2,checkBoxArr),'Alergia': BackHeredity(0,3,checkBoxArr), 'Diabetes': BackHeredity(0,4,checkBoxArr), 'Presion_alta':BackHeredity(0,5,checkBoxArr),'Colesterol':BackHeredity(0,6,checkBoxArr),'Enf_Corazon':BackHeredity(0,7,checkBoxArr),'Cancer':BackHeredity(0,8,checkBoxArr),'Anemia':BackHeredity(0,9,checkBoxArr)},
        {'rowName': 'Madre:', 'Buena_salud ': BackHeredity(1,0,checkBoxArr),'Mala_Salud ': BackHeredity(1,1,checkBoxArr), 'Finado': BackHeredity(1,2,checkBoxArr),'Alergia': BackHeredity(1,3,checkBoxArr), 'Diabetes': BackHeredity(1,4,checkBoxArr), 'Presion_alta':BackHeredity(1,5,checkBoxArr),'Colesterol':BackHeredity(1,6,checkBoxArr),'Enf_Corazon':BackHeredity(1,7,checkBoxArr),'Cancer':BackHeredity(1,8,checkBoxArr),'Anemia':BackHeredity(1,9,checkBoxArr)},
        {'rowName': 'Hermanos:', 'Buena_salud ': BackHeredity(2,0,checkBoxArr),'Mala_Salud ': BackHeredity(2,1,checkBoxArr), 'Finado': BackHeredity(2,2,checkBoxArr),'Alergia': BackHeredity(2,3,checkBoxArr), 'Diabetes': BackHeredity(2,4,checkBoxArr), 'Presion_alta':BackHeredity(2,5,checkBoxArr),'Colesterol':BackHeredity(2,6,checkBoxArr),'Enf_Corazon':BackHeredity(2,7,checkBoxArr),'Cancer':BackHeredity(2,8,checkBoxArr),'Anemia':BackHeredity(2,9,checkBoxArr)},
        {'rowName': '', 'Buena_salud ': '','Mala_Salud ': '', 'Finado': '','Alergia': '', 'Diabetes': '', 'Presion_alta':'','Colesterol':'','Enf_Corazon':'','Cancer':'','Anemia':''},
        {'rowName': 'Pareja:', 'Buena_salud ': BackHeredity(3,0,checkBoxArr),'Mala_Salud ': BackHeredity(3,1,checkBoxArr), 'Finado': BackHeredity(3,2,checkBoxArr),'Alergia': BackHeredity(3,3,checkBoxArr), 'Diabetes': BackHeredity(3,4,checkBoxArr), 'Presion_alta':BackHeredity(3,5,checkBoxArr),'Colesterol':BackHeredity(3,6,checkBoxArr),'Enf_Corazon':BackHeredity(3,7,checkBoxArr),'Cancer':BackHeredity(3,8,checkBoxArr),'Anemia':BackHeredity(3,9,checkBoxArr)},
        {'rowName': 'Hijos:', 'Buena_salud ': BackHeredity(4,0,checkBoxArr),'Mala_Salud ': BackHeredity(4,1,checkBoxArr), 'Finado': BackHeredity(4,2,checkBoxArr),'Alergia': BackHeredity(4,3,checkBoxArr), 'Diabetes': BackHeredity(4,4,checkBoxArr), 'Presion_alta':BackHeredity(4,5,checkBoxArr),'Colesterol':BackHeredity(4,6,checkBoxArr),'Enf_Corazon':BackHeredity(4,7,checkBoxArr),'Cancer':BackHeredity(4,8,checkBoxArr),'Anemia':BackHeredity(4,9,checkBoxArr)},
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
                child: pw.Text('Buena\nsaluD ',
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
                child: pw.Text('Mala\nsaluD ',
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
                child: pw.Text(e['Buena_salud '].toString(),
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
                child: pw.Text(e['Mala_Salud '].toString(),
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
                multiInputHArr != null ? multiInputHArr[index * 11] : '',
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
                multiInputHArr != null ? multiInputHArr[1 + (index * 11)] : '', 
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
                multiInputHArr != null ? multiInputHArr[2 + (index * 11)] : '',
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
                multiInputHArr != null ? multiInputHArr[3 + (index * 11)] : '',
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
                multiInputHArr != null ? multiInputHArr[4 + (index * 11)] : '',
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
                multiInputHArr != null ? multiInputHArr[5 + (index * 11)] : '',
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
                multiInputHArr != null ? multiInputHArr[6 + (index * 11)] : '',
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
                multiInputHArr != null ? multiInputHArr[7 + (index * 11)] : '',
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
                multiInputHArr != null ? multiInputHArr[8 + (index * 11)] : '',
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
                multiInputHArr != null ? multiInputHArr[9 + (index * 11)] : '',
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
                multiInputHArr != null ? multiInputHArr[10 + (index * 11)] : '',
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
                    'Nombre de la lesión o enfermedad ',
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
                  'Incapacidad ',
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
                  'Número de dias de incapacidad ',
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
                        'Si ',
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
        ...List<pw.Row>.generate(3, (int index) {  
        return pw.Row(
        children: [
          pw.SizedBox(
            width: firstCellWidthTabHead,
            child: pw.Container(
              alignment: pw.Alignment.center,
              child: pw.Text(
                multiInputAEArr!= null ? multiInputAEArr[index * 5] : '',
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
                multiInputAEArr!= null ? multiInputAEArr[1 + (index * 5)] : '',
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
                multiInputAEArr!= null ? multiInputAEArr[2 + (index * 5)] : '',
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
                causeDiseaseArr!=null ? causeDiseaseArr[index] == Cause.none ? '' : causeDiseaseArr[index] == Cause.accidente ? '' : 'X' : '',
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
                causeDiseaseArr!=null ? causeDiseaseArr[index] == Cause.none ? '' : causeDiseaseArr[index] == Cause.accidente ? 'X' : '' : '',
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
                multiInputAEArr!= null ? multiInputAEArr[3 + (index * 5)] : '',
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
                yestNotEnumArrDisease != null ? yestNotEnumArrDisease[index]  == YesNot.none ? '' : yestNotEnumArrDisease[index] == YesNot.si ? 'X' : '' : '',
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
                yestNotEnumArrDisease != null ? yestNotEnumArrDisease[index]  == YesNot.none ? '' : yestNotEnumArrDisease[index] == YesNot.si ? '' : 'X' : '',
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
                multiInputAEArr!= null ? multiInputAEArr[4 + (index * 5)] : '',
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
        child: pw.Text('EXAMEN MÉDICO LABORAL: INICIAL ( ${YesNotFunction(radioButtonC, yestNotEnumArr, 1)} ) PRE INGRESO ( ${YesNotFunction(radioButtonC, yestNotEnumArr, 2)} )', style:letterBold12,textAlign: pw.TextAlign.center)
      ),
      pw.Text('PARTE 1: PARA SER LLENADA POR EL PACIENTE', style: letterBold12,textAlign: pw.TextAlign.center),
      pw.SizedBox(height: PdfPageFormat.letter.height * 0.01),
      pw.Row(
      children: [
        pw.Text('FECHA: ',style: letterBold12), 
        pw.Container(
          child: pw.Text('${now.day} DE ${months[now.month-1]} DEL ${now.year}'),
            decoration: pw.BoxDecoration(
              border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
            )
          ) 
        ),
        pw.Spacer(),
        pw.Text('DEPARTAMENTO: ',style: letterBold12), 
        pw.Container(
          child: pw.Text(departamentName(arrDepartaments, multiInputArr)),
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
          child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] :  ''),
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
              child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] :  '',style: letterText),
                decoration: pw.BoxDecoration(
                  border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                )
              ) 
            ),
            pw.Spacer(),
            pw.Text('Sexo: ',style: letterText), 
            pw.Container(
              padding: const pw.EdgeInsets.all(2),
              child: pw.Text(multiInputArr != null ? (int.parse(multiInputArr[++multiInputC]) == 1 ? 'H' : 'M') :  '',style: letterText),
                decoration: pw.BoxDecoration(
                  border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                )
              ) 
            ),
            pw.Spacer(),
            pw.Text('Edad: ',style: letterText), 
            pw.Container(
              padding: const pw.EdgeInsets.all(2),
              child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText),
                decoration: pw.BoxDecoration(
                  border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                )
              ) 
            ),
            pw.Spacer(),
            pw.Text('Edo. Civil: ',style: letterText), 
            pw.Container(
              padding: const pw.EdgeInsets.all(2),
              child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText),
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
              child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText),
                decoration: pw.BoxDecoration(
                  border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                )
              ) 
            ),
            pw.Spacer(),
            pw.Text('Tel. fijo y/o cel: ',style: letterText),
            pw.Container(
              padding: const pw.EdgeInsets.all(2),
              child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText),
                decoration: pw.BoxDecoration(
                  border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                )
              ) 
            ),
            ]
          ),
          pw.Row(
          children: [
            pw.Text('Lugar y fecha de nacimiento: ',style: letterText), 
            pw.Container(
              padding: const pw.EdgeInsets.all(2),
              child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText),
                decoration: pw.BoxDecoration(
                  border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                )
              ) 
            ),
            pw.Spacer(),
            pw.Text('Actividad extra a su trabajo: ',style: letterText), 
            pw.Container(
              padding: const pw.EdgeInsets.all(2),
              child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText),
                decoration: pw.BoxDecoration(
                  border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                )
              ) 
            ),
            ]
          ),
          pw.Row(
          children: [
            pw.Text('Escolaridad: ',style: letterText), 
            pw.Container(
              padding: const pw.EdgeInsets.all(2),
              child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText),
                decoration: pw.BoxDecoration(
                  border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                )
              )
            ),
            pw.Spacer(),
            pw.Text('Carrera universitaria:',style: letterText), 
            pw.Container(
              padding: const pw.EdgeInsets.all(2),
              child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText),
                decoration: pw.BoxDecoration(
                  border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                )
              )
            ),
            pw.Spacer(),
            pw.Text('Núm. de hijos:',style: letterText), 
            pw.Container(
              padding: const pw.EdgeInsets.all(2),
              child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText),
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
                    pw.SizedBox(width: 5),
                    pw.Container(
                      child: pw.Text('DLN',style: letterText10.copyWith(fontWeight: pw.FontWeight.bold)),
                      decoration: checkboxDLNArr !=null ? checkboxDLNArr[0][0] == true ? 
                      pw.BoxDecoration(
                        shape:  pw.BoxShape.circle,
                        border: pw.Border.all(color: PdfColors.red)
                      ) : null : null
                    )
                  ],
                ),
              pw.Row(children: 
              [
                pw.Text('Actitud: ',style: letterText10),
                pw.Container(
                padding: const pw.EdgeInsets.all(2),
                child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                  decoration: pw.BoxDecoration(
                    border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                )
              ]) ,
            pw.Row(children: [
                pw.Text('Marcha: ',style: letterText10),
                pw.Container(
                padding: const pw.EdgeInsets.all(2),
                child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                  decoration: pw.BoxDecoration(
                    border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                )
            ])
              ,
              pw.Row(children: [
                pw.Text('Apariencia: ',style: letterText10),
                pw.Container(
                padding: const pw.EdgeInsets.all(2),
                child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                  decoration: pw.BoxDecoration(
                    border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                ),

              ]),
              pw.Row(children: [
                pw.Text('Edo. ánimo: ',style: letterText10),
                pw.Container(
                padding: const pw.EdgeInsets.all(2),
                child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                  decoration: pw.BoxDecoration(
                    border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                )
              ])
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
                    pw.SizedBox(width: 5),
                    pw.Container(
                      child: pw.Text('DLN',style: letterText10.copyWith(fontWeight: pw.FontWeight.bold)),
                      decoration: checkboxDLNArr !=null ? checkboxDLNArr[0][1] == true ? 
                      pw.BoxDecoration(
                        shape:  pw.BoxShape.circle,
                        border: pw.Border.all(color: PdfColors.red)
                      ) : null : null
                    )
                  ],
                ),
                pw.Row(
                  children: [
                    pw.Text('Oreja   ',style: letterText10),
                    pw.Text('D ',style: letterText10),
                    pw.Container(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                      decoration: pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                        )
                      ) 
                    ),
                    pw.SizedBox(width: 5),
                    pw.Text('I ',style: letterText10),
                    pw.Container(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                      decoration: pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                        )
                      ) 
                    )
                  ],
                ),
                pw.Row(
                  children: [
                    pw.Text('C A E   ',style: letterText10),
                    pw.Text('D ',style: letterText10),
                    pw.Container(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                      decoration: pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                        )
                      ) 
                    ),
                    pw.SizedBox(width: 5),
                    pw.Text('I ',style: letterText10),
                    pw.Container(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                      decoration: pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                        )
                      ) 
                    ),
                    pw.SizedBox(width: 5),
                  ],
                ),
                pw.Row(
                  children: [
                    pw.Text('Tímpano   ',style: letterText10),
                    pw.Text('D ',style: letterText10),
                    pw.Container(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                      decoration: pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                        )
                      ) 
                    ),
                    pw.SizedBox(width: 5),
                    pw.Text('I ',style: letterText10),
                    pw.Container(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                      decoration: pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                        )
                      ) 
                    ),
                    pw.SizedBox(width: 5),
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
                    pw.SizedBox(width: 5),
                    pw.Container(
                      child: pw.Text('DLN',style: letterText10.copyWith(fontWeight: pw.FontWeight.bold)),
                      decoration: checkboxDLNArr !=null ? checkboxDLNArr[0][2] == true ? 
                      pw.BoxDecoration(
                        shape:  pw.BoxShape.circle,
                        border: pw.Border.all(color: PdfColors.red)
                      ) : null : null
                    )
                  ],
                ),
              pw.Row(children: [
                pw.Text('Cabello: ',style: letterText10),
                pw.Container(
                padding: const pw.EdgeInsets.all(2),
                child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                  decoration: pw.BoxDecoration(
                    border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                )
              ]),
              pw.Row(children: [
                pw.Text('Superficie: ',style: letterText10),
                pw.Container(
                padding: const pw.EdgeInsets.all(2),
                child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                  decoration: pw.BoxDecoration(
                    border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                )
              ]),
              pw.Row(children: [
                pw.Text('Forma: ',style: letterText10),
                pw.Container(
                padding: const pw.EdgeInsets.all(2),
                child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                  decoration: pw.BoxDecoration(
                    border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                )
              ]),
              pw.Row(children: [
                pw.Text('Senos PN: ',style: letterText10),
                pw.Container(
                padding: const pw.EdgeInsets.all(2),
                child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                  decoration: pw.BoxDecoration(
                    border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                )
              ]) 
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
                    pw.SizedBox(width: 5),
                    pw.Container(
                      child: pw.Text('DLN',style: letterText10.copyWith(fontWeight: pw.FontWeight.bold)),
                      decoration: checkboxDLNArr !=null ? checkboxDLNArr[0][3] == true ? 
                      pw.BoxDecoration(
                        shape:  pw.BoxShape.circle,
                        border: pw.Border.all(color: PdfColors.red)
                      ) : null : null
                    )
                  ],
                ),
              pw.Row(children: [
                pw.Text('Reflejos: ',style: letterText10),
                pw.Container(
                padding: const pw.EdgeInsets.all(2),
                child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                  decoration: pw.BoxDecoration(
                    border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                )
              ]),
              pw.Row(children: [
                pw.Text('Pupilares: ',style: letterText10),
                pw.Container(
                padding: const pw.EdgeInsets.all(2),
                child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                  decoration: pw.BoxDecoration(
                    border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                )
              ]),
              pw.Row(children: [
                pw.Text('Fondo de Ojo: ',style: letterText10),
                pw.Container(
                padding: const pw.EdgeInsets.all(2),
                child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                  decoration: pw.BoxDecoration(
                    border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                )
              ]),
                pw.Row(
                  children: [
                    pw.Text('Pterigion   ',style: letterText10),
                    pw.Text('D ',style: letterText10),
                    pw.Container(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                      decoration: pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                        )
                      ) 
                    ),
                    pw.SizedBox(width: 5),
                    pw.Text('I ',style: letterText10),
                    pw.Container(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                      decoration: pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                        )
                      ) 
                    ),
                    pw.SizedBox(width: 5),
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
                        pw.SizedBox(width: 5),
                        pw.Container(
                        child: pw.Text('DLN',style: letterText10.copyWith(fontWeight: pw.FontWeight.bold)),
                        decoration: checkboxDLNArr !=null ? checkboxDLNArr[0][4] == true ? 
                        pw.BoxDecoration(
                          shape:  pw.BoxShape.circle,
                          border: pw.Border.all(color: PdfColors.red)
                        ) : null : null
                    )
                      ],
                    ),
                  pw.Row(children: [
                    pw.Text('Reflejos OT: ',style: letterText10),
                    pw.Container(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                      decoration: pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                        )
                      ) 
                    )
                  ]),
                  pw.Row(children: [
                    pw.Text('Romberg: ',style: letterText10),
                    pw.Container(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                      decoration: pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                        )
                      ) 
                    )
                  ]),
                  pw.Row(children: [
                    pw.Text('Talón Rodilla:  ',style: letterText10),
                    pw.Container(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                      decoration: pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                        )
                      ) 
                    )
                  ])
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
                    pw.SizedBox(width: 5),
                    pw.Container(
                      child: pw.Text('DLN',style: letterText10.copyWith(fontWeight: pw.FontWeight.bold)),
                      decoration: checkboxDLNArr !=null ? checkboxDLNArr[0][5] == true ? 
                      pw.BoxDecoration(
                        shape:  pw.BoxShape.circle,
                        border: pw.Border.all(color: PdfColors.red)
                      ) : null : null
                    )
                  ],
                ),
              pw.Row(children: [
                pw.Text('Labios: ',style: letterText10),
                pw.Container(
                padding: const pw.EdgeInsets.all(2),
                child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ' /*'Lorem Ipsum es hol'*/,style: letterText10),
                  decoration: pw.BoxDecoration(
                    border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                )
              ]),
              pw.Row(children: [
                pw.Text('Aliento: ',style: letterText10),
                pw.Container(
                padding: const pw.EdgeInsets.all(2),
                child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                  decoration: pw.BoxDecoration(
                    border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                )
              ]),
              pw.Row(children: [
                pw.Text('Lengua: ',style: letterText10),
                pw.Container(
                padding: const pw.EdgeInsets.all(2),
                child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                  decoration: pw.BoxDecoration(
                    border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                )
              ]),
              pw.Row(children: [
                pw.Text('Faringe: ',style: letterText10),
                pw.Container(
                padding: const pw.EdgeInsets.all(2),
                child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                  decoration: pw.BoxDecoration(
                    border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                )
              ]),
              pw.Row(children: [
                pw.Text('Amígdalas: ',style: letterText10),
                pw.Container(
                padding: const pw.EdgeInsets.all(2),
                child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                  decoration: pw.BoxDecoration(
                    border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                )
              ]),
              pw.Row(children: [
                pw.Text('Dientes: ',style: letterText10),
                pw.Container(
                padding: const pw.EdgeInsets.all(2),
                child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                  decoration: pw.BoxDecoration(
                    border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                )
              ]),
              pw.Row(children: [
                pw.Text('Mucosa: ',style: letterText10),
                pw.Container(
                padding: const pw.EdgeInsets.all(2),
                child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                  decoration: pw.BoxDecoration(
                    border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                )
              ])
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
                    pw.SizedBox(width: 5),
                    pw.Container(
                      child: pw.Text('DLN',style: letterText10.copyWith(fontWeight: pw.FontWeight.bold)),
                      decoration: checkboxDLNArr !=null ? checkboxDLNArr[0][6] == true ? 
                      pw.BoxDecoration(
                        shape:  pw.BoxShape.circle,
                        border: pw.Border.all(color: PdfColors.red)
                      ) : null : null
                    )
                  ],
                ),
              pw.Row(children: [
                pw.Text('Forma: ',style: letterText10),
                pw.Container(
                padding: const pw.EdgeInsets.all(2),
                child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                  decoration: pw.BoxDecoration(
                    border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                )
              ]),
              pw.Row(children: [
                pw.Text('Diafragma: ',style: letterText10),
                pw.Container(
                padding: const pw.EdgeInsets.all(2),
                child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                  decoration: pw.BoxDecoration(
                    border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                )
              ]),
              pw.Row(children: [
                pw.Text('Frotes: ',style: letterText10),
                pw.Container(
                padding: const pw.EdgeInsets.all(2),
                child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                  decoration: pw.BoxDecoration(
                    border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                )
              ]),
              pw.Row(children: [
                pw.Text('Ventilación: ',style: letterText10),
                pw.Container(
                padding: const pw.EdgeInsets.all(2),
                child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                  decoration: pw.BoxDecoration(
                    border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                )
              ]),
              pw.Row(children: [
                pw.Text('Estertores: ',style: letterText10),
                pw.Container(
                padding: const pw.EdgeInsets.all(2),
                child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                  decoration: pw.BoxDecoration(
                    border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                )
              ]),
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
                    pw.SizedBox(width: 5),
                    pw.Container(
                      child: pw.Text('DLN',style: letterText10.copyWith(fontWeight: pw.FontWeight.bold)),
                      decoration: checkboxDLNArr !=null ? checkboxDLNArr[0][7] == true ? 
                      pw.BoxDecoration(
                        shape:  pw.BoxShape.circle,
                        border: pw.Border.all(color: PdfColors.red)
                      ) : null : null
                    )
                  ],
                ),
              pw.Row(children: [
                pw.Text('Forma: ',style: letterText10),
                pw.Container(
                padding: const pw.EdgeInsets.all(2),
                child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                  decoration: pw.BoxDecoration(
                    border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                )
              ]),
              pw.Row(children: [
                pw.Text('Dolor: ',style: letterText10),
                pw.Container(
                padding: const pw.EdgeInsets.all(2),
                child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                  decoration: pw.BoxDecoration(
                    border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                )
              ]),
              pw.Row(children: [
                pw.Text('Masas: ',style: letterText10),
                pw.Container(
                padding: const pw.EdgeInsets.all(2),
                child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                  decoration: pw.BoxDecoration(
                    border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                )
              ]),
                pw.Row(
                  children: [
                    pw.Text('Hernia   ',style: letterText10),
                    pw.Text('D ',style: letterText10),
                    pw.Container(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                      decoration: pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                        )
                      ) 
                    ),
                    pw.SizedBox(width: 5),
                    pw.Text('I ',style: letterText10),
                    pw.Container(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                      decoration: pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                        )
                      ) 
                    ),
                    pw.SizedBox(width: 5),
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
                    pw.SizedBox(width: 5),
                    pw.Container(
                      child: pw.Text('DLN',style: letterText10.copyWith(fontWeight: pw.FontWeight.bold)),
                      decoration: checkboxDLNArr !=null ? checkboxDLNArr[0][8] == true ? 
                      pw.BoxDecoration(
                        shape:  pw.BoxShape.circle,
                        border: pw.Border.all(color: PdfColors.red)
                      ) : null : null
                    )
                  ],
                ),
              pw.Row(children: [
                pw.Text('Septum: ',style: letterText10),
                pw.Container(
                padding: const pw.EdgeInsets.all(2),
                child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                  decoration: pw.BoxDecoration(
                    border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                ),
              ]),
                pw.Row(
                  children: [
                    pw.Text('Mucosa   ',style: letterText10),
                    pw.Text('D ',style: letterText10),
                    pw.Container(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                      decoration: pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                        )
                      ) 
                    ),
                    pw.SizedBox(width: 5),
                    pw.Text('I ',style: letterText10),
                    pw.Container(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                      decoration: pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                        )
                      ) 
                    ),
                    pw.SizedBox(width: 5),
                  ],
                ),
              pw.Row(children: [
                pw.Text('Ventilación: ',style: letterText10),
                pw.Container(
                padding: const pw.EdgeInsets.all(2),
                child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                  decoration: pw.BoxDecoration(
                    border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                )
              ])
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
                    pw.SizedBox(width: 5),
                   pw.Container(
                      child: pw.Text('DLN',style: letterText10.copyWith(fontWeight: pw.FontWeight.bold)),
                      decoration: checkboxDLNArr !=null ? checkboxDLNArr[0][9] == true ? 
                      pw.BoxDecoration(
                        shape:  pw.BoxShape.circle,
                        border: pw.Border.all(color: PdfColors.red)
                      ) : null : null
                    )
                  ],
                ),
              pw.Row(children: [
                pw.Text('Frecuencia: ',style: letterText10),
                pw.Container(
                padding: const pw.EdgeInsets.all(2),
                child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                  decoration: pw.BoxDecoration(
                    border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                )
              ]),
              pw.Row(children: [
                  pw.Text('Ritmo: ',style: letterText10),
                pw.Container(
                padding: const pw.EdgeInsets.all(2),
                child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                  decoration: pw.BoxDecoration(
                    border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                )
              ]),
              pw.Row(children: [
                pw.Text('Tonos: ',style: letterText10),
                pw.Container(
                padding: const pw.EdgeInsets.all(2),
                child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                  decoration: pw.BoxDecoration(
                    border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                )
              ]),
              pw.Row(children: [
                pw.Text('Frotes: ',style: letterText10),
                pw.Container(
                padding: const pw.EdgeInsets.all(2),
                child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                  decoration: pw.BoxDecoration(
                    border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                )
              ]),
              pw.Row(children: [
              pw.Text('Soplos: ',style: letterText10),
                pw.Container(
                padding: const pw.EdgeInsets.all(2),
                child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                  decoration: pw.BoxDecoration(
                    border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                )
              ]),
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
                    pw.Text('PIEL',style: letterText10.copyWith(fontWeight: pw.FontWeight.bold)),
                    pw.SizedBox(width: 5),
                    pw.Container(
                      child: pw.Text('DLN',style: letterText10.copyWith(fontWeight: pw.FontWeight.bold)),
                      decoration: checkboxDLNArr !=null ? checkboxDLNArr[0][10] == true ? 
                      pw.BoxDecoration(
                        shape:  pw.BoxShape.circle,
                        border: pw.Border.all(color: PdfColors.red)
                      ) : null : null
                    )
                  ],
                ),
              pw.Row(children: [
                pw.Text('Cicatrices',style: letterText10),
                pw.Container(
                padding: const pw.EdgeInsets.all(2),
                child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                  decoration: pw.BoxDecoration(
                    border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                )
              ]),
              pw.Row(children: [
                pw.Text('Textura: ',style: letterText10),
                pw.Container(
                padding: const pw.EdgeInsets.all(2),
                child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                  decoration: pw.BoxDecoration(
                    border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                )
              ]),
              pw.Row(children: [
                pw.Text('Diaforesis: ',style: letterText10),
                pw.Container(
                padding: const pw.EdgeInsets.all(2),
                child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                  decoration: pw.BoxDecoration(
                    border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                )
              ]),
              pw.Row(children: [
                pw.Text('Otras Lesiones: ',style: letterText10),
                pw.Container(
                padding: const pw.EdgeInsets.all(2),
                child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                  decoration: pw.BoxDecoration(
                    border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                )
              ]),
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
                    pw.SizedBox(width: 5),
                    pw.Container(
                      child: pw.Text('DLN',style: letterText10.copyWith(fontWeight: pw.FontWeight.bold)),
                      decoration: checkboxDLNArr !=null ? checkboxDLNArr[0][11] == true ? 
                      pw.BoxDecoration(
                        shape:  pw.BoxShape.circle,
                        border: pw.Border.all(color: PdfColors.red)
                      ) : null : null
                    )
                  ],
                ),
                pw.Row(
                  children: [
                    pw.Text('M.S. Articular ',style: letterText10),
                    pw.Text('D ',style: letterText10),
                    pw.Container(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                      decoration: pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                        )
                      ) 
                    ),
                    pw.SizedBox(width: 5),
                    pw.Text('I ',style: letterText10),
                    pw.Container(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                      decoration: pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                        )
                      ) 
                    ),
                  ],
                ),
                pw.Row(
                  children: [
                    pw.Text('Muscular   ',style: letterText10),
                    pw.Text('D ',style: letterText10),
                    pw.Container(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                      decoration: pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                        )
                      ) 
                    ),
                    pw.SizedBox(width: 5),
                    pw.Text('I ',style: letterText10),
                    pw.Container(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                      decoration: pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                        )
                      ) 
                    ),
                    pw.SizedBox(width: 5),
                  ],
                ),
                pw.Row(
                  children: [
                    pw.Text('Nervioso   ',style: letterText10),
                    pw.Text('D ',style: letterText10),
                    pw.Container(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                      decoration: pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                        )
                      ) 
                    ),
                    pw.SizedBox(width: 5),
                    pw.Text('I ',style: letterText10),
                    pw.Container(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                      decoration: pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                        )
                      ) 
                    ),
                    pw.SizedBox(width: 5),
                  ],
                ),
                pw.SizedBox(height: 10),
                pw.Container(
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
                        pw.Text('D ',style: letterText10),
                        pw.Container(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                      decoration: pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                        )
                      ) 
                    ),
                        pw.SizedBox(width: 5),
                        pw.Text('I ',style: letterText10),
                        pw.Container(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                      decoration: pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                        )
                      ) 
                    ),
                        pw.SizedBox(width: 5),
                      ]
                  ),
                  pw.Row(
                      children: [
                        pw.Text('Muscular   ',style: letterText10),
                        pw.Text('D ',style: letterText10),
                        pw.Container(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                      decoration: pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                        )
                      ) 
                    ),
                        pw.SizedBox(width: 5),
                        pw.Text('I ',style: letterText10),
                        pw.Container(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                      decoration: pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                        )
                      ) 
                    ),
                        pw.SizedBox(width: 5),
                      ]
                  ),
                  pw.Row(
                      children: [
                        pw.Text('Nervioso   ',style: letterText10),
                        pw.Text('D ',style: letterText10),
                        pw.Container(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                      decoration: pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                        )
                      ) 
                    ),
                        pw.SizedBox(width: 5),
                        pw.Text('I ',style: letterText10),
                        pw.Container(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                      decoration: pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                        )
                      ) 
                    ),
                        pw.SizedBox(width: 5),
                      ]
                  ),
                  ]
                )
              ),
              pw.SizedBox(height: 10),
              pw.Container(
                width: widthContainer,
                // decoration: pw.BoxDecoration(border: pw.Border.all()),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  children: [
                    pw.Row(
                      children: [
                        pw.Text('Columna: ',style: letterText10.copyWith(fontWeight: pw.FontWeight.bold)),
                        pw.Container(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                      decoration: pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                        )
                      ) 
                    ),
                        pw.SizedBox(width: 5),
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

  int manoDominante = 0;
  switch (manoArr !=null? manoArr[0] :  0) {
    case ManoDominante.diestro: manoDominante = 1; break;
    case ManoDominante.zurdo: manoDominante = 2; break;
    case ManoDominante.ambos: manoDominante = 3;  break;
    default: manoDominante = 0; break;
  }

  int methodAnti = 0;
  switch (methodArr !=null? methodArr[0] : 0) {
    case MetodoAnti.pastillas: methodAnti = 1; break;
    case MetodoAnti.dispositivo: methodAnti = 2; break;
    case MetodoAnti.condon: methodAnti = 3;  break;
    case MetodoAnti.otb: methodAnti = 4; break;
    case MetodoAnti.inyeccion: methodAnti = 5; break;
    case MetodoAnti.implante: methodAnti = 6; break;
    default: methodAnti = 0; break;
  }
  
  Uint8List transformationImage(String sign) {
    if (multiInputArr != null && sign != 'null' && sign != '') {
      return Uint8List.fromList(base64.decode(sign));
    }else{
      return Uint8List.fromList(base64.decode('iVBORw0KGgoAAAANSUhEUgAAABUAAAATCAIAAADwLNHcAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAAEnQAABJ0Ad5mH3gAAAAdSURBVDhPY/hPGRjVTxkY1U8ZGNVPGRja+v//BwBv0KiQRff68wAAAABJRU5ErkJggg=='));
    }

  }

  String paddingMarginSquare = ''; 
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
              child: pw.Text('5.1.-ANTECEDENTES PERSONALES NO PATOLÓGICOS                                      Diestro ( ${manoDominante == 1 ? 'X' : ''} ) Zurdo ( ${manoDominante == 2 ? 'X' : ''} ) Ambos ( ${manoDominante == 3 ? 'X' : ''} )',style: letterText10)
            ),
            pw.Row(
              children: [
                pw.Text('Tabaquismo   No ',style: letterText10), 
                pw.Container(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(YesNotFunction(++radioButtonC, yestNotEnumArr, 2),style: letterText),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                ),
                pw.Text(' SI ',style: letterText10), 
                pw.Container(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(YesNotFunction(radioButtonC, yestNotEnumArr, 1),style: letterText),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                ),
                pw.Spacer(),
                pw.Text('Edad de inicio: ',style: letterText10), 
                pw.Container(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                ),
                pw.Spacer(),
                pw.Text('Cantidad de cigarrillos al día: ',style: letterText10), 
                pw.Container(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                ),
                pw.Spacer(),
                pw.Text('Ingesta de alcohol   No ',style: letterText10), 
                pw.Container(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text( YesNotFunction(++radioButtonC, yestNotEnumArr, 2), style: letterText),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                ),
                pw.Text(' Si ',style: letterText10), 
                pw.Container(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(YesNotFunction(radioButtonC, yestNotEnumArr, 1),style: letterText),
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
                  child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                ),
                pw.Spacer(),
                pw.Text('Frecuencia: ',style: letterText10), 
                pw.Container(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                ),
                pw.Spacer(),
                pw.Text('Toxicomanías   No ',style: letterText10), 
                pw.Container(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(YesNotFunction(++radioButtonC, yestNotEnumArr, 2),style: letterText),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                ),
                pw.Text(' Si ',style: letterText10), 
                pw.Container(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(YesNotFunction(radioButtonC, yestNotEnumArr, 1),style: letterText),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                ),
                pw.Spacer(),
                pw.Text('Edad de inicio: ',style: letterText10), 
                pw.Container(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
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
                  child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                ),
                pw.Spacer(),
                pw.Text('Alergias a medicamentos   No ',style: letterText10), 
                pw.Container(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(YesNotFunction(++radioButtonC, yestNotEnumArr, 2),style: letterText),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                ),
                pw.Text(' Si ',style: letterText10), 
                pw.Container(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(YesNotFunction(radioButtonC, yestNotEnumArr, 1),style: letterText),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                ),
                pw.Spacer(),
                pw.Text(' ¿A cuál? ',style: letterText10), 
                pw.Container(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText),
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
                  child: pw.Text(YesNotFunction(++radioButtonC, yestNotEnumArr, 2),style: letterText),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                ),
                pw.Text(' Si ',style: letterText10), 
                pw.Container(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(YesNotFunction(radioButtonC, yestNotEnumArr, 1),style: letterText),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                ),
                pw.Spacer(),
                pw.Text(' ¿A cuál? ',style: letterText10), 
                pw.Container(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText),
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
                pw.Text('Vacunas en los últimos 12 meses: COVID-19 :   Si ',style: letterText), 
                pw.Container(
                margin: (paddingMarginSquare = YesNotFunction(++radioButtonC, yestNotEnumArr, 1)) == 'X' ? const pw.EdgeInsets.all(0) : const pw.EdgeInsets.all(4),
                padding: (paddingMarginSquare == 'X' ? const pw.EdgeInsets.only(right: 2,left: 2) :  const pw.EdgeInsets.all(4)),
                child: pw.Text(paddingMarginSquare,style: letterText),
                  decoration: pw.BoxDecoration(
                    border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                  )
                ),
                pw.Text(' No ',style: letterText10), 
                pw.Container(
                margin: (paddingMarginSquare = YesNotFunction(radioButtonC, yestNotEnumArr, 2)) == 'X' ? const pw.EdgeInsets.all(0) : const pw.EdgeInsets.all(4),
                padding: (paddingMarginSquare == 'X' ? const pw.EdgeInsets.only(right: 2,left: 2) :  const pw.EdgeInsets.all(4)),
                child: pw.Text(paddingMarginSquare,style: letterText),
                  decoration: pw.BoxDecoration(
                    border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                  )
                ),
                pw.Text('   Tétanos:   Si ',style: letterText10), 
                  pw.Container(
                  margin: (paddingMarginSquare = YesNotFunction(++radioButtonC, yestNotEnumArr, 1)) == 'X' ? const pw.EdgeInsets.all(0) : const pw.EdgeInsets.all(4),
                  padding: (paddingMarginSquare == 'X' ? const pw.EdgeInsets.only(right: 2,left: 2) :  const pw.EdgeInsets.all(4)),
                  child: pw.Text(paddingMarginSquare,style: letterText),
                    decoration: pw.BoxDecoration(
                      border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                    )
                  ),
                  pw.Text(' No ',style: letterText10), 
                  pw.Container(
                  margin: (paddingMarginSquare = YesNotFunction(radioButtonC, yestNotEnumArr, 2)) == 'X' ? const pw.EdgeInsets.all(0) : const pw.EdgeInsets.all(4),
                  padding: (paddingMarginSquare == 'X' ? const pw.EdgeInsets.only(right: 2,left: 2) :  const pw.EdgeInsets.all(4)),
                  child: pw.Text(paddingMarginSquare,style: letterText),
                    decoration: pw.BoxDecoration(
                      border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                    )
                  ),
                pw.Text('   Hepatitis:   Si ',style: letterText10), 
                  pw.Container(
                  margin: (paddingMarginSquare = YesNotFunction(++radioButtonC, yestNotEnumArr, 1)) == 'X' ? const pw.EdgeInsets.all(0) : const pw.EdgeInsets.all(4),
                  padding: (paddingMarginSquare == 'X' ? const pw.EdgeInsets.only(right: 2,left: 2) :  const pw.EdgeInsets.all(4)),
                  child: pw.Text(paddingMarginSquare,style: letterText),
                    decoration: pw.BoxDecoration(
                      border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                    )
                  ),
                  pw.Text(' No ',style: letterText10), 
                  pw.Container(
                  margin: (paddingMarginSquare = YesNotFunction(radioButtonC, yestNotEnumArr, 2)) == 'X' ? const pw.EdgeInsets.all(0) : const pw.EdgeInsets.all(4),
                  padding: (paddingMarginSquare == 'X' ? const pw.EdgeInsets.only(right: 2,left: 2) :  const pw.EdgeInsets.all(4)),
                  child: pw.Text(paddingMarginSquare,style: letterText),
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
                  margin: (paddingMarginSquare = YesNotFunction(++radioButtonC, yestNotEnumArr, 1)) == 'X' ? const pw.EdgeInsets.all(0) : const pw.EdgeInsets.all(4),
                  padding: (paddingMarginSquare == 'X' ? const pw.EdgeInsets.only(right: 2,left: 2) :  const pw.EdgeInsets.all(4)),
                  child: pw.Text(paddingMarginSquare,style: letterText),
                    decoration: pw.BoxDecoration(
                      border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                    )
                  ),
                  pw.Text(' No ',style: letterText10), 
                  pw.Container(
                  margin: (paddingMarginSquare = YesNotFunction(radioButtonC, yestNotEnumArr, 2)) == 'X' ? const pw.EdgeInsets.all(0) : const pw.EdgeInsets.all(4),
                  padding: (paddingMarginSquare == 'X' ? const pw.EdgeInsets.only(right: 2,left: 2) :  const pw.EdgeInsets.all(4)),
                  child: pw.Text(paddingMarginSquare,style: letterText),
                    decoration: pw.BoxDecoration(
                      border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                    )
                  ),
                pw.Text('             Otras: ',style: letterText10), 
                  pw.Container(
                  margin: const pw.EdgeInsets.all(0),
                  padding: const pw.EdgeInsets.all(4),
                  child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
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
                  child: pw.Text(YesNotFunction(++radioButtonC, yestNotEnumArr, 2),style: letterText),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                ),
                pw.Text(' Si ',style: letterText10), 
                pw.Container(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(YesNotFunction(radioButtonC, yestNotEnumArr, 1),style: letterText),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                ),
                pw.Spacer(),
                pw.Text(' ¿A cuál? ',style: letterText10), 
                pw.Container(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                ),
                pw.Spacer(),
                pw.Text(' ¿Con qué frecuencia? ',style: letterText10), 
                pw.Container(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
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
                  // padding:  const pw.EdgeInsets.all(2),
                  child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                ),
                pw.Spacer(),
                pw.Text('Edad de inicio de vida sexual: ',style: letterText10), 
                pw.Container(
                  margin: const pw.EdgeInsets.all(3),
                  // padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                ),
                pw.Spacer(),
                pw.Text('Número de Embarazos: ',style: letterText10), 
                pw.Container(
                  margin: const pw.EdgeInsets.all(3),
                  // padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                ),
                pw.Spacer(),
                pw.Text('Partos: ',style: letterText10), 
                pw.Container(
                  margin: const pw.EdgeInsets.all(3),
                  // padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
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
                  margin: const pw.EdgeInsets.all(3),
                  // padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                ),
                pw.Spacer(),
                pw.Text('Abortos: ',style: letterText10), 
                pw.Container(
                  margin: const pw.EdgeInsets.all(3),
                  // padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                ),
                pw.Spacer(),
                pw.Text('Fecha de Ultima Regla: ',style: letterText10), 
                pw.Container(
                  margin: const pw.EdgeInsets.all(3),
                  // padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                ),
                pw.Spacer(),
                pw.Text('Ritmo: ',style: letterText10), 
                pw.Container(
                  margin: const pw.EdgeInsets.all(3),
                  // padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
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
                  margin: const pw.EdgeInsets.all(3),
                  // padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(methodAnti == 1 ? 'X' : '',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                ),
                pw.Spacer(),
                pw.Text('Dispositivo: ',style: letterText10), 
                pw.Container(
                  margin: const pw.EdgeInsets.all(3),
                  // padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(methodAnti == 2 ? 'X' : '',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                ),
                pw.Spacer(),
                pw.Text('Condón: ',style: letterText10), 
                pw.Container(
                  margin: const pw.EdgeInsets.all(3),
                  // padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(methodAnti == 3 ? 'X' : '',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                ),
                pw.Spacer(),
                pw.Text('OTB: ',style: letterText10), 
                pw.Container(
                  margin: const pw.EdgeInsets.all(3),
                  // padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(methodAnti == 4 ? 'X' : '',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                ),
                pw.Spacer(),
                pw.Text('Inyección: ',style: letterText10), 
                pw.Container(
                  margin: const pw.EdgeInsets.all(3),
                  // padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(methodAnti == 5 ? 'X' : '',style: letterText10),
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
                  margin: const pw.EdgeInsets.all(3),
                  // padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(methodAnti == 6 ? 'X' : '',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                ),
                pw.Spacer(),
                pw.Text('Fecha de Último Papanicolaou: ',style: letterText10), 
                pw.Container(
                  margin: const pw.EdgeInsets.all(3),
                  // padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                ),
                pw.Spacer(),
                pw.Text('Resultado: ',style: letterText10), 
                pw.Container(
                  margin: const pw.EdgeInsets.all(3),
                  // padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                ),
                pw.Spacer(),
                pw.Text('Fecha de Mamografía: ',style: letterText10), 
                pw.Container(
                  margin: const pw.EdgeInsets.all(3),
                  // padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
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
                  margin: const pw.EdgeInsets.all(3),
                  // padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                ),
                pw.SizedBox(width: PdfPageFormat.letter.width * 0.025),
                pw.Text('Lactancia: ',style: letterText10), 
                pw.Container(
                  margin: const pw.EdgeInsets.all(3),
                  // padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
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
                    margin: (paddingMarginSquare = YesNotFunction(11, yestNotEnumArr, 1)) == 'X' ? const pw.EdgeInsets.all(0) : const pw.EdgeInsets.all(4),
                    padding: (paddingMarginSquare == 'X' ? const pw.EdgeInsets.only(right: 2,left: 2) :  const pw.EdgeInsets.all(4)),
                    child: pw.Text(paddingMarginSquare,style: letterText10),
                      decoration: pw.BoxDecoration(
                        border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                      )
                    ),
                    pw.Text(' No',style: letterText10), 
                    pw.Container(
                    margin: (paddingMarginSquare = YesNotFunction(11, yestNotEnumArr, 2)) == 'X' ? const pw.EdgeInsets.all(0) : const pw.EdgeInsets.all(4),
                  padding: (paddingMarginSquare == 'X' ? const pw.EdgeInsets.only(right: 2,left: 2) :  const pw.EdgeInsets.all(4)),
                    child: pw.Text(paddingMarginSquare,style: letterText10),
                      decoration: pw.BoxDecoration(
                        border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                      )
                    ),
                    pw.Text('    Enfs. de la piel:         Si ',style: letterText10), 
                      pw.Container(
                      margin: (paddingMarginSquare = YesNotFunction(17, yestNotEnumArr, 1)) == 'X' ? const pw.EdgeInsets.all(0) : const pw.EdgeInsets.all(4),
                      padding: (paddingMarginSquare == 'X' ? const pw.EdgeInsets.only(right: 2,left: 2) :  const pw.EdgeInsets.all(4)),
                      child: pw.Text(paddingMarginSquare,style: letterText10),
                        decoration: pw.BoxDecoration(
                          border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                        )
                      ),
                      pw.Text(' No ',style: letterText10), 
                      pw.Container(
                      margin: (paddingMarginSquare = YesNotFunction(17, yestNotEnumArr, 2)) == 'X' ? const pw.EdgeInsets.all(0) : const pw.EdgeInsets.all(4),
                      padding: (paddingMarginSquare == 'X' ? const pw.EdgeInsets.only(right: 2,left: 2) :  const pw.EdgeInsets.all(4)),
                      child: pw.Text(paddingMarginSquare,style: letterText10),
                        decoration: pw.BoxDecoration(
                          border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                        )
                      ),
                    pw.Text('     Ginecológicas:       Si ',style: letterText10), 
                      pw.Container(
                      margin: (paddingMarginSquare = YesNotFunction(23, yestNotEnumArr, 1)) == 'X' ? const pw.EdgeInsets.all(0) : const pw.EdgeInsets.all(4),
                      padding: (paddingMarginSquare == 'X' ? const pw.EdgeInsets.only(right: 2,left: 2) :  const pw.EdgeInsets.all(4)),
                      child: pw.Text(paddingMarginSquare,style: letterText10),
                        decoration: pw.BoxDecoration(
                          border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                        )
                      ),
                      pw.Text(' No ',style: letterText10), 
                      pw.Container(
                      margin: (paddingMarginSquare = YesNotFunction(23, yestNotEnumArr, 2)) == 'X' ? const pw.EdgeInsets.all(0) : const pw.EdgeInsets.all(4),
                      padding: (paddingMarginSquare == 'X' ? const pw.EdgeInsets.only(right: 2,left: 2) :  const pw.EdgeInsets.all(4)),
                      child: pw.Text(paddingMarginSquare,style: letterText10),
                        decoration: pw.BoxDecoration(
                          border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                        )
                      ),
                    pw.Text('     Neumonía:       Si ',style: letterText10), 
                      pw.Container(
                      margin: (paddingMarginSquare = YesNotFunction(28, yestNotEnumArr, 1)) == 'X' ? const pw.EdgeInsets.all(0) : const pw.EdgeInsets.all(4),
                      padding: (paddingMarginSquare == 'X' ? const pw.EdgeInsets.only(right: 2,left: 2) :  const pw.EdgeInsets.all(4)),
                      child: pw.Text(paddingMarginSquare,style: letterText10),
                        decoration: pw.BoxDecoration(
                          border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                        )
                      ),
                      pw.Text(' No ',style: letterText10), 
                      pw.Container(
                      margin: (paddingMarginSquare = YesNotFunction(28, yestNotEnumArr, 2)) == 'X' ? const pw.EdgeInsets.all(0) : const pw.EdgeInsets.all(4),
                      padding: (paddingMarginSquare == 'X' ? const pw.EdgeInsets.only(right: 2,left: 2) :  const pw.EdgeInsets.all(4)),
                      child: pw.Text(paddingMarginSquare,style: letterText10),
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
                    margin: (paddingMarginSquare = YesNotFunction(12, yestNotEnumArr, 1)) == 'X' ? const pw.EdgeInsets.all(0) : const pw.EdgeInsets.all(4),
                    padding: (paddingMarginSquare == 'X' ? const pw.EdgeInsets.only(right: 2,left: 2) :  const pw.EdgeInsets.all(4)),
                    child: pw.Text(paddingMarginSquare,style: letterText10),
                      decoration: pw.BoxDecoration(
                        border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                      )
                    ),
                    pw.Text(' No ',style: letterText10), 
                    pw.Container(
                    margin: (paddingMarginSquare = YesNotFunction(12, yestNotEnumArr, 2)) == 'X' ? const pw.EdgeInsets.all(0) : const pw.EdgeInsets.all(4),
                    padding: (paddingMarginSquare == 'X' ? const pw.EdgeInsets.only(right: 2,left: 2) :  const pw.EdgeInsets.all(4)),
                    child: pw.Text(paddingMarginSquare,style: letterText10),
                      decoration: pw.BoxDecoration(
                        border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                      )
                    ),
                    pw.Text('    Enfs. de la tiroides:   Si ',style: letterText10), 
                      pw.Container(
                      margin: (paddingMarginSquare = YesNotFunction(18, yestNotEnumArr, 1)) == 'X' ? const pw.EdgeInsets.all(0) : const pw.EdgeInsets.all(4),
                      padding: (paddingMarginSquare == 'X' ? const pw.EdgeInsets.only(right: 2,left: 2) :  const pw.EdgeInsets.all(4)),
                      child: pw.Text(paddingMarginSquare,style: letterText10),
                        decoration: pw.BoxDecoration(
                          border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                        )
                      ),
                      pw.Text(' No ',style: letterText10), 
                      pw.Container(
                      margin: (paddingMarginSquare = YesNotFunction(18, yestNotEnumArr, 2)) == 'X' ? const pw.EdgeInsets.all(0) : const pw.EdgeInsets.all(4),
                      padding: (paddingMarginSquare == 'X' ? const pw.EdgeInsets.only(right: 2,left: 2) :  const pw.EdgeInsets.all(4)),
                      child: pw.Text(paddingMarginSquare,style: letterText10),
                        decoration: pw.BoxDecoration(
                          border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                        )
                      ),
                    pw.Text('     Hemorroides:         Si ',style: letterText10), 
                      pw.Container(
                      margin: (paddingMarginSquare = YesNotFunction(24, yestNotEnumArr, 1)) == 'X' ? const pw.EdgeInsets.all(0) : const pw.EdgeInsets.all(4),
                      padding: (paddingMarginSquare == 'X' ? const pw.EdgeInsets.only(right: 2,left: 2) :  const pw.EdgeInsets.all(4)),
                      child: pw.Text(paddingMarginSquare,style: letterText10),
                        decoration: pw.BoxDecoration(
                          border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                        )
                      ),
                      pw.Text(' No ',style: letterText10), 
                      pw.Container(
                      margin: (paddingMarginSquare = YesNotFunction(24, yestNotEnumArr, 2)) == 'X' ? const pw.EdgeInsets.all(0) : const pw.EdgeInsets.all(4),
                      padding: (paddingMarginSquare == 'X' ? const pw.EdgeInsets.only(right: 2,left: 2) :  const pw.EdgeInsets.all(4)),
                      child: pw.Text(paddingMarginSquare,style: letterText10),
                        decoration: pw.BoxDecoration(
                          border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                        )
                      ),
                    pw.Text('     Tuberculosis:   Si ',style: letterText10), 
                      pw.Container(
                      margin: (paddingMarginSquare = YesNotFunction(29, yestNotEnumArr, 1)) == 'X' ? const pw.EdgeInsets.all(0) : const pw.EdgeInsets.all(4),
                      padding: (paddingMarginSquare == 'X' ? const pw.EdgeInsets.only(right: 2,left: 2) :  const pw.EdgeInsets.all(4)),
                      child: pw.Text(paddingMarginSquare,style: letterText10),
                        decoration: pw.BoxDecoration(
                          border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                        )
                      ),
                      pw.Text(' No ',style: letterText10), 
                      pw.Container(
                      margin: (paddingMarginSquare = YesNotFunction(29, yestNotEnumArr, 2)) == 'X' ? const pw.EdgeInsets.all(0) : const pw.EdgeInsets.all(4),
                      padding: (paddingMarginSquare == 'X' ? const pw.EdgeInsets.only(right: 2,left: 2) :  const pw.EdgeInsets.all(4)),
                      child: pw.Text(paddingMarginSquare,style: letterText10),
                        decoration: pw.BoxDecoration(
                          border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                        )
                      ),
                  ],
                ),
                pw.Row(
                  children: [
                    pw.Text('Bronquitis         Si ',style: letterText10), 
                      pw.Container(
                      margin: (paddingMarginSquare = YesNotFunction(13, yestNotEnumArr, 1)) == 'X' ? const pw.EdgeInsets.all(0) : const pw.EdgeInsets.all(4),
                      padding: (paddingMarginSquare == 'X' ? const pw.EdgeInsets.only(right: 2,left: 2) :  const pw.EdgeInsets.all(4)),
                      child: pw.Text(paddingMarginSquare,style: letterText10),
                        decoration: pw.BoxDecoration(
                          border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                        )
                      ),
                      pw.Text(' No ',style: letterText10), 
                      pw.Container(
                      margin: (paddingMarginSquare = YesNotFunction(13, yestNotEnumArr, 2)) == 'X' ? const pw.EdgeInsets.all(0) : const pw.EdgeInsets.all(4),
                      padding: (paddingMarginSquare == 'X' ? const pw.EdgeInsets.only(right: 2,left: 2) :  const pw.EdgeInsets.all(4)),
                      child: pw.Text(paddingMarginSquare,style: letterText10),
                        decoration: pw.BoxDecoration(
                          border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                        )
                      ),
                    pw.Text('    Hernias:                     Si ',style: letterText10), 
                      pw.Container(
                      margin: (paddingMarginSquare = YesNotFunction(19, yestNotEnumArr, 1)) == 'X' ? const pw.EdgeInsets.all(0) : const pw.EdgeInsets.all(4),
                      padding: (paddingMarginSquare == 'X' ? const pw.EdgeInsets.only(right: 2,left: 2) :  const pw.EdgeInsets.all(4)),
                      child: pw.Text(paddingMarginSquare,style: letterText10),
                        decoration: pw.BoxDecoration(
                          border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                        )
                      ),
                      pw.Text(' No ',style: letterText10), 
                      pw.Container(
                      margin: (paddingMarginSquare = YesNotFunction(19, yestNotEnumArr, 2)) == 'X' ? const pw.EdgeInsets.all(0) : const pw.EdgeInsets.all(4),
                      padding: (paddingMarginSquare == 'X' ? const pw.EdgeInsets.only(right: 2,left: 2) :  const pw.EdgeInsets.all(4)),
                      child: pw.Text(paddingMarginSquare,style: letterText10),
                        decoration: pw.BoxDecoration(
                          border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                        )
                      ),
                    pw.Text('    Úlceras:                  Si ',style: letterText10), 
                      pw.Container(
                      margin: (paddingMarginSquare = YesNotFunction(25, yestNotEnumArr, 1)) == 'X' ? const pw.EdgeInsets.all(0) : const pw.EdgeInsets.all(4),
                      padding: (paddingMarginSquare == 'X' ? const pw.EdgeInsets.only(right: 2,left: 2) :  const pw.EdgeInsets.all(4)),
                      child: pw.Text(paddingMarginSquare,style: letterText10),
                        decoration: pw.BoxDecoration(
                          border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                        )
                      ),
                      pw.Text(' No ',style: letterText10), 
                      pw.Container(
                      margin: (paddingMarginSquare = YesNotFunction(25, yestNotEnumArr, 2)) == 'X' ? const pw.EdgeInsets.all(0) : const pw.EdgeInsets.all(4),
                      padding: (paddingMarginSquare == 'X' ? const pw.EdgeInsets.only(right: 2,left: 2) :  const pw.EdgeInsets.all(4)),
                      child: pw.Text(paddingMarginSquare,style: letterText10),
                        decoration: pw.BoxDecoration(
                          border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                        )
                      ),
                    pw.Text('     Colitis:              Si ',style: letterText10), 
                      pw.Container(
                      margin: (paddingMarginSquare = YesNotFunction(30, yestNotEnumArr, 1)) == 'X' ? const pw.EdgeInsets.all(0) : const pw.EdgeInsets.all(4),
                      padding: (paddingMarginSquare == 'X' ? const pw.EdgeInsets.only(right: 2,left: 2) :  const pw.EdgeInsets.all(4)),
                      child: pw.Text(paddingMarginSquare,style: letterText10),
                        decoration: pw.BoxDecoration(
                          border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                        )
                      ),
                      pw.Text(' No ',style: letterText10), 
                      pw.Container(
                      margin: (paddingMarginSquare = YesNotFunction(30, yestNotEnumArr, 2)) == 'X' ? const pw.EdgeInsets.all(0) : const pw.EdgeInsets.all(4),
                      padding: (paddingMarginSquare == 'X' ? const pw.EdgeInsets.only(right: 2,left: 2) :  const pw.EdgeInsets.all(4)),
                      child: pw.Text(paddingMarginSquare,style: letterText10),
                        decoration: pw.BoxDecoration(
                          border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                        )
                      ),
                  ],
                ),
                pw.Row(
                  children: [
                    pw.Text('Hepatitis           Si ',style: letterText10), 
                    pw.Container(
                      margin: (paddingMarginSquare = YesNotFunction(14, yestNotEnumArr, 1)) == 'X' ? const pw.EdgeInsets.all(0) : const pw.EdgeInsets.all(4),
                      padding: (paddingMarginSquare == 'X' ? const pw.EdgeInsets.only(right: 2,left: 2) :  const pw.EdgeInsets.all(4)),
                      child: pw.Text(paddingMarginSquare,style: letterText10),
                        decoration: pw.BoxDecoration(
                          border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                        )
                      ),
                      pw.Text(' No ',style: letterText10), 
                      pw.Container(
                      margin: (paddingMarginSquare = YesNotFunction(14, yestNotEnumArr, 2)) == 'X' ? const pw.EdgeInsets.all(0) : const pw.EdgeInsets.all(4),
                      padding: (paddingMarginSquare == 'X' ? const pw.EdgeInsets.only(right: 2,left: 2) :  const pw.EdgeInsets.all(4)),
                      child: pw.Text(paddingMarginSquare,style: letterText10),
                        decoration: pw.BoxDecoration(
                          border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                        )
                      ),
                    pw.Text('    Lumbalgia:                 Si ',style: letterText10), 
                      pw.Container(
                      margin: (paddingMarginSquare = YesNotFunction(20, yestNotEnumArr, 1)) == 'X' ? const pw.EdgeInsets.all(0) : const pw.EdgeInsets.all(4),
                      padding: (paddingMarginSquare == 'X' ? const pw.EdgeInsets.only(right: 2,left: 2) :  const pw.EdgeInsets.all(4)),
                      child: pw.Text(paddingMarginSquare,style: letterText10),
                        decoration: pw.BoxDecoration(
                          border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                        )
                      ),
                      pw.Text(' No ',style: letterText10), 
                      pw.Container(
                      margin: (paddingMarginSquare = YesNotFunction(20, yestNotEnumArr, 2)) == 'X' ? const pw.EdgeInsets.all(0) : const pw.EdgeInsets.all(4),
                      padding: (paddingMarginSquare == 'X' ? const pw.EdgeInsets.only(right: 2,left: 2) :  const pw.EdgeInsets.all(4)),
                      child: pw.Text(paddingMarginSquare,style: letterText10),
                        decoration: pw.BoxDecoration(
                          border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                        )
                      ),
                    pw.Text('    Várices:                  Si ',style: letterText10), 
                      pw.Container(
                      margin: (paddingMarginSquare = YesNotFunction(26, yestNotEnumArr, 1)) == 'X' ? const pw.EdgeInsets.all(0) : const pw.EdgeInsets.all(4),
                      padding: (paddingMarginSquare == 'X' ? const pw.EdgeInsets.only(right: 2,left: 2) :  const pw.EdgeInsets.all(4)),
                      child: pw.Text(paddingMarginSquare,style: letterText10),
                        decoration: pw.BoxDecoration(
                          border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                        )
                      ),
                      pw.Text(' No ',style: letterText10), 
                      pw.Container(
                      margin: (paddingMarginSquare = YesNotFunction(26, yestNotEnumArr, 2)) == 'X' ? const pw.EdgeInsets.all(0) : const pw.EdgeInsets.all(4),
                      padding: (paddingMarginSquare == 'X' ? const pw.EdgeInsets.only(right: 2,left: 2) :  const pw.EdgeInsets.all(4)),
                      child: pw.Text(paddingMarginSquare,style: letterText10),
                        decoration: pw.BoxDecoration(
                          border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                        )
                      ),
                    pw.Text('     Depresión:       Si ',style: letterText10), 
                      pw.Container(
                      margin: (paddingMarginSquare = YesNotFunction(radioButtonC = 31, yestNotEnumArr, 1)) == 'X' ? const pw.EdgeInsets.all(0) : const pw.EdgeInsets.all(4),
                      padding: (paddingMarginSquare == 'X' ? const pw.EdgeInsets.only(right: 2,left: 2) :  const pw.EdgeInsets.all(4)),
                      child: pw.Text(paddingMarginSquare,style: letterText10),
                        decoration: pw.BoxDecoration(
                          border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                        )
                      ),
                      pw.Text(' No ',style: letterText10), 
                      pw.Container(
                      margin: (paddingMarginSquare = YesNotFunction(31, yestNotEnumArr, 2)) == 'X' ? const pw.EdgeInsets.all(0) : const pw.EdgeInsets.all(4),
                      padding: (paddingMarginSquare == 'X' ? const pw.EdgeInsets.only(right: 2,left: 2) :  const pw.EdgeInsets.all(4)),
                      child: pw.Text(paddingMarginSquare,style: letterText10),
                        decoration: pw.BoxDecoration(
                          border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                        )
                      ),
                  ],
                ),
                pw.Row(
                  children: [
                    pw.Text('COVID              Si ',style: letterText10), 
                    pw.Container(
                      margin: (paddingMarginSquare = YesNotFunction(15, yestNotEnumArr, 1)) == 'X' ? const pw.EdgeInsets.all(0) : const pw.EdgeInsets.all(4),
                      padding: (paddingMarginSquare == 'X' ? const pw.EdgeInsets.only(right: 2,left: 2) :  const pw.EdgeInsets.all(4)),
                      child: pw.Text(paddingMarginSquare,style: letterText10),
                        decoration: pw.BoxDecoration(
                          border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                        )
                      ),
                      pw.Text(' No ',style: letterText10), 
                      pw.Container(
                      margin: (paddingMarginSquare = YesNotFunction(15, yestNotEnumArr, 2)) == 'X' ? const pw.EdgeInsets.all(0) : const pw.EdgeInsets.all(4),
                      padding: (paddingMarginSquare == 'X' ? const pw.EdgeInsets.only(right: 2,left: 2) :  const pw.EdgeInsets.all(4)),
                      child: pw.Text(paddingMarginSquare,style: letterText10),
                        decoration: pw.BoxDecoration(
                          border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                        )
                      ),
                    pw.Text('    DIABETES:                Si ',style: letterText10), 
                      pw.Container(
                      margin: (paddingMarginSquare = YesNotFunction(21, yestNotEnumArr, 1)) == 'X' ? const pw.EdgeInsets.all(0) : const pw.EdgeInsets.all(4),
                      padding: (paddingMarginSquare == 'X' ? const pw.EdgeInsets.only(right: 2,left: 2) :  const pw.EdgeInsets.all(4)),
                      child: pw.Text(paddingMarginSquare,style: letterText10),
                        decoration: pw.BoxDecoration(
                          border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                        )
                      ),
                      pw.Text(' No ',style: letterText10), 
                      pw.Container(
                      margin: (paddingMarginSquare = YesNotFunction(21, yestNotEnumArr, 2)) == 'X' ? const pw.EdgeInsets.all(0) : const pw.EdgeInsets.all(4),
                      padding: (paddingMarginSquare == 'X' ? const pw.EdgeInsets.only(right: 2,left: 2) :  const pw.EdgeInsets.all(4)),
                      child: pw.Text(paddingMarginSquare,style: letterText10),
                        decoration: pw.BoxDecoration(
                          border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                        )
                      ),
                    pw.Text('    OTRAS: ',style: letterText10), 
                    
                    pw.Column(
                      children: [
                      /* pw.Container(
                        width: 100,
                        height: 0.5,
                        margin: const pw.EdgeInsets.only(top: 10),
                        color: PdfColors.black,
                        child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ')
                      ),*/
                      pw.Container(
                      margin:const pw.EdgeInsets.all(4),
                      padding: const pw.EdgeInsets.all(2),
                      child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                        decoration: pw.BoxDecoration(
                         border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black)), 
                        )
                      ) 
                      ]
                    )
                  ],
                ),
                pw.Row(
                  children: [
                    pw.Text('Enfs. de riñón   Si ',style: letterText10), 
                      pw.Container(
                      margin: (paddingMarginSquare = YesNotFunction(16, yestNotEnumArr, 1)) == 'X' ? const pw.EdgeInsets.all(0) : const pw.EdgeInsets.all(4),
                      padding: (paddingMarginSquare == 'X' ? const pw.EdgeInsets.only(right: 2,left: 2) :  const pw.EdgeInsets.all(4)),
                      child: pw.Text(paddingMarginSquare,style: letterText10),
                        decoration: pw.BoxDecoration(
                          border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                        )
                      ),
                      pw.Text(' No ',style: letterText10), 
                      pw.Container(
                      margin: (paddingMarginSquare = YesNotFunction(16, yestNotEnumArr, 2)) == 'X' ? const pw.EdgeInsets.all(0) : const pw.EdgeInsets.all(4),
                      padding: (paddingMarginSquare == 'X' ? const pw.EdgeInsets.only(right: 2,left: 2) :  const pw.EdgeInsets.all(4)),
                      child: pw.Text(paddingMarginSquare,style: letterText10),
                        decoration: pw.BoxDecoration(
                          border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                        )
                      ),
                    pw.Text('    Gastritis:                     Si ',style: letterText10), 
                      pw.Container(
                      margin: (paddingMarginSquare = YesNotFunction(22, yestNotEnumArr, 1)) == 'X' ? const pw.EdgeInsets.all(0) : const pw.EdgeInsets.all(4),
                      padding: (paddingMarginSquare == 'X' ? const pw.EdgeInsets.only(right: 2,left: 2) :  const pw.EdgeInsets.all(4)),
                      child: pw.Text(paddingMarginSquare,style: letterText10),
                        decoration: pw.BoxDecoration(
                          border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                        )
                      ),
                      pw.Text(' No ',style: letterText10), 
                      pw.Container(
                      margin: (paddingMarginSquare = YesNotFunction(22, yestNotEnumArr, 2)) == 'X' ? const pw.EdgeInsets.all(0) : const pw.EdgeInsets.all(4),
                      padding: (paddingMarginSquare == 'X' ? const pw.EdgeInsets.only(right: 2,left: 2) :  const pw.EdgeInsets.all(4)),
                      child: pw.Text(paddingMarginSquare,style: letterText10),
                        decoration: pw.BoxDecoration(
                          border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                        )
                      ),
                    pw.Text('    HIPERTENSIÓN:   Si ',style: letterText10), 
                      pw.Container(
                      margin: (paddingMarginSquare = YesNotFunction(27, yestNotEnumArr, 1)) == 'X' ? const pw.EdgeInsets.all(0) : const pw.EdgeInsets.all(4),
                      padding: (paddingMarginSquare == 'X' ? const pw.EdgeInsets.only(right: 2,left: 2) :  const pw.EdgeInsets.all(4)),
                      child: pw.Text(paddingMarginSquare,style: letterText10),
                        decoration: pw.BoxDecoration(
                          border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                        )
                      ),
                      pw.Text(' No ',style: letterText10), 
                      pw.Container(
                      margin: (paddingMarginSquare = YesNotFunction(27, yestNotEnumArr, 2)) == 'X' ? const pw.EdgeInsets.all(0) : const pw.EdgeInsets.all(4),
                      padding: (paddingMarginSquare == 'X' ? const pw.EdgeInsets.only(right: 2,left: 2) :  const pw.EdgeInsets.all(4)),
                      child: pw.Text(paddingMarginSquare,style: letterText10),
                        decoration: pw.BoxDecoration(
                          border:pw.Border.all(width: widthLineTable, color: PdfColors.black), 
                        )
                      ),
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
                    child: pw.Text(YesNotFunction(++radioButtonC, yestNotEnumArr, 2),style: letterText10),
                      decoration: pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                      )
                    ) 
                  ),
                  pw.Text(' Si ',style: letterText10), 
                  pw.Container(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Text(YesNotFunction(radioButtonC, yestNotEnumArr, 1),style: letterText10),
                      decoration: pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                      )
                    ) 
                  ),
                  pw.Spacer(),
                  pw.Text('Motivo: ',style: letterText10), 
                  pw.Container(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                      decoration: pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                      )
                    ) 
                  ),
                  pw.Spacer(),
                  pw.Text('Cirugías   No ',style: letterText10), 
                  pw.Container(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Text(YesNotFunction(++radioButtonC, yestNotEnumArr, 2),style: letterText10),
                      decoration: pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                      )
                    ) 
                  ),
                  pw.Text(' Si ',style: letterText10), 
                  pw.Container(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Text(YesNotFunction(radioButtonC, yestNotEnumArr, 1),style: letterText10),
                      decoration: pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                      )
                    ) 
                  ),
                  pw.Text(' ¿Cuál? ',style: letterText10), 
                  pw.Container(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
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
                    child: pw.Text(YesNotFunction(++radioButtonC, yestNotEnumArr, 2),style: letterText10),
                      decoration: pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                      )
                    ) 
                  ),
                  pw.Text(' Si ',style: letterText10), 
                  pw.Container(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Text(YesNotFunction(radioButtonC, yestNotEnumArr, 1),style: letterText10),
                      decoration: pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                      )
                    ) 
                  ),
                  pw.Spacer(),
                  pw.Text('Motivo: ',style: letterText10), 
                  pw.Container(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                      decoration: pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                      )
                    ) 
                  ),
                  pw.Spacer(),
                  pw.Text('Traumatismos y Fracturas   No ',style: letterText10), 
                  pw.Container(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Text(YesNotFunction(++radioButtonC, yestNotEnumArr, 2),style: letterText10),
                      decoration: pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                      )
                    ) 
                  ),
                  pw.Text(' Si ',style: letterText10), 
                  pw.Container(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Text(YesNotFunction(radioButtonC, yestNotEnumArr, 1),style: letterText10),
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
                    child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                      decoration: pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                      )
                    ) 
                  ),
                  pw.Spacer(),
                  pw.Text('Complicaciones: No ',style: letterText10), 
                  pw.Container(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Text(YesNotFunction(++radioButtonC, yestNotEnumArr, 2),style: letterText10),
                      decoration: pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                      )
                    ) 
                  ),
                  pw.Text(' Si ',style: letterText10), 
                  pw.Container(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Text(YesNotFunction(radioButtonC, yestNotEnumArr, 1),style: letterText10),
                      decoration: pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                      )
                    ) 
                  ),
                  pw.Text(' ¿Cuál? ',style: letterText10), 
                  pw.Container(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
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
                    child: pw.Text(YesNotFunction(++radioButtonC, yestNotEnumArr, 2),style: letterText10),
                      decoration: pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                      )
                    ) 
                  ),
                  pw.Text(' Si ',style: letterText10), 
                  pw.Container(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Text(YesNotFunction(radioButtonC, yestNotEnumArr, 1),style: letterText10),
                      decoration: pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                      )
                    ) 
                  ),
                  pw.Spacer(),
                  pw.Text('¿Cuál?: ',style: letterText10), 
                  pw.Container(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                      decoration: pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                      )
                    ) 
                  ),
                  pw.Text(' Tratamiento actual ',style: letterText10), 
                  pw.Container(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
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
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            mainAxisAlignment: pw.MainAxisAlignment.start, 
              children: [
              pw.Text('Nombre y firma del paciente: ',style:const pw.TextStyle(fontSize: 11)),
              pw.Container(
              width: 350,
              padding: const pw.EdgeInsets.all(2),
              child:
              pw.Row(children: [
                pw.Text(multiInputArr != null ? '${multiInputArr[3]}        ' : '',style: letterText),
                pw.Container(
                  width: 150.0,
                  height: 50.0,
                  child : pw.Image( pw.MemoryImage(transformationImage(multiInputArr != null? multiInputArr[++multiInputC] : ''))),
                ),
              ],),
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
            child: pw.Text('6.- INTERROGATORIO POR APARATOS Y SISTEMAS. ',style: letterBold12),
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
                pw.Text('Sentidos: ', style: letterText12,),
                pw.Container(
                  width: 500,
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                )
                /* pw.Container(
                  width: 430,
                  height: 0.5,
                  margin: const pw.EdgeInsets.only(top: 10),
                  color: PdfColors.black,
                ), */
                ]
              ),
              pw.SizedBox(height: 10),
              pw.Row(
                children: [
                pw.Text('Digestivo: ', style: letterText12),
                pw.Container(
                  width: 500,
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                )
                ]
              ),
              pw.SizedBox(height: 10),
              pw.Row(
                children: [
                pw.Text('Respiratorio: ', style: letterText12),
                pw.Container(
                  width: 460,
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                )
                ]
              ),
              pw.SizedBox(height: 10),
              pw.Row(
                children: [
                pw.Text('Circulatorio: ', style: letterText12),
                pw.Container(
                  width: 475,
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                )
                ]
              ),
              pw.SizedBox(height: 10),
              pw.Row(
                children: [
                pw.Text('Genitourinario: ', style: letterText12),
                pw.Container(
                  width: 450,
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                )
                ]
              ),
              pw.SizedBox(height: 10),
              pw.Row(
                children: [
                pw.Text('Músculo /Esquéletico: ', style: letterText12),
                pw.Container(
                  width: 420,
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                )
                ]
              ),
              pw.SizedBox(height: 10),
              pw.Row(
                children: [
                  pw.Text('Nervioso: ', style: letterText12),
                  pw.Container(
                  width: 500,
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
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
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                      )
                    ) 
                  ),
                  /* pw.Container(
                    width: 40,
                    height: 0.5,
                    margin: const pw.EdgeInsets.only(top: 10),
                    color: PdfColors.black,
                  ), */
                  pw.Text('mmhg  ', style: letterText),
                  pw.Text('F/C ', style: letterText),
                  pw.Container(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                      )
                    ) 
                  ),
                  pw.Text('  Peso ', style: letterText),
                 pw.Container(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                      )
                    ) 
                  ),
                  pw.Text('Kg ', style: letterText),
                  pw.Text(' Talla ', style: letterText),
                  pw.Container(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                      )
                    ) 
                  ),
                  pw.Text('cm  ', style: letterText),
                  pw.Text('P.abd ', style: letterText),
                  pw.Container(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                      )
                    ) 
                  ),
                  pw.Text(' F/R ', style: letterText),
                  pw.Container(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                      )
                    ) 
                  ),
                  pw.Text(' Temp. ', style: letterText),
                  pw.Container(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                      )
                    ) 
                  ),
                  pw.Text(' I.M.C. ', style: letterText),
                  pw.Container(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                      )
                    ) 
                  )
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
                //empieza con el numero 129
                pw.Row(
                  children: [
                    pw.Text('DE CERCA A 30CM', style: letterText12),
                    pw.Spacer(),
                    pw.Text('OD JAEGUER J', style: letterText12),
                    pw.Container(
                      padding: const pw.EdgeInsets.all(2),
                      child: pw.Text(multiInputArr != null ? multiInputArr[129] : ' ',style: letterText10),
                        decoration: pw.BoxDecoration(
                          border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                        )
                      ) 
                    ),
                    pw.Spacer(),
                    pw.Text('OD ROSENBAUN 20/', style: letterText12),
                    pw.Container(
                      padding: const pw.EdgeInsets.all(2),
                      child: pw.Text(multiInputArr != null ? multiInputArr[127] : ' ',style: letterText10),
                        decoration: pw.BoxDecoration(
                          border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                        )
                      ) 
                    ),
                    
                  ]
                ),
                pw.Row(
                  children: [
                    pw.Text('LENTES SI ', style: letterText12),
                    pw.Container(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Text(YesNotFunction(++radioButtonC, yestNotEnumArr, 1),style: letterText10),
                      decoration: pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                      )
                    ) 
                    ),
                    pw.Text('NO ', style: letterText12),
                    pw.Container(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Text(YesNotFunction(radioButtonC, yestNotEnumArr, 2),style: letterText10),
                      decoration: pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                      )
                    ) 
                    ),
                    pw.Spacer(),
                    pw.Text('OI JAEGUER J', style: letterText12),   
                    pw.Container(
                      padding: const pw.EdgeInsets.all(2),
                      child: pw.Text(multiInputArr != null ? multiInputArr[130] : ' ',style: letterText10),
                        decoration: pw.BoxDecoration(
                          border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                        )
                      ) 
                    ),
                    pw.Spacer(),
                    pw.Text('OI ROSENBAUN 20/', style: letterText12),
                    pw.Container(
                      padding: const pw.EdgeInsets.all(2),
                      child: pw.Text(multiInputArr != null ? multiInputArr[128] : ' ',style: letterText10),
                        decoration: pw.BoxDecoration(
                          border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                        )
                      ) 
                    ),
                  ]
                ),
                pw.SizedBox(height: 20),
                pw.Row(
                  children: [
                    pw.Text('DE LEJOS SNELLEN OD 20/', style: letterText12),
                    pw.Container(
                      padding: const pw.EdgeInsets.all(2),
                      child: pw.Text(multiInputArr != null ? multiInputArr[131] : ' ',style: letterText10),
                        decoration: pw.BoxDecoration(
                          border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                        )
                      ) 
                    ),
                    pw.Text('OI 20/', style: letterText12),
                    pw.Container(
                      padding: const pw.EdgeInsets.all(2),
                      child: pw.Text(multiInputArr != null ? multiInputArr[132] : ' ',style: letterText10),
                        decoration: pw.BoxDecoration(
                          border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                        )
                      ) 
                    ),
                  ]
                ),
                pw.Row(
                  children: [
                    pw.Text('LENTES  ', style: letterText12),
                    pw.Text(' SI ', style: letterText12),
                    pw.Container(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Text(YesNotFunction(++radioButtonC, yestNotEnumArr, 1),style: letterText10),
                      decoration: pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                      )
                    ) 
                    ),
                    pw.Text(' NO ', style: letterText12),
                    pw.Container(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Text(YesNotFunction(radioButtonC, yestNotEnumArr, 2 ),style: letterText10),
                      decoration: pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                      )
                    ) 
                    ),
                  ]
                ),
                pw.Row(
                  children: [
                    pw.Text('CAMPIMETRIA  ', style: letterText12),
                    pw.Text(' OD ', style: letterText12),
                    pw.Container(
                      padding: const pw.EdgeInsets.all(2),
                      child: pw.Text(multiInputArr != null ? multiInputArr[ 133 ] : ' ',style: letterText10),
                        decoration: pw.BoxDecoration(
                          border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                        )
                      ) 
                    ),
                    pw.Text(' OI ', style: letterText12),
                    pw.Container(
                      padding: const pw.EdgeInsets.all(2),
                      child: pw.Text(multiInputArr != null ? multiInputArr[134] : ' ',style: letterText10),
                        decoration: pw.BoxDecoration(
                          border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                        )
                      ) 
                    ),
                    pw.Text(' COLOR ', style: letterText12),
                    pw.Container(
                      padding: const pw.EdgeInsets.all(2),
                      child: pw.Text(multiInputArr != null ? multiInputArr[multiInputC = 135] : ' ',style: letterText10),
                        decoration: pw.BoxDecoration(
                          border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                        )
                      ) 
                    ),
                  ]
                ),
                pw.SizedBox(height: 20),
                pw.Row(
                  children: [
                    pw.Text('AMSLER NORMAL ', style: letterText12),
                    pw.Text(' SI ', style: letterText12),
                    pw.Container(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Text(YesNotFunction(++radioButtonC, yestNotEnumArr, 1),style: letterText10),
                      decoration: pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                      )
                    ) 
                    ),
                    pw.Text(' NO ', style: letterText12),
                    pw.Container(
                    padding: const pw.EdgeInsets.all(2),
                    child: pw.Text(YesNotFunction(radioButtonC, yestNotEnumArr, 2),style: letterText10),
                      decoration: pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                      )
                    ) 
                    ),
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
                    pw.Text('Resultados: ', style: letterText12),
                    pw.Container(
                      width: 420,
                      padding: const pw.EdgeInsets.all(2),
                      child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                        decoration: pw.BoxDecoration(
                          border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                        )
                      ) 
                    ),
                    /* pw.Container(
                      width: 450,
                      height: 0.5,
                      margin: const pw.EdgeInsets.only(top: 10),
                      color: PdfColors.black,
                    ) */
                  ]
                ),
                pw.Row(
                  children: [
                    pw.Text('Drogas: ', style: letterText12),
                    pw.Container(
                      width: 420,
                      padding: const pw.EdgeInsets.all(2),
                      child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                        decoration: pw.BoxDecoration(
                          border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                        )
                      ) 
                    ),
                    /* pw.Container(
                      width: 450,
                      height: 0.5,
                      margin: const pw.EdgeInsets.only(top: 10),
                      color: PdfColors.black,
                    ), */
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
              pw.Row(children: [
                //200
                pw.Text('Telerradiografía de Tórax: ', style: letterText12),
                pw.Container(
                  width: 400,
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                )
              ]),
              pw.Row(children: [
                //200
                pw.Text('RX Columna Lumbar: ', style: letterText12),
                pw.Container(
                  width: 400,
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                )
              ]),
                pw.Text('Otros', style: letterText12),
                pw.Row(
                  children: [
                    pw.Text('Espirometria: ', style: letterText12),
                    pw.Text(' Normal ', style: YesNotFunction(++radioButtonC, yestNotEnumArr, 1) == 'X'? pw.TextStyle(color: PdfColors.red, fontWeight: pw.FontWeight.bold, fontSize: 11,font: pw.Font.times()) : pw.TextStyle(fontSize: 11,font: pw.Font.times())),
                    pw.Text(' Fuera de rango ', style: YesNotFunction(radioButtonC, yestNotEnumArr, 2) == 'X'? pw.TextStyle(color: PdfColors.red, fontWeight: pw.FontWeight.bold, fontSize: 11,font: pw.Font.times()) : pw.TextStyle(fontSize: 11,font: pw.Font.times())),
                    pw.Text('Audiometria: ', style: letterText12),
                    pw.Text(' Normal ', style: YesNotFunction(++radioButtonC, yestNotEnumArr, 1) == 'X'? pw.TextStyle(color: PdfColors.red, fontWeight: pw.FontWeight.bold, fontSize: 11,font: pw.Font.times()) : pw.TextStyle(fontSize: 11,font: pw.Font.times())),
                    pw.Text(' Fuera de rango ', style: YesNotFunction(radioButtonC, yestNotEnumArr, 2) == 'X'? pw.TextStyle(color: PdfColors.red, fontWeight: pw.FontWeight.bold, fontSize: 11,font: pw.Font.times()) : pw.TextStyle(fontSize: 11,font: pw.Font.times())),
                    pw.Text('Prueba covid-19 ', style: letterText12),
                    pw.Text(' Normal ', style: YesNotFunction(++radioButtonC, yestNotEnumArr, 1) == 'X'? pw.TextStyle(color: PdfColors.red, fontWeight: pw.FontWeight.bold, fontSize: 11,font: pw.Font.times()) : pw.TextStyle(fontSize: 11,font: pw.Font.times())),
                    pw.Text(' Fuera de rango ', style: YesNotFunction(radioButtonC, yestNotEnumArr, 2) == 'X'? pw.TextStyle(color: PdfColors.red, fontWeight: pw.FontWeight.bold, fontSize: 11,font: pw.Font.times()) : pw.TextStyle(fontSize: 11,font: pw.Font.times())),
                 ],
                  
                ),
                pw.Row(
                  children: [
                    pw.Text('Embarazo: ', style: letterText12),
                    pw.Text(' Normal ', style: YesNotFunction(++radioButtonC, yestNotEnumArr, 1) == 'X'? pw.TextStyle(color: PdfColors.red, fontWeight: pw.FontWeight.bold, fontSize: 11,font: pw.Font.times()) : pw.TextStyle(fontSize: 11,font: pw.Font.times())),
                    pw.Text(' Fuera de rango ', style: YesNotFunction(radioButtonC, yestNotEnumArr, 2) == 'X'? pw.TextStyle(color: PdfColors.red, fontWeight: pw.FontWeight.bold, fontSize: 11,font: pw.Font.times()) : pw.TextStyle(fontSize: 11,font: pw.Font.times())),                    pw.Text('Antidoping: ', style: letterText12),
                    pw.Text(' Normal ', style: YesNotFunction(++radioButtonC, yestNotEnumArr, 1) == 'X'? pw.TextStyle(color: PdfColors.red, fontWeight: pw.FontWeight.bold, fontSize: 11,font: pw.Font.times()) : pw.TextStyle(fontSize: 11,font: pw.Font.times())),
                    pw.Text(' Fuera de rango ', style: YesNotFunction(radioButtonC, yestNotEnumArr, 2) == 'X'? pw.TextStyle(color: PdfColors.red, fontWeight: pw.FontWeight.bold, fontSize: 11,font: pw.Font.times()) : pw.TextStyle(fontSize: 11,font: pw.Font.times())),
                  ],
                )
              ]
            )
          ),
          pw.SizedBox(height: 20),
          pw.Text('DICTAMEN MÉDICO', style: letterBold12.copyWith(fontSize: 10)),
          pw.Row(
            children: [
              pw.Text('  Apto: ', style: letterText12),
              pw.Container(
                width: 80,
                padding: const pw.EdgeInsets.all(2),
                child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText10),
                  decoration: pw.BoxDecoration(
                    border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                  )
                ) 
              ),
             /*  pw.Container(
                width: 100,
                height: 0.5,
                margin: const pw.EdgeInsets.only(top: 10),
                color: PdfColors.black,
              ) */
              pw.Text('  No Apto: ', style: letterText12),
              pw.Container(
                width: 80,
                padding: const pw.EdgeInsets.all(2),
                child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText),
                  decoration: pw.BoxDecoration(
                    border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                  )
                ) 
              ),
              pw.Text('  Apto Con reserva: ', style: letterText12),
              pw.Container(
                width: 220,
                padding: const pw.EdgeInsets.all(2),
                child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText),
                  decoration: pw.BoxDecoration(
                    border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                  )
                ) 
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
                  width: 570,
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(multiInputArr != null ? multiInputArr[++multiInputC] : ' ',style: letterText),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: widthLineTable, color: PdfColors.black), 
                    )
                  ) 
                ),
                /* pw.Container(
                width: double.infinity,
                height: 0.5,
                margin: const pw.EdgeInsets.only(top: 10),
                color: PdfColors.black,
                child: pw.Text('')
              ), */
              ]
            )
          ),
          pw.SizedBox(height: 45),
          pw.Container(
            alignment: pw.Alignment.center,
            child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                // pw.Spacer(),
                /* pw.Container(
                  alignment: pw.Alignment.center,
                  child: pw.Column(
                    children: [
                      pw.Container(
                        width: 150.0,
                        height: 50.0,
                        child : pw.Image( pw.MemoryImage(transformationImage(multiInputArr != null? multiInputArr[144] : ''))),
                      ),
                      pw.Text('_______________________________',style:letterText10),
                      pw.Text('Firma de Aspirante',style:letterText10)
                    ]
                  )
                ), 
                pw.Spacer(),*/
                pw.Container(
                  alignment: pw.Alignment.center,
                  child: pw.Column(
                    children: [
                      pw.Container(
                        width: 150.0,
                        height: 50.0,
                        child : pw.Image( pw.MemoryImage(transformationImage(multiInputArr != null? multiInputArr[144] : ''))),
                      ),
                      pw.Text('_______________________________',style:letterText10),
                      pw.Text('Nombre, Firma y Ced. Prof. del Médico\nDr. Alfredo Gruel Culebro',style:letterText10)
                    ]
                  )
                ),
              ]
            ),
          )
        ]
      );
  })
  );
  stopwatch.stop();
 // print(' El Tiempo de renderizado del pdf es de : ${stopwatch.elapsedMilliseconds} milisegundos');





final Uint8List bytes = await pdf.save();
  String fecha = "${now.day}${now.month}${now.year}";
  String hora = "${now.hour}${now.minute}${now.second}${now.millisecond}";
  String resultado = fecha + hora;
  var fileName = "tabla_medico_$resultado";

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
      final file = File('$path/tabla_medico_$resultado.pdf');  
      await file.writeAsBytes(bytes); 
      await OpenFile.open('$path/tabla_medico_$resultado.pdf');
    }
}
}





