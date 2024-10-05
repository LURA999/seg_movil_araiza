import 'dart:convert';
import 'dart:ui' as ui;
import 'package:app_seguimiento_movil/services/services.dart';
import 'package:app_seguimiento_movil/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_signature_pad/flutter_signature_pad.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import 'package:collection/collection.dart';


const  storage =  FlutterSecureStorage();
class ButtonMedicalTest {

 final Function() setStateCallback;

  ButtonMedicalTest(this.setStateCallback);

  void actualizarEstado() {
    // Aquí se llama a la función setStateCallback para actualizar el estado del widget
    setStateCallback();
  }

Future<String?> newMethod(StateSetter setState,BuildContext context, List<Map<String,dynamic>> arrDepartaments, List<String>? multiInputArr ,
List<String>? multiInputHArr, List<String>? multiInputAEArr, List<List<bool>>? checkBoxArr, List<YesNot>? yestNotEnumArr, 
List<List<bool>>? checkboxDLNArr, List<Cause>? causeDiseaseArr, List<YesNot>? yestNotEnumArrDisease,List<ManoDominante>? manoArr,
List<MetodoAnti>? methodArr, int idExam, bool edit ) {


// print(multiInputArr![25]);
int _currentPageIndex = 0;
List<bool> _activarSignature = [true,true];
int multiInputC = 1; 
int multiInputCH = 0; 
int multiInputCAE = 0; 
int radioButtonC = 0; 
int radioButtonCDisease = 0; 
int radioButtonCDiseaseYN = 0; 
bool btnSave = true;
bool copyBack = true;
List<GlobalKey<State>> specificWidgetKey = [GlobalKey(),GlobalKey(),GlobalKey(),GlobalKey(),GlobalKey(),GlobalKey(),GlobalKey(),GlobalKey(),GlobalKey(),GlobalKey(),GlobalKey(),GlobalKey()];

List<GlobalKey<SignatureState>> sign0 = [GlobalKey<SignatureState>(),GlobalKey<SignatureState>(),GlobalKey<SignatureState>()];
List<ByteData> img = [ByteData(0), ByteData(0), ByteData(0)];
List<SignatureState?> sign = [null,null,null];
ExamIniPreService eips = ExamIniPreService();
List<YesNot> yestNotEnumArrDiseaseFake = [];
List<YesNot> yestNotEnumArrFake = [];
List<ManoDominante> manoArrFake = [];
List<MetodoAnti> methodArrFake = [];
List<List<bool>> listChecked_sec7Fake = [[]];
// List<Cause>? causeDiseaseArrFake = [];
List<Cause> causeEnumFake = [];
List<List<bool>> checkBoxArrFake = [[],[],[],[],[]];
int numEmployee = 0;
//El primero es para controlar los inputs cuando abre y cierra el form
late bool _inputsAdd = false;
// String firmaAspirante = '';
String firmaDoctor = '';
List<String> clavesAComparar = [];

/*
1 = MultiInputsForm
2 = RadioButton
3 = List<CheckBox>
4 = firma
*/

final List<List<Widget>> _pages = [[]] ;
final List<String> _titles = [
'EXAMEN MÉDICO LABORAL', 
'1.- FICHA PERSONAL', 
'2.- HISTORIAL LABORAL',
'3.- ACCIDENTES Y ENFERMEDADES DE TRABAJO Anote SOLO Accidentes de trabajo',
'4.- ANTECEDENTES HEREDITARIOS Y FAMILIARES DE SALUD (Con una X anote los datos positivos según sea el caso)',
'5.- ANTECEDENTES PERSONALES (Con una X anote los datos positivos según sea el caso)\nANTECEDENTES PERSONALES NO PATOLÓGICOS',
'5.2.- ANTECEDENTES PERSONALES PATOLÓGICOS',
'6.- INTERROGATORIO POR APARATOS Y SISTEMAS.',
'7.- EXPLORACIÓN FÍSICA',
'8.- ANÁLISIS DE LABORATORIO',
'9.- ESTUDIOS DE GABINETE', 
'DICTAMEN MÉDICO',
'FIRMAS'
];

//Estos son variables para guardar los resultados de los resultados radiobutton
List<Cause> causeEnum = [Cause.none,Cause.none,Cause.none];
List<YesNot> yesNotEnum = 
[ 
  YesNot.none,YesNot.none,YesNot.none,YesNot.none,YesNot.none,YesNot.none, 
  YesNot.none,YesNot.none,YesNot.none,YesNot.none,YesNot.none,YesNot.none,
  YesNot.none,YesNot.none,YesNot.none,YesNot.none,YesNot.none,YesNot.none,
  YesNot.none,YesNot.none,YesNot.none,YesNot.none,YesNot.none,YesNot.none,
  YesNot.none,YesNot.none,YesNot.none,YesNot.none,YesNot.none,YesNot.none,
  YesNot.none,YesNot.none,YesNot.none,YesNot.none,YesNot.none,YesNot.none,
  YesNot.none,YesNot.none,YesNot.none,YesNot.none,YesNot.none,YesNot.none,
  YesNot.none,YesNot.none,YesNot.none,YesNot.none,YesNot.none,YesNot.none,
  YesNot.none
];

List<ManoDominante> manoDomEnum = [ManoDominante.none];
List<MetodoAnti> metodoAntiEnum = [MetodoAnti.none];

int countCauseEnum =0;
int countYesNotEnum = 0;

//Estas son variables para guardar los resultados de los checkbox
List<List<bool>> listChecked_sec4 =[
[false,false,false,false,false,false,false,false,false,false],
[false,false,false,false,false,false,false,false,false,false],
[false,false,false,false,false,false,false,false,false,false],
[false,false,false,false,false,false,false,false,false,false],
[false,false,false,false,false,false,false,false,false,false]
];


//ESTAS SON VARIABLES PARA ACTIVAR EL DLN
List<List<bool>> listChecked_sec7 =  checkboxDLNArr ?? [
[false,false,false,false,false,false,false,false,false,false,false,false],
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
{//Primeras preguntas (0)
'Numero de Empleado' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[multiInputC++] :  '',keyboardType: TextInputType.number, obligatorio: true,  enabled: true),
'Departamento' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[multiInputC++] :  '', obligatorio: true,  enabled: true, select: true, listSelectForm: arrDepartaments, maxLength: 10, activeListSelect: true ),
'Puesto' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[multiInputC++] :  '', obligatorio: true,  enabled: true),
'pre_o_ini' : RadioInput(tipoEnum: 7, yesNotEnum: yestNotEnumArr ?? yesNotEnum, index: yestNotEnumArr!=null ? radioButtonC++ : countYesNotEnum++,), //0
},
{//ficha personal (1)
  'Nombre' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[multiInputC++] :  '', obligatorio: true,  enabled: true),
  'Sexo' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[multiInputC++] :  '', obligatorio: true,  enabled: true, select: true, activeListSelect: true, listSelectForm: [{'idSex': '1', 'sex': 'Hombre'},{'idSex': '2', 'sex': 'Mujer'}] ),
  'Edad' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[multiInputC++] :  '', obligatorio: true,  enabled: true, keyboardType: TextInputType.number),
  'Edo. Civil' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[multiInputC++] :  '', obligatorio: true,  enabled: true),
  'Domicilio' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[multiInputC++] :  '', obligatorio: true,  enabled: true),
  'Tel. fijo y/o cel' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[multiInputC++] :  '', obligatorio: true,  enabled: true, keyboardType: TextInputType.number),
  'Lugar de nacimiento' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[multiInputC++] :  '', obligatorio: true,  enabled: true),
  'Fecha de nacimiento' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[multiInputC++] :  '', obligatorio: true,  enabled: true, keyboardType: TextInputType.datetime, activeClock: false),
  'Actividad extra a su trabajo' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[multiInputC++] :  '', obligatorio: true,  enabled: true),
  'Escolaridad' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[multiInputC++] :  '', obligatorio: true,  enabled: true),
  'Carrera universitaria' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[multiInputC++] :  '', obligatorio: true,  enabled: true),
  'Núm. de hijos' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[multiInputC++] :  '', obligatorio: true,  enabled: true, keyboardType: TextInputType.number),
},
{//historial laboral (2)
  '1.- Sized' : const SizedBox(height: 20,),
  '1.- Titulo' : const Align(alignment: Alignment.centerLeft, child: Text('Primera empresa',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))),
  '1.- Empresa' : MultiInputsForm(contenido: multiInputHArr != null ? multiInputHArr[multiInputCH++] :  '', obligatorio: true,  enabled: true),
  '1.- Puestos' : MultiInputsForm(contenido: multiInputHArr != null ? multiInputHArr[multiInputCH++] :  '', obligatorio: true,  enabled: true),
  '1.- Tiempo' : MultiInputsForm(contenido: multiInputHArr != null ? multiInputHArr[multiInputCH++] :  '', obligatorio: true,  enabled: true),
  '1.- subSized' : const SizedBox(height: 5,),
  '1.- subTitulo' : const Align(alignment: Alignment.centerLeft, child: Text('Para ser llenado solo por el médico',style: TextStyle(fontSize: 20))),
  '1.- Cuando Salió' : MultiInputsForm(contenido: multiInputHArr != null ? multiInputHArr[multiInputCH++] :  '', obligatorio: true,  enabled: true, keyboardType: TextInputType.datetime, activeClock: false),
  '1.- Rotación de puesto' : MultiInputsForm(contenido: multiInputHArr != null ? multiInputHArr[multiInputCH++] :  '', obligatorio: true,  enabled: true, maxLength: 10),
  '1.- Quimicos solventes' : MultiInputsForm(contenido: multiInputHArr != null ? multiInputHArr[multiInputCH++] :  '', obligatorio: true,  enabled: true, maxLength: 10),
  '1.- Humos' : MultiInputsForm(contenido: multiInputHArr != null ? multiInputHArr[multiInputCH++] :  '', obligatorio: true,  enabled: true, maxLength: 10),
  '1.- Vapores' : MultiInputsForm(contenido: multiInputHArr != null ? multiInputHArr[multiInputCH++] :  '', obligatorio: true,  enabled: true, maxLength: 10),
  '1.- Polvos' : MultiInputsForm(contenido: multiInputHArr != null ? multiInputHArr[multiInputCH++] :  '', obligatorio: true,  enabled: true, maxLength: 10),
  '1.- Ruido' : MultiInputsForm(contenido: multiInputHArr != null ? multiInputHArr[multiInputCH++] :  '', obligatorio: true,  enabled: true, maxLength: 10),
  '1.- Carga de material' : MultiInputsForm(contenido: multiInputHArr != null ? multiInputHArr[multiInputCH++] :  '', obligatorio: true,  enabled: true, maxLength: 10),

  '2.- Sized' : const SizedBox(height: 20,),
  '2.- Titulo' : const Align(alignment: Alignment.centerLeft, child: Text('Segunda empresa',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))),
  '2.- Empresa' : MultiInputsForm(contenido: multiInputHArr != null ? multiInputHArr[multiInputCH++] :  '', obligatorio: true,  enabled: true),
  '2.- Puestos' : MultiInputsForm(contenido: multiInputHArr != null ? multiInputHArr[multiInputCH++] :  '', obligatorio: true,  enabled: true),
  '2.- Tiempo' : MultiInputsForm(contenido: multiInputHArr != null ? multiInputHArr[multiInputCH++] :  '', obligatorio: true,  enabled: true),
  '2.- subSized' : const SizedBox(height: 5,),
  '2.- subTitulo' : const Align(alignment: Alignment.centerLeft, child: Text('Para ser llenado solo por el médico',style: TextStyle(fontSize: 20))),
  '2.- Cuando Salió' : MultiInputsForm(contenido: multiInputHArr != null ? multiInputHArr[multiInputCH++] :  '', obligatorio: true,  enabled: true, keyboardType: TextInputType.datetime, activeClock: false),
  '2.- Rotación de puesto' : MultiInputsForm(contenido: multiInputHArr != null ? multiInputHArr[multiInputCH++] :  '', obligatorio: true,  enabled: true, maxLength: 10),
  '2.- Quimicos solventes' : MultiInputsForm(contenido: multiInputHArr != null ? multiInputHArr[multiInputCH++] :  '', obligatorio: true,  enabled: true, maxLength: 10),
  '2.- Humos' : MultiInputsForm(contenido: multiInputHArr != null ? multiInputHArr[multiInputCH++] :  '', obligatorio: true,  enabled: true, maxLength: 10),
  '2.- Vapores' : MultiInputsForm(contenido: multiInputHArr != null ? multiInputHArr[multiInputCH++] :  '', obligatorio: true,  enabled: true, maxLength: 10),
  '2.- Polvos' : MultiInputsForm(contenido: multiInputHArr != null ? multiInputHArr[multiInputCH++] :  '', obligatorio: true,  enabled: true, maxLength: 10),
  '2.- Ruido' : MultiInputsForm(contenido: multiInputHArr != null ? multiInputHArr[multiInputCH++] :  '', obligatorio: true,  enabled: true, maxLength: 10),
  '2.- Carga de material' : MultiInputsForm(contenido: multiInputHArr != null ? multiInputHArr[multiInputCH++] :  '', obligatorio: true,  enabled: true, maxLength: 10),

  '3.- Sized' : const SizedBox(height: 20,),
  '3.- Titulo' : const Align(alignment: Alignment.centerLeft, child: Text('Tercera empresa',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))),
  '3.- Empresa' : MultiInputsForm(contenido: multiInputHArr != null ? multiInputHArr[multiInputCH++] :  '', obligatorio: true,  enabled: true),
  '3.- Puestos' : MultiInputsForm(contenido: multiInputHArr != null ? multiInputHArr[multiInputCH++] :  '', obligatorio: true,  enabled: true),
  '3.- Tiempo' : MultiInputsForm(contenido: multiInputHArr != null ? multiInputHArr[multiInputCH++] :  '', obligatorio: true,  enabled: true),
  '3.- subSized' : const SizedBox(height: 5,),
  '3.- subTitulo' : const Align(alignment: Alignment.centerLeft, child: Text('Para ser llenado solo por el médico',style: TextStyle(fontSize: 20))),
  '3.- Cuando Salió' : MultiInputsForm(contenido: multiInputHArr != null ? multiInputHArr[multiInputCH++] :  '', obligatorio: true,  enabled: true,keyboardType: TextInputType.datetime, activeClock: false),
  '3.- Rotación de puesto' : MultiInputsForm(contenido: multiInputHArr != null ? multiInputHArr[multiInputCH++] :  '', obligatorio: true,  enabled: true, maxLength: 10),
  '3.- Quimicos solventes' : MultiInputsForm(contenido: multiInputHArr != null ? multiInputHArr[multiInputCH++] :  '', obligatorio: true,  enabled: true, maxLength: 10),
  '3.- Humos' : MultiInputsForm(contenido: multiInputHArr != null ? multiInputHArr[multiInputCH++] :  '', obligatorio: true,  enabled: true, maxLength: 10),
  '3.- Vapores' : MultiInputsForm(contenido: multiInputHArr != null ? multiInputHArr[multiInputCH++] :  '', obligatorio: true,  enabled: true, maxLength: 10),
  '3.- Polvos' : MultiInputsForm(contenido: multiInputHArr != null ? multiInputHArr[multiInputCH++] :  '', obligatorio: true,  enabled: true, maxLength: 10),
  '3.- Ruido' : MultiInputsForm(contenido: multiInputHArr != null ? multiInputHArr[multiInputCH++] :  '', obligatorio: true,  enabled: true, maxLength: 10),
  '3.- Carga de material' : MultiInputsForm(contenido: multiInputHArr != null ? multiInputHArr[multiInputCH++] :  '', obligatorio: true,  enabled: true, maxLength: 10),

  '4.- Sized' : const SizedBox(height: 20,),
  '4.- Titulo' : const Align(alignment: Alignment.centerLeft, child: Text('Cuarta empresa',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))),
  '4.- Empresa' : MultiInputsForm(contenido: multiInputHArr != null ? multiInputHArr[multiInputCH++] :  '', obligatorio: true,  enabled: true),
  '4.- Puestos' : MultiInputsForm(contenido: multiInputHArr != null ? multiInputHArr[multiInputCH++] :  '', obligatorio: true,  enabled: true),
  '4.- Tiempo' : MultiInputsForm(contenido: multiInputHArr != null ? multiInputHArr[multiInputCH++] :  '', obligatorio: true,  enabled: true, maxLength: 10),
  '4.- subSized' : const SizedBox(height: 5,),
  '4.- subTitulo' : const Align(alignment: Alignment.centerLeft, child: Text('Para ser llenado solo por el médico',style: TextStyle(fontSize: 20))),
  '4.- Cuando Salió' : MultiInputsForm(contenido: multiInputHArr != null ? multiInputHArr[multiInputCH++] :  '', obligatorio: true,  enabled: true, keyboardType: TextInputType.datetime, activeClock: false),
  '4.- Rotación de puesto' : MultiInputsForm(contenido: multiInputHArr != null ? multiInputHArr[multiInputCH++] :  '', obligatorio: true,  enabled: true, maxLength: 10),
  '4.- Quimicos solventes' : MultiInputsForm(contenido: multiInputHArr != null ? multiInputHArr[multiInputCH++] :  '', obligatorio: true,  enabled: true, maxLength: 10),
  '4.- Humos' : MultiInputsForm(contenido: multiInputHArr != null ? multiInputHArr[multiInputCH++] :  '', obligatorio: true,  enabled: true, maxLength: 10),
  '4.- Vapores' : MultiInputsForm(contenido: multiInputHArr != null ? multiInputHArr[multiInputCH++] :  '', obligatorio: true,  enabled: true, maxLength: 10),
  '4.- Polvos' : MultiInputsForm(contenido: multiInputHArr != null ? multiInputHArr[multiInputCH++] :  '', obligatorio: true,  enabled: true, maxLength: 10),
  '4.- Ruido' : MultiInputsForm(contenido: multiInputHArr != null ? multiInputHArr[multiInputCH++] :  '', obligatorio: true,  enabled: true, maxLength: 10),
  '4.- Carga de material' : MultiInputsForm(contenido: multiInputHArr != null ? multiInputHArr[multiInputCH++] :  '', obligatorio: true,  enabled: true, maxLength: 10),

} ,
{//ACCIDENTES Y ENFERMEDADES DE TRABAJO (3)
  '1.- Sized' : const SizedBox(height: 20,),
  '1.- Titulo' : const Align(alignment: Alignment.centerLeft, child: Text('Primera empresa',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))),
  '1.- Nombre de empresa' : MultiInputsForm(contenido: multiInputAEArr != null ? multiInputAEArr[multiInputCAE++] :  '', obligatorio: true,  enabled: true),
  '1.- Fecha' : MultiInputsForm(contenido: multiInputAEArr != null ? multiInputAEArr[multiInputCAE++] :  '', obligatorio: true,  enabled: true, keyboardType: TextInputType.datetime, activeClock: false),
  '1.- Puesto' : MultiInputsForm(contenido: multiInputAEArr != null ? multiInputAEArr[multiInputCAE++] :  '', obligatorio: true,  enabled: true),
  '1.- Causa' : const Align(alignment: Alignment.centerLeft, child: Text('Causa',style: TextStyle(fontSize: 20))),
  '1.- Causas' : RadioInput(tipoEnum: 2, causeEnum: causeDiseaseArr ?? causeEnum ,index: causeDiseaseArr !=null ? radioButtonCDisease++ : countCauseEnum++, ),
  '1.- Nombre de la lesión o enfermedad' : MultiInputsForm(contenido: multiInputAEArr != null ? multiInputAEArr[multiInputCAE++] :  '', obligatorio: true,  enabled: true),
  '1.- Incapacidad' : const Align(alignment: Alignment.centerLeft, child: Text('Incapacidad',style: TextStyle(fontSize: 20))),
  '1.- YesNot' : RadioInput(tipoEnum: 1, yesNotEnum: yestNotEnumArrDisease ?? yesNotEnum, index: yestNotEnumArrDisease !=null ? radioButtonCDiseaseYN++ : countYesNotEnum++,),
  '1.- Número de dias de incapacidad' : MultiInputsForm(contenido: multiInputAEArr != null ? multiInputAEArr[multiInputCAE++] :  '', obligatorio: true,  enabled: true, keyboardType: TextInputType.number),
  '2.- Sized' : const SizedBox(height: 20,),
  '2.- Titulo' : const Align(alignment: Alignment.centerLeft, child: Text('Segunda empresa',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))),
  '2.- Nombre de empresa' : MultiInputsForm(contenido: multiInputAEArr != null ? multiInputAEArr[multiInputCAE++] :  '', obligatorio: true,  enabled: true),
  '2.- Fecha' : MultiInputsForm(contenido: multiInputAEArr != null ? multiInputAEArr[multiInputCAE++] :  '', obligatorio: true,  enabled: true, keyboardType: TextInputType.datetime, activeClock: false),
  '2.- Puesto' : MultiInputsForm(contenido: multiInputAEArr != null ? multiInputAEArr[multiInputCAE++] :  '', obligatorio: true,  enabled: true),
  '2.- Causa' : const Align(alignment: Alignment.centerLeft, child: Text('Causa',style: TextStyle(fontSize: 20))),
  '2.- Causas' : RadioInput(tipoEnum: 2, causeEnum: causeDiseaseArr ?? causeEnum ,index: causeDiseaseArr !=null ? radioButtonCDisease++ : countCauseEnum++,),
  '2.- Nombre de la lesión o enfermedad' : MultiInputsForm(contenido: multiInputAEArr != null ? multiInputAEArr[multiInputCAE++] :  '', obligatorio: true,  enabled: true),
  '2.- Incapacidad' : const Align(alignment: Alignment.centerLeft, child: Text('Incapacidad',style: TextStyle(fontSize: 20))),
  '2.- YesNot' : RadioInput(tipoEnum: 1, yesNotEnum: yestNotEnumArrDisease ?? yesNotEnum, index: yestNotEnumArrDisease !=null ? radioButtonCDiseaseYN++ : countYesNotEnum++,),
  '2.- Número de dias de incapacidad' : MultiInputsForm(contenido: multiInputAEArr != null ? multiInputAEArr[multiInputCAE++] :  '', obligatorio: true,  enabled: true, keyboardType: TextInputType.number),
  '3.- Sized' : const SizedBox(height: 20,),
  '3.- Titulo' : const Align(alignment: Alignment.centerLeft, child: Text('Tercera empresa',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))),
  '3.- Nombre de empresa' : MultiInputsForm(contenido: multiInputAEArr != null ? multiInputAEArr[multiInputCAE++] :  '', obligatorio: true,  enabled: true),
  '3.- Fecha' : MultiInputsForm(contenido: multiInputAEArr != null ? multiInputAEArr[multiInputCAE++] :  '', obligatorio: true,  enabled: true, keyboardType: TextInputType.datetime, activeClock: false),
  '3.- Puesto' : MultiInputsForm(contenido: multiInputAEArr != null ? multiInputAEArr[multiInputCAE++] :  '', obligatorio: true,  enabled: true),
  '3.- Causa' : const Align(alignment: Alignment.centerLeft, child: Text('Causa',style: TextStyle(fontSize: 20))),
  '3.- Causas' : RadioInput(tipoEnum: 2, causeEnum: causeDiseaseArr ?? causeEnum ,index: causeDiseaseArr !=null ? radioButtonCDisease++ : countCauseEnum++,),
  '3.- Nombre de la lesión o enfermedad' : MultiInputsForm(contenido: multiInputAEArr != null ? multiInputAEArr[multiInputCAE++] :  '', obligatorio: true,  enabled: true),
  '3.- Incapacidad' : const Align(alignment: Alignment.centerLeft, child: Text('Incapacidad',style: TextStyle(fontSize: 20))),
  '3.- YesNot' : RadioInput(tipoEnum: 1, yesNotEnum: yestNotEnumArrDisease ?? yesNotEnum, index: yestNotEnumArrDisease !=null ? radioButtonCDiseaseYN++ : countYesNotEnum++,),
  '3.- Número de dias de incapacidad' : MultiInputsForm(contenido: multiInputAEArr != null ? multiInputAEArr[multiInputCAE++] :  '', obligatorio: true,  enabled: true, keyboardType: TextInputType.number),
},
{ //4.- ANTECEDENTES HEREDITARIOS Y FAMILIARES DE SALUD (4)
  // (Con una X anote los datos positivos según sea el caso)
  '1.- Sized' : const SizedBox(height: 20,),
  'Padre' : const Align(alignment: Alignment.centerLeft, child: Text('Padre',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))),
  '1.- opc' :  0,
  '2.- Sized' : const SizedBox(height: 20,),
  'Madre' : const Align(alignment: Alignment.centerLeft, child: Text('Madre',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))),
  '2.- opc' : 1,
  '3.- Sized' : const SizedBox(height: 20,),
  'Hermanos' : const Align(alignment: Alignment.centerLeft, child: Text('Hermanos',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))),
  '3.- opc' : 2,
  '4.- Sized' : const SizedBox(height: 20,),
  'Pareja' : const Align(alignment: Alignment.centerLeft, child: Text('Pareja',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))),
  '4.- opc' : 3,
  '5.- Sized' : const SizedBox(height: 20,),
  'Hijos' : const Align(alignment: Alignment.centerLeft, child: Text('Hijos',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))),
  '5.- opc' : 4
},
{//5.-ANTECEDENTES PERSONALES (Con una X anote los datos positivos según sea el caso) (5)
  'Titulo' : const Align(alignment: Alignment.bottomLeft, child: Text('¿Eres?',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))),
  'singleScroll' :  RadioInput(index: 0,tipoEnum: 3,manoDomEnum: manoArr ?? manoDomEnum) , //0
  'Tabaquismo' : Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('Tabaquismo',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      RadioInput(tipoEnum: 4, yesNotEnum: yestNotEnumArr ?? yesNotEnum, index: yestNotEnumArr!=null ? radioButtonC++ : countYesNotEnum++,),//0
      
    ],
  ),
  '1.- Edad de inicio' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[multiInputC++] :  '', obligatorio: true,  enabled: true, keyboardType: TextInputType.number),
  'Cantidad de cigarrillos al día' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[multiInputC++] :  '', obligatorio: true,  enabled: true, keyboardType: TextInputType.number),
  'Alcohol' : Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('Ingesta de alcohol',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      RadioInput(tipoEnum: 4, yesNotEnum: yestNotEnumArr ?? yesNotEnum, index: yestNotEnumArr!=null ? radioButtonC++ : countYesNotEnum++,), //1
    ],
  ),
  '2.- Edad de inicio' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[multiInputC++] :  '', obligatorio: true,  enabled: true, keyboardType: TextInputType.number),
  'Frecuencia' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[multiInputC++] :  '', obligatorio: true,  enabled: true), 
  'Taxicomanías' : Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('Taxicomanías',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      RadioInput(tipoEnum: 4, yesNotEnum: yestNotEnumArr ?? yesNotEnum, index: yestNotEnumArr!=null ? radioButtonC++ : countYesNotEnum++,),//2
    ],
  ),
  '3.- Edad de inicio' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[multiInputC++] :  '', obligatorio: true,  enabled: true, keyboardType: TextInputType.number),
  'Tipo y frecuencia' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[multiInputC++] :  '', obligatorio: true,  enabled: true),
  'Alergías a med' : Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('Alergías a medicamentos',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      RadioInput(tipoEnum: 4, yesNotEnum: yestNotEnumArr ?? yesNotEnum, index: yestNotEnumArr!=null ? radioButtonC++ : countYesNotEnum++,),
    ],
  ),
  '1.- ¿A cuál?' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[multiInputC++] :  '', obligatorio: true,  enabled: true),
  'Alergías a alim' : Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('Alergías a alimentos',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      RadioInput(tipoEnum: 4, yesNotEnum: yestNotEnumArr ?? yesNotEnum, index: yestNotEnumArr!=null ? radioButtonC++ : countYesNotEnum++), //4
    ],
  ),
  '2.- ¿A cuál?' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[multiInputC++] :  '', obligatorio: true,  enabled: true),
  'Vacunas' : const Align(alignment: Alignment.bottomLeft, child: Text('Vacunas en los últimos 12 meses:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))),
  'COVID-19' : Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 10,),
      const Text('COVID-19',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      RadioInput(tipoEnum: 4, yesNotEnum: yestNotEnumArr ?? yesNotEnum, index: yestNotEnumArr!=null ? radioButtonC++ : countYesNotEnum++,),//5
    ],
  ),
  'Tétanos' : Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('Tétanos',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      RadioInput(tipoEnum: 4, yesNotEnum: yestNotEnumArr ?? yesNotEnum, index: yestNotEnumArr!=null ? radioButtonC++ : countYesNotEnum++,),//6
    ],
  ),
  'Hepatits' : Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('Hepatits',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      RadioInput(tipoEnum: 4, yesNotEnum: yestNotEnumArr ?? yesNotEnum, index: yestNotEnumArr!=null ? radioButtonC++ : countYesNotEnum++,),//7
    ],
  ),
  'Neumococo' : Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('Neumococo',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      RadioInput(tipoEnum: 4, yesNotEnum: yestNotEnumArr ?? yesNotEnum, index: yestNotEnumArr!=null ? radioButtonC++ : countYesNotEnum++,),//8
    ],
  ),
  'Otras' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[multiInputC++] :  '', obligatorio: true,  enabled: true),
  'Practicar deporte' : Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('¿Practica algún deporte?',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      RadioInput(tipoEnum: 4, yesNotEnum: yestNotEnumArr ?? yesNotEnum, index: yestNotEnumArr!=null ? radioButtonC++ : countYesNotEnum++,),//9
    ],
  ),
  '3.- ¿A cuál?' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[multiInputC++] :  '', obligatorio: true,  enabled: true),
  '¿Con qué frecuencia?' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[multiInputC++] :  '', obligatorio: true,  enabled: true),
  'Mujeres': Align(
    alignment: Alignment.bottomLeft,
    child:Column(
      children: [
        const SizedBox(height: 15,),
        Text('ANTECEDENTES GINECOLÓGICOS (SOLO SE APLICA A MUJERES)', style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal)),
        const SizedBox(height: 15,),
      ],
    )
  ),
  'Edad de su primera menstruación' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[multiInputC++] :  '', obligatorio: false,  enabled: true, keyboardType: TextInputType.number),
  'Edad de inicio de vida sexual' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[multiInputC++] :  '', obligatorio: false,  enabled: true, keyboardType: TextInputType.number),
  'Número de Embarazos' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[multiInputC++] :  '', obligatorio: false,  enabled: true, keyboardType: TextInputType.number),
  'Partos' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[multiInputC++] :  '', obligatorio: false,  enabled: true, keyboardType: TextInputType.number),
  'Cesáreas' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[multiInputC++] :  '', obligatorio: false,  enabled: true, keyboardType: TextInputType.number),
  'Abortos' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[multiInputC++] :  '', obligatorio: false,  enabled: true, keyboardType: TextInputType.number),
  'Fecha de Ultima Regla' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[multiInputC++] :  '', obligatorio: false,  enabled: true, keyboardType: TextInputType.datetime, activeClock: false),
  'Ritmo' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[multiInputC++] :  '', obligatorio: false,  enabled: true),
  'anticonceptivo actual' : const Align(alignment: Alignment.bottomLeft, child: Text('Método anticonceptivo actual:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))),
  'alignStart' : RadioInput(tipoEnum: 5, metodoAntiEnum: methodArr ?? metodoAntiEnum, index: 0),
  'Fecha de Último Papanicolaou' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[multiInputC++] :  '', obligatorio: true,  enabled: true, keyboardType: TextInputType.datetime, activeClock: false),
  '1.- Resultado' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[multiInputC++] :  '', obligatorio: true,  enabled: true),
  'Fecha de Mamografía' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[multiInputC++] :  '', obligatorio: true,  enabled: true, keyboardType: TextInputType.datetime, activeClock: false),
  '2.- Resultado' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[multiInputC++] :  '', obligatorio: true,  enabled: true),
  'Lactancia' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[multiInputC++] :  '', obligatorio: true,  enabled: true)
},
{//5.2.-ANTECEDENTES PERSONALES PATOLÓGICOS (6)
  'instrucciones': Container(
    alignment: Alignment.bottomLeft,
    child:Column(
      children: [
        const SizedBox(height: 15,),
        Text('Marque SI o NO con una X al lado de cualquiera de las siguientes enfermedades que usted haya padecido o padezca', style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal)),
        const SizedBox(height: 15,),
      ],
    )
  ),
  'alignStart' : Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      const Text('Artritis',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      RadioInput(tipoEnum: 4, yesNotEnum: yestNotEnumArr ?? yesNotEnum, index: yestNotEnumArr!=null ? radioButtonC++ : countYesNotEnum++,),
      const Text('Asma',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      RadioInput(tipoEnum: 4, yesNotEnum: yestNotEnumArr ?? yesNotEnum, index: yestNotEnumArr!=null ? radioButtonC++ : countYesNotEnum++,),
      const Text('Bronquitis',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      RadioInput(tipoEnum: 4, yesNotEnum: yestNotEnumArr ?? yesNotEnum, index: yestNotEnumArr!=null ? radioButtonC++ : countYesNotEnum++,),
      const Text('Hepatits',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      RadioInput(tipoEnum: 4, yesNotEnum: yestNotEnumArr ?? yesNotEnum, index: yestNotEnumArr!=null ? radioButtonC++ : countYesNotEnum++,),
      const Text('COVID',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      RadioInput(tipoEnum: 4, yesNotEnum: yestNotEnumArr ?? yesNotEnum, index: yestNotEnumArr!=null ? radioButtonC++ : countYesNotEnum++,),
      const Text('Enfs. de riñón',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      RadioInput(tipoEnum: 4, yesNotEnum: yestNotEnumArr ?? yesNotEnum, index: yestNotEnumArr!=null ? radioButtonC++ : countYesNotEnum++,),
      const Text('Enfs. de la piel',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      RadioInput(tipoEnum: 4, yesNotEnum: yestNotEnumArr ?? yesNotEnum, index: yestNotEnumArr!=null ? radioButtonC++ : countYesNotEnum++,),
      const Text('Enfs. de la tiroides',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      RadioInput(tipoEnum: 4, yesNotEnum: yestNotEnumArr ?? yesNotEnum, index: yestNotEnumArr!=null ? radioButtonC++ : countYesNotEnum++,),
      const Text('Hernias',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      RadioInput(tipoEnum: 4, yesNotEnum: yestNotEnumArr ?? yesNotEnum, index: yestNotEnumArr!=null ? radioButtonC++ : countYesNotEnum++,),
      const Text('Lumbalgia',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      RadioInput(tipoEnum: 4, yesNotEnum: yestNotEnumArr ?? yesNotEnum, index: yestNotEnumArr!=null ? radioButtonC++ : countYesNotEnum++,),
      const Text('DIABETES',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      RadioInput(tipoEnum: 4, yesNotEnum: yestNotEnumArr ?? yesNotEnum, index: yestNotEnumArr!=null ? radioButtonC++ : countYesNotEnum++,),
      const Text('Gastritis',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      RadioInput(tipoEnum: 4, yesNotEnum: yestNotEnumArr ?? yesNotEnum, index: yestNotEnumArr!=null ? radioButtonC++ : countYesNotEnum++,),
      const Text('Ginecológicas',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      RadioInput(tipoEnum: 4, yesNotEnum: yestNotEnumArr ?? yesNotEnum, index: yestNotEnumArr!=null ? radioButtonC++ : countYesNotEnum++,),
      const Text('Hemorroides',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      RadioInput(tipoEnum: 4, yesNotEnum: yestNotEnumArr ?? yesNotEnum, index: yestNotEnumArr!=null ? radioButtonC++ : countYesNotEnum++,),
      const Text('Úlceras',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      RadioInput(tipoEnum: 4, yesNotEnum: yestNotEnumArr ?? yesNotEnum, index: yestNotEnumArr!=null ? radioButtonC++ : countYesNotEnum++,),
      const Text('Várices',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      RadioInput(tipoEnum: 4, yesNotEnum: yestNotEnumArr ?? yesNotEnum, index: yestNotEnumArr!=null ? radioButtonC++ : countYesNotEnum++,),
      const Text('Hipertensión',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      RadioInput(tipoEnum: 4, yesNotEnum: yestNotEnumArr ?? yesNotEnum, index: yestNotEnumArr!=null ? radioButtonC++ : countYesNotEnum++,),
      const Text('Neumonía',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      RadioInput(tipoEnum: 4, yesNotEnum: yestNotEnumArr ?? yesNotEnum, index: yestNotEnumArr!=null ? radioButtonC++ : countYesNotEnum++,),
      const Text('Tuberculosis',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      RadioInput(tipoEnum: 4, yesNotEnum: yestNotEnumArr ?? yesNotEnum, index: yestNotEnumArr!=null ? radioButtonC++ : countYesNotEnum++,),
      const Text('Colitis',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      RadioInput(tipoEnum: 4, yesNotEnum: yestNotEnumArr ?? yesNotEnum, index: yestNotEnumArr!=null ? radioButtonC++ : countYesNotEnum++,),
      const Text('Depresión',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      RadioInput(tipoEnum: 4, yesNotEnum: yestNotEnumArr ?? yesNotEnum, index: yestNotEnumArr!=null ? radioButtonC++ : countYesNotEnum++,)
    
    ],
  ),
  'OTRAS' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[multiInputC++] :  '', obligatorio: true,  enabled: true),
  '2siONo' : Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      const Text('Hospitalizaciones',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      RadioInput(tipoEnum: 4, yesNotEnum: yestNotEnumArr ?? yesNotEnum, index: yestNotEnumArr!=null ? radioButtonC++ : countYesNotEnum++,),
    ]
  ),
  '1.- Motivo' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[multiInputC++] :  '', obligatorio: true,  enabled: true),
  '3siONo' : Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      const Text('Cirugías',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      RadioInput(tipoEnum: 4, yesNotEnum: yestNotEnumArr ?? yesNotEnum, index: yestNotEnumArr!=null ? radioButtonC++ : countYesNotEnum++,),
    ]
  ),
  '1.- ¿Cuál?' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[multiInputC++] :  '', obligatorio: true,  enabled: true),
  '4siONo' : Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      const Text('Transfusiones',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      RadioInput(tipoEnum: 4, yesNotEnum: yestNotEnumArr ?? yesNotEnum, index: yestNotEnumArr!=null ? radioButtonC++ : countYesNotEnum++,),
    ]
  ),
  '2.- Motivo' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[multiInputC++] :  '', obligatorio: true,  enabled: true),
  '5siONo' : Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      const Text('Traumatismos y Fracturas',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      RadioInput(tipoEnum: 4, yesNotEnum: yestNotEnumArr ?? yesNotEnum, index: yestNotEnumArr!=null ? radioButtonC++ : countYesNotEnum++,),
    ]
  ),
  'Parte del cuerpo' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[multiInputC++] :  '', obligatorio: true,  enabled: true),
  '6siONo' : Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      const Text('Complicaciones',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      RadioInput(tipoEnum: 4, yesNotEnum: yestNotEnumArr ?? yesNotEnum, index: yestNotEnumArr!=null ? radioButtonC++ : countYesNotEnum++,),
    ]
  ),
  '2.- ¿Cuál?' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[multiInputC++] :  '', obligatorio: true,  enabled: true),
  '7siONo' : Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      const Text('Enfermedades crónicas',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      RadioInput(tipoEnum: 4, yesNotEnum: yestNotEnumArr ?? yesNotEnum, index: yestNotEnumArr!=null ? radioButtonC++ : countYesNotEnum++,),
    ]
  ),
  '3.- ¿Cuál?' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[multiInputC++] :  '', obligatorio: true,  enabled: true),
  'Tratamiento actual' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[multiInputC++] :  '', obligatorio: true,  enabled: true),
  /*  'firma paciente': 
    Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      // alignment: Alignment.center,
      children: [
        const Text('Firma del paciente',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
        Spacer(),
        FilledButton.icon(onPressed: (){                   
          _activarSignature = false; 
          
        }, icon: const Icon(Icons.edit), label: const Text('Editar'))
      ]
    ),
    //multiInputC = 46
   '0': MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[multiInputC++] : '', obligatorio: true,paintSignature: true)
 */},
{ //6.- INTERROGATORIO POR APARATOS Y SISTEMAS. (7)
  'Sentidos' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[multiInputC = 49 ] :  '', obligatorio: true,  enabled: true),
  'Digestivo' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true),
  'Respiratorio' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true),
  'Circulatorio' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true),
  'Genitourinario' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true),
  'Músculo/Esquéletico' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true),
  'Nervioso' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true),
},
{ //EXPLORACIÓN FÍSICA (8)
  'T/A - mmgh' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true, keyboardType: TextInputType.number),
  'F/C' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true, keyboardType: TextInputType.number),
  'Peso - Kg' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true, keyboardType: TextInputType.number),
  'Talla - cm' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true, keyboardType: TextInputType.number),
  'P.abd' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true),
  'F/R' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true),
  'Temp.' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true),
  'I.M.C.' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true),
  'dln' : Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text('GENERAL', style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal)),
      CheckInput(contenido: '\t\t\tDLN',listChecked: listChecked_sec7,indexPrincipal:0,indexSecundario: 0, style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal)),
    ]
  ),
  'Actitud' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true,maxLength: 10),
  'Marcha' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true,maxLength: 10),
  'Apariencia' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true,maxLength: 10),
  'Edo. ánimo' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true,maxLength: 10),
  'dln2' : Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text('OÍDOS', style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal)),
      CheckInput(contenido: '\t\t\tDLN',listChecked: listChecked_sec7,indexPrincipal:0,indexSecundario: 1,style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal)),
    ]
  ),
  'OREJA':Align(alignment: Alignment.bottomLeft, child:Text('Oreja', style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal))),
  '1.- D':MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true,maxLength: 5),
  '1.- I' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true,maxLength: 5),
  'C A E':Align(alignment: Alignment.bottomLeft, child:Text('C A E', style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal))),
  '2.- D':MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true,maxLength: 5),
  '2.- I' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true,maxLength: 5),
  'TIMPANO':Align(alignment: Alignment.bottomLeft, child:Text('Tímpano', style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal))),
  '3.- D':MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true,maxLength: 5),
  '3.- I' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true,maxLength: 5),
  'dln3' : Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text('CABEZA', style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal)),
      CheckInput(contenido: '\t\t\tDLN',listChecked: listChecked_sec7,indexPrincipal:0,indexSecundario: 2,style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal)),
    ]
  ),
  'Cabello' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true,maxLength: 10),
  'Superficie' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true,maxLength: 10),
  'Forma' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true,maxLength: 10),
  'Senos PN' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true,maxLength: 10),
  'dln4' : Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text('OJOS', style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal)),
      CheckInput(contenido: '\t\t\tDLN',listChecked: listChecked_sec7,indexPrincipal:0,indexSecundario: 3,style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal)),
    ]
  ),
  'Reflejos' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true,maxLength: 10),
  'Pupilares' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true,maxLength: 10),
  'Fondo de Ojo' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true,maxLength: 10),
  'Pterigion':Align(alignment: Alignment.bottomLeft, child:Text('Pterigion', style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal))),
  '4.- D':MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true,maxLength: 5),
  '4.- I' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true,maxLength: 5),
  'dln5' : Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text('NEUROLÓGICO', style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal)),
      CheckInput(contenido: '\t\t\tDLN',listChecked: listChecked_sec7,indexPrincipal:0,indexSecundario: 4,style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal)),
    ]
  ),
  'Reflejos OT' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true,maxLength: 10),
  'Romberg' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true,maxLength: 10),
  'Talón Rodilla' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true,maxLength: 10),
  'dln6' : Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text('BOCA/FARINGE', style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal)),
      CheckInput(contenido: '\t\t\tDLN',listChecked: listChecked_sec7,indexPrincipal:0,indexSecundario: 5,style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal)),
    ]
  ),
  'Labios' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true,maxLength: 10),
  'Aliento' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true,maxLength: 10),
  'Lengua' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true,maxLength: 10),
  'Faringe' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true,maxLength: 10),
  'Amígdalas' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true,maxLength: 10),
  'Dientes' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true,maxLength: 10),
  '1.- Mucosa' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true,maxLength: 10),
  'dln7' : Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text('TORAX RESP.', style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal)),
      CheckInput(contenido: '\t\t\tDLN',listChecked: listChecked_sec7,indexPrincipal:0,indexSecundario: 6,style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal)),
    ]
  ),
  '1.- Forma' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true,maxLength: 10),
  'Diafragma' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true,maxLength: 10),
  '1.- Frotes' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true,maxLength: 10),
  '1.- Ventilación' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true,maxLength: 10),
  'Estertores' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true,maxLength: 10),
  'dln8' : Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text('ABDOMEN', style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal)),
      CheckInput(contenido: '\t\t\tDLN',listChecked: listChecked_sec7,indexPrincipal:0,indexSecundario: 7,style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal)),
    ]
  ),
  '2.- Forma' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true,maxLength: 10),
  'Dolor' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true,maxLength: 10),
  'Masas' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true,maxLength: 10),
  'Hernia':Align(alignment: Alignment.bottomLeft, child:Text('Hernia', style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal))),
  '5.- D':MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true,maxLength: 5),
  '5.- I' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true,maxLength: 5),
  'dln9' : Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text('NARIZ', style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal)),
      CheckInput(contenido: '\t\t\tDLN',listChecked: listChecked_sec7,indexPrincipal:0,indexSecundario: 8,style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal)),
    ]
  ),
  'Septum' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true,maxLength: 10),
  '2.- Mucosa':Align(alignment: Alignment.bottomLeft, child:Text('Mucosa', style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal))),
  '6.- D':MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true,maxLength: 10),
  '6.- I' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true,maxLength: 10),
  '2.- Ventilación' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true,maxLength: 10),
  'dln10' : Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text('ÁREA PRECORDIAL', style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal)),
      CheckInput(contenido: '\t\t\tDLN',listChecked: listChecked_sec7,indexPrincipal:0,indexSecundario: 9,style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal)),
    ]
  ),
  'Frecuencia' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true,maxLength: 10),
  'Ritmo' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true,maxLength: 10),
  'Tonos' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true,maxLength: 10),
  '2.- Frotes' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true,maxLength: 10),
  'Soplos' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true,maxLength: 10),
  'dln11' : Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text('PIEL', style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal)),
      CheckInput(contenido: '\t\t\tDLN',listChecked: listChecked_sec7,indexPrincipal:0,indexSecundario: 10,style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal)),
    ]
  ),
  'Cicatrices' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true,maxLength: 10),
  'Textura' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true,maxLength: 10),
  'Diaforesis' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true,maxLength: 10),
  'Otras Lesiones' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true,maxLength: 10),
  'dln12' : Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text('EXTREMIDIDADES', style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal)),
      CheckInput(contenido: '\t\t\tDLN',listChecked: listChecked_sec7,indexPrincipal:0,indexSecundario: 11,style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal)),
    ]
  ),
  '1.- Articular':Align(alignment: Alignment.bottomLeft, child:Text('Articular', style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal))),
  '7.- D':MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true,maxLength: 10),
  '7.- I' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true,maxLength: 10),
  '1.- Muscular':Align(alignment: Alignment.bottomLeft, child:Text('Muscular', style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal))),
  '8.- D':MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true,maxLength: 10),
  '8.- I' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true,maxLength: 10),
  '1.- Nervioso':Align(alignment: Alignment.bottomLeft, child:Text('Nervioso', style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal))),
  '9.- D':MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true,maxLength: 10),
  '9.- I' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true,maxLength: 10),
  'M.I.':Align(alignment: Alignment.bottomLeft, child:Text('Nervioso', style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal))),
  '2.-Articular':Align(alignment: Alignment.bottomLeft, child:Text('Articular', style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal))),
  '10.- D':MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true,maxLength: 10),
  '10.- I' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true,maxLength: 10),
  '2.-Muscular':Align(alignment: Alignment.bottomLeft, child:Text('Muscular', style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal))),
  '11.- D':MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true,maxLength: 10),
  '11.- I' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true,maxLength: 10),
  '2.-Nervioso':Align(alignment: Alignment.bottomLeft, child:Text('Nervioso', style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal))),
  '12.- D':MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true,maxLength: 10),
  '12.- I' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true,maxLength: 10),
  'COLUMNA' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true),
  'DE CERCA A 30CM LENTES':Align(alignment: Alignment.bottomLeft, child:Text('DE CERCA A 30CM LENTES', style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal))),
  'lentes cerca': RadioInput(tipoEnum: 4, yesNotEnum: yestNotEnumArr ?? yesNotEnum, index: yestNotEnumArr!=null ? radioButtonC++ : countYesNotEnum++,),
  'OD ROSENBAUN 20/' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true),
  'OI ROSENBAUN 20/' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true),
  'OD JAEGUER J' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true),
  'OI JAEGUER J' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true),
  'DE LEJOS LENTES':Align(alignment: Alignment.bottomLeft, child:Text('DE LEJOS LENTES', style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal))),
  'lentes lejos': RadioInput(tipoEnum: 4, yesNotEnum: yestNotEnumArr ?? yesNotEnum, index: yestNotEnumArr!=null ? radioButtonC++ : countYesNotEnum++,),
  'SNELLEN':Align(alignment: Alignment.bottomLeft, child:Text('SNELLEN', style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal))),
  'OD 20/' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true),
  'OI 20/' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true),
  'CAMPIMETRIA':Align(alignment: Alignment.bottomLeft, child:Text('CAMPIMETRIA', style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal))),
  'OD' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true),
  'OI' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true),
  'COLOR' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true),
  'AMSLER NORMAL' : Align(alignment: Alignment.bottomLeft, child:Text('AMSLER NORMAL', style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal))),
  'amsler': RadioInput(tipoEnum: 4, yesNotEnum: yestNotEnumArr ?? yesNotEnum, index: yestNotEnumArr!=null ? radioButtonC++ : countYesNotEnum++,),
},
{ //ANALISIS DE LABORATORIO (9)
  'Resultados' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true),
  'Drogas' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true),
},
{//ESTUDIOS DE GABINETE (10)

  'Telerradiografía de Tórax' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true),
  'RX Columna Lumbar' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true),
  'Otros':Align(alignment: Alignment.bottomLeft, child:Text('Otros', style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal))),
  'Espirometria':Align(alignment: Alignment.bottomLeft, child:Text('Espirometria', style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal))),
  'espi': RadioInput(tipoEnum: 6, yesNotEnum: yestNotEnumArr ?? yesNotEnum, index: yestNotEnumArr!=null ? radioButtonC++ : countYesNotEnum++,),
  'Audiometria':Align(alignment: Alignment.bottomLeft, child:Text('Audiometria', style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal, ))),
  'audi': RadioInput(tipoEnum: 6, yesNotEnum: yestNotEnumArr ?? yesNotEnum, index: yestNotEnumArr!=null ? radioButtonC++ : countYesNotEnum++,),
  'Prueba covid-19':Align(alignment: Alignment.bottomLeft, child:Text('Prueba covid-19', style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal))),
  'prueba': RadioInput(tipoEnum: 6, yesNotEnum: yestNotEnumArr ?? yesNotEnum, index: yestNotEnumArr!=null ? radioButtonC++ : countYesNotEnum++,),
  'Embarazo':Align(alignment: Alignment.bottomLeft, child:Text('Embarazo', style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal))),
  'emb': RadioInput(tipoEnum: 6, yesNotEnum: yestNotEnumArr ?? yesNotEnum, index: yestNotEnumArr!=null ? radioButtonC++ : countYesNotEnum++,),
  'Antidoping':Align(alignment: Alignment.bottomLeft, child:Text('Antidoping', style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal))),
  'anti': RadioInput(tipoEnum: 6, yesNotEnum: yestNotEnumArr ?? yesNotEnum, index: yestNotEnumArr!=null ? radioButtonC++ : countYesNotEnum++,),

},
{//DICTAMEN MÉDICO (11)
  'Apto' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true),
  'No apto' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true),
  'Apto con conserva' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true),
  'CONDICIONES Y OBSERVACIONES' : MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[++multiInputC] :  '', obligatorio: true,  enabled: true),
},
{ // FIRMAS (12)
  /* 'firma asp': 
  Container(
    alignment: Alignment.center,
    child:const Text('Firma de Aspirante',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))
  ),
  '1': MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[multiInputC++] :  '', obligatorio: true,paintSignature: true), */
  /* 'firma dr': 
  Container(
    alignment: Alignment.center,
    child:const Text('Nombre, Firma y Ced. Prof. del Médico\n Dr. Alfredo Gruel Culebro',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))
  ),
  '1': MultiInputsForm(contenido: multiInputArr != null ? multiInputArr[multiInputC+1] :  '', obligatorio: true,paintSignature: true)
 */} 


];
List<Map<String, dynamic>> formpartBackUp = [
{//Primeras preguntas (0)
'Numero de Empleado' : '',
'Departamento' : '',
'Puesto' : '',
},
{//ficha personal (1)
  'Nombre' :'',
  'Sexo' : '',
  'Edad' : '',
  'Edo. Civil' :'',
  'Domicilio' :'',
  'Tel. fijo y/o cel' : '',
  'Lugar de nacimiento' :'',
  'Fecha de nacimiento' :'',
  'Actividad extra a su trabajo' :'',
  'Escolaridad' :'',
  'Carrera universitaria' :'',
  'Núm. de hijos' : '',
},
{//historial laboral (2)
  '1.- Empresa' : '',
  '1.- Puestos' : '',
  '1.- Tiempo' : '',
  '1.- Cuando Salió' : '',
  '1.- Rotación de puesto' : '',
  '1.- Quimicos solventes' : '',
  '1.- Humos' : '',
  '1.- Vapores' : '',
  '1.- Polvos' : '',
  '1.- Ruido' : '',
  '1.- Carga de material' : '',

  '2.- Empresa' : '',
  '2.- Puestos' : '',
  '2.- Tiempo' : '',
  '2.- Cuando Salió' : '',
  '2.- Rotación de puesto' : '',
  '2.- Quimicos solventes' : '',
  '2.- Humos' : '',
  '2.- Vapores' : '',
  '2.- Polvos' : '',
  '2.- Ruido' : '',
  '2.- Carga de material' : '',

  '3.- Empresa' : '',
  '3.- Puestos' : '',
  '3.- Tiempo' : '',
  '3.- Cuando Salió' : '',
  '3.- Rotación de puesto' : '',
  '3.- Quimicos solventes' : '',
  '3.- Humos' : '',
  '3.- Vapores' : '',
  '3.- Polvos' : '',
  '3.- Ruido' : '',
  '3.- Carga de material' : '',

  '4.- Empresa' : '',
  '4.- Puestos' : '',
  '4.- Tiempo' : '',
  '4.- Cuando Salió' : '',
  '4.- Rotación de puesto' : '',
  '4.- Quimicos solventes' : '',
  '4.- Humos' : '',
  '4.- Vapores' : '',
  '4.- Polvos' : '',
  '4.- Ruido' : '',
  '4.- Carga de material' : '',

} ,
{//ACCIDENTES Y ENFERMEDADES DE TRABAJO (3)
  '1.- Nombre de empresa' : '',
  '1.- Fecha' : '',
  '1.- Puesto' : '',
  '1.- Nombre de la lesión o enfermedad' : '',
  '1.- Número de dias de incapacidad' : '',
  '2.- Nombre de empresa' : '',
  '2.- Fecha' : '',
  '2.- Puesto' : '',
  '2.- Nombre de la lesión o enfermedad' : '',
  '2.- Número de dias de incapacidad' : '',
  '3.- Nombre de empresa' : '',
  '3.- Fecha' : '',
  '3.- Puesto' : '',
  '3.- Nombre de la lesión o enfermedad' : '',
  '3.- Número de dias de incapacidad' : '',
},
{ //4.- ANTECEDENTES HEREDITARIOS Y FAMILIARES DE SALUD (4)
  // (Con una X anote los datos positivos según sea el caso)
},
{//5.-ANTECEDENTES PERSONALES (Con una X anote los datos positivos según sea el caso) (5)
  '1.- Edad de inicio' : '',
  'Cantidad de cigarrillos al día' :'',
  '2.- Edad de inicio' : '',
  'Frecuencia' :'', 
  '3.- Edad de inicio' : '',
  'Tipo y frecuencia' :'',
  '1.- ¿A cuál?' :'',
  '2.- ¿A cuál?' :'',
  'Otras' :'',
  '3.- ¿A cuál?' :'',
  '¿Con qué frecuencia?' :'',
  'Edad de su primera menstruación' : '',
  'Edad de inicio de vida sexual' : '',
  'Número de Embarazos' : '',
  'Partos' : '',
  'Cesáreas' : '',
  'Abortos' : '',
  'Fecha de Ultima Regla' : '',
  'Ritmo' : '',
  'alignStart' : '',
  'Fecha de Último Papanicolaou' : '',
  '1.- Resultado' :'',
  'Fecha de Mamografía' : '',
  '2.- Resultado' :'',
  'Lactancia' :''
},
{//5.2.-ANTECEDENTES PERSONALES PATOLÓGICOS (6)
  'OTRAS' :'',
  '1.- Motivo' :'',
  '1.- ¿Cuál?' :'',
  '2.- Motivo' :'',
  'Parte del cuerpo' :'',
  '2.- ¿Cuál?' :'',
  '3.- ¿Cuál?' :'',
  'Tratamiento actual' :'',
},
{ //6.- INTERROGATORIO POR APARATOS Y SISTEMAS. (7)
  'Sentidos' : '',
  'Digestivo' :'',
  'Respiratorio' :'',
  'Circulatorio' :'',
  'Genitourinario' :'',
  'Músculo/Esquéletico' :'',
  'Nervioso' :'',
},
{ //EXPLORACIÓN FÍSICA (8)
  'T/A - mmgh' :'',
  'F/C' :'',
  'Peso - Kg' : '',
  'Talla - cm' : '',
  'P.abd' :'',
  'F/R' :'',
  'Temp.' :'',
  'I.M.C.' :'',
  'Actitud' : '',
  'Marcha' : '',
  'Apariencia' : '',
  'Edo. ánimo' : '',
  'OREJA':'',
  '1.- D':'',
  '1.- I' : '',
  'C A E':'',
  '2.- D':'',
  '2.- I' : '',
  'TIMPANO':'',
  '3.- D':'',
  '3.- I' : '',
  'Cabello' : '',
  'Superficie' : '',
  'Forma' : '',
  'Senos PN' : '',
  'Reflejos' : '',
  'Pupilares' : '',
  'Fondo de Ojo' : '',
  'Pterigion':'',
  '4.- D': '',
  '4.- I' :  '',
  'Reflejos OT' : '',
  'Romberg' : '',
  'Talón Rodilla' : '',
  'Labios' : '',
  'Aliento' : '',
  'Lengua' : '',
  'Faringe' : '',
  'Amígdalas' : '',
  'Dientes' : '',
  '1.- Mucosa' : '',
  '1.- Forma' : '',
  'Diafragma' : '',
  '1.- Frotes' : '',
  '1.- Ventilación' : '',
  'Estertores' : '',
  '2.- Forma' : '',
  'Dolor' : '',
  'Masas' : '',
  'Hernia':'',
  '5.- D': '',
  '5.- I' :  '',
  'Septum' : '',
  '2.- Mucosa':'',
  '6.- D':'',
  '6.- I' : '',
  '2.- Ventilación' : '',
  'Frecuencia' : '',
  'Ritmo' : '',
  'Tonos' : '',
  '2.- Frotes' : '',
  'Soplos' : '',
  'Cicatrices' : '',
  'Textura' : '',
  'Diaforesis' : '',
  'Otras Lesiones' : '',
  '1.- Articular': '',
  '7.- D':'',
  '7.- I' : '',
  '1.- Muscular':'',
  '8.- D':'',
  '8.- I' : '',
  '1.- Nervioso':'',
  '9.- D':'',
  '9.- I' : '',
  'M.I.':'',
  '2.-Articular':'',
  '10.- D':'',
  '10.- I' : '',
  '2.-Muscular':'',
  '11.- D':'',
  '11.- I' : '',
  '2.-Nervioso':'',
  '12.- D':'',
  '12.- I' : '',
  'COLUMNA' : '',
  'DE CERCA A 30CM LENTES':'',
  'lentes cerca': '',
  'OD ROSENBAUN 20/' : '',
  'OI ROSENBAUN 20/' : '',
  'OD JAEGUER J' : '',
  'OI JAEGUER J' : '',
  'DE LEJOS LENTES': '',
  'lentes lejos': '',
  'SNELLEN': '',
  'OD 20/' : '',
  'OI 20/' : '',
  'CAMPIMETRIA': '',
  'OD' : '',
  'OI' : '',
  'COLOR' : '',
  'AMSLER NORMAL' : '',
  'amsler': '',
},
{ //ANALISIS DE LABORATORIO (9)
  'Resultados' : '',
  'Drogas' : '',
},
{//ESTUDIOS DE GABINETE (10)

  'Telerradiografía de Tórax' : '',
  'RX Columna Lumbar' : '',
  'Otros': '',
  'Espirometria': '',
  'espi': '',
  'Audiometria': '',
  'audi': '',
  'Prueba covid-19': '',
  'prueba': '',
  'Embarazo': '',
  'emb': '',
  'Antidoping': '',
  'anti': '',

},
{//DICTAMEN MÉDICO (11)
  'Apto' : '',
  'No apto' : '',
  'Apto con conserva' : '',
  'CONDICIONES Y OBSERVACIONES' : '',
},
{ } 

];

int i = 0;
if(!_inputsAdd){
_inputsAdd = true;
while ( i < formpart1.length) {
_pages.add([]);
_pages[i].add(Title(
  color: Colors.black, 
  child: 
  _titles[i].contains("\n") ?
  Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text(_titles[i].split('\n')[0], style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .05: 0.025),fontWeight: FontWeight.bold)),
    const SizedBox(height: 15,),
    Text(_titles[i].split('\n')[1], style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal)),
    const SizedBox(height: 15,),
    ]
  ): 
  Text(_titles[i], style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .05: 0.025),fontWeight: FontWeight.bold))));
    formpart1[i].forEach((key, value) {
    //En esta parte podemos establecer widgets especificos para ciertos elementos 
    switch (value.runtimeType) {
      case MultiInputsForm:
      // answers.add((value as MultiInputsForm).contenido.toString());
      if( (value as MultiInputsForm).paintSignature?? false == true){
        if (edit == false) {
          _pages[i].add(
          Column(
            children: [
            SizedBox(
            height: MediaQuery.of(context).size.height *.3,
            width: MediaQuery.of(context).size.width,
            child: Container( 
              decoration: BoxDecoration(
              border: Border.all(color: AppTheme.primary)
            ),
              child: Signature(
                key: sign0[int.parse(key)],
                onSign: () async {
                  sign[int.parse(key)] = sign0[int.parse(key)].currentState!;
                },
                color: Colors.black,
                strokeWidth: 3,
              ),
            ),
          ),
          img[int.parse(key)].buffer.lengthInBytes == 0 ? Container() : LimitedBox(maxHeight: 200.0, child: Image.memory(img[int.parse(key)].buffer.asUint8List())),
          ElevatedButton.icon(
            icon: const Icon(Icons.delete),
            onPressed: btnSave == true ? () async {
              if (sign[int.parse(key)] != null) {
                sign[int.parse(key)] = sign0[int.parse(key)].currentState!;
                sign[int.parse(key)]!.clear();
                sign[int.parse(key)] = null;
                img[int.parse(key)] = ByteData(0);
              }
            } : null,
            label: Text('Borrar',style: getTextStyleButtonField(context)),
          )
          ],
          )
          );
        } else {
          _pages[i].add(
          IgnorePointer(
            ignoring:_activarSignature[int.parse(key)],
            key: specificWidgetKey[int.parse(key)],
            child: Column(
              children: [
              SizedBox(
              height: MediaQuery.of(context).size.height *.3,
              width: MediaQuery.of(context).size.width,
              child: Container( 
                decoration: BoxDecoration(
                border: Border.all(color: AppTheme.primary)
              ),
                child: Signature(
                  key: sign0[int.parse(key)],
                  onSign: () async {
                    sign[int.parse(key)] = sign0[int.parse(key)].currentState!;
                  },
                  color: Colors.black,
                  strokeWidth: 3,
                ),
              ),
            ),
            img[int.parse(key)].buffer.lengthInBytes == 0 ? Container() : LimitedBox(maxHeight: 200.0, 
            child: Image.memory(img[int.parse(key)].buffer.asUint8List())),
            FilledButton.icon(
              icon: const Icon(Icons.delete),
              onPressed: btnSave == true ? () async {
                if (sign[int.parse(key)] != null) {
                  sign[int.parse(key)] = sign0[int.parse(key)].currentState!;
                  sign[int.parse(key)]!.clear();
                  sign[int.parse(key)] = null;
                  img[int.parse(key)] = ByteData(0);
                }
              } : null,
              label: Text('Borrar',style: getTextStyleButtonField(context)),
            )
            ],
            ),
          ));
        }
      } else{
        if (edit) {
           formpartBackUp[i][key] = value.contenido.toString(); 
          /*iBu++; */
        }
        _pages[i].add(const SizedBox(height: 10,));
        _pages[i].add (
        MultiInputs(
        maxLines: 1,
        labelText: key,
        controller: null,
        autofocus: false,
        formProperty: key,
        maxLength: value.maxLength,
        listSelectForm: value.listSelectForm,
        formValue: formpart1[i],
        keyboardType: value.keyboardType ?? TextInputType.text));
        _pages[i].add(const SizedBox(height: 10,));
      }
        break;
      case RadioInput:
        if(value.tipoEnum == 3){
          if (key == 'singleScroll') { 
          _pages[i].add(Align(alignment: Alignment.bottomLeft, child:SingleChildScrollView(scrollDirection: Axis.horizontal, child: value )));
          }else{
          _pages[i].add(value);
          }
      }else{ 
        if (key == 'alignStart') {                
          _pages[i].add(Align(alignment: Alignment.centerLeft,child: value));
        }else{
          _pages[i].add(value);
        }
      }
      break;
      case int:
      _pages[i].add(
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              CheckInput(contenido: 'Buena salud', listChecked: checkBoxArr ?? listChecked_sec4,indexPrincipal: value, indexSecundario: 0,),
              CheckInput(contenido: 'Mala salud', listChecked: checkBoxArr ?? listChecked_sec4,indexPrincipal: value, indexSecundario: 1,),
              CheckInput(contenido: 'Finado', listChecked: checkBoxArr ?? listChecked_sec4,indexPrincipal: value, indexSecundario: 2),
              CheckInput(contenido: 'Alergia', listChecked: checkBoxArr ?? listChecked_sec4,indexPrincipal: value, indexSecundario: 3),
              CheckInput(contenido: 'Diabetes', listChecked: checkBoxArr ?? listChecked_sec4,indexPrincipal: value, indexSecundario: 4),
              CheckInput(contenido: 'Presion Alta', listChecked: checkBoxArr ?? listChecked_sec4,indexPrincipal: value, indexSecundario: 5),
              CheckInput(contenido: 'Colesterol', listChecked: checkBoxArr ?? listChecked_sec4,indexPrincipal: value, indexSecundario: 6),
              CheckInput(contenido: 'Enf. Corazón', listChecked: checkBoxArr ?? listChecked_sec4,indexPrincipal: value, indexSecundario: 7),
              CheckInput(contenido: 'Cancer', listChecked: checkBoxArr ?? listChecked_sec4,indexPrincipal: value, indexSecundario: 8),
              CheckInput(contenido: 'Anemia', listChecked: checkBoxArr ?? listChecked_sec4,indexPrincipal: value, indexSecundario: 9)
            ],
          ),
        )
      );
      break;
      default:
      _pages[i].add(value);
    }  
    
  });
  ++i; 
  }
}
setState((){});

/**
 * 47
145
 */
if (edit && copyBack) {
  yestNotEnumArrDiseaseFake = List.from(yestNotEnumArrDisease!);
  yestNotEnumArrFake = List.from(yestNotEnumArr!); 
  manoArrFake = List.from(manoArr!);
  methodArrFake = List.from(methodArr!);
  // firmaAspirante = multiInputArr![47].toString();
  firmaDoctor = multiInputArr![147].toString();
  listChecked_sec7Fake = [List.from(listChecked_sec7[0])];
  causeEnumFake = List.from(causeDiseaseArr!);  
  numEmployee = int.parse(multiInputArr[1]);
  checkBoxArrFake = [List.from(checkBoxArr![0]),List.from(checkBoxArr[1]),List.from(checkBoxArr[2]),List.from(checkBoxArr[3]),List.from(checkBoxArr[4])];
  copyBack = false;
}

return  showDialog<String>(
context: context,
builder: (BuildContext context ) { 
return Stack(
children: [
  const ModalBarrier(
    dismissible: false,
    color:  Color.fromARGB(80, 0, 0, 0),
  ),
StatefulBuilder(
  builder: (BuildContext context, StateSetter setState) {
    // setState((){
    //   _activarSignature = false;
    // });
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
              Align(
                alignment: Alignment.bottomRight,
                child: IconButton(onPressed: btnSave == true ? () => Navigator.of(context).pop() : null
                , icon: const Icon(Icons.close, size: 35,)),
              ),
              Expanded(
                child: PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  itemCount: myFormKey.length - 1,
                  itemBuilder: (context, index) {
                    if (index == 6) {
                    } 
                    return SingleChildScrollView(
                      child: Form(
                        key: myFormKey[index],
                        child: Column(
                          children: [
                            Column(
                              children: _pages[index],
                            ),
                            if(index == 6)
                            Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  // alignment: Alignment.center,
                                  children: [
                                    const Text('Firma del paciente',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                                    const Spacer(),
                                    if(edit)
                                    FilledButton.icon(onPressed: (){                   
                                      _activarSignature[0] = !_activarSignature[0]; 
                                      setState((){});
                                    }, icon: const Icon(Icons.edit),
                                    style: _activarSignature[0] ? TextButton.styleFrom(
                                      backgroundColor: const ui.Color.fromARGB(255, 187, 187, 187), // Cambia el color del texto del botón a azul
                                      // Puedes ajustar otros estilos como textStyle, padding, shape, etc.
                                    ) :
                                    TextButton.styleFrom(
                                      backgroundColor: AppTheme.primary, // Cambia el color del texto del botón a azul
                                      // Puedes ajustar otros estilos como textStyle, padding, shape, etc.
                                    ),
                                    label: const Text('Editar'))
                                  ]
                                ),
                                IgnorePointer(
                                ignoring: edit == false ? false : _activarSignature[0] ,
                                key: specificWidgetKey[0],
                                child: Column(
                                  children: [
                                  SizedBox(
                                  height: MediaQuery.of(context).size.height *.3,
                                  width: MediaQuery.of(context).size.width,
                                  child: Container( 
                                    decoration: BoxDecoration(
                                    border: Border.all(color: AppTheme.primary)
                                  ),
                                    child: Signature(
                                      key: sign0[0],
                                      onSign: () async {
                                        sign[0] = sign0[0].currentState!;
                                        setState((){});
                                      },
                                      color: Colors.black,
                                      strokeWidth: 3,
                                    ),
                                  ),
                                ),
                                img[0].buffer.lengthInBytes == 0 ? Container() : LimitedBox(maxHeight: 200.0, child: Image.memory(img[0].buffer.asUint8List())),
                                FilledButton.icon(
                                  icon: const Icon(Icons.delete),
                                  onPressed: btnSave == true ? () async {
                                    if (sign[0] != null) {
                                      sign[0] = sign0[0].currentState!;
                                      sign[0]!.clear();
                                      sign[0] = null;
                                      img[0] = ByteData(0);
                                    }
                                  } : null,
                                  label: Text('Borrar',style: getTextStyleButtonField(context)),
                                )
                                ],
                                ),
                              
                              
                                )
                              ],
                            ),
                            if(index == 12)
                            Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  // alignment: Alignment.center,
                                  children: [
                                    const Text('Firma del doctor',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                                    const Spacer(),
                                    if(edit)
                                    FilledButton.icon(onPressed: (){                   
                                      _activarSignature[1] = !_activarSignature[1]; 
                                      setState((){});
                                    }, icon: const Icon(Icons.edit),
                                    style: _activarSignature[1] ? TextButton.styleFrom(
                                      backgroundColor: const ui.Color.fromARGB(255, 187, 187, 187), // Cambia el color del texto del botón a azul
                                      // Puedes ajustar otros estilos como textStyle, padding, shape, etc.
                                    ) :
                                    TextButton.styleFrom(
                                      backgroundColor: AppTheme.primary, // Cambia el color del texto del botón a azul
                                      // Puedes ajustar otros estilos como textStyle, padding, shape, etc.
                                    ),
                                    label: const Text('Editar'))
                                  ]
                                ),
                                IgnorePointer(
                                ignoring:edit == false ? false : _activarSignature[1],
                                key: specificWidgetKey[1],
                                child: Column(
                                  children: [
                                  SizedBox(
                                  height: MediaQuery.of(context).size.height *.3,
                                  width: MediaQuery.of(context).size.width,
                                  child: Container( 
                                    decoration: BoxDecoration(
                                    border: Border.all(color: AppTheme.primary)
                                  ),
                                    child: Signature(
                                      key: sign0[1],
                                      onSign: () async {
                                        sign[1] = sign0[1].currentState!;
                                      },
                                      color: Colors.black,
                                      strokeWidth: 3,
                                    ),
                                  ),
                                ),
                                img[1].buffer.lengthInBytes == 0 ? Container() : LimitedBox(maxHeight: 200.0, child: Image.memory(img[1].buffer.asUint8List())),
                                FilledButton.icon(
                                  icon: const Icon(Icons.delete),
                                  onPressed: btnSave == true ? () async {
                                    if (sign[1] != null) {
                                      sign[1] = sign0[1].currentState!;
                                      sign[1]!.clear();
                                      sign[1] = null;
                                      img[1] = ByteData(0);
                                    }
                                  } : null,
                                  label: Text('Borrar',style: getTextStyleButtonField(context)),
                                )
                                ],
                                ),
                              
                              
                                )
                              ],
                            ),
                          ],
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
                    onPressed: btnSave == true ? () {
                      /* if (_currentPageIndex == _pages.length - 2) {
                          setState((){
                            btnNext = true;
                          });
                        } */
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      setState(() { _currentPageIndex--; });
                    } : null,
                    child: Text('Anterior', style: getTextStyleButtonFieldRow(context)),
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.save),
                    onPressed: btnSave ==true? () async {
                    try {
                    if (causeDiseaseArr !=null) {
                      causeEnum = causeDiseaseArr;
                    }

                      List<bool> activadoArr = [];
                      bool activado = false;

                      // if (int.tryParse((formpart1[0]['Numero de Empleado'] as MultiInputsForm).contenido!) is int) {
                      setState((){
                        btnSave = false;
                      });
                      ExamInModel eim = ExamInModel();
                      eim.departament = int.parse((formpart1[0]['Departamento'] as MultiInputsForm).contenido!); 
                      eim.place = (formpart1[0]['Puesto'] as MultiInputsForm).contenido!;
                      eim.type = (yestNotEnumArr != null ? yestNotEnumArr[0] : yesNotEnum[0])  == YesNot.none ? 0 : (yestNotEnumArr != null ? yestNotEnumArr[0] : yesNotEnum[0]) == YesNot.si ? 1 : 2;
                      //3
                      
                      if (edit == false) {
                        if (eim.toJson().isNotEmpty) {
                          eim.idDetExamInPr =  int.parse((await eips.post_examIn(eim, context)).container![0]["ultimoId"]);                        
                        }
                      } else {
                        activadoArr.clear();
                        if (yestNotEnumArrFake[0] != yestNotEnumArr![0]) {
                          activadoArr.add(true);
                        }

                        clavesAComparar =[
                          'Departamento',
                          'Puesto'
                        ];
                       
                        activadoArr.add(clavesAComparar.any((clave) {
                          return (formpart1[0][clave] as MultiInputsForm).contenido!.toString() !=
                              formpartBackUp[0][clave].toString();
                        }));
                        activado = activadoArr.any((element) =>  element == true);
                        if (activado) {
                          // print('actualiazndo primera seccion');
                          await eips.patch_examIn(eim, idExam, context);
                        }
                      }
                      
                      ExamPeModel epm = ExamPeModel();
                      epm.name = (formpart1[1]['Nombre'] as MultiInputsForm).contenido!;
                      epm.sex = int.parse((formpart1[1]['Sexo'] as MultiInputsForm).contenido!.toString() == '' ? '1' : (formpart1[1]['Sexo'] as MultiInputsForm).contenido!);
                      epm.age = (formpart1[1]['Edad'] as MultiInputsForm).contenido!;
                      epm.marital_status = (formpart1[1]['Edo. Civil'] as MultiInputsForm).contenido!;
                      epm.address = (formpart1[1]['Domicilio'] as MultiInputsForm).contenido!;
                      epm.tel_cel = (formpart1[1]['Tel. fijo y/o cel'] as MultiInputsForm).contenido!;
                      epm.place_birthday = (formpart1[1]['Lugar de nacimiento'] as MultiInputsForm).contenido!.toString();
                      epm.date_birthday = (formpart1[1]['Fecha de nacimiento'] as MultiInputsForm).contenido!.toString();
                      epm.extra_activity = (formpart1[1]['Actividad extra a su trabajo'] as MultiInputsForm).contenido!;
                      epm.schooling = (formpart1[1]['Escolaridad'] as MultiInputsForm).contenido!;
                      epm.college_career = (formpart1[1]['Carrera universitaria'] as MultiInputsForm).contenido!;
                      epm.number_children = (formpart1[1]['Núm. de hijos'] as MultiInputsForm).contenido!;
                      //11 , 11 + 3 = 14 
                      if (edit == false) {
                        //var json =  eam.toJson();
                        //bool valid = json.keys.any((key) => json[key].toString() != '');
                        if (epm.toJson().isNotEmpty) {
                          epm.idPersonal = int.parse((await eips.post_examPe(epm, context)).container![0]["ultimoId"]);
                        }
                      } else {
                        activadoArr.clear();
                        clavesAComparar =[
                          'Nombre',
                          'Sexo',
                          'Edad',
                          'Edo. Civil',
                          'Domicilio',
                          'Tel. fijo y/o cel',
                          'Lugar de nacimiento',
                          'Fecha de nacimiento',
                          'Actividad extra a su trabajo',
                          'Escolaridad',
                          'Carrera universitaria',
                          'Núm. de hijos'
                        ];

                        
                        activado = clavesAComparar.any((clave) {
                          return (formpart1[1][clave] as MultiInputsForm).contenido!.toString() !=
                              formpartBackUp[1][clave].toString();
                        });
                        
                        
                        if (activado) {
                          // print('actualizando segunda seccion');
                          await eips.patch_examPe(epm, idExam, context);
                        }
                      }
                      
                      ExamHePModel hpm = ExamHePModel();
                      switch (manoArr !=null? manoArr[0] :  manoDomEnum[0]) {
                        case ManoDominante.diestro: hpm.fk_dominant_hand = 1; break;
                        case ManoDominante.zurdo: hpm.fk_dominant_hand = 2; break;
                        case ManoDominante.ambos: hpm.fk_dominant_hand = 3;  break;
                        default: hpm.fk_dominant_hand = 0; break;
                      }

                      hpm.smoking = (yestNotEnumArr != null ? yestNotEnumArr[1] : yesNotEnum[4]) == YesNot.none ? 0 : (yestNotEnumArr != null ? yestNotEnumArr[1] : yesNotEnum[4]) == YesNot.si ? 1 : 2; 
                      hpm.age_smoking = (formpart1[5]['1.- Edad de inicio'] as MultiInputsForm).contenido!;
                      hpm.amount_cigarettes = (formpart1[5]['Cantidad de cigarrillos al día'] as MultiInputsForm).contenido!;
                      hpm.alcohol = (yestNotEnumArr != null ? yestNotEnumArr[2] : yesNotEnum[5]) == YesNot.none ? 0 : (yestNotEnumArr != null ? yestNotEnumArr[2] : yesNotEnum[5]) == YesNot.si ? 1 : 2;
                      hpm.age_alcohol = (formpart1[5]['2.- Edad de inicio'] as MultiInputsForm).contenido!;
                      hpm.often_alcohol = (formpart1[5]['Frecuencia'] as MultiInputsForm).contenido!;
                      hpm.taxonomists = (yestNotEnumArr != null ? yestNotEnumArr[3] : yesNotEnum[6]) == YesNot.none ? 0 : (yestNotEnumArr != null ? yestNotEnumArr[3] : yesNotEnum[6]) == YesNot.si ? 1 : 2;
                      hpm.age_taxonomists = (formpart1[5]['3.- Edad de inicio'] as MultiInputsForm).contenido!;
                      hpm.often_taxonomists = (formpart1[5]['Tipo y frecuencia'] as MultiInputsForm).contenido!;
                      hpm.allergy_medicament = (yestNotEnumArr != null ? yestNotEnumArr[4] : yesNotEnum[7]) == YesNot.none ? 0 : (yestNotEnumArr != null ? yestNotEnumArr[4] : yesNotEnum[7]) == YesNot.si ? 1 : 2;
                      hpm.what_medicament = (formpart1[5]['1.- ¿A cuál?'] as MultiInputsForm).contenido!;
                      hpm.allergy_food = (yestNotEnumArr != null ? yestNotEnumArr[5] : yesNotEnum[8]) == YesNot.none ? 0 : (yestNotEnumArr != null ? yestNotEnumArr[5] : yesNotEnum[8]) == YesNot.si ? 1 : 2;
                      hpm.what_food = (formpart1[5]['2.- ¿A cuál?'] as MultiInputsForm).contenido!;
                      hpm.covid_vaccine = (yestNotEnumArr != null ? yestNotEnumArr[6] : yesNotEnum[9]) == YesNot.none ? 0 : (yestNotEnumArr != null ? yestNotEnumArr[6] : yesNotEnum[9]) == YesNot.si ? 1 : 2;
                      hpm.tetanus_vaccine = (yestNotEnumArr != null ? yestNotEnumArr[7] : yesNotEnum[10]) == YesNot.none ? 0 : (yestNotEnumArr != null ? yestNotEnumArr[7] : yesNotEnum[10]) == YesNot.si ? 1 : 2;
                      hpm.hepatitis_vaccine = (yestNotEnumArr != null ? yestNotEnumArr[8] : yesNotEnum[11]) == YesNot.none ? 0 : (yestNotEnumArr != null ? yestNotEnumArr[8] : yesNotEnum[11]) == YesNot.si ? 1 : 2;
                      hpm.pneumococcal_vaccine = (yestNotEnumArr != null ? yestNotEnumArr[9] : yesNotEnum[12]) == YesNot.none ? 0 : (yestNotEnumArr != null ? yestNotEnumArr[9] : yesNotEnum[12]) == YesNot.si ? 1 : 2;
                      hpm.other_vaccine = (formpart1[5]['Otras'] as MultiInputsForm).contenido!;
                      hpm.practice_exercise = (yestNotEnumArr != null ? yestNotEnumArr[10] : yesNotEnum[13]) == YesNot.none ? 0 : (yestNotEnumArr != null ? yestNotEnumArr[10] : yesNotEnum[13]) == YesNot.si ? 1 : 2;
                      hpm.what_exercise = (formpart1[5]['3.- ¿A cuál?'] as MultiInputsForm).contenido!;
                      hpm.often_exercise = (formpart1[5]['¿Con qué frecuencia?'] as MultiInputsForm).contenido!;
                      //22, 14 + 22 = 36

                      ExamGyModel gypm = ExamGyModel();
                      gypm.age_fmenstruation = (formpart1[5]['Edad de su primera menstruación'] as MultiInputsForm).contenido!;
                      gypm.age_stSex_life = (formpart1[5]['Edad de inicio de vida sexual'] as MultiInputsForm).contenido!;
                      gypm.amount_childbirth = (formpart1[5]['Partos'] as MultiInputsForm).contenido!.toString() == '' ? '0' : (formpart1[5]['Partos'] as MultiInputsForm).contenido!;
                      gypm.amount_pregnancy = (formpart1[5]['Número de Embarazos'] as MultiInputsForm).contenido!;
                      gypm.cesarean = (formpart1[5]['Cesáreas'] as MultiInputsForm).contenido!;
                      gypm.abort = (formpart1[5]['Abortos'] as MultiInputsForm).contenido!;
                      gypm.last_rule_date = (formpart1[5]['Fecha de Ultima Regla'] as MultiInputsForm).contenido!;
                      gypm.rhythm = (formpart1[5]['Ritmo'] as MultiInputsForm).contenido!;

                      switch (methodArr !=null? methodArr[0] : metodoAntiEnum[0]) {
                        case MetodoAnti.pastillas: gypm.fk_contraceptive_method = 1; break;
                        case MetodoAnti.dispositivo: gypm.fk_contraceptive_method = 2; break;
                        case MetodoAnti.condon: gypm.fk_contraceptive_method = 3;  break;
                        case MetodoAnti.otb: gypm.fk_contraceptive_method = 4; break;
                        case MetodoAnti.inyeccion: gypm.fk_contraceptive_method = 5; break;
                        case MetodoAnti.implante: gypm.fk_contraceptive_method = 6; break;
                        default: gypm.fk_contraceptive_method = 0; break;
                      }

                      gypm.date_last_pap_smear= (formpart1[5]['Fecha de Último Papanicolaou'] as MultiInputsForm).contenido!;
                      gypm.result_pap_smear= (formpart1[5]['1.- Resultado'] as MultiInputsForm).contenido!;
                      gypm.mammography_date= (formpart1[5]['Fecha de Mamografía'] as MultiInputsForm).contenido!;
                      gypm.result_mammography= (formpart1[5]['2.- Resultado'] as MultiInputsForm).contenido!;
                      gypm.lactation= (formpart1[5]['Lactancia'] as MultiInputsForm).contenido!;
                      //14, 36 + 14 = 50
                      if (edit == false) {
                        if (gypm.toJson().isNotEmpty) {
                          hpm.idHeredityPers = int.parse((await eips.post_examHeP(hpm,context)).container![0]["ultimoId"]);
                          gypm.fk_idHeredityPers = hpm.idHeredityPers; 
                          await eips.post_examGy(gypm, context);
                        }else if(hpm.toJson().isNotEmpty){
                          hpm.idHeredityPers = int.parse((await eips.post_examHeP(hpm,context)).container![0]["ultimoId"]);
                        }
                      } else {
                        activadoArr.clear();
                        if(manoArrFake[0] !=  manoArr![0]){
                          activadoArr.add(true);
                        }
                        if(yestNotEnumArr![1] != yestNotEnumArrFake[1]){
                          activadoArr.add(true);
                        }
                        if(yestNotEnumArr[3] !=  yestNotEnumArrFake[3]){
                          activadoArr.add(true);
                        }
                        if(yestNotEnumArr[4]  != yestNotEnumArrFake[4] ){
                          activadoArr.add(true);
                        }
                        if(yestNotEnumArr[5] !=  yestNotEnumArrFake[5]){
                          activadoArr.add(true);
                        }
                        if(yestNotEnumArr[6]  != yestNotEnumArrFake[6] ){
                          activadoArr.add(true);
                        }
                        if(yestNotEnumArr[7] !=  yestNotEnumArrFake[7]){
                          activadoArr.add(true);
                        }
                        if(yestNotEnumArr[8]  != yestNotEnumArrFake[8] ){
                          activadoArr.add(true);
                        }
                        if(yestNotEnumArr[9] !=  yestNotEnumArrFake[9]){
                          activadoArr.add(true);
                        }
                        if(yestNotEnumArr[10] !=  yestNotEnumArrFake[10]){
                          activadoArr.add(true);
                        }

                        clavesAComparar =[
                          '1.- Edad de inicio',
                          'Cantidad de cigarrillos al día',
                          '2.- Edad de inicio',
                          'Frecuencia',
                          '3.- Edad de inicio',
                          'Tipo y frecuencia',
                          '1.- ¿A cuál?',
                          '2.- ¿A cuál?',
                          'Otras',
                          '3.- ¿A cuál?',
                          '¿Con qué frecuencia?'
                        ];
                        activadoArr.add(clavesAComparar.any((clave) {
                          return (formpart1[5][clave] as MultiInputsForm).contenido!.toString() !=
                              formpartBackUp[5][clave].toString();
                        }));
                        activado = activadoArr.any((element) => element == true);
                      
                        if (activado) {
                          // print('actualizando tercera seccion');
                          await eips.patch_examHeP(hpm, idExam,context);
                        }

                        activadoArr.clear();
                        if(methodArr![0] != methodArrFake[0]){
                          activadoArr.add(true);
                        }
                        clavesAComparar =[
                          'Edad de su primera menstruación',
                          'Edad de inicio de vida sexual',
                          'Partos',
                          'Número de Embarazos',
                          'Cesáreas',
                          'Abortos',
                          'Fecha de Ultima Regla',
                          'Ritmo',
                          'Fecha de Último Papanicolaou',
                          '1.- Resultado',
                          'Fecha de Mamografía',
                          '2.- Resultado',
                          'Lactancia'
                        ];

                        activadoArr.add(clavesAComparar.any((clave) {
                         
                          return (formpart1[5][clave] as MultiInputsForm).contenido!.toString() !=
                              formpartBackUp[5][clave].toString();
                        }));

                        activado = activadoArr.any((element) => element == true);
                        
                        if (activado) {
                          // print('actualizando cuarta seccion');
                          await eips.patch_examGy(gypm, idExam, context);
                        }
                      }

                      ExamPaModel pm = ExamPaModel();
                      pm.arthritis = (yestNotEnumArr != null ? yestNotEnumArr[11] : yesNotEnum[14]) == YesNot.none ? 0 : (yestNotEnumArr != null ? yestNotEnumArr[11] : yesNotEnum[14]) == YesNot.si ? 1 : 2;
                      pm.asthma = (yestNotEnumArr != null ? yestNotEnumArr[12] : yesNotEnum[15]) == YesNot.none ? 0 : (yestNotEnumArr != null ? yestNotEnumArr[12] : yesNotEnum[15]) == YesNot.si ? 1 : 2;
                      pm.bronchitis = (yestNotEnumArr != null ? yestNotEnumArr[13] : yesNotEnum[16]) == YesNot.none ? 0 : (yestNotEnumArr != null ? yestNotEnumArr[13] : yesNotEnum[16]) == YesNot.si ? 1 : 2;
                      pm.hepatitis = (yestNotEnumArr != null ? yestNotEnumArr[14] : yesNotEnum[17]) == YesNot.none ? 0 : (yestNotEnumArr != null ? yestNotEnumArr[14] : yesNotEnum[17]) == YesNot.si ? 1 : 2;
                      pm.covid = (yestNotEnumArr != null ? yestNotEnumArr[15] : yesNotEnum[18]) == YesNot.none ? 0 : (yestNotEnumArr != null ? yestNotEnumArr[15] : yesNotEnum[18]) == YesNot.si ? 1 : 2;
                      pm.kidney_disease = (yestNotEnumArr != null ? yestNotEnumArr[16] : yesNotEnum[19]) == YesNot.none ? 0 : (yestNotEnumArr != null ? yestNotEnumArr[16] : yesNotEnum[19]) == YesNot.si ? 1 : 2;
                      pm.skin_disease = (yestNotEnumArr != null ? yestNotEnumArr[17] : yesNotEnum[20]) == YesNot.none ? 0 : (yestNotEnumArr != null ? yestNotEnumArr[17] : yesNotEnum[20]) == YesNot.si ? 1 : 2;
                      pm.thyreous_disease = (yestNotEnumArr != null ? yestNotEnumArr[18] : yesNotEnum[21]) == YesNot.none ? 0 : (yestNotEnumArr != null ? yestNotEnumArr[18] : yesNotEnum[21]) == YesNot.si ? 1 : 2;
                      pm.hernia = (yestNotEnumArr != null ? yestNotEnumArr[19] : yesNotEnum[22]) == YesNot.none ? 0 : (yestNotEnumArr != null ? yestNotEnumArr[19] : yesNotEnum[22]) == YesNot.si ? 1 : 2;
                      pm.low_back_pain = (yestNotEnumArr != null ? yestNotEnumArr[20] : yesNotEnum[23]) == YesNot.none ? 0 : (yestNotEnumArr != null ? yestNotEnumArr[20] : yesNotEnum[23]) == YesNot.si ? 1 : 2;
                      pm.diabetes = (yestNotEnumArr != null ? yestNotEnumArr[21] : yesNotEnum[24]) == YesNot.none ? 0 : (yestNotEnumArr != null ? yestNotEnumArr[21] : yesNotEnum[24]) == YesNot.si ? 1 : 2;
                      pm.gastitris = (yestNotEnumArr != null ? yestNotEnumArr[22] : yesNotEnum[25]) == YesNot.none ? 0 : (yestNotEnumArr != null ? yestNotEnumArr[22] : yesNotEnum[25]) == YesNot.si ? 1 : 2;
                      pm.gynaecological = (yestNotEnumArr != null ? yestNotEnumArr[23] : yesNotEnum[26]) == YesNot.none ? 0 : (yestNotEnumArr != null ? yestNotEnumArr[23] : yesNotEnum[26]) == YesNot.si ? 1 : 2;
                      pm.hemorrhoid = (yestNotEnumArr != null ? yestNotEnumArr[24] : yesNotEnum[27]) == YesNot.none ? 0 : (yestNotEnumArr != null ? yestNotEnumArr[24] : yesNotEnum[27]) == YesNot.si ? 1 : 2;
                      pm.ulcer = (yestNotEnumArr != null ? yestNotEnumArr[25] : yesNotEnum[28]) == YesNot.none ? 0 : (yestNotEnumArr != null ? yestNotEnumArr[25] : yesNotEnum[28]) == YesNot.si ? 1 : 2;
                      pm.varices = (yestNotEnumArr != null ? yestNotEnumArr[26] : yesNotEnum[29]) == YesNot.none ? 0 : (yestNotEnumArr != null ? yestNotEnumArr[26] : yesNotEnum[29]) == YesNot.si ? 1 : 2;
                      pm.hypertension = (yestNotEnumArr != null ? yestNotEnumArr[27] : yesNotEnum[30]) == YesNot.none ? 0 : (yestNotEnumArr != null ? yestNotEnumArr[27] : yesNotEnum[30]) == YesNot.si ? 1 : 2;
                      pm.pneumonia = (yestNotEnumArr != null ? yestNotEnumArr[28] : yesNotEnum[31]) == YesNot.none ? 0 : (yestNotEnumArr != null ? yestNotEnumArr[28] : yesNotEnum[31]) == YesNot.si ? 1 : 2;
                      pm.tuberculosis = (yestNotEnumArr != null ? yestNotEnumArr[29] : yesNotEnum[32]) == YesNot.none ? 0 : (yestNotEnumArr != null ? yestNotEnumArr[29] : yesNotEnum[32]) == YesNot.si ? 1 : 2;
                      pm.colitis = (yestNotEnumArr != null ? yestNotEnumArr[30] : yesNotEnum[33]) == YesNot.none ? 0 : (yestNotEnumArr != null ? yestNotEnumArr[30] : yesNotEnum[33]) == YesNot.si ? 1 : 2;
                      pm.depression = (yestNotEnumArr != null ? yestNotEnumArr[31] : yesNotEnum[34]) == YesNot.none ? 0 : (yestNotEnumArr != null ? yestNotEnumArr[31] : yesNotEnum[34]) == YesNot.si ? 1 : 2;
                      pm.hospitalization = (yestNotEnumArr != null ? yestNotEnumArr[32] : yesNotEnum[35]) == YesNot.none ? 0 : (yestNotEnumArr != null ? yestNotEnumArr[32] : yesNotEnum[35]) == YesNot.si ? 1 : 2;
                      pm.surgery = (yestNotEnumArr != null ? yestNotEnumArr[33] : yesNotEnum[36]) == YesNot.none ? 0 : (yestNotEnumArr != null ? yestNotEnumArr[33] : yesNotEnum[36]) == YesNot.si ? 1 : 2;
                      pm.transfusion = (yestNotEnumArr != null ? yestNotEnumArr[34] : yesNotEnum[37]) == YesNot.none ? 0 : (yestNotEnumArr != null ? yestNotEnumArr[34] : yesNotEnum[37]) == YesNot.si ? 1 : 2;
                      pm.trauma_fracture = (yestNotEnumArr != null ? yestNotEnumArr[35] : yesNotEnum[38]) == YesNot.none ? 0 : (yestNotEnumArr != null ? yestNotEnumArr[35] : yesNotEnum[38]) == YesNot.si ? 1 : 2;
                      pm.complication = (yestNotEnumArr != null ? yestNotEnumArr[36] : yesNotEnum[39]) == YesNot.none ? 0 : (yestNotEnumArr != null ? yestNotEnumArr[36] : yesNotEnum[39]) == YesNot.si ? 1 : 2;
                      pm.chronic_disease = (yestNotEnumArr != null ? yestNotEnumArr[37] : yesNotEnum[40]) == YesNot.none ? 0 : (yestNotEnumArr != null ? yestNotEnumArr[37] : yesNotEnum[40]) == YesNot.si ? 1 : 2;
                      pm.other_disease = (formpart1[6]['OTRAS'] as MultiInputsForm).contenido!;
                      pm.reason_hospitalization = (formpart1[6]['1.- Motivo'] as MultiInputsForm).contenido!;
                      pm.reason_surgery = (formpart1[6]['1.- ¿Cuál?'] as MultiInputsForm).contenido!;
                      pm.reason_transfusion = (formpart1[6]['2.- Motivo'] as MultiInputsForm).contenido!;
                      pm.what_trauma_fracture = (formpart1[6]['Parte del cuerpo'] as MultiInputsForm).contenido!;
                      pm.what_complication = (formpart1[6]['2.- ¿Cuál?'] as MultiInputsForm).contenido!;
                      pm.what_chronic = (formpart1[6]['3.- ¿Cuál?'] as MultiInputsForm).contenido!;
                      pm.current_treatment = (formpart1[6]['Tratamiento actual'] as MultiInputsForm).contenido!;
                      
                      if (sign[0] != null) {
                        final image = await sign[0]!.getData() ;
                        var data = await image.toByteData(format: ui.ImageByteFormat.png);
                        pm.signature_patient = base64.encode(data!.buffer.asUint8List());

                      } else{
                        pm.signature_patient = multiInputArr != null ? multiInputArr[47] : '';
                      }
                      //36, 50 + 36 = 86
                      
                      if (edit == false) {
                      
                        if (pm.toJson().isNotEmpty) {
                          pm.idPatalogicalPersBack = int.parse((await eips.post_examPa(pm, context)).container![0]["ultimoId"]);
                        }
                      } else {
                        activadoArr.clear();

                        if(yestNotEnumArr![11] != yestNotEnumArrFake[11]){
                          activadoArr.add(true);
                        }
                        if(yestNotEnumArr[12] != yestNotEnumArrFake[12]){
                          activadoArr.add(true);
                        }
                        if(yestNotEnumArr[13] != yestNotEnumArrFake[13]){
                          activadoArr.add(true);
                        }
                        if(yestNotEnumArr[14] != yestNotEnumArrFake[14]){
                          activadoArr.add(true);
                        }
                        if(yestNotEnumArr[15] != yestNotEnumArrFake[15]){
                          activadoArr.add(true);
                        }
                        if(yestNotEnumArr[16] != yestNotEnumArrFake[16]){
                          activadoArr.add(true);
                        }
                        if(yestNotEnumArr[17] != yestNotEnumArrFake[17]){
                          activadoArr.add(true);
                        }
                        if(yestNotEnumArr[18] != yestNotEnumArrFake[18]){
                          activadoArr.add(true);
                        }
                        if(yestNotEnumArr[19] != yestNotEnumArrFake[19]){
                          activadoArr.add(true);
                        }
                        if(yestNotEnumArr[20] != yestNotEnumArrFake[20]){
                          activadoArr.add(true);
                        }
                        if(yestNotEnumArr[21] != yestNotEnumArrFake[21]){
                          activadoArr.add(true);
                        }
                        if(yestNotEnumArr[22] != yestNotEnumArrFake[22]){
                          activadoArr.add(true);
                        }
                        if(yestNotEnumArr[23] != yestNotEnumArrFake[23]){
                          activadoArr.add(true);
                        }
                        if(yestNotEnumArr[24] != yestNotEnumArrFake[24]){
                          activadoArr.add(true);
                        }
                        if(yestNotEnumArr[25] != yestNotEnumArrFake[25]){
                          activadoArr.add(true);
                        }
                        if(yestNotEnumArr[26] != yestNotEnumArrFake[26]){
                          activadoArr.add(true);
                        }
                        if(yestNotEnumArr[27] != yestNotEnumArrFake[27]){
                          activadoArr.add(true);
                        }
                        if(yestNotEnumArr[28] != yestNotEnumArrFake[28]){
                          activadoArr.add(true);
                        }
                        if(yestNotEnumArr[29] != yestNotEnumArrFake[29]){
                          activadoArr.add(true);
                        }
                        if(yestNotEnumArr[30] != yestNotEnumArrFake[30]){
                          activadoArr.add(true);
                        }
                        if(yestNotEnumArr[31] != yestNotEnumArrFake[31]){
                          activadoArr.add(true);
                        }
                        if(yestNotEnumArr[32] != yestNotEnumArrFake[32]){
                          activadoArr.add(true);
                        }
                        if(yestNotEnumArr[33] != yestNotEnumArrFake[33]){
                          activadoArr.add(true);
                        }
                        if(yestNotEnumArr[34] != yestNotEnumArrFake[34]){
                          activadoArr.add(true);
                        }
                        if(yestNotEnumArr[35] != yestNotEnumArrFake[35]){
                          activadoArr.add(true);
                        }
                        if(yestNotEnumArr[36] != yestNotEnumArrFake[36]){
                          activadoArr.add(true);
                        }
                        if(yestNotEnumArr[37] != yestNotEnumArrFake[37]){
                          activadoArr.add(true);
                        }

                        clavesAComparar =[
                          'OTRAS',
                          '1.- Motivo',
                          '1.- ¿Cuál?',
                          '2.- Motivo',
                          'Parte del cuerpo',
                          '2.- ¿Cuál?',
                          '3.- ¿Cuál?',
                          'Tratamiento actual'
                        ];
                        activadoArr.add(clavesAComparar.any((clave) {
                          return (formpart1[6][clave] as MultiInputsForm).contenido!.toString() !=
                              formpartBackUp[6][clave].toString();
                        }));
                        
                        
                        if(pm.signature_patient  != multiInputArr![47]){
                          activadoArr.add(true);
                        }

                        activado = activadoArr.any((element) => element == true);

                        if (activado) {
                          // print('actualizando quinta seccion');
                          await eips.patch_examPa(pm, idExam, context);
                        }
                      }
 
                      ExamApModel eam = ExamApModel();
                      eam.sense = (formpart1[7]['Sentidos'] as MultiInputsForm).contenido!.toString();
                      eam.digestive = (formpart1[7]['Digestivo'] as MultiInputsForm).contenido!.toString();
                      eam.respiratory = (formpart1[7]['Respiratorio'] as MultiInputsForm).contenido!.toString();
                      eam.circulatory = (formpart1[7]['Circulatorio'] as MultiInputsForm).contenido!.toString();
                      eam.genitourinary = (formpart1[7]['Genitourinario'] as MultiInputsForm).contenido!.toString();
                      eam.muscle_skeletal = (formpart1[7]['Músculo/Esquéletico'] as MultiInputsForm).contenido!.toString();
                      eam.nervous = (formpart1[7]['Nervioso'] as MultiInputsForm).contenido!.toString();
                      //7, 86 + 7 = 93 
                      if (edit==false) {
                        if (eam.toJson().isNotEmpty) {
                          eam.idAparattusSystem = int.parse((await eips.post_examAp(eam, context)).container![0]['ultimoId']);
                        }
                      } else {
                       activado = false;
                        clavesAComparar =[
                          'Sentidos',
                          'Digestivo',
                          'Respiratorio',
                          'Circulatorio',
                          'Genitourinario',
                          'Músculo/Esquéletico',
                          'Nervioso'
                        ];
                        activado = clavesAComparar.any((clave) {
                          return (formpart1[7][clave] as MultiInputsForm).contenido!.toString() !=
                              formpartBackUp[7][clave].toString();
                        });
                       
                        if (activado) {
                          // print('actualizando sexta seccion');
                          await eips.patch_examAp(eam, idExam, context);
                        }
                      }
                      
 
                       
                      ExamPhXModel epxm = ExamPhXModel();
                      epxm.t_a = (formpart1[8]['T/A - mmgh'] as MultiInputsForm).contenido!;
                      epxm.f_c = (formpart1[8]['F/C'] as MultiInputsForm).contenido!;
                      epxm.weight = (formpart1[8]['Peso - Kg'] as MultiInputsForm).contenido!;
                      epxm.height = (formpart1[8]['Talla - cm'] as MultiInputsForm).contenido!;
                      epxm.p_abd = (formpart1[8]['P.abd'] as MultiInputsForm).contenido!;
                      epxm.f_r = (formpart1[8]['F/R'] as MultiInputsForm).contenido!;
                      epxm.temp = (formpart1[8]['Temp.'] as MultiInputsForm).contenido!;
                      epxm.i_m_c = (formpart1[8]['I.M.C.'] as MultiInputsForm).contenido!;
                      epxm.general_dln = listChecked_sec7[0][0] == false ? 1 : 2;
                      epxm.attitude = (formpart1[8]['Actitud'] as MultiInputsForm).contenido!;
                      epxm.march = (formpart1[8]['Marcha'] as MultiInputsForm).contenido!;
                      epxm.appearence = (formpart1[8]['Apariencia'] as MultiInputsForm).contenido!;
                      epxm.edo_animo = (formpart1[8]['Edo. ánimo'] as MultiInputsForm).contenido!;
                      epxm.ear_dln = listChecked_sec7[0][1] == false ? 1 : 2;
                      epxm.ear_d = (formpart1[8]['1.- D'] as MultiInputsForm).contenido!;
                      epxm.ear_i = (formpart1[8]['1.- I'] as MultiInputsForm).contenido!;
                      epxm.cae_d = (formpart1[8]['2.- D'] as MultiInputsForm).contenido!;
                      epxm.cae_i = (formpart1[8]['2.- I'] as MultiInputsForm).contenido!;
                      epxm.eardrum_d = (formpart1[8]['3.- D'] as MultiInputsForm).contenido!;
                      epxm.eardrum_i = (formpart1[8]['3.- I'] as MultiInputsForm).contenido!;
                      epxm.head_dln = listChecked_sec7[0][2] == false ? 1 : 2;
                      epxm.hair = (formpart1[8]['Cabello'] as MultiInputsForm).contenido!;
                      epxm.surface = (formpart1[8]['Superficie'] as MultiInputsForm).contenido!;
                      epxm.shape = (formpart1[8]['Forma'] as MultiInputsForm).contenido!;
                      epxm.breast_pn = (formpart1[8]['Senos PN'] as MultiInputsForm).contenido!;
                      epxm.eye_dln = listChecked_sec7[0][3] == false ? 1 : 2;
                      epxm.reflex = (formpart1[8]['Reflejos'] as MultiInputsForm).contenido!;
                      epxm.pupil = (formpart1[8]['Pupilares'] as MultiInputsForm).contenido!;
                      epxm.back_eye = (formpart1[8]['Fondo de Ojo'] as MultiInputsForm).contenido!;
                      epxm.pterigion_d = (formpart1[8]['4.- D'] as MultiInputsForm).contenido!;
                      epxm.pterigion_i = (formpart1[8]['4.- I'] as MultiInputsForm).contenido!;
                      epxm.neuro_dln = listChecked_sec7[0][4] == false ? 1 : 2;
                      epxm.reflex_ot = (formpart1[8]['Reflejos OT'] as MultiInputsForm).contenido!;
                      epxm.romberg = (formpart1[8]['Romberg'] as MultiInputsForm).contenido!;
                      epxm.heel_knee = (formpart1[8]['Talón Rodilla'] as MultiInputsForm).contenido!;
                      epxm.mouth_dln = listChecked_sec7[0][5] == false ? 1 : 2;
                      epxm.lip = (formpart1[8]['Labios'] as MultiInputsForm).contenido!;
                      epxm.breath = (formpart1[8]['Aliento'] as MultiInputsForm).contenido!;
                      epxm.tongue = (formpart1[8]['Lengua'] as MultiInputsForm).contenido!;
                      epxm.pharynx = (formpart1[8]['Faringe'] as MultiInputsForm).contenido!;
                      epxm.amygdala = (formpart1[8]['Amígdalas'] as MultiInputsForm).contenido!;
                      epxm.tooth = (formpart1[8]['Dientes'] as MultiInputsForm).contenido!;
                      epxm.mucosa = (formpart1[8]['1.- Mucosa'] as MultiInputsForm).contenido!;
                      epxm.thorax_dln = listChecked_sec7[0][6] == false ? 1 : 2;
                      epxm.shape_thorax = (formpart1[8]['1.- Forma'] as MultiInputsForm).contenido!;
                      epxm.diaphragm = (formpart1[8]['Diafragma'] as MultiInputsForm).contenido!;
                      epxm.rub_thorax = (formpart1[8]['1.- Frotes'] as MultiInputsForm).contenido!;
                      epxm.ventilation_thorax = (formpart1[8]['1.- Ventilación'] as MultiInputsForm).contenido!;
                      epxm.rales = (formpart1[8]['Estertores'] as MultiInputsForm).contenido!;
                      epxm.abdomen_dln = listChecked_sec7[0][7] == false ? 1 : 2;
                      epxm.shape_abdomen = (formpart1[8]['2.- Forma'] as MultiInputsForm).contenido!;
                      epxm.pain = (formpart1[8]['Dolor'] as MultiInputsForm).contenido!;
                      epxm.mass = (formpart1[8]['Masas'] as MultiInputsForm).contenido!;
                      epxm.hernia_d = (formpart1[8]['5.- D'] as MultiInputsForm).contenido!;
                      epxm.hernia_i = (formpart1[8]['5.- I'] as MultiInputsForm).contenido!;
                      epxm.nose_dln = listChecked_sec7[0][8] == false ? 1 : 2;
                      epxm.septum = (formpart1[8]['Septum'] as MultiInputsForm).contenido!;
                      epxm.mucosa_d = (formpart1[8]['6.- D'] as MultiInputsForm).contenido!;
                      epxm.mucosa_i = (formpart1[8]['6.- I'] as MultiInputsForm).contenido!;
                      epxm.ventilation_nose = (formpart1[8]['2.- Ventilación'] as MultiInputsForm).contenido!;
                      epxm.precordial_area_dln = listChecked_sec7[0][9] == false ? 1 : 2;
                      epxm.often = (formpart1[8]['Frecuencia'] as MultiInputsForm).contenido!;
                      epxm.rhythm = (formpart1[8]['Ritmo'] as MultiInputsForm).contenido!;
                      epxm.tones = (formpart1[8]['Tonos'] as MultiInputsForm).contenido!;
                      epxm.rub_precordial = (formpart1[8]['2.- Frotes'] as MultiInputsForm).contenido!;
                      epxm.puff_precordial = (formpart1[8]['Soplos'] as MultiInputsForm).contenido!;
                      epxm.skin_dln = listChecked_sec7[0][10] == false ? 1 : 2;
                      epxm.scar = (formpart1[8]['Cicatrices'] as MultiInputsForm).contenido!;
                      epxm.texture = (formpart1[8]['Textura'] as MultiInputsForm).contenido!;
                      epxm.diaphoresis = (formpart1[8]['Diaforesis'] as MultiInputsForm).contenido!;
                      epxm.other_injury = (formpart1[8]['Otras Lesiones'] as MultiInputsForm).contenido!;
                      epxm.extremity_dln = listChecked_sec7[0][11] == false ? 1 : 2;
                      epxm.articulate_ext_d = (formpart1[8]['7.- D'] as MultiInputsForm).contenido!;
                      epxm.articulate_ext_i = (formpart1[8]['7.- I'] as MultiInputsForm).contenido!;
                      epxm.muscular_ext_d = (formpart1[8]['8.- D'] as MultiInputsForm).contenido!;
                      epxm.muscular_ext_i = (formpart1[8]['8.- I'] as MultiInputsForm).contenido!;
                      epxm.nervous_ext_d = (formpart1[8]['9.- D'] as MultiInputsForm).contenido!;
                      epxm.nervous_ext_i = (formpart1[8]['9.- I'] as MultiInputsForm).contenido!;
                      epxm.articulate_mi_d = (formpart1[8]['10.- D'] as MultiInputsForm).contenido!;
                      epxm.articulate_mi_i = (formpart1[8]['10.- I'] as MultiInputsForm).contenido!;
                      epxm.muscular_mi_d = (formpart1[8]['11.- D'] as MultiInputsForm).contenido!;
                      epxm.mucular_mi_i = (formpart1[8]['11.- I'] as MultiInputsForm).contenido!;
                      epxm.nervous_mi_d = (formpart1[8]['12.- D'] as MultiInputsForm).contenido!;
                      epxm.nervous_mi_i = (formpart1[8]['12.- I'] as MultiInputsForm).contenido!;
                      epxm.str_column = (formpart1[8]['COLUMNA'] as MultiInputsForm).contenido!;
                      //85, 93 + 85 = 178 
 
                      ExamPhYModel epym = ExamPhYModel();
                      epym.near_30cm  = (yestNotEnumArr != null ? yestNotEnumArr[38] : yesNotEnum[41]) == YesNot.none ? 0 : (yestNotEnumArr != null ? yestNotEnumArr[38] : yesNotEnum[51]) == YesNot.si ? 1 : 2;
                      epym.od_rosenbaun = (formpart1[8]['OD ROSENBAUN 20/']as MultiInputsForm).contenido!;
                      epym.oi_rosenbaun = (formpart1[8]['OI ROSENBAUN 20/']as MultiInputsForm).contenido!;
                      epym.od_jaeguer = (formpart1[8]['OD JAEGUER J']as MultiInputsForm).contenido!;
                      epym.oi_jaeguer = (formpart1[8]['OI JAEGUER J']as MultiInputsForm).contenido!;
                      epym.far_glasses = (yestNotEnumArr != null ? yestNotEnumArr[39] : yesNotEnum[42]) == YesNot.none ? 0 : (yestNotEnumArr != null ? yestNotEnumArr[39] : yesNotEnum[52]) == YesNot.si ? 1 : 2;
                      epym.od_snellen = (formpart1[8]['OD 20/']as MultiInputsForm).contenido!;
                      epym.oi_snellen = (formpart1[8]['OI 20/']as MultiInputsForm).contenido!;
                      epym.od_campimetry = (formpart1[8]['OD']as MultiInputsForm).contenido!;
                      epym.oi_campimetry = (formpart1[8]['OI']as MultiInputsForm).contenido!;
                      epym.color_campimetry = (formpart1[8]['COLOR']as MultiInputsForm).contenido!;
                      epym.amsler_normal = (yestNotEnumArr != null ? yestNotEnumArr[40] : yesNotEnum[43]) == YesNot.none ? 0 : (yestNotEnumArr != null ? yestNotEnumArr[40] : yesNotEnum[53]) == YesNot.si ? 1 : 2;
                      //12, 178 + 12 = 190
                      
                      if (edit == false) {
                        if (epym.toJson().isNotEmpty) {
                          epxm.idExploration = int.parse((await eips.post_examPhX(epxm, context)).container![0]["ultimoId"]);
                          epym.fk_idExploration =epxm.idExploration;
                          await eips.post_examPhY(epym, context);    
                        }else if(epxm.toJson().isNotEmpty){
                          epxm.idExploration = int.parse((await eips.post_examPhX(epxm, context)).container![0]["ultimoId"]);
                        }
                      } else {
                        activadoArr.clear();
                        if(listChecked_sec7[0][0] != listChecked_sec7Fake[0][0]){
                          activadoArr.add(true);
                        }
                        if(listChecked_sec7[0][1] != listChecked_sec7Fake[0][1]){
                          activadoArr.add(true);
                        }
                        if(listChecked_sec7[0][2] != listChecked_sec7Fake[0][2]){
                          activadoArr.add(true);
                        }
                        if(listChecked_sec7[0][3] != listChecked_sec7Fake[0][3]){
                          activadoArr.add(true);
                        }
                        if(listChecked_sec7[0][4] != listChecked_sec7Fake[0][4]){
                          activadoArr.add(true);
                        }
                        if(listChecked_sec7[0][5] != listChecked_sec7Fake[0][5]){
                          activadoArr.add(true);
                        }
                        if( listChecked_sec7[0][6] !=  listChecked_sec7Fake[0][6]){
                          activadoArr.add(true);
                        }
                        if(listChecked_sec7[0][7] != listChecked_sec7Fake[0][7]){
                          activadoArr.add(true);
                        }
                        if(listChecked_sec7[0][8] != listChecked_sec7Fake[0][8]){
                          activadoArr.add(true);
                        }
                        if(listChecked_sec7[0][9] != listChecked_sec7Fake[0][9]){
                          activadoArr.add(true);
                        }
                        if(listChecked_sec7[0][10]  != listChecked_sec7Fake[0][10] ){
                          activadoArr.add(true);
                        }
                        if(listChecked_sec7[0][11] != listChecked_sec7Fake[0][11]){
                          activadoArr.add(true);
                        }
                        clavesAComparar = [
                          'T/A - mmgh',
                          'F/C',
                          'Peso - Kg',
                          'Talla - cm',
                          'P.abd',
                          'F/R',
                          'Temp.',
                          'I.M.C.',
                          'Actitud',
                          'Marcha',
                          'Apariencia',
                          'Edo. ánimo',
                          '1.- D',
                          '1.- I',
                          '2.- D',
                          '2.- I',
                          '3.- D',
                          '3.- I',
                          'Cabello',
                          'Superficie',
                          'Forma',
                          'Senos PN',
                          'Reflejos',
                          'Pupilares',
                          'Fondo de Ojo',
                          '4.- D',
                          '4.- I',
                          'Reflejos OT',
                          'Romberg',
                          'Talón Rodilla',
                          'Labios',
                          'Aliento',
                          'Lengua',
                          'Faringe',
                          'Amígdalas',
                          'Dientes',
                          '1.- Mucosa',
                          '1.- Forma',
                          'Diafragma',
                          '1.- Frotes',
                          '1.- Ventilación',
                          'Estertores',
                          '2.- Forma',
                          'Dolor',
                          'Masas',
                          '5.- D',
                          '5.- I',
                          'Septum',
                          '6.- D',
                          '6.- I',
                          '2.- Ventilación',
                          'Frecuencia',
                          'Ritmo',
                          'Tonos',
                          '2.- Frotes',
                          'Soplos',
                          'Cicatrices',
                          'Textura',
                          'Diaforesis',
                          'Otras Lesiones',
                          '7.- D',
                          '7.- I',
                          '8.- D',
                          '8.- I',
                          '9.- D',
                          '9.- I',
                          '10.- D',
                          '10.- I',
                          '11.- D',
                          '11.- I',
                          '12.- D',
                          '12.- I',
                          'COLUMNA'
                        ];

                        activadoArr.add(clavesAComparar.any((clave) {
                          return (formpart1[8][clave] as MultiInputsForm).contenido!.toString() !=
                              formpartBackUp[8][clave].toString();
                        }));

                        activado = activadoArr.any((element) => element == true);

                        if (activado) {
                          // print('actualizando septima seccion');
                          await eips.patch_examPhX(epxm, idExam, context);
                        }
                        activadoArr.clear();
                        
                        clavesAComparar =[
                        'OD ROSENBAUN 20/',
                        'OI ROSENBAUN 20/',
                        'OD JAEGUER J',
                        'OI JAEGUER J',
                        'OD 20/',
                        'OI 20/',
                        'OD',
                        'OI',
                        'COLOR'
                        ];
                        if(yestNotEnumArr![38] != yestNotEnumArrFake[38]){
                          activadoArr.add(true);
                        }
                        if(yestNotEnumArr[39] != yestNotEnumArrFake[39]){
                          activadoArr.add(true);
                        }
                        if(yestNotEnumArr[40] != yestNotEnumArrFake[40]){
                          activadoArr.add(true);
                        }
                        activadoArr.add(clavesAComparar.any((clave) {
                          return (formpart1[8][clave] as MultiInputsForm).contenido!.toString() !=
                              formpartBackUp[8][clave].toString();
                        }));

                        activado = activadoArr.any((element) => element == true);
                        if (activado) {
                          // print('actualizando octava seccion');
                        await eips.patch_examPhY(epym, idExam, context);   
                        }
                      }

                      ExamLaModel elm = ExamLaModel();
                      elm.result = (formpart1[9]['Resultados'] as MultiInputsForm).contenido!;
                      elm.drug = (formpart1[9]['Drogas'] as MultiInputsForm).contenido!;
                      //2, 190 + 2 = 192
                      if (edit == false) {
                        if (elm.toJson().isNotEmpty) {
                          elm.idLaboratoryTest = int.parse((await eips.post_examLa(elm, context)).container![0]["ultimoId"]);
                        }
                      } else {
                        clavesAComparar =[
                          'Resultados',
                          'Drogas'
                        ];
                        activado = clavesAComparar.any((clave) {
                          return (formpart1[9][clave] as MultiInputsForm).contenido!.toString() !=
                              formpartBackUp[9][clave].toString();
                        });
                        if (activado) {
                          // print('actualizando novena seccion');
                          await eips.patch_examLa(elm, idExam, context);
                        }
                      }
                     
 
                      ExamImModel eimm = ExamImModel();
                      eimm.thorax_radiograph = (formpart1[10]['Telerradiografía de Tórax'] as MultiInputsForm).contenido!;
                      eimm.rx_lumbar_spine = (formpart1[10]['RX Columna Lumbar'] as MultiInputsForm).contenido!;
                      eimm.spirometry = (yestNotEnumArr != null ? yestNotEnumArr[41] : yesNotEnum[44]) == YesNot.none ? 0 : (yestNotEnumArr != null ? yestNotEnumArr[41] : yesNotEnum[44]) == YesNot.si ? 1 : 2;
                      eimm.audiometry = (yestNotEnumArr != null ? yestNotEnumArr[42] : yesNotEnum[45]) == YesNot.none ? 0 : (yestNotEnumArr != null ? yestNotEnumArr[42] : yesNotEnum[45]) == YesNot.si ? 1 : 2;
                      eimm.covid_test = (yestNotEnumArr != null ? yestNotEnumArr[43] : yesNotEnum[46]) == YesNot.none ? 0 : (yestNotEnumArr != null ? yestNotEnumArr[43] : yesNotEnum[46]) == YesNot.si ? 1 : 2;
                      eimm.antidoping = (yestNotEnumArr != null ? yestNotEnumArr[44] : yesNotEnum[47]) == YesNot.none ? 0 : (yestNotEnumArr != null ? yestNotEnumArr[44] : yesNotEnum[47]) == YesNot.si ? 1 : 2;
                      eimm.pregnancy = (yestNotEnumArr != null ? yestNotEnumArr[45] : yesNotEnum[48]) == YesNot.none ? 0 : (yestNotEnumArr != null ? yestNotEnumArr[45] : yesNotEnum[48]) == YesNot.si ? 1 : 2;
                      //7, 192 + 7 = 199
                      if (edit == false) {
                        if (eimm.toJson().isNotEmpty) {
                          eimm.idImagingStudy = int.parse((await eips.post_examIm(eimm, context)).container![0]["ultimoId"]);
                        }
                      } else {
                        activadoArr.clear();
                        activado = false;
                        if(yestNotEnumArr![41] != yestNotEnumArrFake[41]){
                          activadoArr.add(true);
                        }
                        if(yestNotEnumArr[42] != yestNotEnumArrFake[42]){
                          activadoArr.add(true);
                        }
                        if(yestNotEnumArr[43] != yestNotEnumArrFake[43]){
                          activadoArr.add(true);
                        }
                        if(yestNotEnumArr[44] != yestNotEnumArrFake[44]){
                          activadoArr.add(true);
                        }
                        if(yestNotEnumArr[45] != yestNotEnumArrFake[45]) {
                          activadoArr.add(true);
                        }
                        clavesAComparar =[
                          'Telerradiografía de Tórax',
                          'RX Columna Lumbar'
                        ];
                        activadoArr.add(clavesAComparar.any((clave) {
                          return (formpart1[10][clave] as MultiInputsForm).contenido!.toString() !=
                              formpartBackUp[10][clave].toString();
                        }));
                        activado = activadoArr.any((element) => element == true);
                        if (activado) {
                          // print('actualizando diecima seccion');
                          await eips.patch_examIm(eimm, idExam, context);
                        }
                      }
                      

                      ExamDeModel edm = ExamDeModel();
                      edm.suitable = (formpart1[11]['Apto'] as MultiInputsForm).contenido!;
                      edm.not_suitable = (formpart1[11]['No apto'] as MultiInputsForm).contenido!;
                      edm.suitable_more = (formpart1[11]['Apto con conserva'] as MultiInputsForm).contenido!;
                      edm.condition_observation = (formpart1[11]['CONDICIONES Y OBSERVACIONES'] as MultiInputsForm).contenido!;
                      
                      if (sign[1] != null) {
                         final image = await sign[1]!.getData();
                        var data = await image.toByteData(format: ui.ImageByteFormat.png);
                        edm.doctor_signature = base64.encode(data!.buffer.asUint8List());
                      } else{
                        edm.doctor_signature = multiInputArr != null ? multiInputArr[147] : '';
                      }

                      // if (sign[2] !=null ) {
                      //   final image2 = await sign[2]!.getData();
                      //   var data2 = await image2.toByteData(format: ui.ImageByteFormat.png);
                      //   edm.doctor_signature = base64.encode(data2!.buffer.asUint8List());
                      // } else {
                      //   edm.doctor_signature = multiInputArr != null ? multiInputArr[145] : '';
                      // }
                      
                      if (eim.toJson().isNotEmpty) {
                        edm.fk_InitOrPre =  eim.idDetExamInPr;
                      }
                      if (epm.toJson().isNotEmpty) {
                        edm.fk_personalLife = epm.idPersonal;
                      }
                      if (hpm.toJson().isNotEmpty) {
                        edm.fk_heredityPers = hpm.idHeredityPers;
                      }
                      if (pm.toJson().isNotEmpty) {
                        edm.fk_patalogicalPersBack = pm.idPatalogicalPersBack; 
                      }
                      if (eam.toJson().isNotEmpty) {
                        edm.fk_apparatusSystem = eam.idAparattusSystem;
                      }
                      if (epxm.toJson().isNotEmpty) {
                        edm.fk_physicalExploration = epxm.idExploration;
                      }
                      if (elm.toJson().isNotEmpty) {
                        edm.fk_laboratoryTest = elm.idLaboratoryTest;
                      }
                      if (eimm.toJson().isNotEmpty) {
                        edm.fk_imagingStudy = eimm.idImagingStudy;
                      }

                      edm.local = await storage.read(key: 'idHotelRegister');

                      //6, 199 + 6 = 205
                      if (edit == false) {
                        edm.idDetExamInPr = int.parse((await eips.post_examDe(edm, context)).container![0]["ultimoId"]);
                      } else {
                      
                        activado = false;
                        activadoArr.clear();

                        if(edm.doctor_signature != firmaDoctor){
                          activadoArr.add(true);
                        }
                        clavesAComparar =[
                          'Apto',
                          'No apto',
                          'Apto con conserva',
                          'CONDICIONES Y OBSERVACIONES'
                        ];
                        activadoArr.add(clavesAComparar.any((clave) {
                          return (formpart1[11][clave] as MultiInputsForm).contenido!.toString() !=
                              formpartBackUp[11][clave].toString();
                        }));
                        activado = activadoArr.any((element) => element == true);

                        if (activado) {
                          // print('actualizando onceava seccion');
                          await eips.patch_examDe(edm, idExam, context);
                        }
                      }
                      
                      //En este caso no se ocupara un model 
                       
                      List<List<int>> ehfm = [
                      /*padre*/ [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, edm.idDetExamInPr ?? 0],
                      /*madre*/ [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, edm.idDetExamInPr ?? 0],
                      /*herma*/ [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, edm.idDetExamInPr ?? 0],
                      /*parej*/ [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, edm.idDetExamInPr ?? 0],
                      /*hijos*/ [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, edm.idDetExamInPr ?? 0]
                      ];    
                      
                          
                      // 205 + (10 * 5 = 50) = 255  
                      // bool activarBoxArr = false;
                      for (var i = 0; i < 5; i++) {
                        for (var x = 0; x < 10    ; x++) {
                          if(checkBoxArr !=null ? checkBoxArr[i][x] : listChecked_sec4[i][x] == true){
                            ehfm[i][x] = 1;
                          }
                        }
                      }
                      
                      if (edit == false) {
                        for (var i = 0; i < ehfm.length; i++) {
                          await eips.post_examHeF(ehfm[i],context);
                        }
                      }else{
                        for (var i = 0; i < ehfm.length; i++) {
                          if (!const ListEquality().equals(checkBoxArrFake[i], checkBoxArr![i])) {
                            // print('cambio de antecedentes hereditarios row: $i');
                            await eips.patch_examHeF(ehfm[i], idExam,context);
                          }
                        }
                      }
                      
                      
                      //         
                      ExamHiModel ehm = ExamHiModel();
                      for (var i = 0; i < 4; i++) {
                        ehm.company = (formpart1[2]['${1 + i}.- Empresa'] as MultiInputsForm).contenido!.toString();
                        ehm.position =  (formpart1[2]['${1 + i}.- Puestos'] as MultiInputsForm).contenido!.toString();
                        ehm.time = (formpart1[2]['${1 + i}.- Tiempo'] as MultiInputsForm).contenido!.toString();
                        ehm.when_left = (formpart1[2]['${1 + i}.- Cuando Salió'] as MultiInputsForm).contenido!.toString();
                        ehm.job_rotation = (formpart1[2]['${1 + i}.- Rotación de puesto'] as MultiInputsForm).contenido!.toString();
                        ehm.solvent_chemical = (formpart1[2]['${1 + i}.- Quimicos solventes'] as MultiInputsForm).contenido!.toString();
                        ehm.fume = (formpart1[2]['${1 + i}.- Humos'] as MultiInputsForm).contenido!.toString();
                        ehm.vapor = (formpart1[2]['${1 + i}.- Vapores'] as MultiInputsForm).contenido!.toString();
                        ehm.dust = (formpart1[2]['${1 + i}.- Polvos'] as MultiInputsForm).contenido!.toString();
                        ehm.noisy = (formpart1[2]['${1 + i}.- Ruido'] as MultiInputsForm).contenido!.toString();
                        ehm.material_load = (formpart1[2]['${1 + i}.- Carga de material'] as MultiInputsForm).contenido!.toString();

                      //255 + ( 11 * 4 = 44) = 299
                      if (edit == false) {
                        // var json =  ehm.toJson();
                        // bool valid = json.keys.any((key) => json[key].toString() != '');
                        if (ehm.toJson().isNotEmpty) {
                          ehm.fk_idExam = edm.idDetExamInPr;
                          await eips.post_examHi(ehm, 1+i, context);
                        }
                        }else{
                        activado = false;
                        clavesAComparar =[
                          '${1 + i}.- Empresa',
                          '${1 + i}.- Puestos',
                          '${1 + i}.- Tiempo',
                          '${1 + i}.- Cuando Salió',
                          '${1 + i}.- Rotación de puesto',
                          '${1 + i}.- Quimicos solventes',
                          '${1 + i}.- Humos',
                          '${1 + i}.- Vapores',
                          '${1 + i}.- Polvos',
                          '${1 + i}.- Ruido',
                          '${1 + i}.- Carga de material'
                        ];
                        activado = clavesAComparar.any((clave) {
                          return (formpart1[2][clave] as MultiInputsForm).contenido!.toString() !=
                              formpartBackUp[2][clave].toString();
                        });
                          if (activado) {
                          // print('actualizando doceava seccion');
                            await eips.patch_examHi(ehm, idExam, 1+i, context);
                          }
                        }
                      }
                      //         
                      ExamAcModel eacm = ExamAcModel();
                      
                      for (var i = 0; i < 3; i++) {
                        bool activado = false;
                        eacm.company = (formpart1[3]['${1 + i}.- Nombre de empresa']  as MultiInputsForm).contenido!.toString();
                        eacm.date = (formpart1[3]['${1 + i}.- Fecha']  as MultiInputsForm).contenido!.toString();
                        eacm.position = (formpart1[3]['${1 + i}.- Puesto']  as MultiInputsForm).contenido!.toString();
                        eacm.causa = causeEnum[0+i] == Cause.none ? 0 : causeEnum[0+i] == Cause.accidente ? 1 : 2;
                        eacm.disease_name = (formpart1[3]['${1 + i}.- Nombre de la lesión o enfermedad']  as MultiInputsForm).contenido!.toString();
                        eacm.incapacity = (yestNotEnumArrDisease != null ? yestNotEnumArrDisease[i] : yesNotEnum[1+i]) == YesNot.none ? 0 : (yestNotEnumArrDisease != null ? yestNotEnumArrDisease[i] : yesNotEnum[1+i]) == YesNot.si ? 1 : 2;
                        eacm.number_d_incapacity = (formpart1[3]['${1 + i}.- Número de dias de incapacidad'] as MultiInputsForm).contenido!.toString() == '' ? '0' : (formpart1[3]['${1 + i}.- Número de dias de incapacidad'] as MultiInputsForm).contenido!.toString();
                        eacm.fk_idExam = edm.idDetExamInPr;
                        //299+ ( 7 *3 = 21) = 320
                        if (edit == false) {
                          if (eacm.toJson().isNotEmpty) {
                            await eips.post_examAc(eacm, 1+i, context);
                          }
                        }else{
                        activado = false;
                        activadoArr.clear();
                        if (causeEnumFake[0+i] != causeEnum[0+i]) {
                          activadoArr.add(true);
                        } 
                        if (yestNotEnumArrDiseaseFake[i] != yestNotEnumArrDisease![i] ) {
                          activadoArr.add(true);
                        } 
                        clavesAComparar =[
                          '${1 + i}.- Nombre de empresa',
                          '${1 + i}.- Fecha',
                          '${1 + i}.- Puesto',
                          '${1 + i}.- Nombre de la lesión o enfermedad',
                          '${1 + i}.- Número de dias de incapacidad'
                        ];
                        activadoArr.add(clavesAComparar.any((clave) {
                          return (formpart1[3][clave] as MultiInputsForm).contenido!.toString() !=
                              formpartBackUp[3][clave].toString();
                        }));
                        activado = activadoArr.any((element) => element == true);

                          if (activado) {
                          // print('actualizando treceava seccion');
                            await eips.patch_examAc(eacm, idExam, 1+i, context);
                          }
                        }
                      }
                      
                      ExamMaModel emm = ExamMaModel();
                      // messageError(context, (formpart1[0]['Numero de Empleado'] as MultiInputsForm).contenido.toString(), 'title');
                      emm.numEmployee = int.parse(((formpart1[0]['Numero de Empleado'] as MultiInputsForm).contenido == '' ? '0' : (formpart1[0]['Numero de Empleado'] as MultiInputsForm).contenido).toString());
                      emm.fk_initial_pre_entry = edm.idDetExamInPr;

                      //1+ 320 = 321

                        if (edit == false) {
                          await eips.post_examMa(emm,context);  
                        }else{
                          emm.idExam = idExam;
                          if (numEmployee != emm.numEmployee) {
                          // print('actualizando numero de empleado');
                            await eips.patch_examMa(emm, idExam,context);
                          }
                        }

                      Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                          duration: const Duration(seconds: 5),
                          backgroundColor: Colors.green,
                          content: Text('¡Se guardo exitosamente!',style: const TextStyle(color: Colors.white)),
                        ));
                      
                      
                     /*  }else{
                        messageError(context, 'Por favor, para guardar ingrese el número de empleado', 'Error');
                      } */

                      }catch(e){
                        Navigator.of(context).pop();
                        messageError(context, 'Ha ocurrido un error al subir el formulario. ($e)', 'Error');
                      }

                    } : null,
                    label: Text('Guardar', style: getTextStyleButtonFieldRow(context)),
                  ),
                  if (_currentPageIndex < _pages.length - 2)
                  ElevatedButton(
                    onPressed: btnSave == true /* && btnNext == true */ ? () async {
                      if (_currentPageIndex < _pages.length - 2) {
                       /*  if (_currentPageIndex == _pages.length - 3) {
                          setState((){
                            btnNext = false;
                          });
                        } */

                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                        setState(() { 
                          _currentPageIndex++;
                        });    
                      } else {
                        
                        /*if (sign[0] != null || sign[1] != null) {
                          if (_currentPageIndex == _pages.length - 2) {
                            
                          }else{
                            for (var i = 0; i < sign.length; i++) {
                              final image = await sign[i]!.getData();
                              var data = await image.toByteData(format: ui.ImageByteFormat.png);
                              final encoded = base64.encode(data!.buffer.asUint8List());
                            }

                          }
                        } else{
                          print('Faltan las firmas');
                        }*/
                      }
                    } : null,
                    child: Text('Siguiente', style: getTextStyleButtonFieldRow(context)),
                  ),
                ],
              ),
            ],
          ),
        )
  ));
  })
]);
});
}
}
