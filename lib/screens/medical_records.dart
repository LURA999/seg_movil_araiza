import 'dart:io';

import 'package:app_seguimiento_movil/services/services.dart';
import 'package:flutter/material.dart';
import 'package:app_seguimiento_movil/models/models.dart';
import 'package:app_seguimiento_movil/widgets/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';


class MedicalRecords extends StatelessWidget {
  const MedicalRecords({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    EdgeInsets paddingCell = EdgeInsets.fromLTRB(
    MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .005: .01),
    MediaQuery.of(context).size.height * (MediaQuery.of(context).orientation == Orientation.portrait ? .005: .01),
    MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .005: .01),
    MediaQuery.of(context).size.height * (MediaQuery.of(context).orientation == Orientation.portrait ? .005: .01));
    
    EdgeInsets paddingIcon = MediaQuery.of(context).size.height < 960 && MediaQuery.of(context).size.width <600  ?
    //para celulares
    (EdgeInsets.fromLTRB(
    MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .003: .01),
    MediaQuery.of(context).size.height * (MediaQuery.of(context).orientation == Orientation.portrait ? .025: .035),
    MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .003: .01),
    MediaQuery.of(context).size.height * (MediaQuery.of(context).orientation == Orientation.portrait ? .025: .035))) :
    //para tables
    (EdgeInsets.fromLTRB(
    MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .01: .017),
    MediaQuery.of(context).size.height * (MediaQuery.of(context).orientation == Orientation.portrait ? .01: .017),
    MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .01: .017),
    MediaQuery.of(context).size.height * (MediaQuery.of(context).orientation == Orientation.portrait ? .01: .017)));
    
    TextStyle myTextSyleBody = const TextStyle(
      color: Color(0xFF293641),
      fontFamily: 'Inter',
      fontWeight: FontWeight.normal
    );

    TextStyle myTextStyleTitle = const TextStyle(
      color: Color(0xFF293641),
      fontFamily: 'Inter',
      fontWeight: FontWeight.w900,
    );
    
    TextStyle myTextStyleSubtitule = const TextStyle(
      color: Color(0xFF293641),
      fontFamily: 'Inter',
      fontWeight: FontWeight.normal,
    );

    final Map<String, List<Object?>> formValuesBuscar = {
      'search':['',false,false, true,true]
    };

    List<MedicalRecord> files = [
      MedicalRecord(
        id: 3451,
        name: 'Andrea Fernanda Urías Márquez',
        date: '05/06/2023',
        type: 'Examen médico manipuladores de alimentos',
        lastModify : '05/06/2023\nAux. Seguridad e Higiene'
      ),
      MedicalRecord(
        id: 3451,
        name: 'Andrea Fernanda Urías Márquez',
        date: '05/06/2023',
        type: 'Examen médico manipuladores de alimentos',
        lastModify : '05/06/2023\nAux. Seguridad e Higiene'
      ),
      MedicalRecord(
        id: 3451,
        name: 'Andrea Fernanda Urías Márquez',
        date: '05/06/2023',
        type: 'Examen médico manipuladores de alimentos',
        lastModify : '05/06/2023\nAux. Seguridad e Higiene'
      ),
      MedicalRecord(
        id: 3451,
        name: 'Andrea Fernanda Urías Márquez',
        date: '05/06/2023',
        type: 'Examen médico manipuladores de alimentos',
        lastModify : '05/06/2023\nAux. Seguridad e Higiene'
      )
    ];

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width * .05,
                MediaQuery.of(context).size.height * .05,
                MediaQuery.of(context).size.width * .05,
                MediaQuery.of(context).size.height * 0),
                child: Column(
                  children: [
                    Container(
                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * .02),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Text('Seguridad e Higiene',style: myTextStyleTitle.copyWith(fontSize: MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .08: 0.04) )),
                         SizedBox(height: MediaQuery.of(context).size.height *.02),
                         Row(
                           children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.height < 960 && MediaQuery.of(context).size.width <600  ?
                                  //para celulares
                                  ( MediaQuery.of(context).size.width * .4 )
                                  :
                                  //para tablets 
                                  (MediaQuery.of(context).size.width * .3 ),
                                  child: CustomInputField(
                                    formProperty: 'search', 
                                    labelText: 'Núm. de empleado o nombre',
                                    formValues: formValuesBuscar,
                                    maxLines: 1, 
                                    autofocus: false, 
                                    keyboardType:  TextInputType.text),
                                ),
                                    Align(
                                  alignment:Alignment.centerRight,
                                  child: IconButton(
                                    icon: const Icon(Icons.search_outlined),
                                    onPressed: () {
                                      // Acción al presionar el ícono
                                    },
                                  ),
                                 ),
                             const Spacer(),
                             ElevatedButton(
                             onPressed: (){}, 
                             child: Text('Crear nuevo',style: MediaQuery.of(context).size.height < 960 && MediaQuery.of(context).size.width <600  ?
                              //para celulares
                              TextStyle(fontSize: MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .03: 0.015)):
                              //para tablets
                              TextStyle(fontSize: MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .02: 0.015),),
                              ))
                           ],
                         ) 
                        ]
                      ),
                    ),
                  ),
                Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  TableRow(
                    children: [
                    Container(
                      color: const Color.fromARGB(255, 204, 204, 204),
                      child: Row(
                        children: [
                         SizedBox(
                          width: MediaQuery.of(context).size.width * 0.1,
                          child: Container(
                              padding: paddingCell,
                              child: Text('ID',softWrap: true,style: myTextSyleBody.copyWith(fontSize: MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .02: 0.013))),
                            ),
                        ),
                          SizedBox(
                          width: MediaQuery.of(context).size.width * 0.17,
                            child: Container(
                              padding: paddingCell,
                              child: Text('Nombre',softWrap: true,style: myTextSyleBody.copyWith(fontSize: MediaQuery.of(context).size.width  * (MediaQuery.of(context).orientation == Orientation.portrait ? .02: 0.013))),
                            ),
                          ),
                          SizedBox(
                          width: MediaQuery.of(context).size.width * 0.1,
                            child: Container(
                              padding: paddingCell,
                              child: Text('Fecha',softWrap: true,style: myTextSyleBody.copyWith(fontSize: MediaQuery.of(context).size.width  * (MediaQuery.of(context).orientation == Orientation.portrait ? .02: 0.013)))
                            ),
                          ),
                          SizedBox(
                          width: MediaQuery.of(context).size.width * 0.17,
                            child: Container(
                              padding: paddingCell,
                              child: Text('Tipo',softWrap: true,style: myTextSyleBody.copyWith(fontSize: MediaQuery.of(context).size.width  * (MediaQuery.of(context).orientation == Orientation.portrait ? .02: 0.013)))
                            ),
                          ),
                          SizedBox(
                          width: MediaQuery.of(context).size.width * 0.17,
                            child: Container(
                              padding: paddingCell,
                              child: Text('Última modificación',softWrap: true,style: myTextSyleBody.copyWith(fontSize: MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .02: 0.013)))
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width  * (MediaQuery.of(context).orientation == Orientation.portrait ? .16: 0.13),
                          )
                        ],
                      ),
                    ),
                    ]
                  ),
                  ...files.map((file) {
                  return TableRow(children: [
                    Ink(
                      height: 70,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.282),
                            spreadRadius: 0.5,
                            blurRadius: 1,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      child: InkWell(
                        onTap: null,
                        child: Row(
                          children: [
                           SizedBox(
                            width: MediaQuery.of(context).size.width * 0.1,
                            child: Container(
                                padding: paddingCell,
                                child: Text(file.id.toString(),softWrap: true,style: myTextSyleBody.copyWith(fontSize: MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .02: 0.013))),
                              ),
                          ),
                            SizedBox(
                            width: MediaQuery.of(context).size.width * 0.17,
                              child: Container(
                                padding: paddingCell,
                                child: Text(file.name,softWrap: true,style: myTextSyleBody.copyWith(fontSize: MediaQuery.of(context).size.width  * (MediaQuery.of(context).orientation == Orientation.portrait ? .02: 0.013))),
                              ),
                            ),
                            SizedBox(
                            width: MediaQuery.of(context).size.width * 0.1,
                              child: Container(
                                padding: paddingCell,
                                child: Text(file.date,softWrap: true,style: myTextSyleBody.copyWith(fontSize: MediaQuery.of(context).size.width  * (MediaQuery.of(context).orientation == Orientation.portrait ? .02: 0.013)))
                              ),
                            ),
                            SizedBox(
                            width: MediaQuery.of(context).size.width * 0.17,
                              child: Container(
                                padding: paddingCell,
                                child: Text(file.type,softWrap: true,style: myTextSyleBody.copyWith(fontSize: MediaQuery.of(context).size.width  * (MediaQuery.of(context).orientation == Orientation.portrait ? .02: 0.013)))
                              ),
                            ),
                            SizedBox(
                            width: MediaQuery.of(context).size.width * 0.17,
                              child: Container(
                                padding: paddingCell,
                                child: Text(file.lastModify,softWrap: true,style: myTextSyleBody.copyWith(fontSize: MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .02: 0.013)))
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                Expanded(child: Padding(
                                  padding: paddingIcon,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(50),
                                    child: SvgPicture.asset('assets/images/icons_seh/download.svg',width: double.infinity ),
                                    onTap: () {
                                      generatePDF(context,true);
                                    }
                                  ),
                                )),
                                Expanded(child: Padding(
                                  padding: paddingIcon,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(50),
                                    child: SvgPicture.asset('assets/images/icons_seh/edit.svg',width: double.infinity ),
                                    onTap: () {
                                      print('editando');
                                    },
                                  ),
                                )),
                                Expanded(child: Padding(
                                  padding: paddingIcon,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(50),
                                    child: SvgPicture.asset('assets/images/icons_seh/preview.svg',width: double.infinity, ),
                                    onTap: () async {
                                      generatePDF(context,false);
                                      String directory2 = "";
                                      if (Platform.isAndroid) {
                                        directory2 = await getDownloadDirectoryPath();
                                      } else if (Platform.isIOS) {
                                        directory2 = (await getApplicationDocumentsDirectory()).path;
                                      } else {
                                        throw UnsupportedError('Plataforma no compatible');
                                      }
                                      await OpenFile.open('$directory2/tabla_medico.pdf');
                                    }
                                  ),
                                ))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ]);
                }).toList()],
                )
                ],
                ),
              ),
            ),
          ),
          const Navbar(contexto2: 'medical_records')
        ],
      ),
      
    );
  }
}
