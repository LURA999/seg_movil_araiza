
import 'dart:io';
import 'package:app_seguimiento_movil/models/date_excel_assistance.dart';
import 'package:app_seguimiento_movil/models/qr_assistance.dart';
import 'package:app_seguimiento_movil/services/services.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:app_seguimiento_movil/models/models.dart';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:app_seguimiento_movil/widgets/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AssistanceService extends ChangeNotifier{

  bool modoApk = kDebugMode?true:false; 
  bool isSaving = true;
  late String link = modoApk?'https://www.comunicadosaraiza.com/movil_scan_api_prueba/API':'https://www.comunicadosaraiza.com/movil_scan_api_prueba2/API';
  final storage = FlutterSecureStorage();


 Future<bool> postCloseTurnAssistance(BuildContext context) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    messageError(context,'No hay conexión a Internet.', 'Error');
    return false;
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

  try {
        isSaving = true;
        notifyListeners();
        VarProvider vh = VarProvider();
        final t2 = await vh.arrSharedPreferences();
        final url = Uri.parse('$link/turn_assistance.php?idTurn=true');
        var response = (await http.post(url, body: json.encode({'idTurn': t2["idTurn"] }))).body;
        if (response.contains('200')){  
          isSaving = false;
          notifyListeners();
          return true;
        }
        isSaving = false;
        notifyListeners();
        return false; 
      } on SocketException catch (e) {
      // Error de conexión de red (sin conexión a Internet)
      messageError(context,'Error de conexión de red: $e','Error');
        return false; 
    } on HttpException catch (e) {
      // Error de la solicitud HTTP
      messageError(context,'Error de la solicitud HTTP: $e','Error');
        return false; 
    } catch (e) {
      // Otro tipo de error
      messageError(context,'Error inesperado: $e','Error');
    }
    }
    return false; 
  }


Future<bool> postObvAssistance(TurnAssistance t,BuildContext context) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    messageError(context,'No hay conexión a Internet.', 'Error');
    return false;
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
      isSaving = true;
      notifyListeners();
      VarProvider vh = VarProvider();
      final t2 = await vh.arrSharedPreferences();
      t.idTurn= t2["idTurn"];
      final url = Uri.parse('$link/turn_assistance.php');
      var response = (await http.post(url, body: json.encode(t.toJson()),headers: {HttpHeaders.contentTypeHeader: "application/json"})).body;
      
      if (response.contains('200')){  
        isSaving = false;
        notifyListeners();
        return true;
      }
      isSaving = false;
      notifyListeners();
      return false; 
      } on SocketException catch (e) {
    // Error de conexión de red (sin conexión a Internet)
    messageError(context,'Error de conexión de red: $e','Error');
      return false; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    messageError(context,'Error de la solicitud HTTP: $e','Error');
      return false; 
  } catch (e) {
    // Otro tipo de error
    messageError(context,'Error inesperado: $e','Error');
      return false; 
  }
  }
      return false; 
    }

  Future<AccessMap> postTurnAssistance( TurnAssistance session,BuildContext context ) async {
  AccessMap result = AccessMap();
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    messageError(context,'No hay conexión a Internet.', 'Error');
    return result;
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
    final url = Uri.parse('$link/turn_assistance.php');
    session.local =  (await storage.read(key: 'idHotelRegister'));
    var response = (await http.post(url, body: json.encode(session.toJson()),headers: {HttpHeaders.contentTypeHeader: "application/json"})).body;
    final result = AccessMap.fromJson(jsonDecode(response));
    if (result.status == 200) {
      final sm = SessionManager();
      final key = encrypt.Key.fromUtf8('Amxlaraizaoteles');
      final iv = encrypt.IV.fromUtf8('Amxlaraizaoteles');
      final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: AESMode.ecb));
      session.idTurn = result.container![0]["ultimoId"];
      final encrypted = encrypter.encrypt(session.toJson().toString(), iv: iv);
      await sm.initialize();
      await sm.saveSession(encrypted.base64.toString());
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

  Future<AccessMap> getObservation(BuildContext context ) async {
  AccessMap result = AccessMap();
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    messageError(context,'No hay conexión a Internet.', 'Error');
    return result;
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
    isSaving = true;
    notifyListeners();
    
      VarProvider vh = VarProvider();
      final t2 = await vh.arrSharedPreferences();
      final url = Uri.parse('$link/turn_assistance.php?description=${t2["idTurn"]}&local=${ (await storage.read(key: 'idHotelRegister'))}');
      var response = (await http.get(url)).body;
      final result = AccessMap.fromJson(jsonDecode(response));
      if (result.status == 200) {

        isSaving = false;
        notifyListeners();
        return result;
      } 
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

Future<List<Map<String, dynamic>>> selectObsAssitance( DateExcelFood  e,BuildContext context ) async {
    
    List<Map<String, dynamic>> listContainer = [];
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
      e.local = await storage.read(key: 'idHotelRegister');
      final url = Uri.parse('$link/turn_assistance.php?observation=true');
      var response = (await http.post(
      url, 
      body: json.encode(e.toJson()))).body;
      result = AccessMap.fromJson(json.decode(response));
      
      if (result.status == 200){ 
        listContainer =  result.container!;
        isSaving = false;
        notifyListeners();
        return listContainer; 
      }
      isSaving = false;
      notifyListeners();
      return listContainer; 
      } on SocketException catch (e) {
    // Error de conexión de red (sin conexión a Internet)
    messageError(context,'Error de conexión de red: $e','Error');
    return listContainer; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    messageError(context,'Error de la solicitud HTTP: $e','Error');
    return listContainer; 
  } catch (e) {
    // Otro tipo de error
    messageError(context,'Error inesperado: $e','Error');
  }
  }
  return listContainer; 
    }

    Future<List<Map<String, dynamic>>> selectAssitance( DateExcelFood  e,BuildContext context ) async {
    
    List<Map<String, dynamic>> listContainer = [];
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
      final url = Uri.parse('$link/turn_assistance.php?menu=true');
      var response = (await http.post(
      url, 
      body: json.encode(e.toJson()))).body;
      result = AccessMap.fromJson(json.decode(response));
      
      if (result.status == 200){ 
        listContainer =  result.container!;
        isSaving = false;
        notifyListeners();
        return listContainer; 
      }
      isSaving = false;
      notifyListeners();
      return listContainer; 
      } on SocketException catch (e) {
      // Error de conexión de red (sin conexión a Internet)
      messageError(context,'Error de conexión de red: $e','Error');
      return listContainer; 
    } on HttpException catch (e) {
      // Error de la solicitud HTTP
      messageError(context,'Error de la solicitud HTTP: $e','Error');
      return listContainer; 
    } catch (e) {
      // Otro tipo de error
      messageError(context,'Error inesperado: $e','Error');
    }
    }
    return listContainer; 
  }
    
   Future<AccessMap> postQrAssistance( QrAssistance scn,BuildContext context ) async {
  AccessMap result = AccessMap();
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    messageError(context,'No hay conexión a Internet.', 'Error');
    return result;
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
    isSaving = true;
    notifyListeners();
     final url = Uri.parse('$link/qr_assistance.php');
      var response = (await http.post(
      url, 
      body:json.encode(scn.toJson()))).body;
      result = AccessMap.fromJson(jsonDecode(response));
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
  Future<bool> postRegisterAssistance( QrAssistance reg,BuildContext context ) async {
  AccessMap result = AccessMap();
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    messageError(context,'No hay conexión a Internet.', 'Error');
    return false;
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
    isSaving = true;
    notifyListeners();
    final url = Uri.parse('$link/qr_assistance.php');
      var response = (await http.post(
      url, 
      body: json.encode(reg.toJson()))).body;
      result = AccessMap.fromJson(jsonDecode(response));
      if (result.status == 200){ 
        isSaving = false;
        notifyListeners();
        return true;
      }else{
        messageError(context, result.container![0]['error'].toString(),'Error');
      }

    isSaving = false;
    notifyListeners();
      return false;
  } on SocketException catch (e) {
    // Error de conexión de red (sin conexión a Internet)
    messageError(context,'Error de conexión de red: $e','Error');
     return false;
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    messageError(context,'Error de la solicitud HTTP: $e','Error');
     return false;
  } catch (e) {
    // Otro tipo de error
    messageError(context,'Error inesperado: $e','Error');
     return false;
  }
  }
  return false;
  }
 
   Future<List<Map<String, dynamic>>> selectDateAssistance( DateExcelAssistance  e,BuildContext context ) async {
    
    List<Map<String, dynamic>> listContainer = [];
    AccessMap result = AccessMap();
    var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    messageError(context,'No hay conexión a Internet.', 'Error');
    return listContainer;
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
      isSaving = true;
      notifyListeners();
      final url = Uri.parse('$link/qr_assistance.php');
      var response = (await http.post(
      url, 
      body: json.encode(e.toJson()))).body;
      result = AccessMap.fromJson(json.decode(response));
          
      if (result.status == 200){ 
        listContainer =  result.container!;
        isSaving = false;
        notifyListeners();
        return listContainer; 
      }
      isSaving = false;
      notifyListeners();
      return listContainer; 
      } on SocketException catch (e) {
    // Error de conexión de red (sin conexión a Internet)
    messageError(context,'Error de conexión de red: $e','Error');
    return listContainer; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    messageError(context,'Error de la solicitud HTTP: $e','Error');
    return listContainer; 
  } catch (e) {
    // Otro tipo de error
    messageError(context,'Error inesperado: $e','Error');
    return listContainer; 
  }
  }
  return listContainer; 
  }


Future<List<Map<String, dynamic>>> selectDateAssistanceObservations( DateExcelAssistance  e,BuildContext context ) async {
    
    List<Map<String, dynamic>> listContainer = [];
    AccessMap result = AccessMap();
    var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    messageError(context,'No hay conexión a Internet.', 'Error');
    return listContainer;
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
      isSaving = true;
      notifyListeners();
      final url = Uri.parse('$link/turn_assistance.php?getObservations=true');
      var response = (await http.post(
      url, 
      body: json.encode(e.toJson()))).body;
      result = AccessMap.fromJson(json.decode(response));
      
      if (result.status == 200){ 
        listContainer =  result.container!;
        isSaving = false;
        notifyListeners();
        return listContainer; 
      }
      isSaving = false;
      notifyListeners();
      return listContainer; 
      } on SocketException catch (e) {
    // Error de conexión de red (sin conexión a Internet)
    messageError(context,'Error de conexión de red: $e','Error');
    return listContainer; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    messageError(context,'Error de la solicitud HTTP: $e','Error');
    return listContainer; 
  } catch (e) {
    // Otro tipo de error
    messageError(context,'Error inesperado: $e','Error');
    return listContainer; 
  }
  }
  return listContainer; 
  }

  Future<List<Map<String, dynamic>>> showEmployeeAssistance( String palabra,BuildContext context , int local ) async {
    
    List<Map<String, dynamic>> listContainer = [];
    AccessMap result = AccessMap();
    var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    messageError(context,'No hay conexión a Internet.', 'Error');
    return listContainer;
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
try {
      isSaving = true;
      notifyListeners();
      final url = Uri.parse('$link/qr_assistance.php?nameSearch=$palabra&local=$local');
      var response =(await http.get(url)).body;
      final result = AccessMap.fromJson(json.decode(response));
      
      if (result.status == 200){ 
        listContainer =  result.container!;
        isSaving = false;
        notifyListeners();
        return listContainer; 
      }
      isSaving = false;
      notifyListeners();
      return listContainer; 
      } on SocketException catch (e) {
    // Error de conexión de red (sin conexión a Internet)
    messageError(context,'Error de conexión de red: $e','Error');
    return listContainer; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    messageError(context,'Error de la solicitud HTTP: $e','Error');
    return listContainer; 
  } catch (e) {
    // Otro tipo de error
    messageError(context,'Error inesperado: $e','Error');
    return listContainer; 
  }
  }
  return listContainer; 
  }


Future<List<Map<String, dynamic>>> showCoursesAssistance( String palabra,BuildContext context ) async {
    
    List<Map<String, dynamic>> listContainer = [];
    AccessMap result = AccessMap();
    var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    messageError(context,'No hay conexión a Internet.', 'Error');
    return listContainer;
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
      isSaving = true;
      notifyListeners();
      final url = Uri.parse('$link/turn_assistance.php?courseSearch=$palabra&local=${ (await storage.read(key: 'idHotelRegister'))}');
      var response =(await http.get(url)).body;
      final result = AccessMap.fromJson(json.decode(response));
      
      if (result.status == 200){ 
        listContainer =  result.container!;
        isSaving = false;
        notifyListeners();
        return listContainer; 
      }
      isSaving = false;
      notifyListeners();
      return listContainer; 
      } on SocketException catch (e) {
    // Error de conexión de red (sin conexión a Internet)
    messageError(context,'Error de conexión de red: $e','Error');
    return listContainer; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    messageError(context,'Error de la solicitud HTTP: $e','Error');
    return listContainer; 
  } catch (e) {
    // Otro tipo de error
    messageError(context,'Error inesperado: $e','Error');
    return listContainer; 
  }
  }
  return listContainer; 
  }
}


