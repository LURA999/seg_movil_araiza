
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:app_seguimiento_movil/models/models.dart';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:app_seguimiento_movil/widgets/widgets.dart';

class ExamIniPreService extends ChangeNotifier{

  bool modoApk = kDebugMode?true:false; 
  bool isSaving = true;
  late String link = modoApk?'https://www.comunicadosaraiza.com/movil_scan_api/API':'https://www.comunicadosaraiza.com/movil_scan_api/API';



 Future<List<Map<String,dynamic>>> getDepartament( BuildContext context ) async {
  AccessMap result = AccessMap();
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    messageError(context,'No hay conexión a Internet.');
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
    messageError(context,'Error de conexión de red: $e');
    return []; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    messageError(context,'Error de la solicitud HTTP: $e');
    return []; 
  } catch (e) {
    // Otro tipo de error
    messageError(context,'Error inesperado: $e');
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
    messageError(context,'No hay conexión a Internet.');
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
    messageError(context,'Error de conexión de red 3: $e');
    return result; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    messageError(context,'Error de la solicitud 3 HTTP: $e');
    return result; 
  } catch (e) {
    // Otro tipo de error
    messageError(context,'Error inesperado 3: $e');
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
    messageError(context,'No hay conexión a Internet.');
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
    messageError(context,'Error de conexión de red: $e');
    return result; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    messageError(context,'Error de la solicitud HTTP: $e');
    return result; 
  } catch (e) {
    // Otro tipo de error
    messageError(context,'Error inesperado: $e');
    return result; 
  }
  }
    return result; 
  } 

  Future<AccessMap> post_examAc(ExamAcModel obj,BuildContext context ) async {
  AccessMap result = AccessMap();
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    messageError(context,'No hay conexión a Internet.');
    return result;
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
    final url = Uri.parse('$link/medical_exam.php?post_examAc=true');
    var response = (await http.post(url, body: json.encode(obj.toJson()),headers: {HttpHeaders.contentTypeHeader: "application/json"})).body;
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
    messageError(context,'Error de conexión de red: $e');
    return result; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    messageError(context,'Error de la solicitud HTTP: $e');
    return result; 
  } catch (e) {
    // Otro tipo de error
    messageError(context,'Error inesperado: $e');
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
    messageError(context,'No hay conexión a Internet.');
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
    messageError(context,'Error de conexión de red: $e');
    return result; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    messageError(context,'Error de la solicitud HTTP: $e');
    return result; 
  } catch (e) {
    // Otro tipo de error
    messageError(context,'Error inesperado: $e');
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
    messageError(context,'No hay conexión a Internet.');
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
    messageError(context,'Error de conexión de red: $e');
    return result; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    messageError(context,'Error de la solicitud HTTP: $e');
    return result; 
  } catch (e) {
    // Otro tipo de error
    messageError(context,'Error inesperado: $e');
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
    messageError(context,'No hay conexión a Internet.');
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
    messageError(context,'Error de conexión de red: $e');
    return result; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    messageError(context,'Error de la solicitud HTTP: $e');
    return result; 
  } catch (e) {
    // Otro tipo de error
    messageError(context,'Error inesperado: $e');
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
    messageError(context,'No hay conexión a Internet.');
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
    messageError(context,'Error de conexión de red: $e');
    return result; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    messageError(context,'Error de la solicitud HTTP: $e');
    return result; 
  } catch (e) {
    // Otro tipo de error
    messageError(context,'Error inesperado: $e');
    return result; 
  }
  }
    return result; 
  } 

  Future<AccessMap> post_examHi(ExamHiModel obj,BuildContext context ) async {
  AccessMap result = AccessMap();
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    messageError(context,'No hay conexión a Internet.');
    return result;
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
  
    final url = Uri.parse('$link/medical_exam.php?post_examHi=true');
    var response = (await http.post(url, body: json.encode(obj.toJson()),headers: {HttpHeaders.contentTypeHeader: "application/json"})).body;
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
    messageError(context,'Error de conexión de red: $e');
    return result; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    messageError(context,'Error de la solicitud HTTP: $e');
    return result; 
  } catch (e) {
    // Otro tipo de error
    messageError(context,'Error inesperado: $e');
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
    messageError(context,'No hay conexión a Internet.');
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
    messageError(context,'Error de conexión de red: $e');
    return result; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    messageError(context,'Error de la solicitud HTTP: $e');
    return result; 
  } catch (e) {
    // Otro tipo de error
    messageError(context,'Error inesperado: $e');
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
    messageError(context,'No hay conexión a Internet.');
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
    messageError(context,'Error de conexión de red: $e');
    return result; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    messageError(context,'Error de la solicitud HTTP: $e');
    return result; 
  } catch (e) {
    // Otro tipo de error
    messageError(context,'Error inesperado: $e');
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
    messageError(context,'No hay conexión a Internet.');
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
    messageError(context,'Error de conexión de red: $e');
    return result; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    messageError(context,'Error de la solicitud HTTP: $e');
    return result; 
  } catch (e) {
    // Otro tipo de error
    messageError(context,'Error inesperado: $e');
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
    messageError(context,'No hay conexión a Internet.');
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
    messageError(context,'Error de conexión de red: $e');
    return result; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    messageError(context,'Error de la solicitud HTTP: $e');
    return result; 
  } catch (e) {
    // Otro tipo de error
    messageError(context,'Error inesperado: $e');
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
    messageError(context,'No hay conexión a Internet.');
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
    messageError(context,'Error de conexión de red: $e');
    return result; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    messageError(context,'Error de la solicitud HTTP: $e');
    return result; 
  } catch (e) {
    // Otro tipo de error
    messageError(context,'Error inesperado: $e');
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
    messageError(context,'No hay conexión a Internet.');
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
    messageError(context,'Error de conexión de red: $e');
    return result; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    messageError(context,'Error de la solicitud HTTP: $e');
    return result; 
  } catch (e) {
    // Otro tipo de error
    messageError(context,'Error inesperado: $e');
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
    messageError(context,'No hay conexión a Internet.');
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
    messageError(context,'Error de conexión de red: $e');
    return result; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    messageError(context,'Error de la solicitud HTTP: $e');
    return result; 
  } catch (e) {
    // Otro tipo de error
    messageError(context,'Error inesperado: $e');
    return result; 
  }
  }
    return result; 
  } 

  


}




