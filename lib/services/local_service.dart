
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:app_seguimiento_movil/models/models.dart';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:app_seguimiento_movil/widgets/widgets.dart';

class LocalService extends ChangeNotifier{

  bool modoApk = kDebugMode?true:false; 
  bool isSaving = true;
  late String link = modoApk?'https://www.comunicadosaraiza.com/portal_api/API':'https://www.comunicadosaraiza.com/portal_api/API';


 Future<Access> getLocal(BuildContext context ) async {
  Access result = Access();
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none ) {
    // No hay conexión a Internet
    messageError(context,'No hay conexión a Internet.');
    return result;
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
    isSaving = true;
    notifyListeners();
    final url = Uri.parse('$link/local.php?opc=-1');
    var response = (await http.get(url)).body;
      final result = Access.fromJson(jsonDecode(response));
    // var response = await http.post(url, body: {'pass': pass, 'departament': departament});
    if (result.status == 200){
      isSaving = false;
      notifyListeners();
      return result;
    }else{
      messageError(context,'Contraseña incorrecta.');
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
  // messageError(context,'Error desconocido.');
    return result; 
  } 



}




