import '../screens/screens.dart';
import '../services/services.dart';

class Routers {
  static final List<Set<String>> namesRouter = 
    [
      {
        'home',
      },
      {
        'control_vehicles',
        'control_rh',
        'control_seh'
      },
      {
        'scanner_qr',
        'control_food',
        'medical_records'

      }
    ];



  static final routerMain = {

    //Seccion de vehiculos
    namesRouter[0].toList()[0] : ( _ ) => const CustomBackBvuttonInterceptor(child:HomeScreen()), 
    namesRouter[1].toList()[0] : ( _ ) => const CustomBackBvuttonInterceptor(child:ControlVehicles()),
    namesRouter[2].toList()[0] : ( _ ) => const CustomBackBvuttonInterceptor(child:ScannerQR()),

    //Seccuion de RH
    namesRouter[1].toList()[1] : ( _ ) => const CustomBackBvuttonInterceptor(child:RhControl()),
    namesRouter[2].toList()[1] : ( _ ) => const CustomBackBvuttonInterceptor(child:DiningRoom()),

    //Seccion de SeH
    namesRouter[1].toList()[2] : ( _ ) => const CustomBackBvuttonInterceptor(child:SehControl()),
    namesRouter[2].toList()[2] : ( _ ) => const CustomBackBvuttonInterceptor(child:MedicalRecords()),

  }; 
}