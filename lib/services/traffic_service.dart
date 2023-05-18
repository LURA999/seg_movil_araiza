import 'package:app_seguimiento_movil/models/access_model.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:io';

class DepartamentService extends ChangeNotifier {
  final String _baseUrl = "127.0.0.1:8000";
  bool isSaving = true;
  final dio = Dio();

  Future<Access> getCar( String pass, int departament ) async {
  Access result = Access();
  try {
    isSaving = true;
    notifyListeners();
    final response = await dio.get(
      'http://10.0.2.2:8000/selct_departament?pass=${pass}&departament=${departament}',
      options: Options(
        headers: {
          HttpHeaders.contentTypeHeader: "application/json"
        }
      ));

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
}

/**
 * headers = {'Content-type': 'application/json'}
 * url = 'http://tu_url.com/api/tu_endpoint'
 * response = requests.post(url, data=json.dumps(data), headers=headers)
 */
    