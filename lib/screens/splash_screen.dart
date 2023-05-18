import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app_seguimiento_movil/screens/screens.dart';

class SplashScreen extends StatefulWidget {
  final Duration splashScreenDuration;

  SplashScreen({this.splashScreenDuration = const Duration(seconds: 3)});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<bool>? _isLoading;

  @override
  void initState() {
    super.initState();
    _isLoading = loadData();
  }

  Future<bool> loadData() async {
    // Simula una carga de datos larga
    await Future.delayed(widget.splashScreenDuration);

    // Completa la carga de datos y devuelve true
    return true;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return Scaffold(
      
      backgroundColor: const Color(0xFF293641),
      body: Center(
        child: FutureBuilder(
          future: _isLoading,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/images/araiza_logo.png',
                    height: 200,
                  ),
                  const SizedBox(height: 20),
                  // CustomLoading(),
                  const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    backgroundColor: Colors.grey,
                  ),
                ],
              );
            } else {
              return const HomeScreen();
            }
          },
        ),
      ),
    );
  }
}

