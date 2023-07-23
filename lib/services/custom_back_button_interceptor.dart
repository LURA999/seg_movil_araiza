import 'package:flutter/material.dart';

class CustomBackBvuttonInterceptor extends StatelessWidget {

  final Widget child;

  const CustomBackBvuttonInterceptor({Key? key, required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: child
    , onWillPop:  () async {
      return false;
    } );
  }
}
