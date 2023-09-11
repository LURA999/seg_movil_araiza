import 'dart:convert';
import 'dart:ui' as ui;

import 'package:app_seguimiento_movil/services/services.dart';
import 'package:app_seguimiento_movil/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_signature_pad/flutter_signature_pad.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';


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
    
      onPressed: () async {
        
        DepartamentService dp = DepartamentService();
        final arrDepa =  await dp.getDepartament(context);
        List<String> arr = [];
        for (var el in arrDepa) {
          arr.add(el['departamento'].toString());
        }
        newMethod(context, arr);
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

Future<String?> newMethod(BuildContext context, List<String> arrDepartaments) {
int _currentPageIndex = 0;
ExamIniPreService eips = ExamIniPreService();

List<GlobalKey<SignatureState>> sign0 = [GlobalKey<SignatureState>(),GlobalKey<SignatureState>()];
List<ByteData> img = [ByteData(0), ByteData(0)];
List<SignatureState?> sign = [null,null];



//El primero es para controlar los inputs cuando abre y cierra el form
late bool _inputsAdd = false;
//El segundo es para controlar los radiobutton que se generan al abrir y cerrar el form
late bool _inputsAdd2 = false;

/*
1 = MultiInputsForm
2 = RadioButton
3 = List<CheckBox>
4 = firma
*/

List<String?> answersStr = [];

List<int> campos = [
//EXAMEN MÉDICO LABORAL
1,1,1,2,
//FICHA PERSONAL
1,1,1,1,1,1,1,1,1,1,1,
//HISTORIAL LABORAL
1,1,1,1,1,1,1,1,1,1,1,1,
//ACCIDENTES Y ENFERMEDADES DE TRABAJO Anote SOLO Accidentes de trabajo
1,1,1,2,1,2,1,1,1,1,2,1,2,1,1,1,1,2,1,2,1,
//ANTECEDENTES HEREDITARIOS Y FAMILIARES DE SALUD (Con una X anote los datos positivos según sea el caso)
3,3,3,3,3,
//ANTECEDENTES PERSONALES (Con una X anote los datos positivos según sea el caso)\nANTECEDENTES PERSONALES NO PATOLÓGICOS
2,2,1,1,2,1,1,2,1,1,2,1,2,1,2,2,2,2,1,2,1,1,1,1,1,1,1,1,1,1,2,1,1,1,1,1,
//ANTECEDENTES PERSONALES PATOLÓGICOS
2,1,2,1,2,1,2,1,2,1,2,1,2,1,1,
//INTERROGATORIO POR APARATOS Y SISTEMAS.
1,1,1,1,1,1,1,
//EXPLORACIÓN FÍSICA
1,1,1,1,1,1,1,1,3,1,1,1,1,3,1,1,1,1,1,1,3,1,1,1,1,3,1,1,1,1,1,3,1,1,1,3,1,1,1,1,1,1
,1,3,1,1,1,1,1,3,1,1,1,1,1,3,1,1,1,1,3,1,1,1,1,1,3,1,1,1,1,3,1,1,1,1,1,1,1,1,1,1,1,1,1
,2,1,1,1,1,2,1,1,1,1,1,2,
//ANÁLISIS DE LABORATORIO
1,1,
//ESTUDIOS DE GABINETE
1,1,2,2,2,2,2,
//DICTAMEN MÉDICO
1,1,1,1,
//firma
4,4
];

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
YesNot.none,YesNot.none,YesNot.none,YesNot.none,YesNot.none,YesNot.none
];

List<ManoDominante> manoDomEnum = [ManoDominante.none];
List<MetodoAnti> metodoAntiEnum = [MetodoAnti.none];

int countCauseEnum =0;
int countYesNotEnum = 0;
int countManoDomEnum = 0;

//Estas son variables para guardar los resultados de los checkbox
List<List<bool>> listChecked_sec4 =[
[false,false,false,false,false,false,false,false,false,false],
[false,false,false,false,false,false,false,false,false,false],
[false,false,false,false,false,false,false,false,false,false],
[false,false,false,false,false,false,false,false,false,false],
[false,false,false,false,false,false,false,false,false,false]
];


//ESTAS SON VARIABLES PARA ACTIVAR EL DLN
List<List<bool>> listChecked_sec7 =[
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
'Numero de Empleado' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
'Departamento' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true, select: true, listselect: arrDepartaments ),
'Puesto' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
'pre_o_ini' : RadioInput(tipoEnum: 7, yesNotEnum: yesNotEnum, index: countYesNotEnum++,),
},
{//ficha personal (1)
  'Nombre' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'Sexo' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true, select: true, listselect: ['Hombre', 'Mujer'] ),
  'Edad' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'Edo. Civil' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'Domicilio' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'Tel. fijo y/o cel' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'Lugar y fecha de nacimiento' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'Actividad extra a su trabajo' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'Escolaridad' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'Carrera universitaria' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'Núm. de hijos' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
},
{//historial laboral (2)
  '1.- Sized' : const SizedBox(height: 20,),
  '1.- Titulo' : const Align(alignment: Alignment.centerLeft, child: Text('Primera empresa',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))),
  '1.- Empresa' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  '1.- Puestos' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  '1.- Tiempo' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  '2.- Sized' : const SizedBox(height: 20,),
  '2.- Titulo' : const Align(alignment: Alignment.centerLeft, child: Text('Segunda empresa',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))),
  '2.- Empresa' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  '2.- Puestos' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  '2.- Tiempo' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  '3.- Sized' : const SizedBox(height: 20,),
  '3.- Titulo' : const Align(alignment: Alignment.centerLeft, child: Text('Tercera empresa',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))),
  '3.- Empresa' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  '3.- Puestos' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  '3.- Tiempo' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  '4.- Sized' : const SizedBox(height: 20,),
  '4.- Titulo' : const Align(alignment: Alignment.centerLeft, child: Text('Cuarta empresa',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))),
  '4.- Empresa' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  '4.- Puestos' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  '4.- Tiempo' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
} ,
{//ACCIDENTES Y ENFERMEDADES DE TRABAJO (3)
  '1.- Sized' : const SizedBox(height: 20,),
  '1.- Titulo' : const Align(alignment: Alignment.centerLeft, child: Text('Primera empresa',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))),
  '1.- Nombre de empresa' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  '1.- Fecha' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true, keyboardType: TextInputType.datetime),
  '1.- Puesto' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  '1.- Causa' : const Align(alignment: Alignment.centerLeft, child: Text('Causa',style: TextStyle(fontSize: 20))),
  '1.- Causas' : RadioInput(tipoEnum: 2, causeEnum: causeEnum ,index: countCauseEnum++,),
  '1.- Nombre de la lesión o enfermedad' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  '1.- Incapacidad' : const Align(alignment: Alignment.centerLeft, child: Text('Incapacidad',style: TextStyle(fontSize: 20))),
  '1.- YesNot' : RadioInput(tipoEnum: 1, yesNotEnum: yesNotEnum, index: countYesNotEnum++,),
  '1.- Número de dias de incapacidad' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  '2.- Sized' : const SizedBox(height: 20,),
  '2.- Titulo' : const Align(alignment: Alignment.centerLeft, child: Text('Segunda empresa',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))),
  '2.- Nombre de empresa' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  '2.- Fecha' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true, keyboardType: TextInputType.datetime),
  '2.- Puesto' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  '2.- Causa' : const Align(alignment: Alignment.centerLeft, child: Text('Causa',style: TextStyle(fontSize: 20))),
  '2.- Causas' : RadioInput(tipoEnum: 2, causeEnum: causeEnum ,index: countCauseEnum++,),
  '2.- Nombre de la lesión o enfermedad' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  '2.- Incapacidad' : const Align(alignment: Alignment.centerLeft, child: Text('Incapacidad',style: TextStyle(fontSize: 20))),
  '2.- YesNot' : RadioInput(tipoEnum: 1, yesNotEnum: yesNotEnum, index: countYesNotEnum++,),
  '2.- Número de dias de incapacidad' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  '3.- Sized' : const SizedBox(height: 20,),
  '3.- Titulo' : const Align(alignment: Alignment.centerLeft, child: Text('Tercera empresa',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))),
  '3.- Nombre de empresa' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  '3.- Fecha' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true, keyboardType: TextInputType.datetime),
  '3.- Puesto' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  '3.- Causa' : const Align(alignment: Alignment.centerLeft, child: Text('Causa',style: TextStyle(fontSize: 20))),
  '3.- Causas' : RadioInput(tipoEnum: 2, causeEnum: causeEnum ,index: countCauseEnum++,),
  '3.- Nombre de la lesión o enfermedad' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  '3.- Incapacidad' : const Align(alignment: Alignment.centerLeft, child: Text('Incapacidad',style: TextStyle(fontSize: 20))),
  '3.- YesNot' : RadioInput(tipoEnum: 1, yesNotEnum: yesNotEnum, index: countYesNotEnum++,),
  '3.- Número de dias de incapacidad' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
},
{ //4.- ANTECEDENTES HEREDITARIOS Y FAMILIARES DE SALUD (4)
  // (Con una X anote los datos positivos según sea el caso)
  '1.- Sized' : const SizedBox(height: 20,),
  'Padre' : const Align(alignment: Alignment.centerLeft, child: Text('Padre',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))),
  '1.- opc' : 
  [
  CheckInput(contenido: 'Buena salud',listChecked: listChecked_sec4,indexPrincipal:0,indexSecundario: 0,),
  CheckInput(contenido: 'Mala salud',listChecked: listChecked_sec4,indexPrincipal:0,indexSecundario: 1,),
  CheckInput(contenido: 'Finado',listChecked: listChecked_sec4,indexPrincipal:0,indexSecundario: 2),
  CheckInput(contenido: 'Alergia',listChecked: listChecked_sec4,indexPrincipal:0,indexSecundario: 3),
  CheckInput(contenido: 'Diabetes',listChecked: listChecked_sec4,indexPrincipal:0,indexSecundario: 4),
  CheckInput(contenido: 'Presion Alta',listChecked: listChecked_sec4,indexPrincipal:0,indexSecundario: 5),
  CheckInput(contenido: 'Colesterol',listChecked: listChecked_sec4,indexPrincipal:0,indexSecundario: 6),
  CheckInput(contenido: 'Enf. Corazón',listChecked: listChecked_sec4,indexPrincipal:0,indexSecundario: 7),
  CheckInput(contenido: 'Cancer',listChecked: listChecked_sec4,indexPrincipal:0,indexSecundario: 8),
  CheckInput(contenido: 'Anemia',listChecked: listChecked_sec4,indexPrincipal:0,indexSecundario: 9)
],
  '2.- Sized' : const SizedBox(height: 20,),
  'Madre' : const Align(alignment: Alignment.centerLeft, child: Text('Madre',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))),
  '2.- opc' : 
  [
  CheckInput(contenido: 'Buena salud',listChecked: listChecked_sec4,indexPrincipal:1,indexSecundario: 0,),
  CheckInput(contenido: 'Mala salud',listChecked: listChecked_sec4,indexPrincipal:1,indexSecundario: 1,),
  CheckInput(contenido: 'Finado',listChecked: listChecked_sec4,indexPrincipal:1,indexSecundario: 2,),
  CheckInput(contenido: 'Alergia',listChecked: listChecked_sec4,indexPrincipal:1,indexSecundario: 3,),
  CheckInput(contenido: 'Diabetes',listChecked: listChecked_sec4,indexPrincipal:1,indexSecundario: 4,),
  CheckInput(contenido: 'Presion Alta',listChecked: listChecked_sec4,indexPrincipal:1,indexSecundario: 5,),
  CheckInput(contenido: 'Colesterol',listChecked: listChecked_sec4,indexPrincipal:1,indexSecundario: 6,),
  CheckInput(contenido: 'Enf. Corazón',listChecked: listChecked_sec4,indexPrincipal:1,indexSecundario: 7,),
  CheckInput(contenido: 'Cancer',listChecked: listChecked_sec4,indexPrincipal:1,indexSecundario: 8,),
  CheckInput(contenido: 'Anemia',listChecked: listChecked_sec4,indexPrincipal:1,indexSecundario: 9,),
  ],
  '3.- Sized' : const SizedBox(height: 20,),
  'Hermanos' : const Align(alignment: Alignment.centerLeft, child: Text('Hermanos',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))),
  '3.- opc' : 
  [
    CheckInput(contenido: 'Buena salud',listChecked: listChecked_sec4,indexPrincipal:2,indexSecundario: 0,),
    CheckInput(contenido: 'Mala salud',listChecked: listChecked_sec4,indexPrincipal:2,indexSecundario: 1,),
    CheckInput(contenido: 'Finado',listChecked: listChecked_sec4,indexPrincipal:2,indexSecundario: 2,),
    CheckInput(contenido: 'Alergia',listChecked: listChecked_sec4,indexPrincipal:2,indexSecundario: 3,),
    CheckInput(contenido: 'Diabetes',listChecked: listChecked_sec4,indexPrincipal:2,indexSecundario: 4,),
    CheckInput(contenido: 'Presion Alta',listChecked: listChecked_sec4,indexPrincipal:2,indexSecundario: 5,),
    CheckInput(contenido: 'Colesterol',listChecked: listChecked_sec4,indexPrincipal:2,indexSecundario: 6,),
    CheckInput(contenido: 'Enf. Corazón',listChecked: listChecked_sec4,indexPrincipal:2,indexSecundario: 7,),
    CheckInput(contenido: 'Cancer',listChecked: listChecked_sec4,indexPrincipal:2,indexSecundario: 8,),
    CheckInput(contenido: 'Anemia',listChecked: listChecked_sec4,indexPrincipal:2,indexSecundario: 9,),
  ],
  '4.- Sized' : const SizedBox(height: 20,),
  'Pareja' : const Align(alignment: Alignment.centerLeft, child: Text('Pareja',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))),
'4.- opc' : 
[
  CheckInput(contenido: 'Buena salud',listChecked: listChecked_sec4,indexPrincipal:3,indexSecundario: 0,),
  CheckInput(contenido: 'Mala salud',listChecked: listChecked_sec4,indexPrincipal:3,indexSecundario: 1,),
  CheckInput(contenido: 'Finado',listChecked: listChecked_sec4,indexPrincipal:3,indexSecundario: 2,),
  CheckInput(contenido: 'Alergia',listChecked: listChecked_sec4,indexPrincipal:3,indexSecundario: 3,),
  CheckInput(contenido: 'Diabetes',listChecked: listChecked_sec4,indexPrincipal:3,indexSecundario: 4,),
  CheckInput(contenido: 'Presion Alta',listChecked: listChecked_sec4,indexPrincipal:3,indexSecundario: 5,),
  CheckInput(contenido: 'Colesterol',listChecked: listChecked_sec4,indexPrincipal:3,indexSecundario: 6,),
  CheckInput(contenido: 'Enf. Corazón',listChecked: listChecked_sec4,indexPrincipal:3,indexSecundario: 7,),
  CheckInput(contenido: 'Cancer',listChecked: listChecked_sec4,indexPrincipal:3,indexSecundario: 8,),
  CheckInput(contenido: 'Anemia',listChecked: listChecked_sec4,indexPrincipal:3,indexSecundario: 9,),
],
  '5.- Sized' : const SizedBox(height: 20,),
  'Hijos' : const Align(alignment: Alignment.centerLeft, child: Text('Hijos',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))),
  '5.- opc' : 
  [
    CheckInput(contenido: 'Buena salud',listChecked: listChecked_sec4,indexPrincipal:4,indexSecundario: 0,),
    CheckInput(contenido: 'Mala salud',listChecked: listChecked_sec4,indexPrincipal:4,indexSecundario: 1,),
    CheckInput(contenido: 'Finado',listChecked: listChecked_sec4,indexPrincipal:4,indexSecundario: 2,),
    CheckInput(contenido: 'Alergia',listChecked: listChecked_sec4,indexPrincipal:4,indexSecundario: 3,),
    CheckInput(contenido: 'Diabetes',listChecked: listChecked_sec4,indexPrincipal:4,indexSecundario: 4,),
    CheckInput(contenido: 'Presion Alta',listChecked: listChecked_sec4,indexPrincipal:4,indexSecundario: 5,),
    CheckInput(contenido: 'Colesterol',listChecked: listChecked_sec4,indexPrincipal:4,indexSecundario: 6,),
    CheckInput(contenido: 'Enf. Corazón',listChecked: listChecked_sec4,indexPrincipal:4,indexSecundario: 7,),
    CheckInput(contenido: 'Cancer',listChecked: listChecked_sec4,indexPrincipal:4,indexSecundario: 8,),
    CheckInput(contenido: 'Anemia',listChecked: listChecked_sec4,indexPrincipal:4,indexSecundario: 9,),
  ],
},
{//5.-ANTECEDENTES PERSONALES (Con una X anote los datos positivos según sea el caso) (5)
  'Titulo' : const Align(alignment: Alignment.bottomLeft, child: Text('¿Eres?',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))),
  'singleScroll' :  RadioInput(index: countManoDomEnum,tipoEnum: 3,manoDomEnum: manoDomEnum) ,
  'Tabaquismo' : Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('Tabaquismo',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      RadioInput(tipoEnum: 4, yesNotEnum: yesNotEnum, index: countYesNotEnum++,),
    ],
  ),
  '1.- Edad de inicio' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'Cantidad de cigarrillos al día' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'Alcohol' : Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('Ingesta de alcohol',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      RadioInput(tipoEnum: 4, yesNotEnum: yesNotEnum, index: countYesNotEnum++,),
    ],
  ),
  '2.- Edad de inicio' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'Frecuencia' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true), 
  'Taxicomanías' : Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('Taxicomanías',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      RadioInput(tipoEnum: 4, yesNotEnum: yesNotEnum, index: countYesNotEnum++,),
    ],
  ),
  '3.- Edad de inicio' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'Tipo y frecuencia' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'Alergías a med' : Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('Alergías a medicamentos',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      RadioInput(tipoEnum: 4, yesNotEnum: yesNotEnum, index: countYesNotEnum++,),
    ],
  ),
  '1.- ¿A cuál?' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'Alergías a alim' : Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('Alergías a alimentos',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      RadioInput(tipoEnum: 4, yesNotEnum: yesNotEnum, index: countYesNotEnum++,),
    ],
  ),
  '2.- ¿A cuál?' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'Vacunas' : const Align(alignment: Alignment.bottomLeft, child: Text('Vacunas en los últimos 12 meses:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))),
  'COVID-19' : Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 10,),
      const Text('COVID-19',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      RadioInput(tipoEnum: 4, yesNotEnum: yesNotEnum, index: countYesNotEnum++,),
    ],
  ),
  'Tétanos' : Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('Tétanos',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      RadioInput(tipoEnum: 4, yesNotEnum: yesNotEnum, index: countYesNotEnum++,),
    ],
  ),
  'Hepatits' : Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('Hepatits',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      RadioInput(tipoEnum: 4, yesNotEnum: yesNotEnum, index: countYesNotEnum++,),
    ],
  ),
  'Neumococo' : Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('Neumococo',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      RadioInput(tipoEnum: 4, yesNotEnum: yesNotEnum, index: countYesNotEnum++,),
    ],
  ),
  'Otras' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'Practicar deporte' : Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('¿Practica algún deporte?',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      RadioInput(tipoEnum: 4, yesNotEnum: yesNotEnum, index: countYesNotEnum++,),
    ],
  ),
  '3.- ¿A cuál?' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  '¿Con qué frecuencia?' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
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
  'Edad de su primera menstruación' : MultiInputsForm(contenido: '3', obligatorio: false,  enabled: true),
  'Edad de inicio de vida sexual' : MultiInputsForm(contenido: '3', obligatorio: false,  enabled: true),
  'Número de Embarazos' : MultiInputsForm(contenido: '3', obligatorio: false,  enabled: true),
  'Partos' : MultiInputsForm(contenido: '3', obligatorio: false,  enabled: true),
  'Cesáreas' : MultiInputsForm(contenido: '3', obligatorio: false,  enabled: true),
  'Abortos' : MultiInputsForm(contenido: '3', obligatorio: false,  enabled: true),
  'Fecha de Ultima Regla' : MultiInputsForm(contenido: '3', obligatorio: false,  enabled: true),
  'Ritmo' : MultiInputsForm(contenido: '3', obligatorio: false,  enabled: true),
  'anticonceptivo actual' : const Align(alignment: Alignment.bottomLeft, child: Text('Método anticonceptivo actual:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))),
  'alignStart' : RadioInput(tipoEnum: 5, metodoAntiEnum: metodoAntiEnum, index: 0),
  'Fecha de Último Papanicolaou' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  '1.- Resultado' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'Fecha de Mamografía' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true, keyboardType: TextInputType.datetime),
  '2.- Resultado' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'Lactancia' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true)
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
      RadioInput(tipoEnum: 4, yesNotEnum: yesNotEnum, index: countYesNotEnum++,),
      const Text('Asma',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      RadioInput(tipoEnum: 4, yesNotEnum: yesNotEnum, index: countYesNotEnum++,),
      const Text('Bronquitis',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      RadioInput(tipoEnum: 4, yesNotEnum: yesNotEnum, index: countYesNotEnum++,),
      const Text('Hepatits',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      RadioInput(tipoEnum: 4, yesNotEnum: yesNotEnum, index: countYesNotEnum++,),
      const Text('COVID',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      RadioInput(tipoEnum: 4, yesNotEnum: yesNotEnum, index: countYesNotEnum++,),
      const Text('Enfs. de riñón',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      RadioInput(tipoEnum: 4, yesNotEnum: yesNotEnum, index: countYesNotEnum++,),
      const Text('Enfs. de la piel',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      RadioInput(tipoEnum: 4, yesNotEnum: yesNotEnum, index: countYesNotEnum++,),
      const Text('Enfs. de la tiroides',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      RadioInput(tipoEnum: 4, yesNotEnum: yesNotEnum, index: countYesNotEnum++,),
      const Text('Hernias',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      RadioInput(tipoEnum: 4, yesNotEnum: yesNotEnum, index: countYesNotEnum++,),
      const Text('Lumbalgia',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      RadioInput(tipoEnum: 4, yesNotEnum: yesNotEnum, index: countYesNotEnum++,),
      const Text('DIABETES',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      RadioInput(tipoEnum: 4, yesNotEnum: yesNotEnum, index: countYesNotEnum++,),
      const Text('Gastritis',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      RadioInput(tipoEnum: 4, yesNotEnum: yesNotEnum, index: countYesNotEnum++,),
      const Text('Ginecológicas',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      RadioInput(tipoEnum: 4, yesNotEnum: yesNotEnum, index: countYesNotEnum++,),
      const Text('Hemorroides',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      RadioInput(tipoEnum: 4, yesNotEnum: yesNotEnum, index: countYesNotEnum++,),
      const Text('Úlceras',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      RadioInput(tipoEnum: 4, yesNotEnum: yesNotEnum, index: countYesNotEnum++,),
      const Text('Várices',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      RadioInput(tipoEnum: 4, yesNotEnum: yesNotEnum, index: countYesNotEnum++,),
      const Text('Neumonía',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      RadioInput(tipoEnum: 4, yesNotEnum: yesNotEnum, index: countYesNotEnum++,),
      const Text('Tuberculosis',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      RadioInput(tipoEnum: 4, yesNotEnum: yesNotEnum, index: countYesNotEnum++,),
      const Text('Colitis',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      RadioInput(tipoEnum: 4, yesNotEnum: yesNotEnum, index: countYesNotEnum++,),
      const Text('Depresión',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      RadioInput(tipoEnum: 4, yesNotEnum: yesNotEnum, index: countYesNotEnum++,)
    
    ],
  ),
  'OTRAS' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  '2siONo' : Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      const Text('Hospitalizaciones',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      RadioInput(tipoEnum: 4, yesNotEnum: yesNotEnum, index: countYesNotEnum++,),
    ]
  ),
  '1.- Motivo' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  '3siONo' : Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      const Text('Cirugías',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      RadioInput(tipoEnum: 4, yesNotEnum: yesNotEnum, index: countYesNotEnum++,),
    ]
  ),
  '2.- Motivo' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  '4siONo' : Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      const Text('Transfusiones',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      RadioInput(tipoEnum: 4, yesNotEnum: yesNotEnum, index: countYesNotEnum++,),
    ]
  ),
  '3.- Motivo' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  '5siONo' : Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      const Text('Traumatismos y Fracturas',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      RadioInput(tipoEnum: 4, yesNotEnum: yesNotEnum, index: countYesNotEnum++,),
    ]
  ),
  'Parte del cuerpo' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  '6siONo' : Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      const Text('Complicaciones',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      RadioInput(tipoEnum: 4, yesNotEnum: yesNotEnum, index: countYesNotEnum++,),
    ]
  ),
  '1.- ¿Cuál?' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  '7siONo' : Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      const Text('Enfermedades crónicas',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      RadioInput(tipoEnum: 4, yesNotEnum: yesNotEnum, index: countYesNotEnum++,),
    ]
  ),
  '2.- ¿Cuál?' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'Tratamiento actual' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
},
{ //6.- INTERROGATORIO POR APARATOS Y SISTEMAS. (7)
  'Sentidos' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'Digestivo' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'Respiratorio' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'Circulatorio' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'Genitourinario' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'Músculo/Esquéletico' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'Nervioso' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
},
{ //EXPLORACIÓN FÍSICA (8)
  'T/A - mmgh' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'F/C' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'Peso - Kg' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'Talla - cm' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'P.abd' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'F/R' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'Temp.' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'I.M.C.' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'dln' : Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text('GENERAL', style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal)),
      CheckInput(contenido: '\t\t\tDLN',listChecked: listChecked_sec7,indexPrincipal:0,indexSecundario: 0, style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal)),
    ]
  ),
  'Actitud' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'Marcha' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'Apariencia' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'Edo. ánimo' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'dln2' : Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text('OÍDOS', style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal)),
      CheckInput(contenido: '\t\t\tDLN',listChecked: listChecked_sec7,indexPrincipal:0,indexSecundario: 1,style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal)),
    ]
  ),
  'OREJA':Align(alignment: Alignment.bottomLeft, child:Text('Oreja', style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal))),
  '1.- D':MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  '1.- I' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'C A E':Align(alignment: Alignment.bottomLeft, child:Text('C A E', style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal))),
  '2.- D':MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  '2.- I' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'TIMPANO':Align(alignment: Alignment.bottomLeft, child:Text('Tímpano', style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal))),
  '3.- D':MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  '3.- I' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'dln3' : Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text('CABEZA', style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal)),
      CheckInput(contenido: '\t\t\tDLN',listChecked: listChecked_sec7,indexPrincipal:0,indexSecundario: 2,style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal)),
    ]
  ),
  'Cabello' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'Superficie' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'Forma' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'Senos PN' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'dln4' : Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text('OJOS', style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal)),
      CheckInput(contenido: '\t\t\tDLN',listChecked: listChecked_sec7,indexPrincipal:0,indexSecundario: 3,style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal)),
    ]
  ),
  'Reflejos' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'Pupilares' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'Fondo de Ojo' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'Pterigion':Align(alignment: Alignment.bottomLeft, child:Text('Pterigion', style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal))),
  '4.- D':MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  '4.- I' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'dln5' : Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text('NEUROLÓGICO', style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal)),
      CheckInput(contenido: '\t\t\tDLN',listChecked: listChecked_sec7,indexPrincipal:0,indexSecundario: 4,style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal)),
    ]
  ),
  'Reflejos OT' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'Romberg' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'Talón Rodilla' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'dln6' : Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text('BOCA/FARINGE', style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal)),
      CheckInput(contenido: '\t\t\tDLN',listChecked: listChecked_sec7,indexPrincipal:0,indexSecundario: 5,style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal)),
    ]
  ),
  'Labios' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'Aliento' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'Lengua' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'Faringe' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'Amígdalas' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'Dientes' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  '1.- Mucosa' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'dln7' : Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text('TORAX RESP.', style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal)),
      CheckInput(contenido: '\t\t\tDLN',listChecked: listChecked_sec7,indexPrincipal:0,indexSecundario: 6,style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal)),
    ]
  ),
  '1.- Forma' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'Diafragma' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  '1.- Frotes' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  '1.- Ventilación' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'Estertores' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'dln8' : Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text('ABDOMEN', style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal)),
      CheckInput(contenido: '\t\t\tDLN',listChecked: listChecked_sec7,indexPrincipal:0,indexSecundario: 7,style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal)),
    ]
  ),
  '2.- Forma' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'Dolor' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'Masas' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'Hernia':Align(alignment: Alignment.bottomLeft, child:Text('Hernia', style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal))),
  '5.- D':MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  '5.- I' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'dln9' : Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text('NARIZ', style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal)),
      CheckInput(contenido: '\t\t\tDLN',listChecked: listChecked_sec7,indexPrincipal:0,indexSecundario: 8,style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal)),
    ]
  ),
  'Septum' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  '2.- Mucosa':Align(alignment: Alignment.bottomLeft, child:Text('Mucosa', style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal))),
  '6.- D':MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  '6.- I' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  '2.- Ventilación' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'dln10' : Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text('ÁREA PRECORDIAL', style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal)),
      CheckInput(contenido: '\t\t\tDLN',listChecked: listChecked_sec7,indexPrincipal:0,indexSecundario: 9,style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal)),
    ]
  ),
  'Frecuencia' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'Ritmo' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'Tonos' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  '2.- Frotes' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'Soplos' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'dln11' : Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text('PIEL', style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal)),
      CheckInput(contenido: '\t\t\tDLN',listChecked: listChecked_sec7,indexPrincipal:0,indexSecundario: 10,style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal)),
    ]
  ),
  'Cicatrices' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'Textura' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'Diaforesis' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'Otras Lesiones' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'dln12' : Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text('EXTREMIDIDADES', style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal)),
      CheckInput(contenido: '\t\t\tDLN',listChecked: listChecked_sec7,indexPrincipal:0,indexSecundario: 11,style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal)),
    ]
  ),
  '1.- Articular':Align(alignment: Alignment.bottomLeft, child:Text('Articular', style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal))),
  '7.- D':MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  '7.- I' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  '1.- Muscular':Align(alignment: Alignment.bottomLeft, child:Text('Muscular', style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal))),
  '8.- D':MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  '8.- I' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  '1.- Nervioso':Align(alignment: Alignment.bottomLeft, child:Text('Nervioso', style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal))),
  '9.- D':MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  '9.- I' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'M.I.':Align(alignment: Alignment.bottomLeft, child:Text('Nervioso', style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal))),
  '2.-Articular':Align(alignment: Alignment.bottomLeft, child:Text('Articular', style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal))),
  '10.- D':MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  '10.- I' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  '2.-Muscular':Align(alignment: Alignment.bottomLeft, child:Text('Muscular', style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal))),
  '11.- D':MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  '11.- I' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  '2.-Nervioso':Align(alignment: Alignment.bottomLeft, child:Text('Nervioso', style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal))),
  '12.- D':MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  '12.- I' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'COLUMNA' : MultiInputsForm(contenido: 'rer', obligatorio: true,  enabled: true),
  'DE CERCA A 30CM LENTES':Align(alignment: Alignment.bottomLeft, child:Text('DE CERCA A 30CM LENTES', style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal))),
  'lentes cerca': RadioInput(tipoEnum: 4, yesNotEnum: yesNotEnum, index: countYesNotEnum++,),
  'OD ROSENBAUN 20/' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'OI ROSENBAUN 20/' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'OD JAEGUER J' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'OI JAEGUER J' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'DE LEJOS LENTES':Align(alignment: Alignment.bottomLeft, child:Text('DE LEJOS LENTES', style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal))),
  'lentes lejos': RadioInput(tipoEnum: 4, yesNotEnum: yesNotEnum, index: countYesNotEnum++,),
  'SNELLEN':Align(alignment: Alignment.bottomLeft, child:Text('SNELLEN', style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal))),
  'OD 20/' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'OI 20/' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'CAMPIMETRIA':Align(alignment: Alignment.bottomLeft, child:Text('CAMPIMETRIA', style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal))),
  'OD' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'OI' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'COLOR' : MultiInputsForm(contenido: 'azul', obligatorio: true,  enabled: true),
  'AMSLER NORMAL':Align(alignment: Alignment.bottomLeft, child:Text('AMSLER NORMAL', style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal))),
  'amsler': RadioInput(tipoEnum: 4, yesNotEnum: yesNotEnum, index: countYesNotEnum++,),
},
{ //ANALISIS DE LABORATORIO (9)
  'Resultados' : MultiInputsForm(contenido: 'res', obligatorio: true,  enabled: true),
  'Drogas' : MultiInputsForm(contenido: 'drog', obligatorio: true,  enabled: true),
},
{//ESTUDIOS DE GABINETE (10)
  'Telerradiografía de Tórax' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'RX Columna Lumbar' : MultiInputsForm(contenido: '3', obligatorio: true,  enabled: true),
  'Otros':Align(alignment: Alignment.bottomLeft, child:Text('Otros', style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal))),
  'Espirometria':Align(alignment: Alignment.bottomLeft, child:Text('Espirometria', style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal))),
  'espi': RadioInput(tipoEnum: 6, yesNotEnum: yesNotEnum, index: countYesNotEnum++,),
  'Audiometria':Align(alignment: Alignment.bottomLeft, child:Text('Audiometria', style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal))),
  'audi': RadioInput(tipoEnum: 6, yesNotEnum: yesNotEnum, index: countYesNotEnum++,),
  'Prueba covid-19':Align(alignment: Alignment.bottomLeft, child:Text('Prueba covid-19', style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal))),
  'prueba': RadioInput(tipoEnum: 6, yesNotEnum: yesNotEnum, index: countYesNotEnum++,),
  'Embarazo':Align(alignment: Alignment.bottomLeft, child:Text('Embarazo', style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal))),
  'emb': RadioInput(tipoEnum: 6, yesNotEnum: yesNotEnum, index: countYesNotEnum++,),
  'Antidoping':Align(alignment: Alignment.bottomLeft, child:Text('Antidoping', style: TextStyle(fontSize:MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020),fontWeight: FontWeight.normal))),
  'anti': RadioInput(tipoEnum: 6, yesNotEnum: yesNotEnum, index: countYesNotEnum++,),

},
{//DICTAMEN MÉDICO (11)
  'Apto' : MultiInputsForm(contenido: 'apto', obligatorio: true,  enabled: true),
  'No apto' : MultiInputsForm(contenido: 'noapto', obligatorio: true,  enabled: true),
  'Apto con conserva' : MultiInputsForm(contenido: 'apto', obligatorio: true,  enabled: true),
  'CONDICIONES Y OBSERVACIONES' : MultiInputsForm(contenido: 'cond', obligatorio: true,  enabled: true),
},
{ // FIRMAS (12)
  'firma asp': 
  Container(
    alignment: Alignment.center,
    child:const Text('Firma de Aspirante')
  ),
  '0': MultiInputsForm(contenido: '', obligatorio: true,paintSignature: true),
  'firma dr': 
  Container(
    alignment: Alignment.center,
    child:const Text('Nombre, Firma y Ced. Prof. del Médico\n Dr. Alfredo Gruel Culebro')
  ),
  '1': MultiInputsForm(contenido: '', obligatorio: true,paintSignature: true)
} 


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
      if( (value as MultiInputsForm).paintSignature?? false == true){
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
            onPressed: () async {
              if (sign[int.parse(key)] != null) {
                sign[int.parse(key)] = sign0[int.parse(key)].currentState!;
                sign[int.parse(key)]!.clear();
                sign[int.parse(key)] = null;
                img[int.parse(key)] = ByteData(0);
              }
            },
            label: Text('Borrar',style: getTextStyleButtonField(context)),
          ),
          ],
          )
          );
      } else{
        _pages[i].add(const SizedBox(height: 10,));
        _pages[i].add (
        MultiInputs(
        maxLines: 1,
        labelText: key,
        controller: null,
        autofocus: false,
        formProperty: key,
        listSelectForm: value.listselect,
        formValue: formpart1[i],
        keyboardType: TextInputType.text));
        _pages[i].add(const SizedBox(height: 10,));
      }
        break;
      case RadioInput:
      // print(value.tipoEnum);
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
builder: (BuildContext context ) { 
return Stack(
children: [
  const ModalBarrier(
    dismissible: false,
    color:  Color.fromARGB(80, 0, 0, 0),
  ),
StatefulBuilder(
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
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  itemCount: myFormKey.length - 1,
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
                  ElevatedButton.icon(
                    icon: const Icon(Icons.save),
                    onPressed: () async {
                      int indexRadioButton = 0;
                      /*int indexCampo = 0;
                      
                        1 = MultiInputsForm
                        2 = RadioButton
                        3 = List<CheckBox>
                        4 = firma
                      */
                      /* for (var el in formpart1) {
                        el.forEach((key, value) {
                            if ( (value is SizedBox || value is Align  || value is Container) == false) {
                              if (campos[indexCampo] == 1) {
                                answersStr.add(value.contenido);
                              }else{
                              }
                            indexCampo++;

                            }
                        });
                      } */
                       ExamInModel eim = ExamInModel();
                      eim.departament = int.parse((formpart1[0]['Departamento'] as MultiInputsForm).contenido!);
                      eim.place = (formpart1[0]['Puesto'] as MultiInputsForm).contenido!;
                      eim.type = yesNotEnum[0] == YesNot.none ? 0 : yesNotEnum[0] == YesNot.si ? 1 : 2;
                      eim.idDetExamInPr =  int.parse((await eips.post_examIn(eim, context)).container![0]["ultimoId"]);
                      
                      
                      ExamPeModel epm = ExamPeModel();
                      epm.name = (formpart1[1]['Nombre'] as MultiInputsForm).contenido!;
                      epm.sex = int.parse((formpart1[1]['Sexo'] as MultiInputsForm).contenido!);
                      epm.age = (formpart1[1]['Edad'] as MultiInputsForm).contenido!;
                      epm.marital_status = (formpart1[1]['Edo. Civil'] as MultiInputsForm).contenido!;
                      epm.address = (formpart1[1]['Domicilio'] as MultiInputsForm).contenido!;
                      epm.tel_cel = (formpart1[1]['Tel. fijo y/o cel'] as MultiInputsForm).contenido!;
                      epm.place_and_birthday = (formpart1[1]['Lugar y fecha de nacimiento'] as MultiInputsForm).contenido!;
                      epm.extra_activity = (formpart1[1]['Actividad extra a su trabajo'] as MultiInputsForm).contenido!;
                      epm.schooling = (formpart1[1]['Escolaridad'] as MultiInputsForm).contenido!;
                      epm.college_career = (formpart1[1]['Carrera universitaria'] as MultiInputsForm).contenido!;
                      epm.number_children = (formpart1[1]['Núm. de hijos'] as MultiInputsForm).contenido!;
                      epm.idPersonal = int.parse((await eips.post_examPe(epm, context)).container![0]["ultimoId"]);
                      
                      
                      ExamHePModel hpm = ExamHePModel();
                      switch (manoDomEnum[0]) {
                        case ManoDominante.diestro: hpm.fk_dominant_hand = 1; break;
                        case ManoDominante.zurdo: hpm.fk_dominant_hand = 2; break;
                        case ManoDominante.ambos: hpm.fk_dominant_hand = 3;  break;
                        case ManoDominante.none: hpm.fk_dominant_hand = 0; break;
                      }

                      hpm.smoking = yesNotEnum[4] == YesNot.none ? 0 : yesNotEnum[4] == YesNot.si ? 1 : 2; 
                      hpm.age_smoking = (formpart1[5]['1.- Edad de inicio'] as MultiInputsForm).contenido!;
                      hpm.amount_cigarettes = (formpart1[5]['Cantidad de cigarrillos al día'] as MultiInputsForm).contenido!;
                      hpm.alcohol = yesNotEnum[5] == YesNot.none ? 0 : yesNotEnum[5] == YesNot.si ? 1 : 2;
                      hpm.age_alcohol = (formpart1[5]['2.- Edad de inicio'] as MultiInputsForm).contenido!;
                      hpm.often_alcohol = (formpart1[5]['Frecuencia'] as MultiInputsForm).contenido!;
                      hpm.taxonomists = yesNotEnum[5] == YesNot.none ? 0 : yesNotEnum[6] == YesNot.si ? 1 : 2;
                      hpm.age_taxonomists = (formpart1[5]['3.- Edad de inicio'] as MultiInputsForm).contenido!;
                      hpm.often_taxonomists = (formpart1[5]['Tipo y frecuencia'] as MultiInputsForm).contenido!;
                      hpm.allergy_medicament = yesNotEnum[7] == YesNot.none ? 0 : yesNotEnum[7] == YesNot.si ? 1 : 2;
                      hpm.what_medicament = (formpart1[5]['1.- ¿A cuál?'] as MultiInputsForm).contenido!;
                      hpm.allergy_food = yesNotEnum[8] == YesNot.none ? 0 : yesNotEnum[8] == YesNot.si ? 1 : 2;
                      hpm.what_food = (formpart1[5]['2.- ¿A cuál?'] as MultiInputsForm).contenido!;
                      hpm.covid_vaccine = yesNotEnum[9] == YesNot.none ? 0 : yesNotEnum[9] == YesNot.si ? 1 : 2;
                      hpm.tetanus_vaccine = yesNotEnum[10] == YesNot.none ? 0 : yesNotEnum[10] == YesNot.si ? 1 : 2;
                      hpm.hepatitis_vaccine = yesNotEnum[11] == YesNot.none ? 0 : yesNotEnum[11] == YesNot.si ? 1 : 2;
                      hpm.pneumococcal_vaccine = yesNotEnum[12] == YesNot.none ? 0 : yesNotEnum[12] == YesNot.si ? 1 : 2;
                      hpm.other_vaccine = (formpart1[5]['Otras'] as MultiInputsForm).contenido!;
                      hpm.practice_exercise = yesNotEnum[13] == YesNot.none ? 0 : yesNotEnum[13] == YesNot.si ? 1 : 2;
                      hpm.what_exercise = (formpart1[5]['3.- ¿A cuál?'] as MultiInputsForm).contenido!;
                      hpm.often_exercise = (formpart1[5]['¿Con qué frecuencia?'] as MultiInputsForm).contenido!;
                      hpm.idHeredityPers = int.parse((await eips.post_examHeP(hpm,context)).container![0]["ultimoId"]);
 
                      ExamGyModel gypm = ExamGyModel();
                      gypm.age_fmenstruation = (formpart1[5]['Edad de su primera menstruación'] as MultiInputsForm).contenido!;
                      gypm.age_stSex_life = (formpart1[5]['Edad de inicio de vida sexual'] as MultiInputsForm).contenido!;
                      gypm.amount_childbirth = int.parse((formpart1[5]['Número de Embarazos'] as MultiInputsForm).contenido!);
                      gypm.amount_pregnancy = (formpart1[5]['Partos'] as MultiInputsForm).contenido!;
                      gypm.cesarean = (formpart1[5]['Cesáreas'] as MultiInputsForm).contenido!;
                      gypm.abort = (formpart1[5]['Abortos'] as MultiInputsForm).contenido!;
                      gypm.last_rule_date = (formpart1[5]['Fecha de Ultima Regla'] as MultiInputsForm).contenido!;
                      gypm.rhythm = (formpart1[5]['Ritmo'] as MultiInputsForm).contenido!;
                      switch (metodoAntiEnum[0]) {
                        case MetodoAnti.pastillas: gypm.fk_contraceptive_method = 1; break;
                        case MetodoAnti.dispositivo: gypm.fk_contraceptive_method = 2; break;
                        case MetodoAnti.condon: gypm.fk_contraceptive_method = 3;  break;
                        case MetodoAnti.otb: gypm.fk_contraceptive_method = 4; break;
                        case MetodoAnti.inyeccion: gypm.fk_contraceptive_method = 5; break;
                        case MetodoAnti.implante: gypm.fk_contraceptive_method = 6; break;
                        case MetodoAnti.none: gypm.fk_contraceptive_method = 0; break;

                      }
                      gypm.date_last_pap_smear= (formpart1[5]['Fecha de Último Papanicolaou'] as MultiInputsForm).contenido!;
                      gypm.result_pap_smear= (formpart1[5]['1.- Resultado'] as MultiInputsForm).contenido!;
                      gypm.mammography_date= (formpart1[5]['Fecha de Mamografía'] as MultiInputsForm).contenido!;
                      gypm.result_mammography= (formpart1[5]['2.- Resultado'] as MultiInputsForm).contenido!;
                      gypm.lactation= (formpart1[5]['Lactancia'] as MultiInputsForm).contenido!;
                      gypm.fk_idHeredityPers = hpm.idHeredityPers; 

                      ExamPaModel pm = ExamPaModel();
                      pm.arthritis = yesNotEnum[14] == YesNot.none ? 0 : yesNotEnum[14] == YesNot.si ? 1 : 2;
                      pm.asthma = yesNotEnum[15] == YesNot.none ? 0 : yesNotEnum[15] == YesNot.si ? 1 : 2;
                      pm.bronchitis = yesNotEnum[16] == YesNot.none ? 0 : yesNotEnum[16] == YesNot.si ? 1 : 2;
                      pm.hepatitis = yesNotEnum[17] == YesNot.none ? 0 : yesNotEnum[17] == YesNot.si ? 1 : 2;
                      pm.covid = yesNotEnum[18] == YesNot.none ? 0 : yesNotEnum[18] == YesNot.si ? 1 : 2;
                      pm.kidney_disease = yesNotEnum[19] == YesNot.none ? 0 : yesNotEnum[19] == YesNot.si ? 1 : 2;
                      pm.skin_disease = yesNotEnum[20] == YesNot.none ? 0 : yesNotEnum[20] == YesNot.si ? 1 : 2;
                      pm.thyreous_disease = yesNotEnum[21] == YesNot.none ? 0 : yesNotEnum[21] == YesNot.si ? 1 : 2;
                      pm.hernia = yesNotEnum[22] == YesNot.none ? 0 : yesNotEnum[22] == YesNot.si ? 1 : 2;
                      pm.low_back_pain = yesNotEnum[23] == YesNot.none ? 0 : yesNotEnum[23] == YesNot.si ? 1 : 2;
                      pm.diabetes = yesNotEnum[24] == YesNot.none ? 0 : yesNotEnum[24] == YesNot.si ? 1 : 2;
                      pm.gastitris = yesNotEnum[25] == YesNot.none ? 0 : yesNotEnum[25] == YesNot.si ? 1 : 2;
                      pm.gynaecological = yesNotEnum[26] == YesNot.none ? 0 : yesNotEnum[26] == YesNot.si ? 1 : 2;
                      pm.hemorrhoid = yesNotEnum[27] == YesNot.none ? 0 : yesNotEnum[27] == YesNot.si ? 1 : 2;
                      pm.ulcer = yesNotEnum[28] == YesNot.none ? 0 : yesNotEnum[28] == YesNot.si ? 1 : 2;
                      pm.varices = yesNotEnum[29] == YesNot.none ? 0 : yesNotEnum[29] == YesNot.si ? 1 : 2;
                      pm.pneumonia = yesNotEnum[30] == YesNot.none ? 0 : yesNotEnum[30] == YesNot.si ? 1 : 2;
                      pm.tuberculosis = yesNotEnum[31] == YesNot.none ? 0 : yesNotEnum[31] == YesNot.si ? 1 : 2;
                      pm.colitis = yesNotEnum[32] == YesNot.none ? 0 : yesNotEnum[32] == YesNot.si ? 1 : 2;
                      pm.depression = yesNotEnum[33] == YesNot.none ? 0 : yesNotEnum[33] == YesNot.si ? 1 : 2;
                      pm.other_disease= (formpart1[6]['Tratamiento actual'] as MultiInputsForm).contenido!;
                      pm.idPatalogicalPersBack = int.parse((await eips.post_examPa(pm, context)).container![0]["ultimoId"]);
 
                      ExamApModel eam = ExamApModel();
                      eam.sense = (formpart1[7]['Sentidos'] as MultiInputsForm).contenido!;
                      eam.digestive = (formpart1[7]['Digestivo'] as MultiInputsForm).contenido!;
                      eam.respiratory = (formpart1[7]['Respiratorio'] as MultiInputsForm).contenido!;
                      eam.circulatory = (formpart1[7]['Circulatorio'] as MultiInputsForm).contenido!;
                      eam.genitourinary = (formpart1[7]['Genitourinario'] as MultiInputsForm).contenido!;
                      eam.muscle_skeletal = (formpart1[7]['Músculo/Esquéletico'] as MultiInputsForm).contenido!;
                      eam.nervous = (formpart1[7]['Nervioso'] as MultiInputsForm).contenido!;
                      eam.idAparattusSystem = int.parse((await eips.post_examAp(eam, context)).container![0]['ultimoId']);
 
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
                      epxm.shape_thorax = (formpart1[8]['1.- Mucosa'] as MultiInputsForm).contenido!;
                      epxm.diaphragm = (formpart1[8]['1.- Forma'] as MultiInputsForm).contenido!;
                      epxm.rub_thorax = (formpart1[8]['Diafragma'] as MultiInputsForm).contenido!;
                      epxm.puff_thorax = (formpart1[8]['1.- Frotes'] as MultiInputsForm).contenido!;
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
                      epxm.idExploration = int.parse((await eips.post_examPhX(epxm, context)).container![0]["ultimoId"]);
 
                      ExamPhYModel epym = ExamPhYModel();
                      epym.fk_idExploration =epxm.idExploration;
                      epym.near_30cm  = yesNotEnum[34] == YesNot.none ? 0 : yesNotEnum[34] == YesNot.si ? 1 : 2;
                      epym.od_rosenbaun = (formpart1[8]['OD ROSENBAUN 20/']as MultiInputsForm).contenido!;
                      epym.oi_rosenbaun = (formpart1[8]['OI ROSENBAUN 20/']as MultiInputsForm).contenido!;
                      epym.od_jaeguer = (formpart1[8]['OD JAEGUER J']as MultiInputsForm).contenido!;
                      epym.oi_jaeguer = (formpart1[8]['OI JAEGUER J']as MultiInputsForm).contenido!;
                      epym.far_glasses = yesNotEnum[35] == YesNot.none ? 0 : yesNotEnum[35] == YesNot.si ? 1 : 2;
                      epym.od_snellen = (formpart1[8]['OD 20/']as MultiInputsForm).contenido!;
                      epym.oi_snellen = (formpart1[8]['OI 20/']as MultiInputsForm).contenido!;
                      epym.od_campimetry = (formpart1[8]['OD']as MultiInputsForm).contenido!;
                      epym.oi_campimetry = (formpart1[8]['OI']as MultiInputsForm).contenido!;
                      epym.color_campimetry = (formpart1[8]['COLOR']as MultiInputsForm).contenido!;
                      epym.amsler_normal = yesNotEnum[36] == YesNot.none ? 0 : yesNotEnum[36] == YesNot.si ? 1 : 2;
                      await eips.post_examPhY(epym, context);    

                      ExamLaModel elm = ExamLaModel();
                      elm.drug = (formpart1[9]['Resultados'] as MultiInputsForm).contenido!;
                      elm.result = (formpart1[9]['Drogas'] as MultiInputsForm).contenido!;
                      elm.idLaboratoryTest = int.parse((await eips.post_examLa(elm, context)).container![0]["ultimoId"]);
 
                      ExamImModel eimm = ExamImModel();
                      eimm.thorax_radiograph = (formpart1[10]['Telerradiografía de Tórax'] as MultiInputsForm).contenido!;
                      eimm.rx_lumbar_spine = (formpart1[10]['RX Columna Lumbar'] as MultiInputsForm).contenido!;
                      eimm.spirometry = yesNotEnum[37] == YesNot.none ? 0 : yesNotEnum[37] == YesNot.si ? 1 : 2;
                      eimm.audiometry = yesNotEnum[38] == YesNot.none ? 0 : yesNotEnum[38] == YesNot.si ? 1 : 2;
                      eimm.covid_test = yesNotEnum[39] == YesNot.none ? 0 : yesNotEnum[39] == YesNot.si ? 1 : 2;
                      eimm.pregnancy = yesNotEnum[40] == YesNot.none ? 0 : yesNotEnum[40] == YesNot.si ? 1 : 2;
                      eimm.antidoping = yesNotEnum[41] == YesNot.none ? 0 : yesNotEnum[41] == YesNot.si ? 1 : 2;
                      eimm.idImagingStudy = int.parse((await eips.post_examIm(eimm, context)).container![0]["ultimoId"]);
                      

                      ExamDeModel edm = ExamDeModel();
                      edm.suitable = (formpart1[11]['Apto'] as MultiInputsForm).contenido!;
                      edm.not_suitable = (formpart1[11]['No apto'] as MultiInputsForm).contenido!;
                      edm.suitable_more = (formpart1[11]['Apto con conserva'] as MultiInputsForm).contenido!;
                      edm.condition_observation = (formpart1[11]['CONDICIONES Y OBSERVACIONES'] as MultiInputsForm).contenido!;
                      final image = await sign[0]!.getData();
                      var data = await image.toByteData(format: ui.ImageByteFormat.png);
                      edm.applicant_signature = base64.encode(data!.buffer.asUint8List());
                      final image2 = await sign[1]!.getData();
                      var data2 = await image2.toByteData(format: ui.ImageByteFormat.png);
                      edm.doctor_signature = base64.encode(data2!.buffer.asUint8List());
                      edm.fk_InitOrPre =  eim.idDetExamInPr;
                      edm.fk_personalLife = epm.idPersonal;
                      edm.fk_heredityPers = hpm.idHeredityPers;
                      edm.fk_patalogicalPersBack = pm.idPatalogicalPersBack; 
                      edm.fk_apparatusSystem = eam.idAparattusSystem;
                      edm.fk_physicalExploration = epxm.idExploration;
                      edm.fk_laboratoryTest = elm.idLaboratoryTest;
                      edm.fk_imagingStudy = eimm.idImagingStudy;
                      edm.idDetExamInPr = int.parse((await eips.post_examDe(edm, context)).container![0]["ultimoId"]);

                      //En este caso no se ocupara un model 
                       
                      List<List<int>> ehfm = [
                      /*padre*/ [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, edm.idDetExamInPr!],
                      /*madre*/ [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, edm.idDetExamInPr!],
                      /*herma*/ [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, edm.idDetExamInPr!],
                      /*parej*/ [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, edm.idDetExamInPr!],
                      /*hijos*/ [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, edm.idDetExamInPr!]
                      ];    
                      
                      for (var i = 0; i < 5; i++) {
                        for (var x = 0; x < 10    ; x++) {
                          if(listChecked_sec4[i][x]== true){
                            switch (i) {
                              case 0: ehfm[i][x] = 1;
                                break;
                              case 1: ehfm[i][x] = 1;
                                break;
                              case 2: ehfm[i][x] = 1;
                                break;
                              case 3: ehfm[i][x] = 1;
                                break;
                              case 4: ehfm[i][x] = 1;
                                break;  
                              default:
                            }
                            
                          }
                        }
                      }
                      for (var i = 0; i < ehfm.length; i++) {
                        await eips.post_examHeF(ehfm[i],context);
                      }
                      
                      
                      ExamHiModel ehm = ExamHiModel();
                      for (var i = 0; i < 3; i++) {
                        ehm.company = (formpart1[2]['${i + 1}.- Empresa'] as MultiInputsForm).contenido!;
                        ehm.position =  (formpart1[2]['${i + 1}.- Puestos'] as MultiInputsForm).contenido!;
                        ehm.time = (formpart1[2]['${i + 1}.- Tiempo'] as MultiInputsForm).contenido!;
                        ehm.fk_idExam = edm.idDetExamInPr;
                        await eips.post_examHi(ehm, context);
                      }

                      ExamAcModel eacm = ExamAcModel();
                      for (var i = 0; i < 3; i++) {
                        eacm.company = (formpart1[3]['${i + 1}.- Nombre de empresa']  as MultiInputsForm).contenido!;
                        eacm.date = (formpart1[3]['${i + 1}.- Fecha']  as MultiInputsForm).contenido!;
                        eacm.position = (formpart1[3]['${i + 1}.- Puesto']  as MultiInputsForm).contenido!;
                        eacm.causa = causeEnum[0+i] == Cause.none ? 0 : causeEnum[0+i] == Cause.accidente ? 1 : 2;
                        eacm.disease_name = (formpart1[3]['${i + 1}.- Nombre de la lesión o enfermedad']  as MultiInputsForm).contenido!;
                        eacm.incapacity = yesNotEnum[1+i] == YesNot.none ? 0 : yesNotEnum[1+i] == YesNot.si ? 1 : 2;
                        eacm.number_d_incapacity = int.parse((formpart1[3]['${i + 1}.- Número de dias de incapacidad']  as MultiInputsForm).contenido!);
                        eacm.fk_idExam = edm.idDetExamInPr;
                        await eips.post_examAc(eacm, context);
                      }
                      
                      ExamMaModel emm = ExamMaModel();
                      emm.numEmployee = int.parse((formpart1[0]['Numero de Empleado'] as MultiInputsForm).contenido!);
                      emm.fk_initial_pre_entry = edm.idDetExamInPr;
                      await eips.post_examMa(emm,context);  

                      answersStr.clear();
                    },
                    label: const Text('Guardar'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
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

                        if (sign[0] != null || sign[1] != null) {
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
                        }
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
]);
}
);
}

}
