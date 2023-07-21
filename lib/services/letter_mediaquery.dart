import 'package:flutter/material.dart';

  TextStyle getTextStyleTitle(BuildContext context) {
    //portait es cuando esta horizontal
    //landscape es cuando esta vertical
    double fontSize = MediaQuery.of(context).size.height < 960 && MediaQuery.of(context).size.width <600  ?
    //para celulares
      MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .07: 0.06):
    //para tablets
    MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .05 : 0.04);

  //  print( MediaQuery.of(context).size.height < 960 && MediaQuery.of(context).size.width <600  ? 'celulares' : 'tablets');

    return TextStyle(
    color: Colors.black,
    fontFamily: 'GothamBold',
    fontWeight: FontWeight.w700,
    fontSize: fontSize
    );
  }

  TextStyle getTextStyleButtonField(BuildContext context) {
    double fontSize = MediaQuery.of(context).size.height < 960 && MediaQuery.of(context).size.width <600  ?
    //para celulares
      MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.015):
    //para tablets
    MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .02: 0.015);

    return TextStyle(
    fontFamily: 'Inter',
    fontWeight: MediaQuery.of(context).orientation == Orientation.portrait ? FontWeight.w700 : FontWeight.w600,
    fontSize: fontSize
    );

  }


  TextStyle getTextStyleText(BuildContext context) {
    double fontSize = MediaQuery.of(context).size.height < 960 && MediaQuery.of(context).size.width <600  ?
    //para celulares
      MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.020):
    //para tablets
    MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .03: 0.015);

    return TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.normal,
    fontSize: fontSize
    );
  }