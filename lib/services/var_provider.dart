import 'dart:convert';

import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:app_seguimiento_movil/models/models.dart';
import 'package:app_seguimiento_movil/services/services.dart';



class VarProvider with ChangeNotifier {
 TurnVehicle tn = TurnVehicle();
 bool varControl = false;
 bool varSalir = false;
 int auxPrevDirectory = 1;
 int auxNextDirectory = 1;


  void updateVariable(bool value) {
    varControl = value;
    notifyListeners();
  }

  void updateVarSalir(bool value) {
    varSalir = value;
    notifyListeners();
  }

  void updatePrev(int value) {
    auxPrevDirectory = value;
    notifyListeners();
  }

  Future<Map<String, dynamic>> arrSharedPreferences() async {
    final sm = SessionManager();
    final key = encrypt.Key.fromUtf8('Amxlaraizaoteles');
    final iv = encrypt.IV.fromUtf8('Amxlaraizaoteles');
    final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: AESMode.ecb));
    await sm.initialize();
    String decrypted = encrypter.decrypt(encrypt.Encrypted.fromBase64(sm.getSession()!.toString()), iv: iv);
    return tn.fromJsonReverse(decrypted);
  }


}
