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
        'scanner_qr_vehicles',
        'control_food',
        'medical_records',
        'routes_seh',
        'control_assistance'
      },
      {
        'tour_seh_tr1_a',
        'tour_seh_tr1_b',
        'tour_seh_tr1_c',
        'tour_seh_tr2_a',
        'tour_seh_tr2_b',
        'tour_seh_tr2_c',
        'tour_seh_tr3_a',
        'tour_seh_tr3_b',
        'tour_seh_tr3_c',
        'tour_seh_tr4_a',
        'tour_seh_tr4_b',
        'tour_seh_tr4_c', 
        'scanner_qr_assistance',
        'scanner_qr_food'
      }
    ];


  static final routerMain = {

    //Seccion de vehiculos
    /* home */ namesRouter[0].toList()[0] : ( _ ) => const CustomBackBvuttonInterceptor(child:HomeScreen()), 
    /* control_vehicles */ namesRouter[1].toList()[0] : ( _ ) => const CustomBackBvuttonInterceptor(child:ControlVehicles()),
    /* scanner_qr_vehicles */ namesRouter[2].toList()[0] : ( _ ) => const CustomBackBvuttonInterceptor(child:ScannerQR()),
    /* scanner_qr_assistance */ namesRouter[3].toList()[12] : ( _ ) => const CustomBackBvuttonInterceptor(child:ScannerQR()),
    /* scanner_qr_food*/ namesRouter[3].toList()[13] : ( _ ) => const CustomBackBvuttonInterceptor(child:ScannerQR()),

    //Seccuion de RH
    /* control_rh */ namesRouter[1].toList()[1] : ( _ ) => const CustomBackBvuttonInterceptor(child:RhControl()),
    /* control_food */ namesRouter[2].toList()[1] : ( _ ) => const CustomBackBvuttonInterceptor(child:DiningRoom()),

    //Seccion de SeH
    /* control_seh */ namesRouter[1].toList()[2] : ( _ ) => const CustomBackBvuttonInterceptor(child:SehControl()),
    /* medical_records */ namesRouter[2].toList()[2] : ( _ ) => const CustomBackBvuttonInterceptor(child:MedicalRecords()),
    /* routes_seh */ namesRouter[2].toList()[3] : ( _ ) => const CustomBackBvuttonInterceptor(child:RoutesSeh()),
    /* control_assistance */ namesRouter[2].toList()[4] : ( _ ) => const CustomBackBvuttonInterceptor(child:ControlAssistance()),
    
    /* tour_seh_tr1_a */ namesRouter[3].toList()[0] : ( _ ) => const CustomBackBvuttonInterceptor(child:QuestRoute()),
    /* tour_seh_tr1_b */ namesRouter[3].toList()[1] : ( _ ) => const CustomBackBvuttonInterceptor(child:QuestRoute()),
    /* tour_seh_tr1_c */ namesRouter[3].toList()[2] : ( _ ) => const CustomBackBvuttonInterceptor(child:QuestRoute()),
    /* tour_seh_tr2_a */ namesRouter[3].toList()[3] : ( _ ) => const CustomBackBvuttonInterceptor(child:QuestRoute()),
    /* tour_seh_tr2_b */ namesRouter[3].toList()[4] : ( _ ) => const CustomBackBvuttonInterceptor(child:QuestRoute()),
    /* tour_seh_tr2_c */ namesRouter[3].toList()[5] : ( _ ) => const CustomBackBvuttonInterceptor(child:QuestRoute()),
    /* tour_seh_tr3_a */ namesRouter[3].toList()[6] : ( _ ) => const CustomBackBvuttonInterceptor(child:QuestRoute()),
    /* tour_seh_tr3_b */ namesRouter[3].toList()[7] : ( _ ) => const CustomBackBvuttonInterceptor(child:QuestRoute()),
    /* tour_seh_tr3_c */ namesRouter[3].toList()[8] : ( _ ) => const CustomBackBvuttonInterceptor(child:QuestRoute()),
    /* tour_seh_tr4_a */ namesRouter[3].toList()[9] : ( _ ) => const CustomBackBvuttonInterceptor(child:QuestRoute()),
    /* tour_seh_tr4_b */ namesRouter[3].toList()[10] : ( _ ) => const CustomBackBvuttonInterceptor(child:QuestRoute()),
    /* tour_seh_tr4_c */ namesRouter[3].toList()[11] : ( _ ) => const CustomBackBvuttonInterceptor(child:QuestRoute())

  }; 
}







