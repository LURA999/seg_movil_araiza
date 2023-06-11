import 'package:app_seguimiento_movil/models/models.dart';
import 'package:app_seguimiento_movil/services/services.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:encrypt/encrypt.dart' as encrypt;

class DepartamentService extends ChangeNotifier {
  // final String _baseUrl = "127.0.0.1:8000";
  bool isSaving = true;
  final dio = Dio();
  VarProvider vp = VarProvider();

  Future<Access> checkPassWord( String pass, int departament ) async {

  Access result = Access();

  try {
    isSaving = true;
    notifyListeners();
    final response = await dio.get(
      'http://10.0.2.2:8000/sct_dep?pass=$pass&departament=$departament'
      );

    if (response.statusCode == 200){
      final result = Access.fromJson(response.data);
      isSaving = false;
      notifyListeners();
      return result;
    }
    isSaving = false;
    notifyListeners();
    return result; 
  } on DioError catch(e) {
    return result;
  }
  
  } 

  
    Future<bool> postCloseTurnVehicle() async {
    try {
      isSaving = true;
      notifyListeners();
      final response = await dio.put(
        'http://10.0.2.2:8000/pst_tncv/'
        );
      if (response.statusCode == 200){
        isSaving = false;
        notifyListeners();
        return true;
      }
      isSaving = false;
      notifyListeners();
      return false; 
      } on DioError catch(e) {
        return false;
      }
    }
  Future<bool> postCloseTurnFood() async {
    try {
      isSaving = true;
      notifyListeners();
      final response = await dio.put(
        'http://10.0.2.2:8000/pst_tncf/'
        );
      if (response.statusCode == 200){
        isSaving = false;
        notifyListeners();
        return true;
      }
      isSaving = false;
      notifyListeners();
      return false; 
      } on DioError catch(e) {
        return false;
      }
    }
Future<bool> postObvFood(TurnFood t) async {
    try {
      isSaving = true;
      notifyListeners();
      final response = await dio.put(
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
      }
      isSaving = false;
      notifyListeners();
      return false; 
      } on DioError catch(e) {
        return false;
      }
    }
Future<bool> postObvVehicle(TurnVehicle t) async {
    try {
      isSaving = true;
      notifyListeners();
      final response = await dio.put(
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
      }
      isSaving = false;
      notifyListeners();
      return false; 
      } on DioError catch(e) {
        return false;
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
    final response = await dio.post(
      'http://10.0.2.2:8000/pst_tnv/',
      options: Options(
        headers: {
          HttpHeaders.contentTypeHeader: "application/json"
        }
      ), data: session.toJson());

    isSaving = false;
    notifyListeners();
    return result; 
  } on DioError catch(e) {
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
    final response = await dio.post(
      'http://10.0.2.2:8000/pst_tnf/',
      options: Options(
        headers: {
          HttpHeaders.contentTypeHeader: "application/json"
        }
      ), data: session.toJson());

    isSaving = false;
    notifyListeners();
    return result; 
  } on DioError catch(e) {
    return result;
  }
  
  } 
  Future<Access> postQr( Qr scn ) async {
  Access result = Access();
  try {
    isSaving = true;
    notifyListeners();
    final response = await dio.post(
      'http://10.0.2.2:8000/pst_qr/',
      options: Options(
        headers: {
          HttpHeaders.contentTypeHeader: "application/json"
        }
      ),
      data: scn,);
    isSaving = false;
    notifyListeners();
    return result; 
  } on DioError catch(e) {
    return result;
  }
  
  }

  
    Future<String> selectDate( DateExcel  e ) async {
    Qr qr = Qr();
    
    List<Qr> result = [];
    try {
      isSaving = true;
      notifyListeners();
      final response = await dio.post(
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
      return str['data'].toString(); 
      } on DioError catch(e) {
        return e.toString();
      }
    }
  


  Future<bool> postRegisterVehicle( RegisterVehicle reg ) async {
  Access result = Access();
  try {
    isSaving = true;
    notifyListeners();
    final response = await dio.post(
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
    }
    isSaving = false;
    notifyListeners();
      return false;
  } on DioError catch(e) {
      return false;
  }
  
  }


  Future<bool> postRegisterFood( RegisterFood reg ) async {
  Access result = Access();
  try {
    isSaving = true;
    notifyListeners();
    final response = await dio.post(
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
    }
    isSaving = false;
    notifyListeners();
      return false;
  } on DioError catch(e) {
      return false;
  }
  
  }
}

    /**
     * headers = {'Content-type': 'application/json'}
     * url = 'http://tu_url.com/api/tu_endpoint'
     * response = requests.post(url, data=json.dumps(data), headers=headers)
     */
    