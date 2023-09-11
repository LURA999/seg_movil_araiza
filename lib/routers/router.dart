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
        'control_seh',
      },
      {
        'scanner_qr',
        'control_food',
        'medical_records',
        'routes_seh',
        'tour_seh',
        'control_assistance'
      }
    ];


  static final routerMain = {

    //Seccion de vehiculos
    /*home*/ namesRouter[0].toList()[0] : ( _ ) => const CustomBackBvuttonInterceptor(child:HomeScreen()), 
    /*control_vehicles*/ namesRouter[1].toList()[0] : ( _ ) => const CustomBackBvuttonInterceptor(child:ControlVehicles()),
    /*scanner_qr*/ namesRouter[2].toList()[0] : ( _ ) => const CustomBackBvuttonInterceptor(child:ScannerQR()),

    //Seccuion de RH
    /*control_rh*/ namesRouter[1].toList()[1] : ( _ ) => const CustomBackBvuttonInterceptor(child:RhControl()),
    /*control_food*/ namesRouter[2].toList()[1] : ( _ ) => const CustomBackBvuttonInterceptor(child:DiningRoom()),

    //Seccion de SeH
    /*control_seh*/ namesRouter[1].toList()[2] : ( _ ) => const CustomBackBvuttonInterceptor(child:SehControl()),
    /*medical_records*/ namesRouter[2].toList()[2] : ( _ ) => const CustomBackBvuttonInterceptor(child:MedicalRecords()),
    /*routes_seh*/ namesRouter[2].toList()[3] : ( _ ) => const CustomBackBvuttonInterceptor(child:RoutesSeh()),
    /*tour_seh*/ namesRouter[2].toList()[4] : ( _ ) => const CustomBackBvuttonInterceptor(child:QuestRoute()),
    /*control_assistance*/ namesRouter[2].toList()[5] : ( _ ) => const CustomBackBvuttonInterceptor(child:ControlAssistance()),


  }; 
}







