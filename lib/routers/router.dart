import '../screens/screens.dart';

class Routers {
  static final List<Set<String>> namesRouter = 
    [
      {
        'home',
      },
      {
        'control_vehicles',
        'control_rh'
      },
      {
        'scanner_qr',
        'control_food'
      }
    ];



  static final routerMain = {
    namesRouter[0].toList()[0] : ( _ ) => const HomeScreen(), 
    namesRouter[1].toList()[0] : ( _ ) => const ControlVehicles(),
    namesRouter[2].toList()[0] : ( _ ) => const ScannerQR(),
    namesRouter[1].toList()[1] : ( _ ) => const RhControl(),
    namesRouter[2].toList()[1] : ( _ ) => const DiningRoom(),

  }; 
}