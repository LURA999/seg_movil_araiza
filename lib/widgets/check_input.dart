import 'package:app_seguimiento_movil/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CheckInput extends StatefulWidget {
  final List<List<bool>> listChecked;
  final String contenido;
  final int indexPrincipal;
  final int indexSecundario;
  final TextStyle? style;

  const CheckInput({Key? key, 
  required this.contenido, 
  required this.listChecked, 
  required this.indexPrincipal, 
  required this.indexSecundario, 
  this.style}) : super(key: key);

  @override
  State<CheckInput> createState() => _CheckInputState();
}

class _CheckInputState extends State<CheckInput> {
  @override
  Widget build(BuildContext context) {
    // print('[${widget.indexPrincipal}][${widget.indexSecundario}]');

     Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return AppTheme.primary;
      }
      return AppTheme.primary;
    }

    return Row(
      children: [
        Text(widget.contenido,style: widget.style,),
        Checkbox(
          checkColor: Colors.white,
          fillColor: MaterialStateProperty.resolveWith(getColor),
          value: widget.listChecked[widget.indexPrincipal][widget.indexSecundario],
          onChanged: (bool? value) {
            setState(() {
              widget.listChecked[widget.indexPrincipal][widget.indexSecundario] = value!;
            });
          },
        ),
      ],
    );
  }
  
}
