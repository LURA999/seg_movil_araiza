import 'package:app_seguimiento_movil/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/models.dart';


  int _currentPageIndex = 0;


class MedicalTest extends StatefulWidget {
  final BuildContext context;
  const MedicalTest({Key? key, required this.context}) : super(key: key);

  @override
  State<MedicalTest> createState() => _MedicalTestState();
}

 

class _MedicalTestState extends State<MedicalTest> {

  final EmployeeRole? _character = EmployeeRole.employee;
  bool morePage = false;  

  late bool _inputsAdd = false;
  final List<List<Widget>> _pages = [[]] ;
  final List<String> _titles = ['EXAMEN MÉDICO LABORAL', '1.- FICHA PERSONAL', '2.- HISTORIAL LABORAL','3.- ACCIDENTES Y ENFERMEDADES DE TRABAJO Anote SOLO Accidentes de trabajo','4.- ANTECEDENTES HEREDITARIOS Y FAMILIARES DE SALUD (Con una X anote los datos positivos según sea el caso)','5.-ANTECEDENTES PERSONALES (Con una X anote los datos positivos según sea el caso)','ANTECEDENTES GINECOLÓGICOS (SOLO SE APLICA A MUJERES)','5.2.-ANTECEDENTES PERSONALES PATOLÓGICOS','6.- INTERROGATORIO POR APARATOS Y SISTEMAS.','7.-EXPLORACIÓN FÍSICA','8.-ANÁLISIS DE LABORATORIO','9.-ESTUDIOS DE GABINETE', 'DICTAMEN MÉDICO'];

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
          child: Text('Crear nuevo',style: MediaQuery.of(context).size.height < 960 && MediaQuery.of(context).size.width <600  ?
          //para celulares
          TextStyle(fontSize: MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .03: 0.015)):
          //para tablets
          TextStyle(fontSize: MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .02: 0.015),),
          ),
          )
        );
      }
  Future<String?> newMethod(BuildContext context) {
    _currentPageIndex =0;
    PageController _pageController = PageController(initialPage: 0);

    final List<GlobalKey<FormState>> myFormKey = [GlobalKey<FormState>(),GlobalKey<FormState>(),GlobalKey<FormState>(),GlobalKey<FormState>()];
    // final List<TextEditingController> controller = [TextEditingController(),TextEditingController(),TextEditingController()];

    List<Map<String, MultiInputs>> formpart1 = [
    {//Primeras preguntas
    'Departamento' : MultiInputs(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),// 'guard': ['',false,false, true],
    'Puesto' : MultiInputs(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),// 'date_start_hour': ['',true,false, true],
    },
    {//ficha personal
     'Nombre' : MultiInputs(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),// 'guard': ['',false,false, true],
     'Sexo' : MultiInputs(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),// 'date_start_hour': ['',true,false, true],
     'Edad' : MultiInputs(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),// 'guard': ['',false,false, true],
     'Edo. Civil' : MultiInputs(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),// 'date_start_hour': ['',true,false, true],
     'Domicilio' : MultiInputs(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),// 'guard': ['',false,false, true],
     'Tel. fijo y/o cel' : MultiInputs(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),// 'date_start_hour': ['',true,false, true],
     'Lugar y fecha de nacimiento' : MultiInputs(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),// 'date_start_hour': ['',true,false, true],
     'Actividad extra a su trabajo' : MultiInputs(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),// 'date_start_hour': ['',true,false, true],
     'Escolaridad' : MultiInputs(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),// 'date_start_hour': ['',true,false, true],
     'Carrera universitaria' : MultiInputs(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),// 'date_start_hour': ['',true,false, true],
     'Núm. de hijos' : MultiInputs(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),// 'date_start_hour': ['',true,false, true],
    },
    {//historial laboral
     '1.- Empresa' : MultiInputs(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),// 'guard': ['',false,false, true],
     '1.- Puestos' : MultiInputs(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),// 'date_start_hour': ['',true,false, true],
     '1.- Tiempo' : MultiInputs(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),// 'guard': ['',false,false, true],
     '2.- Empresa' : MultiInputs(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),// 'guard': ['',false,false, true],
     '2.- Puestos' : MultiInputs(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),// 'date_start_hour': ['',true,false, true],
     '2.- Tiempo' : MultiInputs(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),// 'guard': ['',false,false, true],
     '3.- Empresa' : MultiInputs(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),// 'guard': ['',false,false, true],
     '3.- Puestos' : MultiInputs(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),// 'date_start_hour': ['',true,false, true],
     '3.- Tiempo' : MultiInputs(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),// 'guard': ['',false,false, true],
     '4.- Empresa' : MultiInputs(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),// 'guard': ['',false,false, true],
     '4.- Puestos' : MultiInputs(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),// 'date_start_hour': ['',true,false, true],
     '4.- Tiempo' : MultiInputs(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),// 'guard': ['',false,false, true],
    } ,
    {//historial laboral
     '1.- Nombre de empresa' : MultiInputs(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),// 'guard': ['',false,false, true],
     '1.- Fecha' : MultiInputs(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),// 'date_start_hour': ['',true,false, true],
     '1.- Puesto' : MultiInputs(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),// 'guard': ['',false,false, true],
     '1.- Causa' : MultiInputs(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),// 'guard': ['',false,false, true],
     '1.- Nombre de la lesión o enfermedad' : MultiInputs(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),// 'guard': ['',false,false, true],
     '1.- Incapacidad' : MultiInputs(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),// 'guard': ['',false,false, true],
     '1.- Número de dias de incapacidad' : MultiInputs(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),// 'guard': ['',false,false, true],
     '2.- Nombre de empresa' : MultiInputs(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),// 'guard': ['',false,false, true],
     '2.- Fecha' : MultiInputs(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),// 'date_start_hour': ['',true,false, true],
     '2.- Puesto' : MultiInputs(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),// 'guard': ['',false,false, true],
     '2.- Causa' : MultiInputs(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),// 'guard': ['',false,false, true],
     '2.- Nombre de la lesión o enfermedad' : MultiInputs(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),// 'guard': ['',false,false, true],
     '2.- Incapacidad' : MultiInputs(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),// 'guard': ['',false,false, true],
     '2.- Número de dias de incapacidad' : MultiInputs(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),// 'guard': ['',false,false, true],
     '3.- Nombre de empresa' : MultiInputs(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),// 'guard': ['',false,false, true],
     '3.- Fecha' : MultiInputs(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),// 'date_start_hour': ['',true,false, true],
     '3.- Puesto' : MultiInputs(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),// 'guard': ['',false,false, true],
     '3.- Causa' : MultiInputs(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),// 'guard': ['',false,false, true],
     '3.- Nombre de la lesión o enfermedad' : MultiInputs(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),// 'guard': ['',false,false, true],
     '3.- Incapacidad' : MultiInputs(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),// 'guard': ['',false,false, true],
     '3.- Número de dias de incapacidad' : MultiInputs(contenido: '', obligatorio: true, select: false, enabled: true, paintSignature: false,uploadFile: false),// 'guard': ['',false,false, true],
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
          _pages[i].add(const SizedBox(height: 10,));
          _pages[i].add (
          MultiInputs(
          maxLines: 1,
          labelText: key,
          controller: null,
          autofocus: false,
          formProperty: key,
          MultiInputss: formpart1[i],
          keyboardType: TextInputType.text));
          formi++;
          _pages[i].add(const SizedBox(height: 10,));
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
        MediaQuery.of(context).size.height < 960 && MediaQuery.of(context).size.width <600  ?
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
                      itemCount: 4,
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
