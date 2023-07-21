
 import 'package:flutter/material.dart';

messageError(BuildContext context, String msg){
  return showDialog(
    context: context, // Accede al contexto del widget actual
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Error'),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Cierra el diálogo
            },
            child: const Text('Cerrar'),
          ),
        ],
      );
    });
 }
