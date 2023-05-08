import '../screens/screens.dart';

class Routers {
  static final List<Set<String>> namesRouter = 
    [
      {
        'home',
      },
      {
        'control_vehiculos',
      },
      {
        'scanner_qr'
      }
    ];



  static final routerMain = {
    namesRouter[0].elementAt(0) : ( _ ) => const HomeScreen(), 
    namesRouter[1].elementAt(0) : ( _ ) => const ControlVehiculos(),
    namesRouter[2].elementAt(0) : ( _ ) => const ScannerQR(),
  }; 
}