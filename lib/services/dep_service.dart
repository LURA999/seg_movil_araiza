import 'package:app_seguimiento_movil/models/models.dart';
import 'package:app_seguimiento_movil/services/services.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

//,headers: {HttpHeaders.contentTypeHeader: "application/json"}
class DepartamentService extends ChangeNotifier {


  bool isSaving = true;
  final dio = Dio();
  //Esta en modo desarrollo?
  bool modoApk = kDebugMode?true:false; 
  late String link = modoApk?'https://www.comunicadosaraiza.com/movil_scan_api/API':'https://www.comunicadosaraiza.com/movil_scan_api/API';

 Future<List<Map<String, dynamic>>> nameGuard( String name,BuildContext context ) async {
AccessMap result = AccessMap();
 
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    print('No hay conexión a Internet.');
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
    isSaving = true;
    notifyListeners();
    final url = Uri.parse('$link/turn_vehicle.php?name=$name');
    var response = (await http.get(url)).body;
      final result = AccessMap.fromJson(json.decode(response));
    // var response = await http.post(url, body: {'pass': pass, 'departament': departament});

    if (result.status == 200){
      isSaving = false;
      notifyListeners();
      return result.container! ;
    }
    isSaving = false;
    notifyListeners();
    return result.container!; 
  } on SocketException catch (e) {
    // Error de conexión de red (sin conexión a Internet)
    print('Error de conexión de red: $e');
    return result.container!; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    print('Error de la solicitud HTTP: $e');
    return result.container!; 
  } catch (e) {
    // Otro tipo de error
    print('Error inesperado: $e');
    return result.container!; 
  }
  }
    return result.container!; 
  
  } 

  Future<List<Map<String, dynamic>>> namesGuard(BuildContext context) async {
    AccessMap result = AccessMap();

  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    print('No hay conexión a Internet.');
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
try {
    isSaving = true;
    notifyListeners();
    final url = Uri.parse('$link/turn_vehicle.php?names=true');
    var response = (await http.get(url)).body;
      final result = AccessMap.fromJson(json.decode(response));
    // var response = await http.post(url, body: {'pass': pass, 'departament': departament});

    if (result.status == 200){
      isSaving = false;
      notifyListeners();
      return result.container! ;
    }
    isSaving = false;
    notifyListeners();
    return result.container!; 
  } on SocketException catch (e) {
    // Error de conexión de red (sin conexión a Internet)
    print('Error de conexión de red: $e');
    return result.container!; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    print('Error de la solicitud HTTP: $e');
    return result.container!; 
  } catch (e) {
    // Otro tipo de error
    print('Error inesperado: $e');
    return result.container!; 
  }
  }
    return result.container!; 
  } 

Future<Access> dataGuard( int idGuard,BuildContext context ) async {
  Access result = Access();
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    print('No hay conexión a Internet.');
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
    isSaving = true;
    notifyListeners();
    final url = Uri.parse('$link/turn_vehicle.php?idGuard=$idGuard');
    var response = (await http.get(url)).body;
      final result = Access.fromJson(jsonDecode(response));
    // var response = await http.post(url, body: {'pass': pass, 'departament': departament});
    if (result.status == 200){
      isSaving = false;
      notifyListeners();
      return result;
    }
    isSaving = false;
    notifyListeners();
    return result; 
  } on SocketException catch (e) {
    // Error de conexión de red (sin conexión a Internet)
    print('Error de conexión de red: $e');
    return result; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    print('Error de la solicitud HTTP: $e');
    return result; 
  } catch (e) {
    // Otro tipo de error
    print('Error inesperado: $e');
    return result; 
  }
  }
    return result; 
  
  } 

  Future<Access> checkPassWord( String pass, int departament,BuildContext context ) async {
  Access result = Access();
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    print('No hay conexión a Internet.');
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
    isSaving = true;
    notifyListeners();
    final url = Uri.parse('$link/departament.php?departament=$departament&pass=$pass');
    var response = (await http.get(url)).body;
      final result = Access.fromJson(jsonDecode(response));
    // var response = await http.post(url, body: {'pass': pass, 'departament': departament});
    if (result.status == 200){
      isSaving = false;
      notifyListeners();
      return result;
    }
    isSaving = false;
    notifyListeners();
    return result; 
  } on SocketException catch (e) {
    // Error de conexión de red (sin conexión a Internet)
    print('Error de conexión de red: $e');
    return result; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    print('Error de la solicitud HTTP: $e');
    return result; 
  } catch (e) {
    // Otro tipo de error
    print('Error inesperado: $e');
    return result; 
  }
  }
    return result; 
  } 

  
    Future<bool> postCloseTurnVehicle(BuildContext context) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    print('No hay conexión a Internet.');
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
      isSaving = true;
      notifyListeners();
      final url = Uri.parse('$link/turn_vehicle.php');
      var response = (await http.post(url, body: json.encode({}))).body;
      
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
    print('Error de conexión de red: $e');
      return false; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    print('Error de la solicitud HTTP: $e');
      return false; 
  } catch (e) {
    // Otro tipo de error
    print('Error inesperado: $e');
      return false; 
  }
  }
      return false; 
    }
  Future<bool> postCloseTurnFood() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    print('No hay conexión a Internet.');
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
      }
      isSaving = false;
      notifyListeners();
      return false; 
     } on SocketException catch (e) {
    // Error de conexión de red (sin conexión a Internet)
    print('Error de conexión de red: $e');
      return false; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    print('Error de la solicitud HTTP: $e');
      return false; 
  } catch (e) {
    // Otro tipo de error
    print('Error inesperado: $e');
  }
  }
      return false; 
    }

    
Future<bool> postObvFood(TurnFood t,BuildContext context) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    print('No hay conexión a Internet.');
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
      }
      isSaving = false;
      notifyListeners();
      return false; 
      } on SocketException catch (e) {
    // Error de conexión de red (sin conexión a Internet)
    print('Error de conexión de red: $e');
      return false; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    print('Error de la solicitud HTTP: $e');
      return false; 
  } catch (e) {
    // Otro tipo de error
    print('Error inesperado: $e');
      return false; 
  }
  }
      return false; 
    }
Future<bool> postObvVehicle(TurnVehicle t,BuildContext context) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    print('No hay conexión a Internet.');
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
      isSaving = true;
      notifyListeners();
      final url = Uri.parse('$link/turn_vehicle.php');
      var response = (await http.post(url, body: json.encode(t.toJson()))).body;
      
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
    print('Error de conexión de red: $e');
      return false; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    print('Error de la solicitud HTTP: $e');
      return false; 
  } catch (e) {
    // Otro tipo de error
    print('Error inesperado: $e');
      return false; 
  }
  }
      return false; 
    }

  Future<Access> findVehicle(String plate,BuildContext context) async {
    Access result = Access();
    var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    print('No hay conexión a Internet.');
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
      notifyListeners();
      final url = Uri.parse('$link/qr_vehicle.php?plate=$plate');
      var response = (await http.get(url)).body;
      final result = Access.fromJson(jsonDecode(response));
      if (result.status == 200){
        isSaving = false;
        notifyListeners();
        return result;
      }
      
      isSaving = false;
      notifyListeners();
      return result; 
    } on SocketException catch (e) {
    // Error de conexión de red (sin conexión a Internet)
    print('Error de conexión de red: $e');
    return result; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    print('Error de la solicitud HTTP: $e');
    return result; 
  } catch (e) {
    // Otro tipo de error
    print('Error inesperado: $e');
    return result; 
  }
  }
    return result; 
    
  }

  Future<Access> postTurnVehicle( TurnVehicle session,BuildContext context ) async {
  final sm = SessionManager();
  TurnVehicle tn = TurnVehicle();
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
    print('No hay conexión a Internet.');
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
    isSaving = true;
    notifyListeners();
    final url = Uri.parse('$link/turn_vehicle.php');
      var response = (await http.post(
      url, 
      body: json.encode(session.toJson()))).body;
      result =Access.fromJson(json.decode(response));

    isSaving = false;
    notifyListeners();
    return result; 
  } on SocketException catch (e) {
    // Error de conexión de red (sin conexión a Internet)
    print('Error de conexión de red: $e');
    return result; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    print('Error de la solicitud HTTP: $e');
    return result; 
  } catch (e) {
    // Otro tipo de error
    print('Error inesperado: $e');
    return result; 
  }
  }
    return result; 
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
    print('No hay conexión a Internet.');
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
    isSaving = true;
    notifyListeners();

      var request = http.MultipartRequest('POST', Uri.parse('$link/turn_food.php'));
      request.files.add(await http.MultipartFile.fromPath('photo', session.picture!));

      // Agregar datos adicionales
      request.fields['date_hour'] = session.date_hour!;
      request.fields['dessert'] = session.dessert!;
      request.fields['garrison'] = session.garrison!;
      request.fields['plate'] = session.plate!;
      request.fields['received'] = session.received!;

    await request.send();

    isSaving = false;
    notifyListeners();
    return result; 
  } on SocketException catch (e) {
    // Error de conexión de red (sin conexión a Internet)
    print('Error de conexión de red: $e');
    return result; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    print('Error de la solicitud HTTP: $e');
    return result; 
  } catch (e) {
    // Otro tipo de error
    print('Error inesperado: $e');
    return result; 
  }
  }
    return result; 
  } 
  
  Future<Access> postQrVehicle( Qr scn,BuildContext context ) async {
  Access result = Access();
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    print('No hay conexión a Internet.');
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
    isSaving = true;
    notifyListeners();
     final url = Uri.parse('$link/qr_vehicle.php');
      var response = (await http.post(
      url, 
      body:json.encode(scn.toJson()))).body;
      result =Access.fromJson(json.decode(response));
      
    isSaving = false;
    notifyListeners();
    return result; 
  } on SocketException catch (e) {
    // Error de conexión de red (sin conexión a Internet)
    print('Error de conexión de red: $e');
    return result; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    print('Error de la solicitud HTTP: $e');
    return result; 
  } catch (e) {
    // Otro tipo de error
    print('Error inesperado: $e');
    return result; 
  }
  }
    return result; 
  }

  Future<Access> postQrFood( QrFood scn,BuildContext context ) async {
  Access result = Access();
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    print('No hay conexión a Internet.');
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
    isSaving = true;
    notifyListeners();
     final url = Uri.parse('$link/qr_food.php');
      var response = (await http.post(
      url, 
      body:json.encode(scn.toJson()))).body;
      result =Access.fromJson(json.decode(response));
      
    isSaving = false;
    notifyListeners();
    return result; 
  } on SocketException catch (e) {
    // Error de conexión de red (sin conexión a Internet)
    print('Error de conexión de red: $e');
    return result; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    print('Error de la solicitud HTTP: $e');
    return result; 
  } catch (e) {
    // Otro tipo de error
    print('Error inesperado: $e');
    return result; 
  }
  }
  
    return result; 
  }


  
    Future<List<Map<String, dynamic>>> selectObsVehicle( DateExcelVehicle  e,BuildContext context ) async {
    
    List<Map<String, dynamic>> listContainer = [];
    AccessMap result = AccessMap();

    var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    print('No hay conexión a Internet.');
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
      isSaving = true;
      notifyListeners();
      final url = Uri.parse('$link/turn_vehicle.php');
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
    print('Error de conexión de red: $e');
    return listContainer; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    print('Error de la solicitud HTTP: $e');
    return listContainer; 
  } catch (e) {
    // Otro tipo de error
    print('Error inesperado: $e');
    return listContainer; 
  }
  }
  return listContainer; 
    }
     Future<List<Map<String, dynamic>>> selectObsFood( DateExcelFood  e,BuildContext context ) async {
    
    List<Map<String, dynamic>> listContainer = [];
    AccessMap result = AccessMap();

    var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    print('No hay conexión a Internet.');
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
      } 
      isSaving = false;
      notifyListeners();
      return listContainer; 
      } on SocketException catch (e) {
    // Error de conexión de red (sin conexión a Internet)
    print('Error de conexión de red: $e');
    return listContainer; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    print('Error de la solicitud HTTP: $e');
    return listContainer; 
  } catch (e) {
    // Otro tipo de error
    print('Error inesperado: $e');
  }
  }
  return listContainer; 
    }
  
    Future<List<Map<String, dynamic>>> selectDateVehicle( DateExcelVehicle  e,BuildContext context ) async {
    
    List<Map<String, dynamic>> listContainer = [];
    AccessMap result = AccessMap();

    var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    print('No hay conexión a Internet.');
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
      isSaving = true;
      notifyListeners();
      final url = Uri.parse('$link/qr_vehicle.php');
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
    print('Error de conexión de red: $e');
    return listContainer; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    print('Error de la solicitud HTTP: $e');
    return listContainer; 
  } catch (e) {
    // Otro tipo de error
    print('Error inesperado: $e');
    return listContainer; 
  }
  }
  return listContainer; 
    }
     Future<List<Map<String, dynamic>>> selectDateFood( DateExcelFood  e,BuildContext context ) async {
    
    List<Map<String, dynamic>> listContainer = [];
    AccessMap result = AccessMap();

    var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    print('No hay conexión a Internet.');
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
      isSaving = true;
      notifyListeners();
      final url = Uri.parse('$link/qr_vehicle.php');
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
    print('Error de conexión de red: $e');
    return listContainer; 
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    print('Error de la solicitud HTTP: $e');
    return listContainer; 
  } catch (e) {
    // Otro tipo de error
    print('Error inesperado: $e');
    return listContainer; 
  }
  }
  return listContainer; 
    }
  
  


  Future<Access> postRegisterVehicle( RegisterVehicle reg,BuildContext context ) async {
  Access result = Access();
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    print('No hay conexión a Internet.');
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
    isSaving = true;
    notifyListeners();
    final url = Uri.parse('$link/qr_vehicle.php');
      var response = (await http.post(
      url, 
      body: json.encode(reg.toJson()))).body;
      result =Access.fromJson(json.decode(response));

      if (result.status == 200){ 
        isSaving = false;
        notifyListeners();
        return result;
      } 
    isSaving = false;
    notifyListeners();
      return result;
  } on SocketException catch (e) {
    // Error de conexión de red (sin conexión a Internet)
    print('Error de conexión de red: $e');
    return result;
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    print('Error de la solicitud HTTP: $e');
    return result;
  } catch (e) {
    // Otro tipo de error
    print('Error inesperado: $e');
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
    print('No hay conexión a Internet.');
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
    isSaving = true;
    notifyListeners();

    final url = Uri.parse('$link/qr_food.php');
      var response = (await http.post(
      url, 
      body: json.encode(reg.toJson()))).body;
      
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
    print('Error de conexión de red: $e');
     return false;
  } on HttpException catch (e) {
    // Error de la solicitud HTTP
    print('Error de la solicitud HTTP: $e');
     return false;
  } catch (e) {
    // Otro tipo de error
    print('Error inesperado: $e');
     return false;
  }
  }
  return false;
  }
}
 

 messageError(BuildContext context){
  return showDialog(
    context: context, // Accede al contexto del widget actual
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Error'),
        content: Text('Se produjo un error durante la solicitud HTTP.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Cierra el diálogo
            },
            child: Text('Cerrar'),
          ),
        ],
      );
 });
 }

    /**
     * headers = {'Content-type': 'application/json'}
     * url = 'http://tu_url.com/api/tu_endpoint'
     * response = requests.post(url, data=json.dumps(data), headers=headers)
     */
    