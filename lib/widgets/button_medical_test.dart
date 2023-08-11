import 'package:app_seguimiento_movil/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/models.dart';
import '../services/letter_mediaquery.dart';


class MedicalTest extends StatefulWidget {
  final BuildContext context;
  const MedicalTest({Key? key, required this.context}) : super(key: key);

  @override
  State<MedicalTest> createState() => _MedicalTestState();
}

 

class _MedicalTestState extends State<MedicalTest> {

  @override
  Widget build(BuildContext context) {
      return SizedBox(
        child: ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
            ),
          ),
          onPressed: () {
              newMethod(context);
          },
          child: Text('Crear nuevo',style: getTextStyleButtonField(context),
          ),
        )
        );
      }
  Future<String?> newMethod(BuildContext context) {
    int _currentPageIndex = 0;
  final EmployeeRole? _character = EmployeeRole.employee;
  bool morePage = false;  

  //El primero es para controlar los inputs cuando abre y cierra el form
  late bool _inputsAdd = false;
  //El segundo es para controlar los radiobutton que se generan al abrir y cerrar el form
  late bool _inputsAdd2 = false;


  final List<List<Widget>> _pages = [[]] ;
  final List<String> _titles = ['EXAMEN MÉDICO LABORAL', '1.- FICHA PERSONAL', '2.- HISTORIAL LABORAL','3.- ACCIDENTES Y ENFERMEDADES DE TRABAJO Anote SOLO Accidentes de trabajo','4.- ANTECEDENTES HEREDITARIOS Y FAMILIARES DE SALUD (Con una X anote los datos positivos según sea el caso)','5.-ANTECEDENTES PERSONALES (Con una X anote los datos positivos según sea el caso)','ANTECEDENTES GINECOLÓGICOS (SOLO SE APLICA A MUJERES)','5.2.-ANTECEDENTES PERSONALES PATOLÓGICOS','6.- INTERROGATORIO POR APARATOS Y SISTEMAS.','7.-EXPLORACIÓN FÍSICA','8.-ANÁLISIS DE LABORATORIO','9.-ESTUDIOS DE GABINETE', 'DICTAMEN MÉDICO'];
  
  //Estos son variables para guardar los resultados de los resultados radiobutton
  List<Cause> causeEnum = [Cause.none,Cause.none,Cause.none];
  List<YesNot> yesNotEnum = [YesNot.none,YesNot.none,YesNot.none];
  List<ManoDominante> manoDomEnum = [ManoDominante.none];
  int countCauseEnum =0;
  int countYesNotEnum = 0;
  int countManoDomEnum = 0;

  //Estas son variables para guardar los resultados de los checkbox
  List<List<bool>> listChecked =[
    [false,false,false,false,false,false,false,false,false,false],
    [false,false,false,false,false,false,false,false,false,false],
    [false,false,false,false,false,false,false,false,false,false],
    [false,false,false,false,false,false,false,false,false,false],
    [false,false,false,false,false,false,false,false,false,false]
  ];

    _currentPageIndex =0;
    PageController _pageController = PageController(initialPage: 0);

    final List<GlobalKey<FormState>> myFormKey = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    ];
    // final List<TextEditingController> controller = [TextEditingController(),TextEditingController(),TextEditingController()];

    List<Map<String, dynamic>> formpart1 = [
    {//Primeras preguntas
    'Departamento' : MultiInputsForm(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),
    'Puesto' : MultiInputsForm(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),
    },
    {//ficha personal
     'Nombre' : MultiInputsForm(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),
     'Sexo' : MultiInputsForm(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),
     'Edad' : MultiInputsForm(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),
     'Edo. Civil' : MultiInputsForm(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),
     'Domicilio' : MultiInputsForm(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),
     'Tel. fijo y/o cel' : MultiInputsForm(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),
     'Lugar y fecha de nacimiento' : MultiInputsForm(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),
     'Actividad extra a su trabajo' : MultiInputsForm(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),
     'Escolaridad' : MultiInputsForm(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),
     'Carrera universitaria' : MultiInputsForm(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),
     'Núm. de hijos' : MultiInputsForm(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),
    },
    {//historial laboral
     '1.- Sized' : const SizedBox(height: 20,),
     '1.- Titulo' : const Align(alignment: Alignment.centerLeft, child: Text('Primera empresa',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))),
     '1.- Empresa' : MultiInputsForm(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),
     '1.- Puestos' : MultiInputsForm(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),
     '1.- Tiempo' : MultiInputsForm(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),
     '2.- Sized' : const SizedBox(height: 20,),
     '2.- Titulo' : const Align(alignment: Alignment.centerLeft, child: Text('Segunda empresa',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))),
     '2.- Empresa' : MultiInputsForm(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),
     '2.- Puestos' : MultiInputsForm(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),
     '2.- Tiempo' : MultiInputsForm(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),
     '3.- Sized' : const SizedBox(height: 20,),
     '3.- Titulo' : const Align(alignment: Alignment.centerLeft, child: Text('Tercera empresa',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))),
     '3.- Empresa' : MultiInputsForm(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),
     '3.- Puestos' : MultiInputsForm(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),
     '3.- Tiempo' : MultiInputsForm(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),
     '4.- Sized' : const SizedBox(height: 20,),
     '4.- Titulo' : const Align(alignment: Alignment.centerLeft, child: Text('Cuarta empresa',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))),
     '4.- Empresa' : MultiInputsForm(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),
     '4.- Puestos' : MultiInputsForm(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),
     '4.- Tiempo' : MultiInputsForm(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),
    } ,
    {//historial laboral
     '1.- Sized' : const SizedBox(height: 20,),
     '1.- Titulo' : const Align(alignment: Alignment.centerLeft, child: Text('Primera empresa',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))),
     '1.- Nombre de empresa' : MultiInputsForm(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),
     '1.- Fecha' : MultiInputsForm(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),
     '1.- Puesto' : MultiInputsForm(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),
     '1.- Causa' : const Align(alignment: Alignment.centerLeft, child: Text('Causa',style: TextStyle(fontSize: 20))),
     '1.- Causas' : RadioInput(tipoEnum: 2, causeEnum: causeEnum ,index: countCauseEnum++,),
     '1.- Nombre de la lesión o enfermedad' : MultiInputsForm(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),
     '1.- Incapacidad' : const Align(alignment: Alignment.centerLeft, child: Text('Incapacidad',style: TextStyle(fontSize: 20))),
     '1.- YesNot' : RadioInput(tipoEnum: 1, yesNotEnum: yesNotEnum, index: countYesNotEnum++,),
     '1.- Número de dias de incapacidad' : MultiInputsForm(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),
     '2.- Sized' : const SizedBox(height: 20,),
     '2.- Titulo' : const Align(alignment: Alignment.centerLeft, child: Text('Segunda empresa',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))),
     '2.- Nombre de empresa' : MultiInputsForm(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),
     '2.- Fecha' : MultiInputsForm(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),
     '2.- Puesto' : MultiInputsForm(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),
     '2.- Causa' : const Align(alignment: Alignment.centerLeft, child: Text('Causa',style: TextStyle(fontSize: 20))),
     '2.- Causas' : RadioInput(tipoEnum: 2, causeEnum: causeEnum ,index: countCauseEnum++,),
     '2.- Nombre de la lesión o enfermedad' : MultiInputsForm(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),
     '2.- Incapacidad' : const Align(alignment: Alignment.centerLeft, child: Text('Incapacidad',style: TextStyle(fontSize: 20))),
     '2.- YesNot' : RadioInput( tipoEnum: 1, yesNotEnum: yesNotEnum, index: countYesNotEnum++,),
     '2.- Número de dias de incapacidad' : MultiInputsForm(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),
     '3.- Sized' : const SizedBox(height: 20,),
     '3.- Titulo' : const Align(alignment: Alignment.centerLeft, child: Text('Tercera empresa',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))),
     '3.- Nombre de empresa' : MultiInputsForm(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),
     '3.- Fecha' : MultiInputsForm(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),
     '3.- Puesto' : MultiInputsForm(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),
     '3.- Causa' : const Align(alignment: Alignment.centerLeft, child: Text('Causa',style: TextStyle(fontSize: 20))),
     '3.- Causas' : RadioInput( tipoEnum: 2, causeEnum: causeEnum ,index: countCauseEnum++,),
     '3.- Nombre de la lesión o enfermedad' : MultiInputsForm(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),
     '3.- Incapacidad' : const Align(alignment: Alignment.centerLeft, child: Text('Incapacidad',style: TextStyle(fontSize: 20))),
     '3.- YesNot' : RadioInput( tipoEnum: 1, yesNotEnum: yesNotEnum, index: countYesNotEnum++,),
     '3.- Número de dias de incapacidad' : MultiInputsForm(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),
    },
    { //4.- ANTECEDENTES HEREDITARIOS Y FAMILIARES DE SALUD 
      // (Con una X anote los datos positivos según sea el caso)
     '1.- Sized' : const SizedBox(height: 20,),
     'Padre' : const Align(alignment: Alignment.centerLeft, child: Text('Padre',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))),
     '1.- opc' : [
                CheckInput(contenido: 'Buena salud',listChecked: listChecked,indexPrincipal:0,indexSecundario: 0,),
                CheckInput(contenido: 'Mala salud',listChecked: listChecked,indexPrincipal:0,indexSecundario: 1,),
                CheckInput(contenido: 'Finado',listChecked: listChecked,indexPrincipal:0,indexSecundario: 2),
                CheckInput(contenido: 'Alergia',listChecked: listChecked,indexPrincipal:0,indexSecundario: 3),
                CheckInput(contenido: 'Diabetes',listChecked: listChecked,indexPrincipal:0,indexSecundario: 4),
                CheckInput(contenido: 'Presion Alta',listChecked: listChecked,indexPrincipal:0,indexSecundario: 5),
                CheckInput(contenido: 'Colesterol',listChecked: listChecked,indexPrincipal:0,indexSecundario: 6),
                CheckInput(contenido: 'Enf. Corazón',listChecked: listChecked,indexPrincipal:0,indexSecundario: 7),
                CheckInput(contenido: 'Cancer',listChecked: listChecked,indexPrincipal:0,indexSecundario: 8),
                CheckInput(contenido: 'Anemia',listChecked: listChecked,indexPrincipal:0,indexSecundario: 9)
                  ],
     '2.- Sized' : const SizedBox(height: 20,),
     'Madre' : const Align(alignment: Alignment.centerLeft, child: Text('Madre',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))),
     '2.- opc' : [
                CheckInput(contenido: 'Buena salud',listChecked: listChecked,indexPrincipal:1,indexSecundario: 0,),
                CheckInput(contenido: 'Mala salud',listChecked: listChecked,indexPrincipal:1,indexSecundario: 1,),
                CheckInput(contenido: 'Finado',listChecked: listChecked,indexPrincipal:1,indexSecundario: 2,),
                CheckInput(contenido: 'Alergia',listChecked: listChecked,indexPrincipal:1,indexSecundario: 3,),
                CheckInput(contenido: 'Diabetes',listChecked: listChecked,indexPrincipal:1,indexSecundario: 4,),
                CheckInput(contenido: 'Presion Alta',listChecked: listChecked,indexPrincipal:1,indexSecundario: 5,),
                CheckInput(contenido: 'Colesterol',listChecked: listChecked,indexPrincipal:1,indexSecundario: 6,),
                CheckInput(contenido: 'Enf. Corazón',listChecked: listChecked,indexPrincipal:1,indexSecundario: 7,),
                CheckInput(contenido: 'Cancer',listChecked: listChecked,indexPrincipal:1,indexSecundario: 8,),
                CheckInput(contenido: 'Anemia',listChecked: listChecked,indexPrincipal:1,indexSecundario: 9,),
                  ],
     '3.- Sized' : const SizedBox(height: 20,),
     'Hermanos' : const Align(alignment: Alignment.centerLeft, child: Text('Hermanos',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))),
     '3.- opc' : [
                CheckInput(contenido: 'Buena salud',listChecked: listChecked,indexPrincipal:2,indexSecundario: 0,),
                CheckInput(contenido: 'Mala salud',listChecked: listChecked,indexPrincipal:2,indexSecundario: 1,),
                CheckInput(contenido: 'Finado',listChecked: listChecked,indexPrincipal:2,indexSecundario: 2,),
                CheckInput(contenido: 'Alergia',listChecked: listChecked,indexPrincipal:2,indexSecundario: 3,),
                CheckInput(contenido: 'Diabetes',listChecked: listChecked,indexPrincipal:2,indexSecundario: 4,),
                CheckInput(contenido: 'Presion Alta',listChecked: listChecked,indexPrincipal:2,indexSecundario: 5,),
                CheckInput(contenido: 'Colesterol',listChecked: listChecked,indexPrincipal:2,indexSecundario: 6,),
                CheckInput(contenido: 'Enf. Corazón',listChecked: listChecked,indexPrincipal:2,indexSecundario: 7,),
                CheckInput(contenido: 'Cancer',listChecked: listChecked,indexPrincipal:2,indexSecundario: 8,),
                CheckInput(contenido: 'Anemia',listChecked: listChecked,indexPrincipal:2,indexSecundario: 9,),
                  ],
     '4.- Sized' : const SizedBox(height: 20,),
     'Pareja' : const Align(alignment: Alignment.centerLeft, child: Text('Pareja',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))),
     '4.- opc' : [
                CheckInput(contenido: 'Buena salud',listChecked: listChecked,indexPrincipal:3,indexSecundario: 0,),
                CheckInput(contenido: 'Mala salud',listChecked: listChecked,indexPrincipal:3,indexSecundario: 1,),
                CheckInput(contenido: 'Finado',listChecked: listChecked,indexPrincipal:3,indexSecundario: 2,),
                CheckInput(contenido: 'Alergia',listChecked: listChecked,indexPrincipal:3,indexSecundario: 3,),
                CheckInput(contenido: 'Diabetes',listChecked: listChecked,indexPrincipal:3,indexSecundario: 4,),
                CheckInput(contenido: 'Presion Alta',listChecked: listChecked,indexPrincipal:3,indexSecundario: 5,),
                CheckInput(contenido: 'Colesterol',listChecked: listChecked,indexPrincipal:3,indexSecundario: 6,),
                CheckInput(contenido: 'Enf. Corazón',listChecked: listChecked,indexPrincipal:3,indexSecundario: 7,),
                CheckInput(contenido: 'Cancer',listChecked: listChecked,indexPrincipal:3,indexSecundario: 8,),
                CheckInput(contenido: 'Anemia',listChecked: listChecked,indexPrincipal:3,indexSecundario: 9,),
                  ],
     '5.- Sized' : const SizedBox(height: 20,),
     'Hijos' : const Align(alignment: Alignment.centerLeft, child: Text('hijos',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))),
     '5.- opc' : [
                CheckInput(contenido: 'Buena salud',listChecked: listChecked,indexPrincipal:4,indexSecundario: 0,),
                CheckInput(contenido: 'Mala salud',listChecked: listChecked,indexPrincipal:4,indexSecundario: 1,),
                CheckInput(contenido: 'Finado',listChecked: listChecked,indexPrincipal:4,indexSecundario: 2,),
                CheckInput(contenido: 'Alergia',listChecked: listChecked,indexPrincipal:4,indexSecundario: 3,),
                CheckInput(contenido: 'Diabetes',listChecked: listChecked,indexPrincipal:4,indexSecundario: 4,),
                CheckInput(contenido: 'Presion Alta',listChecked: listChecked,indexPrincipal:4,indexSecundario: 5,),
                CheckInput(contenido: 'Colesterol',listChecked: listChecked,indexPrincipal:4,indexSecundario: 6,),
                CheckInput(contenido: 'Enf. Corazón',listChecked: listChecked,indexPrincipal:4,indexSecundario: 7,),
                CheckInput(contenido: 'Cancer',listChecked: listChecked,indexPrincipal:4,indexSecundario: 8,),
                CheckInput(contenido: 'Anemia',listChecked: listChecked,indexPrincipal:4,indexSecundario: 9,),
                  ],
    },
    {//5.-ANTECEDENTES PERSONALES (Con una X anote los datos positivos según sea el caso)
      '¿Eres?' : const Align(alignment: Alignment.centerLeft, child: Text('hijos',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))),
      '5.- mano' : RadioInput(index: countManoDomEnum,tipoEnum: 3,manoDomEnum: manoDomEnum ),         
    } 


  ];

  int i = 0;
  if(!_inputsAdd){
    _inputsAdd = true;
    while ( i < formpart1.length) {
    _pages.add([]);
    int formi = 1;
    _pages[i].add(Title(
      color: Colors.black, 
      child: Text(_titles[i], style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .05: 0.025),fontWeight: FontWeight.bold))));
        formpart1[i].forEach((key, value) {
        switch (value.runtimeType) {
          case MultiInputsForm:
            _pages[i].add(const SizedBox(height: 10,));
            _pages[i].add (
            MultiInputs(
            maxLines: 1,
            labelText: key,
            controller: null,
            autofocus: false,
            formProperty: key,
            formValue: formpart1[i],
            keyboardType: TextInputType.text));
            formi++;
            _pages[i].add(const SizedBox(height: 10,));
            break;
          case RadioInput:
          // print(value.tipoEnum);
           if(value.tipoEnum == 3){
            _pages[i].add(value);
          }else{ 
          _pages[i].add(value);
          }
          break;
          case List<CheckInput>:
            _pages[i].add(SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: value,
            ),
          ));
          break;
          default:
          _pages[i].add(value);
        }  
        
      });
      ++i; 
      }
    }
  

    return  showDialog<String>(
    context: context,
    builder: (BuildContext context ) => StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
      return GestureDetector(
      onTap: () => SystemChannels.textInput.invokeMethod('TextInput.hide'),
      child: Dialog(
        insetPadding:  
        MediaQuery.of(context).size.height < 960 && MediaQuery.of(context).size.width <900  ?
          //para celulares
          EdgeInsets.fromLTRB(
          MediaQuery.of(context).size.width * .07,
          MediaQuery.of(context).size.height * .07,
          MediaQuery.of(context).size.width * .07,
          MediaQuery.of(context).size.height * .07,
        ):
          //para tablets
          EdgeInsets.fromLTRB(
          MediaQuery.of(context).size.width * .07,
          MediaQuery.of(context).size.height * .0,
          MediaQuery.of(context).size.width * .07,
          MediaQuery.of(context).size.height * .0,
          ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      // physics: const NeverScrollableScrollPhysics(),
                      controller: _pageController,
                      itemCount: 7,
                      itemBuilder: (context, index) {
                        return SingleChildScrollView(
                          child: Form(
                            key: myFormKey[index],
                            child: Column(
                              children: _pages[index],
                            ),
                          ),
                        );
                      },
                      onPageChanged: (index) {
                        setState(() {
                          _currentPageIndex = index;
                        });
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if( _currentPageIndex > 0)
                      ElevatedButton(
                        onPressed: () {
                            _pageController.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          setState(() { _currentPageIndex--; });
                        },
                        child: const Text('Anterior'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_currentPageIndex < _pages.length - 2) {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                            // formpart1[_currentPageIndex].forEach((key, value) { 
                            //   print(value.contenido);
                            // });
                            setState(() { 
                              _currentPageIndex++;
                            });    
                          } else {
                            // formpart1[_currentPageIndex].forEach((key, value) { 
                            //   print(value.contenido);
                            // });

                          }
                          
                        },
                        child: Text(_currentPageIndex == _pages.length - 2
                            ? 'Terminar'
                            : 'Siguiente'),
                      ),
                    ],
                  ),
                ],
              ),
            )
      ));
    })
    );
  }
  
}
