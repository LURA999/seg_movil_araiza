import 'package:app_seguimiento_movil/services/services.dart';
import 'package:app_seguimiento_movil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:app_seguimiento_movil/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:app_seguimiento_movil/routers/router.dart';



void main() => runApp(const AppState());
  

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( _ ) =>  VarProvider(), lazy: false,)
      ],
      child:  const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
  final HistoryNavigator navigatorObserver = HistoryNavigator();
  final navigatorKey = GlobalKey<NavigatorState>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      navigatorObservers: [navigatorObserver],
      home: SplashScreen(),
      routes: Routers.routerMain,
      theme: AppTheme.lightTeheme,

    );
  }
}

