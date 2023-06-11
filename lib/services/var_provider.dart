import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:app_seguimiento_movil/models/models.dart';
import 'package:app_seguimiento_movil/services/services.dart';



class VarProvider with ChangeNotifier {
 final key = encrypt.Key.fromLength(32);
 final iv = encrypt.IV.fromLength(16);
 TurnVehicle tn = TurnVehicle();
 final sm = SessionManager();
 bool myGlobalVariable = false;
 int auxPrevDirectory = 1;
 int auxNextDirectory = 1;


  void updateVariable(bool value) {
    myGlobalVariable = value;
    notifyListeners();
  }


  void updatePrev(int value) {
    auxPrevDirectory = value;
    notifyListeners();
  }

  Future<Map<String, dynamic>> arrSharedPreferences() async {
    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    await sm.initialize();
    String decrypted = encrypter.decrypt(encrypt.Encrypted(base64.decode(sm.getSession()!)), iv: iv);
    return tn.fromJsonReverse(decrypted);
  }


}
