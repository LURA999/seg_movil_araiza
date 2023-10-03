import 'dart:io';
import 'package:app_seguimiento_movil/services/services.dart';
import 'package:app_seguimiento_movil/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:app_seguimiento_movil/models/models.dart';
import 'package:app_seguimiento_movil/widgets/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';


class MedicalRecords extends StatefulWidget {
const MedicalRecords({Key? key}) : super(key: key);

@override
State<MedicalRecords> createState() => _MedicalRecordsState();
}

class _MedicalRecordsState extends State<MedicalRecords> {
int itemShow = 10;
bool arrLoadFiles = true;

List<MedicalRecord> files = [ ];

List<String> resString = [ ];
List<String> resString2 = [ ];
List<String> resString3 = [ ];
List<List<bool>>? bolArr = [ ];
List<YesNot> yesNotEnum = [];
List<Cause>? causeDisease = [];
List<YesNot>? yesNotDisease = [];
List<List<bool>> checkboxDLN = [];
List<ManoDominante> manoDomEnum = [];
List<MetodoAnti> metodoAntiEnum = [];
List<Map<String,dynamic>> arrDepa = [];

ScrollController scrollControl = ScrollController();
bool isLoading = false;
BouncingScrollPhysics? physCustom;

final TextEditingController controller = TextEditingController();
final Map<String, MultiInputsForm> formValuesBuscar = {
  'search' : MultiInputsForm(contenido: '')
};

@override
void initState() {
  super.initState();
  scrollControl.addListener(() {
    if (scrollControl.position.pixels <= 40) {
      physCustom  = null;
    }else{
      physCustom = const BouncingScrollPhysics();
      
      if ((scrollControl.position.pixels + 500) >= scrollControl.position.maxScrollExtent) {
        fetchDataTable();
      }
    }
    
    });

}


@override
Widget build(BuildContext context) {
Size size = MediaQuery.of(context).size ;
EdgeInsets paddingCell = EdgeInsets.fromLTRB(
MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .005: .01),
MediaQuery.of(context).size.height * (MediaQuery.of(context).orientation == Orientation.portrait ? .005: .01),
0,
MediaQuery.of(context).size.height * (MediaQuery.of(context).orientation == Orientation.portrait ? .005: .01));

EdgeInsets paddingIcon = MediaQuery.of(context).size.height < 960 && MediaQuery.of(context).size.width <500  ?
//para celulares
(EdgeInsets.fromLTRB(
MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .01: .0001),
MediaQuery.of(context).size.height * (MediaQuery.of(context).orientation == Orientation.portrait ? .01: .0001),
MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .01: .0001),
MediaQuery.of(context).size.height * (MediaQuery.of(context).orientation == Orientation.portrait ? .01: .0001))) :
//para tables
(EdgeInsets.fromLTRB(
MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .001: .0001),
MediaQuery.of(context).size.height * (MediaQuery.of(context).orientation == Orientation.portrait ? .001: .0001),
MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .001: .0001),
MediaQuery.of(context).size.height * (MediaQuery.of(context).orientation == Orientation.portrait ? .001: .0001)));

TextStyle myTextSyleBody = const TextStyle(
  color: Color(0xFF293641),
  fontFamily: 'GothamMedium',
  fontWeight: FontWeight.normal
);

TextStyle myTextStyleTitle = const TextStyle(
  color: Color(0xFF293641),
  fontFamily: 'GothamBold',
  fontWeight: FontWeight.w900,
);




 Future<List<MedicalRecord>> fetchData() async {
  if (arrLoadFiles) {
    files.clear();
    ExamIniPreService eips = ExamIniPreService();
    final list = await eips.getAllExamList(context);
    for (var el in list) {
      files.add(
      MedicalRecord(
        id: int.parse(el['numEmployee']), 
        name: el['name'] == '' ? 'N/A' : el['name'], 
        date: el['datetime_modification'], 
        type: el['examName'] ?? 'N/A', 
        lastModify: el['datetime_modification'],
        exam: int.parse(el['idExam'])
        )
      );
      arrLoadFiles = false;
    }   
  }
  return files;
  }

Future<void> onRefresh () async{
  await Future.delayed(const Duration(seconds: 3));
}

return FutureBuilder<List<MedicalRecord>>(
future: fetchData(),
builder: (context, snapshot) {
 
return Scaffold(
  body: Column(
    children: [
      Expanded(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
          MediaQuery.of(context).size.width * .05,
          MediaQuery.of(context).size.height * .05,
          MediaQuery.of(context).size.width * .05,
          MediaQuery.of(context).size.height * 0),
          child: Column(
            children: [
              
            if (snapshot.hasData) 
            Expanded(
            child: Stack(
              children: [
                ListView.builder(
                  physics: physCustom,
                  controller: scrollControl,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                     if (index == 0) {
                    return Column(
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
                                      width: MediaQuery.of(context).size.height < 960 && MediaQuery.of(context).size.width <900  ?
                                      //para celulares
                                      ( MediaQuery.of(context).size.width * .4 )
                                      :
                                      //para tablets 
                                      (MediaQuery.of(context).size.width * .3 ),
                                      child: MultiInputs(
                                        formProperty: 'search', 
                                        labelText: '# empleado o nombre',
                                        formValue: formValuesBuscar,
                                        controller: controller,
                                        maxLines: 1, 
                                        autofocus: false),
                                      ),
                                        Align(
                                      alignment:Alignment.centerRight,
                                      child: IconButton(
                                        icon: const Icon(Icons.search_outlined),
                                        onPressed: () async {
                                          ExamIniPreService eips = ExamIniPreService();
                                          files.clear();
                                          final list = await eips.getAllExamListSearch(context,controller.text);
                                          for (var el in list) {
                                            files.add(
                                            MedicalRecord(
                                              id: int.parse(el['numEmployee']), 
                                              name: el['name'] == '' ? 'N/A' : el['name'], 
                                              date: el['datetime_modification'], 
                                              type: el['examName'] ?? 'N/A', 
                                              lastModify: el['datetime_modification'],
                                              exam: int.parse(el['idExam'])
                                              )
                                            );
                                          }
                                          setState(() { });   
                                        },
                                      ),
                                      ),
                                  const Spacer(),
                                  ElevatedButton(
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(0),
                                        ),
                                      ),
                                    ),
                                  
                                    onPressed: () async {
                                      
                                      DepartamentService dp = DepartamentService();
                                      arrDepa =  await dp.getDepartament(context);                              
                                      newMethod(context, arrDepa, null, null, null, null, null, null, null, null, null, null, -1, false);
                                    },
                                    child: Text('Crear nuevo',style: MediaQuery.of(context).size.height < 960 && MediaQuery.of(context).size.width <600  ?
                                    //para celulares
                                    TextStyle(fontSize: MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .03: 0.015)):
                                    //para tablets
                                    TextStyle(fontSize: MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .02: 0.015),),
                                    ),
                                    )
                            
                                ],
                              ) 
                            ]
                          ),
                        ),
                      ),
                        Container(
                          color: const Color.fromARGB(255, 204, 204, 204),
                          child: Row(
                            children: [
                              SizedBox(
                              width: MediaQuery.of(context).size.width * 0.1,
                              child: Container(
                                  padding: paddingCell,
                                  child: Text('ID',softWrap: true,style: myTextSyleBody.copyWith(fontSize: MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .03: 0.013))),
                                ),
                            ),
                              SizedBox(
                              width: MediaQuery.of(context).size.width * 0.17,
                                child: Container(
                                  padding: paddingCell,
                                  child: Text('Nombre',softWrap: true,style: myTextSyleBody.copyWith(fontSize: MediaQuery.of(context).size.width  * (MediaQuery.of(context).orientation == Orientation.portrait ? .03: 0.014))),
                                ),
                              ),
                              SizedBox(
                              width: MediaQuery.of(context).size.width * 0.17,
                                child: Container(
                                  padding: paddingCell,
                                  child: Text('Fecha',softWrap: true,style: myTextSyleBody.copyWith(fontSize: MediaQuery.of(context).size.width  * (MediaQuery.of(context).orientation == Orientation.portrait ? .03: 0.013)))
                                ),
                              ),
                              SizedBox(
                              width: MediaQuery.of(context).size.width * 0.23,
                                child: Container(
                                  padding: paddingCell,
                                  child: Text('Tipo',softWrap: true,style: myTextSyleBody.copyWith(fontSize: MediaQuery.of(context).size.width  * (MediaQuery.of(context).orientation == Orientation.portrait ? .03: 0.013)))
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: paddingCell,
                                  child: Text('Opciones',softWrap: true,style: myTextSyleBody.copyWith(fontSize: MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .03: 0.013)))
                                ),
                              ),
                            ],
                          ),
                        ),
                        tablaBodySeH(context, paddingCell, snapshot, index, myTextSyleBody, paddingIcon)
                      ],
                    ); // El primer elemento es el encabezado
                  } 
                    return tablaBodySeH(context, paddingCell, snapshot, index, myTextSyleBody, paddingIcon);
                  }
                ),
               if(isLoading)
                Positioned(
                  bottom: 5,
                  left: size.width * 0.45 - 30,
                  child:  loadingIcon()
                )
                 
              ],
            ),),
          ],
          )
          ),
      ),
      const SizedBox(child: Navbar(contexto2: 'medical_records'))
        ]),
      );
      
}
  );

}

Container loadingIcon() {
  return Container(
    padding: const EdgeInsets.all(10),
    width: 60,
    height: 60,
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.9),
      shape: BoxShape.circle
    ),
    child: const CircularProgressIndicator( color: AppTheme.primary, ),
  );
}

Future<void> fetchDataTable() async {
  if(isLoading) return;

  isLoading = true;
  setState(() { });

  await Future.delayed( const Duration(seconds:  3));

  isLoading = false;
  setState(() { });
  
  scrollControl.animateTo(
        scrollControl.position.pixels + 120, 
        duration: const Duration(milliseconds: 300), 
        curve: Curves.fastOutSlowIn
      );
}



Column tablaBodySeH(BuildContext context, EdgeInsets paddingCell, AsyncSnapshot<List<MedicalRecord>> snapshot, int index, TextStyle myTextSyleBody, EdgeInsets paddingIcon) {
  return Column(
                children: [
                  Container(
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
                    child: Row(
                      children: [
                        SizedBox(
                        width: MediaQuery.of(context).size.width * 0.1,
                        child: Container(
                            padding: paddingCell,
                            child: Text(snapshot.data![index].id.toString(),softWrap: true,style: myTextSyleBody.copyWith(fontSize: MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .027: 0.013))),
                          ),
                      ),
                        SizedBox(
                        width: MediaQuery.of(context).size.width * 0.17,
                          child: Container(
                            padding: paddingCell,
                            child: Text(snapshot.data![index].name,softWrap: true,style: myTextSyleBody.copyWith(fontSize: MediaQuery.of(context).size.width  * (MediaQuery.of(context).orientation == Orientation.portrait ? .027: 0.013))),
                          ),
                        ),
                        SizedBox(
                        width: MediaQuery.of(context).size.width * 0.17,
                          child: Container(
                            padding: paddingCell,
                            child: Text(snapshot.data![index].date,softWrap: true,style: myTextSyleBody.copyWith(fontSize: MediaQuery.of(context).size.width  * (MediaQuery.of(context).orientation == Orientation.portrait ? .027: 0.013)))
                          ),
                        ),
                        SizedBox(
                        width: MediaQuery.of(context).size.width * 0.23,
                          child: Container(
                            padding: paddingCell,
                            child: Text(snapshot.data![index].type,softWrap: true,style: myTextSyleBody.copyWith(fontSize: MediaQuery.of(context).size.width  * (MediaQuery.of(context).orientation == Orientation.portrait ? .027: 0.013)))
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                            Expanded(child: Container(
                              margin: EdgeInsets.all(1),
                              padding: paddingIcon,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(50),
                                child: SvgPicture.asset('assets/images/icons_seh/download.svg',width: double.infinity ),
                                onTap: () async => await onTapEdit(snapshot, index, context, 2),
                              ),
                            )),
                            Expanded(child: Container(
                              padding: paddingIcon,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(50),
                                child: SvgPicture.asset('assets/images/icons_seh/edit.svg',width: double.infinity ),
                                onTap: () async => await onTapEdit(snapshot, index, context, 1),
                              ),
                            )),
                            Expanded(child: Container(
                              margin: EdgeInsets.all(1),
                              padding: paddingIcon,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(50),
                                child: SvgPicture.asset('assets/images/icons_seh/preview.svg',width: double.infinity, ),
                                onTap: () async => await onTapEdit(snapshot, index, context, 3),
                              ),
                            ))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              );
}

   onTapEdit(AsyncSnapshot<List<MedicalRecord>> snapshot, int index, BuildContext context, int type) async {
    //type 1 = edit
    //type 2 = pdf
                                int cExamPart1 = 0;
                                yesNotEnum = [];
                                checkboxDLN = [[]];
                                ExamIniPreService eips = ExamIniPreService();
                                final  info = await eips.getOneExamPart1(snapshot.data![index].exam,context);
                                resString = [];
                                info[0].forEach((key, value) {
                                  if(cExamPart1 < 145){
                                    resString.add(value.toString() == 'null'? '' : value.toString());
                                  } else if (cExamPart1 > 144 && cExamPart1 < 191) {
                                      switch (int.parse(value)) {
                                        case 1:  yesNotEnum.add(YesNot.si); break;
                                        case 2:  yesNotEnum.add(YesNot.no); break; 
                                        default:
                                         yesNotEnum.add(YesNot.none); 
                                      }
                                  }else if(cExamPart1 > 190&& cExamPart1 < 203) {
                                    checkboxDLN[0].add(int.parse(value) == 2 ? true : false);
                                  }else{
                                    switch (key) {
                                      case 'fk_dominant_hand':
                                        switch (int.parse(value)) {
                                          case 1:  manoDomEnum.add(ManoDominante.diestro); break;
                                          case 2: manoDomEnum.add(ManoDominante.zurdo); break;
                                          case 3: manoDomEnum.add(ManoDominante.ambos);  break;
                                          case 0: manoDomEnum.add(ManoDominante.none); break;
                                        }
                                      break;
                                      case 'fk_contraceptive_method':
                                        switch (int.parse(value)) {
                                            case 1:metodoAntiEnum.add(MetodoAnti.pastillas); break;
                                            case 2:metodoAntiEnum.add(MetodoAnti.dispositivo); break;
                                            case 3:metodoAntiEnum.add(MetodoAnti.condon);   break;
                                            case 4:metodoAntiEnum.add(MetodoAnti.otb); break;
                                            case 5:metodoAntiEnum.add(MetodoAnti.inyeccion); break;
                                            case 6:metodoAntiEnum.add(MetodoAnti.implante); break;
                                            case 0:metodoAntiEnum.add(MetodoAnti.none); break;
                                          }
                                      break;
                                      default:
        
                                    }
                                  }
                                  cExamPart1++;
                                });
        
        
                                DepartamentService dp = DepartamentService();
                                arrDepa =  await dp.getDepartament(context);
                
                                final arrHis =  await eips.getExamHistory(snapshot.data![index].exam,context);
                                      resString2 = [];
                                if (arrHis.isNotEmpty) {
                                  for (var i = 0; i < 4; i++) {
                                    arrHis[i].forEach((key, value) {
                                      resString2.add(value.toString());
                                    });
                                  }
                                }
        
                                final arrAcciddentDi =  await eips.getExamAcciddentDisease(snapshot.data![index].exam,context);
                                resString3 = [];
                                if (arrAcciddentDi.isNotEmpty) {
                                  for (var i = 0; i < 3; i++) {
                                    arrAcciddentDi[i].forEach((key, value) {
                                      if (key == 'causa') {
                                        switch (int.parse(value)) {
                                          case 1:  causeDisease!.add(Cause.accidente); break;
                                          case 2:  causeDisease!.add(Cause.enfermedad); break; 
                                          default:
                                           causeDisease!.add(Cause.none); 
                                        }
                                      }else if (key == 'incapacity') {
                                          switch (int.parse(value)) {
                                            case 1:  yesNotDisease!.add(YesNot.si); break;
                                            case 2:  yesNotDisease!.add(YesNot.no); break; 
                                            default:
                                            yesNotDisease!.add(YesNot.none); 
                                          }
                                      }else{
                                        resString3.add(value.toString());
                                      }
                                    });
                                  }
                                }else{
                                  causeDisease = null;
                                  yesNotDisease = null;
                                }
        
                                final arrHeredity =  await eips.getExamHeredityFam(snapshot.data![index].exam,context);
                                if (arrHeredity.isNotEmpty) {
                                  bolArr = [ [],[],[],[],[]];
                                  for (var i = 0; i < 5; i++) {
                                    arrHeredity[i].forEach((key, value) {
                                      bolArr![i].add(int.parse(value) == 0 ? false : true);
                                    });
                                  }
                                } else {
                                  bolArr = null;
                                }
                                
                                //Edit
                                if (type == 1) {
                                await newMethod(context, arrDepa, resString, resString2, resString3, bolArr, 
                                yesNotEnum, checkboxDLN, causeDisease, yesNotDisease, manoDomEnum, metodoAntiEnum,int.parse(snapshot.data![index].exam.toString()), true );
                              
                                files.clear();
                                final list = await eips.getAllExamList(context);
                                for (var el in list) {
                                  files.add(
                                  MedicalRecord(
                                    id: int.parse(el['numEmployee']), 
                                    name: el['name'] == '' ? 'N/A' : el['name'], 
                                    date: el['datetime_modification'], 
                                    type: el['examName'] ?? 'N/A', 
                                    lastModify: el['datetime_modification'],
                                    exam: int.parse(el['idExam'])
                                    )
                                  );
                                }
                                setState(() { });   
                                //Preview
                                } else if(type == 2) {
                                   generatePDF(context,true,arrDepa,resString, resString2, resString3, bolArr, 
                                  yesNotEnum, checkboxDLN, causeDisease, yesNotDisease, manoDomEnum, metodoAntiEnum);
                                
                                //Download
                                } else if(type == 3){
                                  generatePDF(context,false, arrDepa,resString, resString2, resString3, bolArr, 
                                  yesNotEnum, checkboxDLN, causeDisease, yesNotDisease, manoDomEnum, metodoAntiEnum);
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
                               
                              
}
}
