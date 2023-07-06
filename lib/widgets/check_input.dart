import 'package:app_seguimiento_movil/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CheckInput extends StatefulWidget {
  final List<List<bool>> listChecked;
  final String contenido;
  final int indexPrincipal;
  final int indexSecundario;

  const CheckInput({Key? key, 
  required this.contenido, 
  required this.listChecked, 
  required this.indexPrincipal, 
  required this.indexSecundario}) : super(key: key);

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
        Text(widget.contenido),
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
  

  /***
   * 
   * Column(
          children: [
              ListTile(
              title: const Text('Si'),
              leading: Radio<YesNot>(
                activeColor: AppTheme.primary,
                fillColor: MaterialStateProperty.resolveWith(getColor),
                value: YesNot.si,
                groupValue: widget.yesNotEnum![widget.index],
                onChanged: (YesNot? value) {
                  setState(() {
                    widget.yesNotEnum![widget.index] = value!;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('No'),
              leading: Radio<YesNot>(
                activeColor: AppTheme.primary,
                fillColor: MaterialStateProperty.resolveWith(getColor),
                value: YesNot.no,
                groupValue: widget.yesNotEnum![widget.index],
                onChanged: (YesNot? value) {
                  setState(() {
                    widget.yesNotEnum![widget.index] = value!;
                  });
                },
              ),
            ),
          ],
        );
        
      case 2:
      return Column(
          children: [
              ListTile(
              title: const Text('Accidente'),
              leading: Radio<Cause>(
                activeColor: AppTheme.primary,
                fillColor: MaterialStateProperty.resolveWith(getColor),
                value: Cause.accidente,
                groupValue: widget.causeEnum![widget.index],
                onChanged: (Cause? value) {
                  setState(() {
                    widget.causeEnum![widget.index] = value!;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Enfermedad'),
              leading: Radio<Cause>(
                activeColor: AppTheme.primary,
                fillColor: MaterialStateProperty.resolveWith(getColor),
                value: Cause.enfermedad,
                groupValue: widget.causeEnum![widget.index],
                onChanged: (Cause? value) {
                  setState(() {
                    widget.causeEnum![widget.index] = value!;
                  });
                },
              ),
            ),
          ],
        );
   */
}
