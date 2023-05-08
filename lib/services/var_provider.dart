import 'package:flutter/material.dart';



class VarProvider with ChangeNotifier {
 bool myGlobalVariable = false;
 int auxPrevDirectory = 1;
 int auxNextDirectory = 1;


   updateVariable(bool value) {
    myGlobalVariable = value;
    notifyListeners();
  }


  updatePrev(int value) {
    auxPrevDirectory = value;
    notifyListeners();
  }
}
