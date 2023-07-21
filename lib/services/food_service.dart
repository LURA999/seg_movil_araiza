
import 'dart:io';
import 'package:app_seguimiento_movil/services/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:app_seguimiento_movil/models/models.dart';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:app_seguimiento_movil/widgets/widgets.dart';

class FoodService extends ChangeNotifier{

  bool modoApk = kDebugMode?true:false; 
  bool isSaving = true;
  late String link = modoApk?'https://www.comunicadosaraiza.com/movil_scan_api/API':'https://www.comunicadosaraiza.com/movil_scan_api/API';


 Future<bool> postCloseTurnFood(BuildContext context) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    messageError(context,'No hay conexión a Internet.');
    return false;
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
      isSaving = true;
      notifyListeners();
      final url = Uri.parse('$link/turn_food.php');
      var response = (await http.post(url, body: json.encode({}))).body;
      
      if (response.contains('200')){  
        isSaving = false;
        notifyListeners();
        return true;
      }else{
          messageError(context,'Error desconocido.');

      }
      isSaving = false;
      notifyListeners();
      return false; 
     } on SocketException catch (e) {
    // Error de conexión de red (sin conexión a Internet)
    messageError(context,'Error de conexión de red: $e');
      return false; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    messageError(context,'Error de la solicitud HTTP: $e');
      return false; 
  } catch (e) {
    // Otro tipo de error
    messageError(context,'Error inesperado: $e');
  }
  }
      return false; 
    }


Future<bool> postObvFood(TurnFood t,BuildContext context) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    messageError(context,'No hay conexión a Internet.');
    return false;
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
      isSaving = true;
      notifyListeners();
      final url = Uri.parse('$link/turn_food.php');
      var response = (await http.post(url, body: json.encode(t.toJson()),headers: {HttpHeaders.contentTypeHeader: "application/json"})).body;
      
      if (response.contains('200')){  
        isSaving = false;
        notifyListeners();
        return true;
      }else{
              messageError(context,'Error desconocido.');

      }
      isSaving = false;
      notifyListeners();
      return false; 
      } on SocketException catch (e) {
    // Error de conexión de red (sin conexión a Internet)
    messageError(context,'Error de conexión de red: $e');
      return false; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    messageError(context,'Error de la solicitud HTTP: $e');
      return false; 
  } catch (e) {
    // Otro tipo de error
    messageError(context,'Error inesperado: $e');
      return false; 
  }
  }
      return false; 
    }

  Future<Access> postTurnFood( TurnFood session,BuildContext context ) async {
  final sm = SessionManager();
  TurnFood tn = TurnFood();
  final key = encrypt.Key.fromLength(32);
  final iv = encrypt.IV.fromLength(16);
  final encrypter = encrypt.Encrypter(encrypt.AES(key));
  final encrypted = encrypter.encrypt(session.toJson().toString(), iv: iv);
  await sm.initialize();
  await sm.saveSession(encrypted.base64.toString());

  Access result = Access();
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    messageError(context,'No hay conexión a Internet.');
    return result;
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
    isSaving = true;
    notifyListeners();
    var request = http.MultipartRequest('POST', Uri.parse('$link/turn_food.php'));
    request.files.add(await http.MultipartFile.fromPath('photo', session.picture!));
    // Agregar datos adicionales
    request.fields['picture'] = session.picture!;
    request.fields['dessert'] = session.dessert!;
    request.fields['garrison'] = session.garrison!;
    request.fields['dish'] = session.dish!;
    request.fields['received'] = session.received!;
    await request.send();
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
Future<List<Map<String, dynamic>>> selectObsFood( DateExcelFood  e,BuildContext context ) async {
    
    List<Map<String, dynamic>> listContainer = [];
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
      final url = Uri.parse('$link/turn_food.php');
      var response = (await http.post(
      url, 
      body: json.encode(e.toJson()))).body;
      result = AccessMap.fromJson(json.decode(response));
      
      if (result.status == 200){ 
        listContainer =  result.container!;
        isSaving = false;
        notifyListeners();
        return listContainer; 
      } else{
      messageError(context,'Error desconocido.');

      }
      isSaving = false;
      notifyListeners();
      return listContainer; 
      } on SocketException catch (e) {
    // Error de conexión de red (sin conexión a Internet)
    messageError(context,'Error de conexión de red: $e');
    return listContainer; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    messageError(context,'Error de la solicitud HTTP: $e');
    return listContainer; 
  } catch (e) {
    // Otro tipo de error
    messageError(context,'Error inesperado: $e');
  }
  }
  return listContainer; 
    }
    
   Future<Access> postQrFood( QrFood scn,BuildContext context ) async {
  Access result = Access();
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    messageError(context,'No hay conexión a Internet.');
    return result;
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
    isSaving = true;
    notifyListeners();
     final url = Uri.parse('$link/qr_food.php');
      var response = (await http.post(
      url, 
      body:json.encode(scn.toJson()))).body;
      result =Access.fromJson(json.decode(response));
      
      if (result.status == 200) {
        return result; 
      } else {
        messageError(context,'Error desconocido.');
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
  Future<bool> postRegisterFood( RegisterFood reg,BuildContext context ) async {
  Access result = Access();
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    messageError(context,'No hay conexión a Internet.');
    return false;
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
    isSaving = true;
    notifyListeners();
    print(reg.toJson());
    final url = Uri.parse('$link/qr_food.php');
      var response = (await http.post(
      url, 
      body: json.encode(reg.toJson()))).body;
      
      if (response.contains('200')){ 
        isSaving = false;
        notifyListeners();
        return true;
      }else{
    messageError(context,'Error desconocido.');

      }

    isSaving = false;
    notifyListeners();
      return false;
  } on SocketException catch (e) {
    // Error de conexión de red (sin conexión a Internet)
    messageError(context,'Error de conexión de red: $e');
     return false;
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    messageError(context,'Error de la solicitud HTTP: $e');
     return false;
  } catch (e) {
    // Otro tipo de error
    messageError(context,'Error inesperado: $e');
     return false;
  }
  }
  return false;
  }
 
   Future<List<Map<String, dynamic>>> selectDateFood( DateExcelFood  e,BuildContext context ) async {
    
    List<Map<String, dynamic>> listContainer = [];
    AccessMap result = AccessMap();
    var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    messageError(context,'No hay conexión a Internet.');
    return listContainer;
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
      isSaving = true;
      notifyListeners();
      final url = Uri.parse('$link/qr_food.php');
      var response = (await http.post(
      url, 
      body: json.encode(e.toJson()))).body;
      result = AccessMap.fromJson(json.decode(response));
      
      if (result.status == 200){ 
        listContainer =  result.container!;
        isSaving = false;
        notifyListeners();
        return listContainer; 
      } else{
      messageError(context,'Error desconocido.');

      }
      isSaving = false;
      notifyListeners();
      return listContainer; 
      } on SocketException catch (e) {
    // Error de conexión de red (sin conexión a Internet)
    messageError(context,'Error de conexión de red: $e');
    return listContainer; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    messageError(context,'Error de la solicitud HTTP: $e');
    return listContainer; 
  } catch (e) {
    // Otro tipo de error
    messageError(context,'Error inesperado: $e');
    return listContainer; 
  }
  }
  return listContainer; 
  
    }

}


