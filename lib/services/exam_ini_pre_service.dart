
// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:app_seguimiento_movil/models/models.dart';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:app_seguimiento_movil/widgets/widgets.dart';

class ExamIniPreService extends ChangeNotifier{

  bool modoApk = kDebugMode?true:false; 
  bool isSaving = true;
  late String link = modoApk?'https://www.comunicadosaraiza.com/movil_scan_api_prueba/API':'https://www.comunicadosaraiza.com/movil_scan_api_prueba2/API';

  final storage = FlutterSecureStorage();


 Future<List<Map<String,dynamic>>> getDepartament( BuildContext context ) async {
  AccessMap result = AccessMap();
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    messageError(context,'No hay conexión a Internet.', 'Error');
    return [];
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
    isSaving = true;
    notifyListeners();
    final url = Uri.parse('https://www.comunicadosaraiza.com/portal_api/API/Users/userLogin.php?departamento=true');
    var response = (await http.get(url)).body;
      final result = AccessMap.fromJson(jsonDecode(response));
    // var response = await http.post(url, body: {'pass': pass, 'departament': departament});
    if (result.status == 200){
      isSaving = false;
      notifyListeners();
      return result.container!;
    }else{
     // messageError(context,'Contraseña incorrecta.');
    }

    isSaving = false;
    notifyListeners();
    return []; 
  } on SocketException catch (e) {
    // Error de conexión de red (sin conexión a Internet)
    messageError(context,'Error de conexión de red: $e','Error');
    return []; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    messageError(context,'Error de la solicitud HTTP: $e','Error');
    return []; 
  } catch (e) {
    // Otro tipo de error
    messageError(context,'Error inesperado: $e','Error');
    return []; 
  }
  }
  // messageError(context,'Error desconocido.');
    return []; 
  } 

Future<List<Map<String,dynamic>>> getOneExamPart1(int idExam, BuildContext context ) async {
  AccessMap result = AccessMap();
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    messageError(context,'No hay conexión a Internet.', 'Error');
    return [];
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
    isSaving = true;
    notifyListeners();
    final url = Uri.parse('$link/medical_exam.php?getOneExamPart1=true');
    var response = (await http.post(url, body: json.encode([idExam, await storage.read(key: 'idHotelRegister')]),headers: {HttpHeaders.contentTypeHeader: "application/json"})).body;
    final result = AccessMap.fromJson(jsonDecode(response));
    if (result.status == 200){
      isSaving = false;
      notifyListeners();
      return result.container!;
    }else{
     // messageError(context,'Contraseña incorrecta.');
    }

    isSaving = false;
    notifyListeners();
    return []; 
  } on SocketException catch (e) {
    // Error de conexión de red (sin conexión a Internet)
    messageError(context,'Error de conexión de red: $e','Error');
    return []; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    messageError(context,'Error de la solicitud HTTP: $e','Error');
    return []; 
  } catch (e) {
    // Otro tipo de error
    messageError(context,'Error inesperado: $e','Error');
    return []; 
  }
  }
  // messageError(context,'Error desconocido.');
    return []; 
  } 

Future<List<Map<String,dynamic>>> getExamAcciddentDisease(int idExam, BuildContext context ) async {
  AccessMap result = AccessMap();
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    messageError(context,'No hay conexión a Internet.', 'Error');
    return [];
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
    isSaving = true;
    notifyListeners();
    final url = Uri.parse('$link/medical_exam.php?getExamAcciddentDisease=true');
    var response = (await http.post(url, body: json.encode([idExam]),headers: {HttpHeaders.contentTypeHeader: "application/json"})).body;
    final result = AccessMap.fromJson(jsonDecode(response));
    // var response = await http.post(url, body: {'pass': pass, 'departament': departament});
    if (result.status == 200){
      isSaving = false;
      notifyListeners();
      return result.container!;
    }else{
     // messageError(context,'Contraseña incorrecta.');
    }

    isSaving = false;
    notifyListeners();
    return []; 
  } on SocketException catch (e) {
    // Error de conexión de red (sin conexión a Internet)
    messageError(context,'Error de conexión de red: $e','Error');
    return []; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    messageError(context,'Error de la solicitud HTTP: $e','Error');
    return []; 
  } catch (e) {
    // Otro tipo de error
    messageError(context,'Error inesperado: $e','Error');
    return []; 
  }
  }
  // messageError(context,'Error desconocido.');
    return []; 
  } 

  Future<List<Map<String,dynamic>>> getExamHeredityFam(int idExam, BuildContext context ) async {
  AccessMap result = AccessMap();
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    messageError(context,'No hay conexión a Internet.', 'Error');
    return [];
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
    isSaving = true;
    notifyListeners();
    final url = Uri.parse('$link/medical_exam.php?getExamHeredityFam=true');
    var response = (await http.post(url, body: json.encode([idExam]),headers: {HttpHeaders.contentTypeHeader: "application/json"})).body;
    final result = AccessMap.fromJson(jsonDecode(response));
    // var response = await http.post(url, body: {'pass': pass, 'departament': departament});
    if (result.status == 200){
      isSaving = false;
      notifyListeners();
      return result.container!;
    }else{
     // messageError(context,'Contraseña incorrecta.');
    }

    isSaving = false;
    notifyListeners();
    return []; 
  } on SocketException catch (e) {
    // Error de conexión de red (sin conexión a Internet)
    messageError(context,'Error de conexión de red: $e','Error');
    return []; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    messageError(context,'Error de la solicitud HTTP: $e','Error');
    return []; 
  } catch (e) {
    // Otro tipo de error
    messageError(context,'Error inesperado: $e','Error');
    return []; 
  }
  }
  // messageError(context,'Error desconocido.');
    return []; 
  } 

  Future<List<Map<String,dynamic>>> getExamHistory(int idExam, BuildContext context ) async {
  AccessMap result = AccessMap();
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    messageError(context,'No hay conexión a Internet.', 'Error');
    return [];
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
    isSaving = true;
    notifyListeners();
    final url = Uri.parse('$link/medical_exam.php?getExamHistory=true');
    var response = (await http.post(url, body: json.encode([idExam]),headers: {HttpHeaders.contentTypeHeader: "application/json"})).body;
    final result = AccessMap.fromJson(jsonDecode(response));
    // var response = await http.post(url, body: {'pass': pass, 'departament': departament});
    if (result.status == 200){
      isSaving = false;
      notifyListeners();
      return result.container!;
    }else{
     // messageError(context,'Contraseña incorrecta.');
    }

    isSaving = false;
    notifyListeners();
    return []; 
  } on SocketException catch (e) {
    // Error de conexión de red (sin conexión a Internet)
    messageError(context,'Error de conexión de red: $e','Error');
    return []; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    messageError(context,'Error de la solicitud HTTP: $e','Error');
    return []; 
  } catch (e) {
    // Otro tipo de error
    messageError(context,'Error inesperado: $e','Error');
    return []; 
  }
  }
  // messageError(context,'Error desconocido.');
    return []; 
  } 

Future<List<Map<String,dynamic>>> getAllExamList( BuildContext context ) async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    messageError(context,'No hay conexión a Internet.', 'Error');
    return [];
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
    isSaving = true;
    notifyListeners();
    final url = Uri.parse('$link/medical_exam.php?ExamList=true');
    final local = await storage.read(key: 'idHotelRegister');
    var response = (await http.post(url,body: json.encode([local]))).body;
    final result = AccessMap.fromJson(jsonDecode(response));
    // var response = await http.post(url, body: {'pass': pass, 'departament': departament});
    if (result.status == 200){
      isSaving = false;
      notifyListeners();
      return result.container!;
    }else{
     // messageError(context,'Contraseña incorrecta.');
    }

    isSaving = false;
    notifyListeners();
    return []; 
  } on SocketException catch (e) {
    // Error de conexión de red (sin conexión a Internet)
    messageError(context,'Error de conexión de red: $e','Error');
    return []; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    messageError(context,'Error de la solicitud HTTP: $e','Error');
    return []; 
  } catch (e) {
    // Otro tipo de error
    messageError(context,'Error inesperado: $e','Error');
    return []; 
  }
  }
  // messageError(context,'Error desconocido.');
    return []; 
  } 

  Future<List<Map<String,dynamic>>> getAllExamListSearch_paginator( BuildContext context, int search,int amount,String word) async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    messageError(context,'No hay conexión a Internet.', 'Error');
    return [];
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
    isSaving = true;
    notifyListeners();
    final url = Uri.parse('$link/medical_exam.php?get_paginator=$search');
    var response = (await http.post(url, body: json.encode({'amount': amount, 'word': word, 'local': await storage.read(key: 'idHotelRegister')}))).body;
    final result = AccessMap.fromJson(jsonDecode(response));
    if (result.status == 200){
      isSaving = false;
      notifyListeners();
      return result.container!;
    }else{
     // messageError(context,'Contraseña incorrecta.');
    }

    isSaving = false;
    notifyListeners();
    return []; 
  } on SocketException catch (e) {
    // Error de conexión de red (sin conexión a Internet)
    messageError(context,'Error de conexión de red: $e','Error');
    return []; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    messageError(context,'Error de la solicitud HTTP: $e','Error');
    return []; 
  } catch (e) {
    // Otro tipo de error
    messageError(context,'Error inesperado: $e','Error');
    return []; 
  }
  }
  // messageError(context,'Error desconocido.');
    return []; 
  } 


  Future<List<Map<String,dynamic>>> getAllExamListSearch( BuildContext context, String word ) async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    messageError(context,'No hay conexión a Internet.', 'Error');
    return [];
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
    isSaving = true;
    notifyListeners();
    final url = Uri.parse('$link/medical_exam.php?search=true');
    var response = (await http.post(url, body: json.encode([word, await storage.read(key: 'idHotelRegister')]))).body;
      final result = AccessMap.fromJson(jsonDecode(response));
    // var response = await http.post(url, body: {'pass': pass, 'departament': departament});
    if (result.status == 200){
      isSaving = false;
      notifyListeners();
      return result.container!;
    }else{
     // messageError(context,'Contraseña incorrecta.');
    }

    isSaving = false;
    notifyListeners();
    return []; 
  } on SocketException catch (e) {
    // Error de conexión de red (sin conexión a Internet)
    messageError(context,'Error de conexión de red: $e','Error');
    return []; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    messageError(context,'Error de la solicitud HTTP: $e','Error');
    return []; 
  } catch (e) {
    // Otro tipo de error
    messageError(context,'Error inesperado: $e','Error');
    return []; 
  }
  }
  // messageError(context,'Error desconocido.');
    return []; 
  } 

Future<List<Map<String,dynamic>>> getAllPagesPaginator( BuildContext context, int search,int amount,String word ) async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    messageError(context,'No hay conexión a Internet.', 'Error');
    return [];
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
    isSaving = true;
    notifyListeners();
    final url = Uri.parse('$link/medical_exam.php?allPagesPaginator=$search');
    var response = (await http.post(url, body: json.encode({'amount': amount, 'word': word, 'local': await storage.read(key: 'idHotelRegister')}))).body;    
    final result = AccessMap.fromJson(jsonDecode(response));
    if (result.status == 200){
      isSaving = false;
      notifyListeners();
      return result.container!;
    }else{
     // messageError(context,'Contraseña incorrecta.');
    }

    isSaving = false;
    notifyListeners();
    return []; 
  } on SocketException catch (e) {
    // Error de conexión de red (sin conexión a Internet)
    messageError(context,'Error de conexión de red: $e','Error');
    return []; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    messageError(context,'Error de la solicitud HTTP: $e','Error');
    return []; 
  } catch (e) {
    // Otro tipo de error
    messageError(context,'Error inesperado: $e','Error');
    return []; 
  }
  }
  // messageError(context,'Error desconocido.');
    return []; 
  } 


Future<AccessMap> post_examMa( ExamMaModel obj,BuildContext context ) async {
  AccessMap result = AccessMap();
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    messageError(context,'No hay conexión a Internet.', 'Error');
    return result;
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
    final url = Uri.parse('$link/medical_exam.php?post_examMa=true');
    var response = (await http.post(url, body: json.encode(obj.toJson()),headers: {HttpHeaders.contentTypeHeader: "application/json"})).body;
    final result = AccessMap.fromJson(jsonDecode(response));
    if (result.status == 200) {
      isSaving = true;
      notifyListeners();
      return result;
    }
     
    isSaving = false;
    notifyListeners();
    return result; 
  } on SocketException catch (e) {
    // Error de conexión de red (sin conexión a Internet)
    messageError(context,'Error de conexión de red: $e','Error');
    return result; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    messageError(context,'Error de la solicitud HTTP: $e','Error');
    return result; 
  } catch (e) {
    // Otro tipo de error
    messageError(context,'Error inesperado: $e','Error');
    return result; 
  }
  }
    return result; 
  }

 Future<AccessMap> post_examDe(ExamDeModel obj ,BuildContext context ) async {
  AccessMap result = AccessMap();
  var connectivityResult = await (Connectivity().checkConnectivity());

  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    messageError(context,'No hay conexión a Internet.', 'Error');
    return result;
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
    final url = Uri.parse('$link/medical_exam.php?post_examDe=true');
    var response = (await http.post(url, body: json.encode(obj.toJson()),headers: {HttpHeaders.contentTypeHeader: "application/json"})).body;
    final result = AccessMap.fromJson(jsonDecode(response));
    if (result.status == 200) {
      return result;
    }
     
    isSaving = false;
    notifyListeners();
    return result; 
  } on SocketException catch (e) {
    // Error de conexión de red (sin conexión a Internet)
    messageError(context,'Error de conexión de red: $e','Error');
    return result; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    messageError(context,'Error de la solicitud HTTP: $e','Error');
    return result; 
  } catch (e) {
    // Otro tipo de error
    messageError(context,'Error inesperado: $e','Error');
    return result; 
  }
  }
    return result; 
  } 

  Future<AccessMap> post_examAc(ExamAcModel obj, int idFake,BuildContext context ) async {
  AccessMap result = AccessMap();
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    messageError(context,'No hay conexión a Internet.', 'Error');
    return result;
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
    final url = Uri.parse('$link/medical_exam.php?post_examAc=true');
    final f = json.encode(obj.toJson());
    // Decodifica el JSON a un objeto Dart
    Map<String, dynamic> decodedJson = json.decode(f);
    // Agrega la nueva variable
    decodedJson['idFake'] = idFake;
    // Codifica nuevamente el objeto Dart en JSON
    final nuevoJson = json.encode(decodedJson);
    var response = (await http.post(url, body: nuevoJson,headers: {HttpHeaders.contentTypeHeader: "application/json"})).body;
    final result = AccessMap.fromJson(jsonDecode(response));
    if (result.status == 200) {
 
      notifyListeners();
      return result;
    }
     
    isSaving = false;
    notifyListeners();
    return result; 
  } on SocketException catch (e) {
    // Error de conexión de red (sin conexión a Internet)
    messageError(context,'Error de conexión de red: $e','Error');
    return result; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    messageError(context,'Error de la solicitud HTTP: $e','Error');
    return result; 
  } catch (e) {
    // Otro tipo de error
    messageError(context,'Error inesperado: $e','Error');
    return result; 
  }
  }
    return result; 
  } 

  Future<AccessMap> post_examAp(ExamApModel obj,BuildContext context ) async {
  AccessMap result = AccessMap();
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    messageError(context,'No hay conexión a Internet.', 'Error');
    return result;
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
    final url = Uri.parse('$link/medical_exam.php?post_examAp=true');
    var response = (await http.post(url, body: json.encode(obj.toJson()),headers: {HttpHeaders.contentTypeHeader: "application/json"})).body;
    final result = AccessMap.fromJson(jsonDecode(response));
    if (result.status == 200) {
      return result;
    }
     
    isSaving = false;
    notifyListeners();
    return result; 
  } on SocketException catch (e) {
    // Error de conexión de red (sin conexión a Internet)
    messageError(context,'Error de conexión de red: $e','Error');
    return result; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    messageError(context,'Error de la solicitud HTTP: $e','Error');
    return result; 
  } catch (e) {
    // Otro tipo de error
    messageError(context,'Error inesperado: $e','Error');
    return result; 
  }
  }
    return result; 
  } 

  Future<AccessMap> post_examGy(ExamGyModel obj,BuildContext context ) async {
  AccessMap result = AccessMap();
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    messageError(context,'No hay conexión a Internet.', 'Error');
    return result;
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
    final url = Uri.parse('$link/medical_exam.php?post_examGy=true');
    var response = (await http.post(url, body: json.encode(obj.toJson()),headers: {HttpHeaders.contentTypeHeader: "application/json"})).body;
    final result = AccessMap.fromJson(jsonDecode(response));
    if (result.status == 200) {
      return result;
    }
     
    isSaving = false;
    notifyListeners();
    return result; 
  } on SocketException catch (e) {
    // Error de conexión de red (sin conexión a Internet)
    messageError(context,'Error de conexión de red: $e','Error');
    return result; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    messageError(context,'Error de la solicitud HTTP: $e','Error');
    return result; 
  } catch (e) {
    // Otro tipo de error
    messageError(context,'Error inesperado: $e','Error');
    return result; 
  }
  }
    return result; 
  } 

  Future<AccessMap> post_examHeF(List<int> obj ,BuildContext context ) async {
  AccessMap result = AccessMap();
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    messageError(context,'No hay conexión a Internet.', 'Error');
    return result;
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
    final url = Uri.parse('$link/medical_exam.php?post_examHeF=true');
    var response = (await http.post(url, body: json.encode(obj),headers: {HttpHeaders.contentTypeHeader: "application/json"})).body;
    final result = AccessMap.fromJson(jsonDecode(response));
    if (result.status == 200) {
      return result;
    }
     
    isSaving = false;
    notifyListeners();
    return result; 
  } on SocketException catch (e) {
    // Error de conexión de red (sin conexión a Internet)
    messageError(context,'Error de conexión de red: $e','Error');
    return result; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    messageError(context,'Error de la solicitud HTTP: $e','Error');
    return result; 
  } catch (e) {
    // Otro tipo de error
    messageError(context,'Error inesperado: $e','Error');
    return result; 
  }
  }
    return result; 
  } 

  Future<AccessMap> post_examHeP(ExamHePModel obj,BuildContext context ) async {
  AccessMap result = AccessMap();
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    messageError(context,'No hay conexión a Internet.', 'Error');
    return result;
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
    final url = Uri.parse('$link/medical_exam.php?post_examHeP=true');
    var response = (await http.post(url, body: json.encode(obj.toJson()),headers: {HttpHeaders.contentTypeHeader: "application/json"})).body;
    final result = AccessMap.fromJson(jsonDecode(response));
    if (result.status == 200) {
      return result;
    }
     
    isSaving = false;
    notifyListeners();
    return result; 
  } on SocketException catch (e) {
    // Error de conexión de red (sin conexión a Internet)
    messageError(context,'Error de conexión de red: $e','Error');
    return result; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    messageError(context,'Error de la solicitud HTTP: $e','Error');
    return result; 
  } catch (e) {
    // Otro tipo de error
    messageError(context,'Error inesperado: $e','Error');
    return result; 
  }
  }
    return result; 
  } 

  Future<AccessMap> post_examHi(ExamHiModel obj, int idFake,BuildContext context ) async {
  AccessMap result = AccessMap();
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    messageError(context,'No hay conexión a Internet.', 'Error');
    return result;
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
  
    final url = Uri.parse('$link/medical_exam.php?post_examHi=true');
    final f = json.encode(obj.toJson());
    // Decodifica el JSON a un objeto Dart
    Map<String, dynamic> decodedJson = json.decode(f);
    // Agrega la nueva variable
    decodedJson['idFake'] = idFake;
    // Codifica nuevamente el objeto Dart en JSON
    final nuevoJson = json.encode(decodedJson);
    var response = (await http.post(url, body: nuevoJson,headers: {HttpHeaders.contentTypeHeader: "application/json"})).body;
    final result = AccessMap.fromJson(jsonDecode(response));
    if (result.status == 200) {
      notifyListeners();
      return result;
    }
     
    isSaving = false;
    notifyListeners();
    return result; 
  } on SocketException catch (e) {
    // Error de conexión de red (sin conexión a Internet)
    messageError(context,'Error de conexión de red: $e','Error');
    return result; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    messageError(context,'Error de la solicitud HTTP: $e','Error');
    return result; 
  } catch (e) {
    // Otro tipo de error
    messageError(context,'Error inesperado: $e','Error');
    return result; 
  }
  }
    return result; 
  } 

  Future<AccessMap> post_examIm( ExamImModel obj,BuildContext context ) async {
  AccessMap result = AccessMap();
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    messageError(context,'No hay conexión a Internet.', 'Error');
    return result;
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
    final url = Uri.parse('$link/medical_exam.php?post_examIm=true');
    var response = (await http.post(url, body: json.encode(obj.toJson()),headers: {HttpHeaders.contentTypeHeader: "application/json"})).body;
    final result = AccessMap.fromJson(jsonDecode(response));
    if (result.status == 200) {
      return result;
    }
     
    isSaving = false;
    notifyListeners();
    return result; 
  } on SocketException catch (e) {
    // Error de conexión de red (sin conexión a Internet)
    messageError(context,'Error de conexión de red: $e','Error');
    return result; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    messageError(context,'Error de la solicitud HTTP: $e','Error');
    return result; 
  } catch (e) {
    // Otro tipo de error
    messageError(context,'Error inesperado: $e','Error');
    return result; 
  }
  }
    return result; 
  } 

  Future<AccessMap> post_examLa(ExamLaModel obj,BuildContext context ) async {
  AccessMap result = AccessMap();
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    messageError(context,'No hay conexión a Internet.', 'Error');
    return result;
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
    final url = Uri.parse('$link/medical_exam.php?post_examLa=true');
    var response = (await http.post(url, body: json.encode(obj.toJson()),headers: {HttpHeaders.contentTypeHeader: "application/json"})).body;
    final result = AccessMap.fromJson(jsonDecode(response));
    if (result.status == 200) {
      return result;
    }
     
    isSaving = false;
    notifyListeners();
    return result; 
  } on SocketException catch (e) {
    // Error de conexión de red (sin conexión a Internet)
    messageError(context,'Error de conexión de red: $e','Error');
    return result; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    messageError(context,'Error de la solicitud HTTP: $e','Error');
    return result; 
  } catch (e) {
    // Otro tipo de error
    messageError(context,'Error inesperado: $e','Error');
    return result; 
  }
  }
    return result; 
  } 

  Future<AccessMap> post_examIn(ExamInModel obj,BuildContext context ) async {
  AccessMap result = AccessMap();
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    messageError(context,'No hay conexión a Internet.', 'Error');
    return result;
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
    final url = Uri.parse('$link/medical_exam.php?post_examIn=true');
    var response = (await http.post(url, body: json.encode(obj.toJson()),headers: {HttpHeaders.contentTypeHeader: "application/json"})).body;
    final result = AccessMap.fromJson(jsonDecode(response));
    if (result.status == 200) {
      return result;
    }
     
    isSaving = false;
    notifyListeners();
    return result; 
  } on SocketException catch (e) {
    // Error de conexión de red (sin conexión a Internet)
    messageError(context,'Error de conexión de red: $e','Error');
    return result; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    messageError(context,'Error de la solicitud HTTP: $e','Error');
    return result; 
  } catch (e) {
    // Otro tipo de error
    messageError(context,'Error inesperado: $e','Error');
    return result; 
  }
  }
    return result; 
  } 

  Future<AccessMap> post_examPa( ExamPaModel obj,BuildContext context ) async {
  AccessMap result = AccessMap();
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    messageError(context,'No hay conexión a Internet.', 'Error');
    return result;
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
  
    final url = Uri.parse('$link/medical_exam.php?post_examPa=true');
    var response = (await http.post(url, body: json.encode(obj.toJson()),headers: {HttpHeaders.contentTypeHeader: "application/json"})).body;
    final result = AccessMap.fromJson(jsonDecode(response));
    if (result.status == 200) {
      return result;
    }
     
    isSaving = false;
    notifyListeners();
    return result; 
  } on SocketException catch (e) {
    // Error de conexión de red (sin conexión a Internet)
    messageError(context,'Error de conexión de red: $e','Error');
    return result; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    messageError(context,'Error de la solicitud HTTP: $e','Error');
    return result; 
  } catch (e) {
    // Otro tipo de error
    messageError(context,'Error inesperado: $e','Error');
    return result; 
  }
  }
    return result; 
  } 

  Future<AccessMap> post_examPe( ExamPeModel obj,BuildContext context ) async {
  AccessMap result = AccessMap();
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    messageError(context,'No hay conexión a Internet.', 'Error');
    return result;
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
    final url = Uri.parse('$link/medical_exam.php?post_examPe=true');
    var response = (await http.post(url, body: json.encode(obj.toJson()),headers: {HttpHeaders.contentTypeHeader: "application/json"})).body;
    final result = AccessMap.fromJson(jsonDecode(response));
    if (result.status == 200) {
      return result;
    }
     
    isSaving = false;
    notifyListeners();
    return result; 
  } on SocketException catch (e) {
    // Error de conexión de red (sin conexión a Internet)
    messageError(context,'Error de conexión de red: $e','Error');
    return result; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    messageError(context,'Error de la solicitud HTTP: $e','Error');
    return result; 
  } catch (e) {
    // Otro tipo de error
    messageError(context,'Error inesperado: $e','Error');
    return result; 
  }
  }
    return result; 
  } 

  Future<AccessMap> post_examPhX(ExamPhXModel obj,BuildContext context ) async {
  AccessMap result = AccessMap();
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    messageError(context,'No hay conexión a Internet.', 'Error');
    return result;
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
    final url = Uri.parse('$link/medical_exam.php?post_examPhX=true');
    var response = (await http.post(url, body: json.encode(obj.toJson()),headers: {HttpHeaders.contentTypeHeader: "application/json"})).body;
    final result = AccessMap.fromJson(jsonDecode(response));
    if (result.status == 200) {
      return result;
    }
     
    isSaving = false;
    notifyListeners();
    return result; 
  } on SocketException catch (e) {
    // Error de conexión de red (sin conexión a Internet)
    messageError(context,'Error de conexión de red: $e','Error');
    return result; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    messageError(context,'Error de la solicitud HTTP: $e','Error');
    return result; 
  } catch (e) {
    // Otro tipo de error
    messageError(context,'Error inesperado: $e','Error');
    return result; 
  }
  }
    return result; 
  } 

  Future<AccessMap> post_examPhY( ExamPhYModel obj,BuildContext context ) async {
  AccessMap result = AccessMap();
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    messageError(context,'No hay conexión a Internet.', 'Error');
    return result;
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
    final url = Uri.parse('$link/medical_exam.php?post_examPhY=true');
    var response = (await http.post(url, body: json.encode(obj.toJson()),headers: {HttpHeaders.contentTypeHeader: "application/json"})).body;
    final result = AccessMap.fromJson(jsonDecode(response));
    if (result.status == 200) {
      return result;
    }
     
    isSaving = false;
    notifyListeners();
    return result; 
  } on SocketException catch (e) {
    // Error de conexión de red (sin conexión a Internet)
    messageError(context,'Error de conexión de red: $e','Error');
    return result; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    messageError(context,'Error de la solicitud HTTP: $e','Error');
    return result; 
  } catch (e) {
    // Otro tipo de error
    messageError(context,'Error inesperado: $e','Error');
    return result; 
  }
  }
    return result; 
  } 

///ACTUALIZACION

patch_updateExam( int idExam ,BuildContext context ) async {
  AccessMap result = AccessMap();

  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    messageError(context,'No hay conexión a Internet.', 'Error');
    return result;
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
try {
    final url = Uri.parse('$link/medical_exam.php?timeModification_exam=$idExam');
    var response = (await http.patch(url, headers: {HttpHeaders.contentTypeHeader: "application/json"})).body;
    final result = AccessMap.fromJson(jsonDecode(response));
    if (result.status == 200) {
      return result;
    }
     
    isSaving = false;
    notifyListeners();
    return result; 
  } on SocketException catch (e) {
    // Error de conexión de red (sin conexión a Internet)
    messageError(context,'Error de conexión de red: $e','Error');
    return result; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    messageError(context,'Error de la solicitud HTTP: $e','Error');
    return result; 
  } catch (e) {
    // Otro tipo de error
    messageError(context,'Error inesperado: $e','Error');
    return result; 
  }
  }
    return result;     
  }

  patch_examIn( ExamInModel obj,int idExam ,BuildContext context ) async {
  AccessMap result = AccessMap();

  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    messageError(context,'No hay conexión a Internet.', 'Error');
    return result;
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
  try {
    final url = Uri.parse('$link/medical_exam.php?patch_examIn=true');
    final f = json.encode(obj.toJson());
    // Decodifica el JSON a un objeto Dart
    Map<String, dynamic> decodedJson = json.decode(f);
    // Agrega la nueva variable
    decodedJson['idExam'] = idExam;
    // Codifica nuevamente el objeto Dart en JSON
    final nuevoJson = json.encode(decodedJson);
    var response = (await http.patch(url, body: nuevoJson,headers: {HttpHeaders.contentTypeHeader: "application/json"})).body;
    
    final result = AccessMap.fromJson(jsonDecode(response));
    if (result.status == 200) {
      await patch_updateExam(idExam, context); 
      return result;
    }
     
    isSaving = false;
    notifyListeners();
    return result; 
  } on SocketException catch (e) {
    // Error de conexión de red (sin conexión a Internet)
    messageError(context,'Error de conexión de red: $e','Error');
    return result; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    messageError(context,'Error de la solicitud HTTP: $e','Error');
    return result; 
  } catch (e) {
    // Otro tipo de error
    messageError(context,'Error inesperado: $e','Error');
    return result; 
  }
  }
    return result;     
  }

  patch_examPe(ExamPeModel obj ,int idExam, BuildContext context ) async {
    AccessMap result = AccessMap();
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    messageError(context,'No hay conexión a Internet.', 'Error');
    return result;
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
    final url = Uri.parse('$link/medical_exam.php?patch_examPe=true');
    final f = json.encode(obj.toJson());
    // Decodifica el JSON a un objeto Dart
    Map<String, dynamic> decodedJson = json.decode(f);
    // Agrega la nueva variable
    decodedJson['idExam'] = idExam;
    // Codifica nuevamente el objeto Dart en JSON
    final nuevoJson = json.encode(decodedJson);
    var response = (await http.patch(url, body: nuevoJson,headers: {HttpHeaders.contentTypeHeader: "application/json"})).body;
    final result = AccessMap.fromJson(jsonDecode(response));
    if (result.status == 200) {
      await patch_updateExam(idExam, context); 
      return result;
    }
     
    isSaving = false;
    notifyListeners();
    return result; 
  } on SocketException catch (e) {
    // Error de conexión de red (sin conexión a Internet)
    messageError(context,'Error de conexión de red: $e','Error');
    return result; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    messageError(context,'Error de la solicitud HTTP: $e','Error');
    return result; 
  } catch (e) {
    // Otro tipo de error
    messageError(context,'Error inesperado: $e','Error');
    return result; 
  }
  }
    return result; 
  }

  patch_examHeP(ExamHePModel obj,int idExam, BuildContext context ) async {
    AccessMap result = AccessMap();
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    messageError(context,'No hay conexión a Internet.', 'Error');
    return result;
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
    final url = Uri.parse('$link/medical_exam.php?patch_examHeP=true');
    final f = json.encode(obj.toJson());
    // Decodifica el JSON a un objeto Dart
    Map<String, dynamic> decodedJson = json.decode(f);
    // Agrega la nueva variable
    decodedJson['idExam'] = idExam;
    // Codifica nuevamente el objeto Dart en JSON
    final nuevoJson = json.encode(decodedJson);
    var response = (await http.patch(url, body: nuevoJson,headers: {HttpHeaders.contentTypeHeader: "application/json"})).body;
    final result = AccessMap.fromJson(jsonDecode(response));
    if (result.status == 200) {
      await patch_updateExam(idExam, context); 
      return result;
    }
     
    isSaving = false;
    notifyListeners();
    return result; 
  } on SocketException catch (e) {
    // Error de conexión de red (sin conexión a Internet)
    messageError(context,'Error de conexión de red: $e','Error');
    return result; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    messageError(context,'Error de la solicitud HTTP: $e','Error');
    return result; 
  } catch (e) {
    // Otro tipo de error
    messageError(context,'Error inesperado: $e','Error');
    return result; 
  }
  }
    return result; 
  }

  patch_examGy(ExamGyModel obj,int idExam, BuildContext context ) async {
    AccessMap result = AccessMap();
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    messageError(context,'No hay conexión a Internet.', 'Error');
    return result;
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
    final url = Uri.parse('$link/medical_exam.php?patch_examGy=true');
    final f = json.encode(obj.toJson());
    // Decodifica el JSON a un objeto Dart
    Map<String, dynamic> decodedJson = json.decode(f);
    // Agrega la nueva variable
    decodedJson['idExam'] = idExam;
    // Codifica nuevamente el objeto Dart en JSON
    final nuevoJson = json.encode(decodedJson);
    var response = (await http.patch(url, body: nuevoJson,headers: {HttpHeaders.contentTypeHeader: "application/json"})).body;
    final result = AccessMap.fromJson(jsonDecode(response));
    if (result.status == 200) {
        patch_updateExam(idExam, context); 
      return result;
    }
     
    isSaving = false;
    notifyListeners();
    return result; 
  } on SocketException catch (e) {
    // Error de conexión de red (sin conexión a Internet)
    messageError(context,'Error de conexión de red: $e','Error');
    return result; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    messageError(context,'Error de la solicitud HTTP: $e','Error');
    return result; 
  } catch (e) {
    // Otro tipo de error
    messageError(context,'Error inesperado: $e','Error');
    return result; 
  }
  }
    return result; 
  }

  patch_examPa(ExamPaModel obj,int idExam, BuildContext context ) async {
    AccessMap result = AccessMap();
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    messageError(context,'No hay conexión a Internet.', 'Error');
    return result;
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
    final url = Uri.parse('$link/medical_exam.php?patch_examPa=true');

    final f = json.encode(obj.toJson());
    // Decodifica el JSON a un objeto Dart
    Map<String, dynamic> decodedJson = json.decode(f);
    // Agrega la nueva variable
    decodedJson['idExam'] = idExam;
    // Codifica nuevamente el objeto Dart en JSON
    final nuevoJson = json.encode(decodedJson);
    var response = (await http.patch(url, body: nuevoJson,headers: {HttpHeaders.contentTypeHeader: "application/json"})).body;
    final result = AccessMap.fromJson(jsonDecode(response));
    if (result.status == 200) {
      await patch_updateExam(idExam, context); 
      return result;
    }
     
    isSaving = false;
    notifyListeners();
    return result; 
  } on SocketException catch (e) {
    // Error de conexión de red (sin conexión a Internet)
    messageError(context,'Error de conexión de red: $e','Error');
    return result; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    messageError(context,'Error de la solicitud HTTP: $e','Error');
    return result; 
  } catch (e) {
    // Otro tipo de error
    messageError(context,'Error inesperado: $e','Error');
    return result; 
  }
  }
    return result; 
  }

  patch_examAp(ExamApModel obj,int idExam, BuildContext context  ) async {
    AccessMap result = AccessMap();
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    messageError(context,'No hay conexión a Internet.', 'Error');
    return result;
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
    final url = Uri.parse('$link/medical_exam.php?patch_examAp=true');
    final f = json.encode(obj.toJson());
    // Decodifica el JSON a un objeto Dart
    Map<String, dynamic> decodedJson = json.decode(f);
    // Agrega la nueva variable
    decodedJson['idExam'] = idExam;
    // Codifica nuevamente el objeto Dart en JSON
    final nuevoJson = json.encode(decodedJson);
    var response = (await http.patch(url, body: nuevoJson,headers: {HttpHeaders.contentTypeHeader: "application/json"})).body;
    final result = AccessMap.fromJson(jsonDecode(response));
    if (result.status == 200) {
      await patch_updateExam(idExam, context); 
      return result;
    }
     
    isSaving = false;
    notifyListeners();
    return result; 
  } on SocketException catch (e) {
    // Error de conexión de red (sin conexión a Internet)
    messageError(context,'Error de conexión de red: $e','Error');
    return result; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    messageError(context,'Error de la solicitud HTTP: $e','Error');
    return result; 
  } catch (e) {
    // Otro tipo de error
    messageError(context,'Error inesperado: $e','Error');
    return result; 
  }
  }
    return result; 
  }

  patch_examPhX(ExamPhXModel obj,int idExam, BuildContext context ) async {
    AccessMap result = AccessMap();
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    messageError(context,'No hay conexión a Internet.', 'Error');
    return result;
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
    final url = Uri.parse('$link/medical_exam.php?patch_examPhX=true');
    final f = json.encode(obj.toJson());
    // Decodifica el JSON a un objeto Dart
    Map<String, dynamic> decodedJson = json.decode(f);
    // Agrega la nueva variable
    decodedJson['idExam'] = idExam;
    // Codifica nuevamente el objeto Dart en JSON
    final nuevoJson = json.encode(decodedJson);
    var response = (await http.patch(url, body: nuevoJson,headers: {HttpHeaders.contentTypeHeader: "application/json"})).body;
    final result = AccessMap.fromJson(jsonDecode(response));
    if (result.status == 200) {
      await patch_updateExam(idExam, context); 
      return result;
    }
     
    isSaving = false;
    notifyListeners();
    return result; 
  } on SocketException catch (e) {
    // Error de conexión de red (sin conexión a Internet)
    messageError(context,'Error de conexión de red: $e','Error');
    return result; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    messageError(context,'Error de la solicitud HTTP: $e','Error');
    return result; 
  } catch (e) {
    // Otro tipo de error
    messageError(context,'Error inesperado: $e','Error');
    return result; 
  }
  }
    return result; 
  }

  patch_examPhY(ExamPhYModel obj,int idExam, BuildContext context ) async {
    AccessMap result = AccessMap();
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    messageError(context,'No hay conexión a Internet.', 'Error');
    return result;
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
    final url = Uri.parse('$link/medical_exam.php?patch_examPhY=true');
    final f = json.encode(obj.toJson());
    // Decodifica el JSON a un objeto Dart
    Map<String, dynamic> decodedJson = json.decode(f);
    // Agrega la nueva variable
    decodedJson['idExam'] = idExam;
    // Codifica nuevamente el objeto Dart en JSON
    final nuevoJson = json.encode(decodedJson);
    var response = (await http.patch(url, body: nuevoJson,headers: {HttpHeaders.contentTypeHeader: "application/json"})).body;
    final result = AccessMap.fromJson(jsonDecode(response));
    if (result.status == 200) {
      await patch_updateExam(idExam, context); 
      return result;
    }
     
    isSaving = false;
    notifyListeners();
    return result; 
  } on SocketException catch (e) {
    // Error de conexión de red (sin conexión a Internet)
    messageError(context,'Error de conexión de red: $e','Error');
    return result; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    messageError(context,'Error de la solicitud HTTP: $e','Error');
    return result; 
  } catch (e) {
    // Otro tipo de error
    messageError(context,'Error inesperado: $e','Error');
    return result; 
  }
  }
    return result; 
  }

  patch_examLa( ExamLaModel obj,int idExam, BuildContext context ) async {
    AccessMap result = AccessMap();
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    messageError(context,'No hay conexión a Internet.', 'Error');
    return result;
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
    final url = Uri.parse('$link/medical_exam.php?patch_examLa=true');
    final f = json.encode(obj.toJson());
    // Decodifica el JSON a un objeto Dart
    Map<String, dynamic> decodedJson = json.decode(f);
    // Agrega la nueva variable
    decodedJson['idExam'] = idExam;
    // Codifica nuevamente el objeto Dart en JSON
    final nuevoJson = json.encode(decodedJson);
    var response = (await http.patch(url, body: nuevoJson,headers: {HttpHeaders.contentTypeHeader: "application/json"})).body;
    final result = AccessMap.fromJson(jsonDecode(response));
    if (result.status == 200) {
      await patch_updateExam(idExam, context); 
      return result;
    }
     
    isSaving = false;
    notifyListeners();
    return result; 
  } on SocketException catch (e) {
    // Error de conexión de red (sin conexión a Internet)
    messageError(context,'Error de conexión de red: $e','Error');
    return result; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    messageError(context,'Error de la solicitud HTTP: $e','Error');
    return result; 
  } catch (e) {
    // Otro tipo de error
    messageError(context,'Error inesperado: $e','Error');
    return result; 
  }
  }
    return result; 
  }

  patch_examIm(ExamImModel obj,int idExam, BuildContext context ) async {
    AccessMap result = AccessMap();
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    messageError(context,'No hay conexión a Internet.', 'Error');
    return result;
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
    final url = Uri.parse('$link/medical_exam.php?patch_examIm=true');
    final f = json.encode(obj.toJson());
    // Decodifica el JSON a un objeto Dart
    Map<String, dynamic> decodedJson = json.decode(f);
    // Agrega la nueva variable
    decodedJson['idExam'] = idExam;
    // Codifica nuevamente el objeto Dart en JSON
    final nuevoJson = json.encode(decodedJson);
    var response = (await http.patch(url, body: nuevoJson,headers: {HttpHeaders.contentTypeHeader: "application/json"})).body;
    final result = AccessMap.fromJson(jsonDecode(response));
    if (result.status == 200) {
      await patch_updateExam(idExam, context); 
      return result;
    }
     
    isSaving = false;
    notifyListeners();
    return result; 
  } on SocketException catch (e) {
    // Error de conexión de red (sin conexión a Internet)
    messageError(context,'Error de conexión de red: $e','Error');
    return result; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    messageError(context,'Error de la solicitud HTTP: $e','Error');
    return result; 
  } catch (e) {
    // Otro tipo de error
    messageError(context,'Error inesperado: $e','Error');
    return result; 
  }
  }
    return result; 
  }

  patch_examDe(ExamDeModel obj,int idExam, BuildContext context ) async {
    AccessMap result = AccessMap();
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    messageError(context,'No hay conexión a Internet.', 'Error');
    return result;
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
    final url = Uri.parse('$link/medical_exam.php?patch_examDe=true');
    final f = json.encode(obj.toJson());
    // Decodifica el JSON a un objeto Dart
    Map<String, dynamic> decodedJson = json.decode(f);
    // Agrega la nueva variable
    decodedJson['idExam'] = idExam;
    // Codifica nuevamente el objeto Dart en JSON
    final nuevoJson = json.encode(decodedJson);
    var response = (await http.patch(url, body: nuevoJson,headers: {HttpHeaders.contentTypeHeader: "application/json"})).body;
    final result = AccessMap.fromJson(jsonDecode(response));
    if (result.status == 200) {
      await patch_updateExam(idExam, context); 
      return result;
    }
     
    isSaving = false;
    notifyListeners();
    return result; 
  } on SocketException catch (e) {
    // Error de conexión de red (sin conexión a Internet)
    messageError(context,'Error de conexión de red: $e','Error');
    return result; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    messageError(context,'Error de la solicitud HTTP: $e','Error');
    return result; 
  } catch (e) {
    // Otro tipo de error
    messageError(context,'Error inesperado: $e','Error');
    return result; 
  }
  }
    return result; 
  }

  patch_examHeF( List<int> obj ,int idExam, BuildContext context ) async {
    AccessMap result = AccessMap();
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    messageError(context,'No hay conexión a Internet.', 'Error');
    return result;
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
    obj.add(idExam);
    final url = Uri.parse('$link/medical_exam.php?patch_examHeF=true');
    var response = (await http.patch(url, body: json.encode(obj),headers: {HttpHeaders.contentTypeHeader: "application/json"})).body;
    final result = AccessMap.fromJson(jsonDecode(response));
    if (result.status == 200) {
      return result;
    }
     
    isSaving = false;
    notifyListeners();
    return result; 
  } on SocketException catch (e) {
    // Error de conexión de red (sin conexión a Internet)
    messageError(context,'Error de conexión de red: $e','Error');
    return result; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    messageError(context,'Error de la solicitud HTTP: $e','Error');
    return result; 
  } catch (e) {
    // Otro tipo de error
    messageError(context,'Error inesperado: $e','Error');
    return result; 
  }
  }
    return result; 
  }

  patch_examHi( ExamHiModel obj,int idExam, int idFake, BuildContext context ) async {
    AccessMap result = AccessMap();
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    messageError(context,'No hay conexión a Internet.', 'Error');
    return result;
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
    final url = Uri.parse('$link/medical_exam.php?patch_examHi=true');
    final f = json.encode(obj.toJson());
    // Decodifica el JSON a un objeto Dart
    Map<String, dynamic> decodedJson = json.decode(f);
    // Agrega la nueva variable
    decodedJson['idExam'] = idExam;
    decodedJson['idFake'] = idFake;
    // Codifica nuevamente el objeto Dart en JSON
    final nuevoJson = json.encode(decodedJson);
    var response = (await http.patch(url, body: nuevoJson,headers: {HttpHeaders.contentTypeHeader: "application/json"})).body;
    final result = AccessMap.fromJson(jsonDecode(response));
    if (result.status == 200) {
        await patch_updateExam(idExam, context); 
      return result;
    }
     
    isSaving = false;
    notifyListeners();
    return result; 
  } on SocketException catch (e) {
    // Error de conexión de red (sin conexión a Internet)
    messageError(context,'Error de conexión de red: $e','Error');
    return result; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    messageError(context,'Error de la solicitud HTTP: $e','Error');
    return result; 
  } catch (e) {
    // Otro tipo de error
    messageError(context,'Error inesperado: $e','Error');
    return result; 
  }
  }
    return result; 
  }

  patch_examAc(ExamAcModel obj,int idExam, int idFake, BuildContext context ) async {
    AccessMap result = AccessMap();
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    messageError(context,'No hay conexión a Internet.', 'Error');
    return result;
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
    final url = Uri.parse('$link/medical_exam.php?patch_examAc=true');
    final f = json.encode(obj.toJson());
    // Decodifica el JSON a un objeto Dart
    Map<String, dynamic> decodedJson = json.decode(f);
    // Agrega la nueva variable
    decodedJson['idExam'] = idExam;
    decodedJson['idFake'] = idFake;
    // Codifica nuevamente el objeto Dart en JSON
    final nuevoJson = json.encode(decodedJson);
    var response = (await http.patch(url, body: nuevoJson,headers: {HttpHeaders.contentTypeHeader: "application/json"})).body;
    final result = AccessMap.fromJson(jsonDecode(response));
    if (result.status == 200) {
      await patch_updateExam(idExam, context); 
      return result;
    }
     
    isSaving = false;
    notifyListeners();
    return result; 
  } on SocketException catch (e) {
    // Error de conexión de red (sin conexión a Internet)
    messageError(context,'Error de conexión de red: $e','Error');
    return result; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    messageError(context,'Error de la solicitud HTTP: $e','Error');
    return result; 
  } catch (e) {
    // Otro tipo de error
    messageError(context,'Error inesperado: $e','Error');
    return result; 
  }
  }
    return result; 
  }

  patch_examMa( ExamMaModel obj,int idExam, BuildContext context ) async {
    AccessMap result = AccessMap();
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    messageError(context,'No hay conexión a Internet.', 'Error');
    return result;
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
    final url = Uri.parse('$link/medical_exam.php?patch_examMa=true');
    final f = json.encode(obj.toJson());
    // Decodifica el JSON a un objeto Dart
    Map<String, dynamic> decodedJson = json.decode(f);
    // Agrega la nueva variable
    decodedJson['idExam'] = idExam;
    // Codifica nuevamente el objeto Dart en JSON
    final nuevoJson = json.encode(decodedJson);
    var response = (await http.patch(url, body: nuevoJson,headers: {HttpHeaders.contentTypeHeader: "application/json"})).body;
    final result = AccessMap.fromJson(jsonDecode(response));
    if (result.status == 200) {
      return result;
    }
     
    isSaving = false;
    notifyListeners();
    return result; 
  } on SocketException catch (e) {
    // Error de conexión de red (sin conexión a Internet)
    messageError(context,'Error de conexión de red: $e','Error');
    return result; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    messageError(context,'Error de la solicitud HTTP: $e','Error');
    return result; 
  } catch (e) {
    // Otro tipo de error
    messageError(context,'Error inesperado: $e','Error');
    return result; 
  }
  }
    return result; 
  }

  delete_examMa( int idExam, BuildContext context ) async {
    AccessMap result = AccessMap();
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    messageError(context,'No hay conexión a Internet.', 'Error');
    return result;
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
    final url = Uri.parse('$link/medical_exam.php?id=$idExam');
    var response = (await http.delete(url,headers: {HttpHeaders.contentTypeHeader: "application/json"})).body;
    final result = AccessMap.fromJson(jsonDecode(response));
    if (result.status == 200) {
      return result;
    }
     
    isSaving = false;
    notifyListeners();
    return result; 
  } on SocketException catch (e) {
    // Error de conexión de red (sin conexión a Internet)
    messageError(context,'Error de conexión de red: $e','Error');
    return result; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    messageError(context,'Error de la solicitud HTTP: $e','Error');
    return result; 
  } catch (e) {
    // Otro tipo de error
    messageError(context,'Error inesperado: $e','Error');
    return result; 
  }
  }
    return result; 
  }



}




