// ignore_for_file: use_build_context_synchronously

import 'package:app_seguimiento_movil/models/models.dart';
import 'package:app_seguimiento_movil/services/services.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:app_seguimiento_movil/widgets/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


//,headers: {HttpHeaders.contentTypeHeader: "application/json"}
class VehicleService extends ChangeNotifier {


  bool isSaving = true;
  final dio = Dio();
  //Esta en modo desarrollo?
  bool modoApk = kDebugMode?true:false; 
  late String link = modoApk?'https://www.comunicadosaraiza.com/movil_scan_api_prueba2/API':'https://www.comunicadosaraiza.com/movil_scan_api_prueba2/API';
  final storage = const FlutterSecureStorage();

 Future<List<Map<String, dynamic>>> nameGuard( String name,BuildContext context ) async { 
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    messageError(context,'No hay conexión a Internet.', 'Error');
    return [];
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
    isSaving = true;
    notifyListeners();
    final url = Uri.parse('$link/turn_vehicle.php?name=$name&local=${(await storage.read(key: 'idHotelRegister'))}');
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
    return []; 
  
  } 

  Future<List<Map<String, dynamic>>> namesGuard(BuildContext context) async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    messageError(context,'No hay conexión a Internet.', 'Error');
    return [];
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
try {
    isSaving = true;
    notifyListeners();
    final url = Uri.parse('$link/turn_vehicle.php?names=true&local=${(await storage.read(key: 'idHotelRegister')) }');
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
    return []; 
  } 


  Future<List<Map<String, dynamic>>> showPlateRegister(String value,BuildContext context) async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    messageError(context,'No hay conexión a Internet.', 'Error');
    return [];
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
try {
    isSaving = true;
    notifyListeners();
    final url = Uri.parse('$link/qr_vehicle.php?platesSearch=$value&local=${(await storage.read(key: 'idHotelRegister')) }');
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
    return []; 
  } 


  Future<List<Map<String, dynamic>>> insertPlateRegister(String value,BuildContext context) async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    messageError(context,'No hay conexión a Internet.', 'Error');
    return [];
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
try {
    isSaving = true;
    notifyListeners();
    final url = Uri.parse('$link/qr_vehicle.php?platesSearch=$value');
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
    return []; 
  } 


Future<List<Map<String, dynamic>>> dataGuard( String idGuard,BuildContext context ) async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    messageError(context,'No hay conexión a Internet.', 'Error');
    return [];
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
    isSaving = true;
    notifyListeners();
    final url = Uri.parse('$link/turn_vehicle.php?nameSign=$idGuard&local=${(await storage.read(key: 'idHotelRegister')) }');
    var response = (await http.get(url)).body;
      final result = AccessMap.fromJson(jsonDecode(response));
    // var response = await http.post(url, body: {'pass': pass, 'departament': departament});
    if (result.status == 200){
      isSaving = false;
      notifyListeners();
      return result.container!;
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
    return []; 
  
  } 

  
  
    Future<bool> postCloseTurnVehicle(BuildContext context) async {
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
      final url = Uri.parse('$link/turn_vehicle.php?idTurn=true');
      var response = (await http.post(url, body: json.encode({'idTurn': t2["idTurn"], 'local': (await storage.read(key: 'idHotelRegister'))  }))).body;
      
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
 
    
Future<bool> postObvVehicle(TurnVehicle t,BuildContext context) async {
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
      t.idTurn = t2["idTurn"];
      t.local  = (await storage.read(key: 'idHotelRegister')) ;
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

  Future<Access> findVehicle(String plate,BuildContext context,int condition) async {
    Access result = Access();
    var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    messageError(context,'No hay conexión a Internet.', 'Error');
    return result;
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
      notifyListeners();
      final url = Uri.parse('$link/qr_vehicle.php?plate=$plate&condition=$condition');
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

  Future<AccessMap> postTurnVehicle( TurnVehicle session,BuildContext context ) async {
  

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
    session.local = (await storage.read(key: 'idHotelRegister')) ;
    final url = Uri.parse('$link/turn_vehicle.php');
    var response = (await http.post(
    url, 
    body: json.encode(session.toJson()))).body;
    result =AccessMap.fromJson(jsonDecode(response));
    if (result.status == 200) {
    isSaving = false;
    notifyListeners();
    final sm = SessionManager();
      final key = encrypt.Key.fromUtf8('Amxlaraizaoteles');
      final iv = encrypt.IV.fromUtf8('Amxlaraizaoteles');
      final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: AESMode.ecb));
    session.idTurn = result.container![0]["ultimoId"];
    final encrypted = encrypter.encrypt(session.toJson().toString(), iv: iv);
    await sm.initialize();
    await sm.saveSession(encrypted.base64.toString());
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

  
  Future<AccessMap> postQrVehicle( Qr scn,BuildContext context ) async {
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
     final url = Uri.parse('$link/qr_vehicle.php?qr=true');
      var response = (await http.post(
      url, 
      body:json.encode(scn.toJson()))).body;
      result =AccessMap.fromJson(jsonDecode(response));
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

 
  Future<AccessMap> getObservation(BuildContext context ) async {
  AccessMap result = AccessMap();
   VarProvider vp = VarProvider();
    final json = await vp.arrSharedPreferences();

  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    messageError(context,'No hay conexión a Internet.', 'Error');
    return result;
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
    isSaving = true;
    notifyListeners();
     final url = Uri.parse('$link/turn_vehicle.php?nameTurn=${json["guard"]}&local=${(await storage.read(key: 'idHotelRegister')) }');
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

    Future<List<Map<String, dynamic>>> selectObsVehicle( DateExcelVehicle  e,BuildContext context ) async {
    
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
     
  
    Future<List<Map<String, dynamic>>> selectDateVehicle( DateExcelVehicle  e,BuildContext context ) async {
    
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
      e.local = (await storage.read(key: 'idHotelRegister')) ;
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
   


  Future<AccessMap> postRegisterVehicle( RegisterVehicle reg,BuildContext context ) async {
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
    final url = Uri.parse('$link/qr_vehicle.php?qr2=true');
      var response = (await http.post(
      url, 
      body: json.encode(reg.toJson()))).body;
      result =AccessMap.fromJson(json.decode(response));
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



    /**
     * headers = {'Content-type': 'application/json'}
     * url = 'http://tu_url.com/api/tu_endpoint'
     * response = requests.post(url, data=json.dumps(data), headers=headers)
     */
    