import 'package:flutter/material.dart';



class VarProvider with ChangeNotifier {
 bool myGlobalVariable = false;
   updateVariable(bool value) {
    myGlobalVariable = value;
    notifyListeners();
  }
}
