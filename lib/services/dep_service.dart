import 'package:app_seguimiento_movil/models/models.dart';
import 'package:app_seguimiento_movil/services/services.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'dart:convert';

import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

//,headers: {HttpHeaders.contentTypeHeader: "application/json"}
class DepartamentService extends ChangeNotifier {


  bool isSaving = true;
  final dio = Dio();
  //Esta en modo desarrollo?
  bool modoApk = kDebugMode?true:false; 
  late String link = modoApk?'https://www.comunicadosaraiza.com/movil_scan_api/API':'https://www.comunicadosaraiza.com/movil_scan_api/API';

 Future<List<Map<String, dynamic>>> nameGuard( String name ) async {
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
  } catch(e) {
    return [] ;
  }
  
  } 

  Future<List<Map<String, dynamic>>> namesGuard() async {
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
  } catch(e) {
    return [] ;
  }
  
  } 

Future<Access> dataGuard( int idGuard ) async {
  Access result = Access();
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
  } catch(e) {
    return result;
  }
  
  } 

  Future<Access> checkPassWord( String pass, int departament ) async {
  Access result = Access();
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
  } catch(e) {
    return result;
  }
  
  } 

  
    Future<bool> postCloseTurnVehicle() async {
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
      /* final response = await dio.put(
        'http://10.0.2.2:8000/pst_tncv/'
        ); 
      if (response.statusCode == 200){
        isSaving = false;
        notifyListeners();
        return true;
      }*/
      isSaving = false;
      notifyListeners();
      return false; 
      } catch(e) {
        return false;
      }
    }
  Future<bool> postCloseTurnFood() async {
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
     /* final response = await dio.put(
        'http://10.0.2.2:8000/pst_tncf/'
        );
      if (response.statusCode == 200){
        isSaving = false;
        notifyListeners();
        return true;
      }*/
      isSaving = false;
      notifyListeners();
      return false; 
      } catch(e) {
        return false;
      }
    }
Future<bool> postObvFood(TurnFood t) async {
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
      /*final response = await dio.put(
        'http://10.0.2.2:8000/pst_obvf/',options: Options(
        headers: {
          HttpHeaders.contentTypeHeader: "application/json"
        }
        ), data: t.toJson()
      );
      if (response.statusCode == 200){
        isSaving = false;
        notifyListeners();
        return true;
      }*/
      isSaving = false;
      notifyListeners();
      return false; 
      }  catch(e) {
        return false;
      }
    }
Future<bool> postObvVehicle(TurnVehicle t) async {
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
      /* final response = await dio.put(
        'http://10.0.2.2:8000/pst_obvv/',options: Options(
        headers: {
          HttpHeaders.contentTypeHeader: "application/json"
        }
        ), data: t.toJson()
      );
      if (response.statusCode == 200){
        isSaving = false;
        notifyListeners();
        return true;
      } */
      isSaving = false;
      notifyListeners();
      return false; 
      }  catch(e) {
        return false;
      }
    }

  Future<Access> findVehicle(String plate) async {
    Access result = Access();
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
    } catch (e) {
      return result;
    }
    
    
  }

  Future<Access> postTurnVehicle( TurnVehicle session ) async {
  final sm = SessionManager();
  TurnVehicle tn = TurnVehicle();
  final key = encrypt.Key.fromLength(32);
  final iv = encrypt.IV.fromLength(16);
  final encrypter = encrypt.Encrypter(encrypt.AES(key));
  final encrypted = encrypter.encrypt(session.toJson().toString(), iv: iv);
  await sm.initialize();
  await sm.saveSession(encrypted.base64.toString());

  Access result = Access();
  try {
    isSaving = true;
    notifyListeners();
    final url = Uri.parse('$link/turn_vehicle.php');
      var response = (await http.post(
      url, 
      body: json.encode(session.toJson()))).body;
      result =Access.fromJson(json.decode(response));

    /* final response = await dio.post(
      'http://10.0.2.2:8000/pst_tnv/',
      options: Options(
        headers: {
          HttpHeaders.contentTypeHeader: "application/json"
        }
      ), data: session.toJson()); */

    isSaving = false;
    notifyListeners();
    return result; 
  }  catch(e) {
    return result;
  }
  
  } 

  Future<Access> postTurnFood( TurnFood session ) async {
  final sm = SessionManager();
  TurnFood tn = TurnFood();
  final key = encrypt.Key.fromLength(32);
  final iv = encrypt.IV.fromLength(16);
  final encrypter = encrypt.Encrypter(encrypt.AES(key));
  final encrypted = encrypter.encrypt(session.toJson().toString(), iv: iv);
  await sm.initialize();
  await sm.saveSession(encrypted.base64.toString());

  Access result = Access();
  try {
    isSaving = true;
    notifyListeners();
      final url = Uri.parse('$link/turn_food.php');
      var response = (await http.post(
      url, 
      body: json.encode(session.toJson()))).body;
      result =Access.fromJson(json.decode(response));
   /*  final response = await dio.post(
      'http://10.0.2.2:8000/pst_tnf/',
      options: Options(
        headers: {
          HttpHeaders.contentTypeHeader: "application/json"
        }
      ), data: session.toJson());
 */
    isSaving = false;
    notifyListeners();
    return result; 
  }  catch(e) {
    return result;
  }
  
  } 
  
  Future<Access> postQr( Qr scn ) async {
  Access result = Access();
  try {
    isSaving = true;
    notifyListeners();
     final url = Uri.parse('$link/qr_vehicle.php');
      var response = (await http.post(
      url, 
      body:json.encode(scn.toJson()))).body;
      result =Access.fromJson(json.decode(response));
      
      
    /*final response = await dio.post(
      'http://10.0.2.2:8000/pst_qr/',
      options: Options(
        headers: {
          HttpHeaders.contentTypeHeader: "application/json"
        }
      ),
      data: scn,);*/
    isSaving = false;
    notifyListeners();
    return result; 
  } on Exception catch(e) {
    return result;
  }
  
  }

  
    Future<List<Map<String, dynamic>>> selectDate( DateExcel  e ) async {
    
    List<Map<String, dynamic>> listContainer = [];
    AccessMap result = AccessMap();

    try {
      isSaving = true;
      notifyListeners();
      final url = Uri.parse('$link/qr_vehicle.php');
      var response = (await http.post(
      url, 
      body: json.encode(e.toJson()))).body;
      result = AccessMap.fromJson(json.decode(response));
      /* final response = await dio.post(
        'http://10.0.2.2:8000/slc_rep/',
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json'
          }
        ), data: e);
      final str = response.data;

      if (response.statusCode == 200){
        isSaving = false;
        notifyListeners();
        return str['data'].toString();
      } 
      isSaving = false;
      notifyListeners();
      return str.container.toString();
      */

      if (result.status == 200){ 
        listContainer =  result.container!;
        isSaving = false;
        notifyListeners();
        return listContainer; 
      } 
      isSaving = false;
      notifyListeners();
      return listContainer; 
      } catch(e) {
        return listContainer;
      }
    }
  


  Future<Access> postRegisterVehicle( RegisterVehicle reg ) async {
  Access result = Access();
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

    /* final response = await dio.post(
      'http://10.0.2.2:8000/pst_regv/',
      options: Options(
        headers: {
          HttpHeaders.contentTypeHeader: "application/json"
        }
      ),
      data: reg);

    if (response.statusCode == 200){
      isSaving = false;
      notifyListeners();
      return true;
    } */
    isSaving = false;
    notifyListeners();
      return result;
  }  catch(e) {
      return result;
  }
  
  }


  Future<bool> postRegisterFood( RegisterFood reg ) async {
  Access result = Access();
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
    /* final response = await dio.post(
      'http://10.0.2.2:8000/pst_regf/',
      options: Options(
        headers: {
          HttpHeaders.contentTypeHeader: "application/json"
        }
      ),
      data: reg);

    if (response.statusCode == 200){
      isSaving = false;
      notifyListeners();
      return true;
    } */

    isSaving = false;
    notifyListeners();
      return false;
  }  catch(e) {
      return false;
  }
  
  }
}

    /**
     * headers = {'Content-type': 'application/json'}
     * url = 'http://tu_url.com/api/tu_endpoint'
     * response = requests.post(url, data=json.dumps(data), headers=headers)
     */
    