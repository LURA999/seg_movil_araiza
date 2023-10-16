import 'package:app_seguimiento_movil/services/services.dart';
import 'package:app_seguimiento_movil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:app_seguimiento_movil/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:app_seguimiento_movil/routers/router.dart';



void main() => runApp(const AppState());



class AppState extends StatefulWidget {
  const AppState({super.key});

  @override
  State<AppState> createState() => _AppStateState();
}

class _AppStateState extends State<AppState> {
  get http => null;

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( _ ) =>  VarProvider(), lazy: false,),
      ],
      child:  const MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  

  @override
  Widget build(BuildContext context) {
  final HistoryNavigator navigatorObserver = HistoryNavigator();
  final navigatorKey = GlobalKey<NavigatorState>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      navigatorObservers: [navigatorObserver],
      home: CustomBackBvuttonInterceptor(child: MedicalRecords(),),
      routes: Routers.routerMain,
      theme: AppTheme.lightTeheme,
      
    );
  }

    @override
  void initState() { 
    super.initState();
  }
}





/* import 'package:flutter/material.dart';

/// Flutter code sample for [DropdownButton].

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

void main() => runApp(const DropdownButtonApp());

class DropdownButtonApp extends StatelessWidget {
  const DropdownButtonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('DropdownButton Sample')),
        body: const Center(
          child: DropdownButtonExample(),
        ),
      ),
    );
  }
}

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
 */