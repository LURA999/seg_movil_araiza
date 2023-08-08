
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:app_seguimiento_movil/models/models.dart';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:app_seguimiento_movil/widgets/widgets.dart';

class SehTourService extends ChangeNotifier{

  bool modoApk = kDebugMode?true:false; 
  bool isSaving = true;
  late String link = modoApk?'https://www.comunicadosaraiza.com/movil_scan_api/API':'https://www.comunicadosaraiza.com/movil_scan_api/API';


 Future<bool> postForm(List<int> answer,int formAB, BuildContext context) async {
    var connectivityResult = await (Connectivity().checkConnectivity());  
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    messageError(context,'No hay conexión a Internet.');
    return false;
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
      isSaving = true;
      notifyListeners();
      print('$link/tour_seh.php?formAB=$formAB');
      final url = Uri.parse('$link/tour_seh.php?formAB=$formAB');
      var response = (await http.patch(url, body: json.encode({'data':answer}))).body;
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


Future<bool> postComments(List<String?> input,int formComment, BuildContext context) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    messageError(context,'No hay conexión a Internet.');
    return false;
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
      isSaving = true;
      notifyListeners();
      final url = Uri.parse('$link/tour_seh.php?formComment=$formComment');
      var response = (await http.patch(url, body: json.encode({'data':input}))).body;
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

    Future<bool> postDescriptions(DescriptionsSeh input,int formComment, BuildContext context) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    messageError(context,'No hay conexión a Internet.');
    return false;
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
      isSaving = true;
      notifyListeners();
      final url = Uri.parse('$link/tour_seh.php?formDescription=$formComment');
      var response = (await http.patch(url, body: json.encode(input.toJson()))).body;
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

    Future<List<int>> getAnswer(int form,BuildContext context ) async {
 
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    messageError(context,'No hay conexión a Internet.');
    return [];
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
    isSaving = true;
    notifyListeners();
     final url = Uri.parse('$link/tour_seh.php?form=$form&answer=true');
       var response = (await http.get(url)).body;
      final result = AccessListInt.fromJson(jsonDecode(response));
      if (result.status == 200) {
        isSaving = false;
        notifyListeners();
        return result.container! ;
      } 
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
    return []; 
  }

   Future<List<Map<String,dynamic>>> getComments(int form,BuildContext context ) async {
 
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    messageError(context,'No hay conexión a Internet.');
    return [];
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
    isSaving = true;
    notifyListeners();
     final url = Uri.parse('$link/tour_seh.php?form=$form&comments=true');
       var response = (await http.get(url)).body;
      final result =  AccessMap.fromJson(jsonDecode(response));

      if (result.status == 200) {
        isSaving = false;
        notifyListeners();
        return result.container! ;
      } 
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
    return []; 
  }


  Future<List<Map<String,dynamic>>> getDescriptions(int form,BuildContext context ) async {
 
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    // No hay conexión a Internet
    messageError(context,'No hay conexión a Internet.');
    return [];
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

try {
    isSaving = true;
    notifyListeners();
     final url = Uri.parse('$link/tour_seh.php?form=$form&descriptions=true');
       var response = (await http.get(url)).body;
      final result =  AccessMap.fromJson(jsonDecode(response));

      if (result.status == 200) {
        isSaving = false;
        notifyListeners();
        return result.container! ;
      } 
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
    return []; 
  }
}


