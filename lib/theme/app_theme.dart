import 'package:flutter/material.dart';


class AppTheme {
  static const Color primary = Color.fromRGBO(220, 153, 73,1);

  static final ThemeData lightTeheme = ThemeData.light().copyWith(
      
      //CAmbia el color del calendario
       colorScheme: const ColorScheme.light(
        primary: primary, // color primario
      ),
      //Color primario
        primaryColor: Colors.black,
        //Appbar Theme
        appBarTheme: const AppBarTheme(
          color: primary,
          elevation: 0
        ),

        //TextButtonTheme
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor:primary ),
        ),

        //FloatingActionsButtons
        floatingActionButtonTheme:  const FloatingActionButtonThemeData(
          backgroundColor: primary
        ),

        //ElevatedButtons
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
            elevation: 0
          ),
          
         
        ),
      //Configuracion de los inputs
        inputDecorationTheme: const InputDecorationTheme(
          prefixIconColor: primary,
          suffixIconColor: primary,
          floatingLabelStyle: TextStyle( color: primary ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide( color: primary),
            // borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), topRight: Radius.circular(10))
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide( color: primary),
            // borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), topRight: Radius.circular(10))
          ),
          border:OutlineInputBorder(
            borderSide: BorderSide( color: primary),
          ),
        )
  );

}