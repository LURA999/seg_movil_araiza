import 'package:flutter/material.dart';

  TextStyle getTextStyleTitle(BuildContext context, Color? colors) {
    //portait es cuando esta horizontal
    //landscape es cuando esta vertical
    double fontSize = MediaQuery.of(context).size.height < 960 && MediaQuery.of(context).size.width <900  ?
    //para celulares
      MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .07: 0.04):
    //para tablets
    MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .05 : 0.04);

  //  print( MediaQuery.of(context).size.height < 960 && MediaQuery.of(context).size.width <900  ? 'celulares' : 'tablets');

    return TextStyle(
    color: colors ?? Colors.black,
    fontFamily: 'GothamMedium',
    fontWeight: FontWeight.w700,
    fontSize: fontSize
    );
  }

 TextStyle getTextStyleTitleHome(BuildContext context, Color? colors) {
    //portait es cuando esta horizontal
    //landscape es cuando esta vertical
    double fontSize = MediaQuery.of(context).size.height < 960 && MediaQuery.of(context).size.width <900  ?
    //para celulares
      MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .08: 0.04):
    //para tablets
    MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .07: 0.05);

  //  print( MediaQuery.of(context).size.height < 960 && MediaQuery.of(context).size.width <900  ? 'celulares' : 'tablets');

    return TextStyle(
    color: colors ?? Colors.black,
    fontFamily: 'GothamMedium',
    fontWeight: FontWeight.w700,
    fontSize: fontSize
    );
  }

  TextStyle getTextStyleTitle2(BuildContext context, Color? colors) {
    //portait es cuando esta horizontal
    //landscape es cuando esta vertical
    double fontSize = MediaQuery.of(context).size.height < 960 && MediaQuery.of(context).size.width <900  ?
    //para celulares
      MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.02):
    //para tablets
    MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .03: 0.02);

  //  print( MediaQuery.of(context).size.height < 960 && MediaQuery.of(context).size.width <900  ? 'celulares' : 'tablets');

    return TextStyle(
    color: colors ?? Colors.black,
    fontFamily: 'GothamBook',
    fontWeight: FontWeight.w700,
    fontSize: fontSize
    );
  }


  TextStyle getTextStyleButtonField(BuildContext context) {
    double fontSize = MediaQuery.of(context).size.height < 960 && MediaQuery.of(context).size.width <900  ?
    //para celulares
      MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .03: 0.015):
    //para tablets
    MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .03: 0.015);

    return TextStyle(
    fontFamily: 'GothamBold',
    // fontWeight: MediaQuery.of(context).orientation == Orientation.portrait ? FontWeight.w700 : FontWeight.w600,
    fontSize: fontSize
    );

  }

  TextStyle getTextStyleButtonFieldRow(BuildContext context) {
    double fontSize = MediaQuery.of(context).size.height < 960 && MediaQuery.of(context).size.width <500  ?
    //para celulares
      MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .03: 0.015):
    //para tablets
    MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .02: 0.015);

    return TextStyle(
    fontFamily: 'GothamBold',
    fontWeight: MediaQuery.of(context).orientation == Orientation.portrait ? FontWeight.w700 : FontWeight.w600,
    fontSize: fontSize
    );

  }


  TextStyle getTextStyleText(BuildContext context, FontWeight? ft, Color? color) {
    double fontSize = MediaQuery.of(context).size.height < 960 && MediaQuery.of(context).size.width <500  ?
    //para celulares
      MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.015):
    //para tablets
    MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .03: 0.015);

    return TextStyle(
    fontFamily: 'GothamMedium',
    fontWeight: ft ?? FontWeight.normal,
    color: color,
    fontSize: fontSize
    );
  }

   TextStyle getTextStyleTextNormal(BuildContext context, FontWeight? ft, Color? color) {
    double fontSize = MediaQuery.of(context).size.height < 960 && MediaQuery.of(context).size.width <500  ?
    //para celulares
      MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.015):
    //para tablets
    MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .03: 0.015);

    return TextStyle(
    fontFamily: 'GothamBook',
    fontWeight: ft ?? FontWeight.normal,
    color: color,
    fontSize: fontSize
    );
  }