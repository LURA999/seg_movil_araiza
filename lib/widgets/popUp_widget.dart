import 'package:app_seguimiento_movil/services/letter_mediaquery.dart';
import 'package:flutter/material.dart';

messageError(BuildContext context, String msg, String title){
  return showDialog(
    context: context, // Accede al contexto del widget actual
    builder: (BuildContext context) {
      return AlertDialog(
        title:  Text(title,style: getTextStyleText(context,FontWeight.bold,null),),
        content: Text(msg, style: getTextStyleText(context,null,null)),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Cierra el diálogo
            },
            child:  Text('Cerrar', style: getTextStyleButtonField(context),),
          ),
        ],
      );
    });
 }

