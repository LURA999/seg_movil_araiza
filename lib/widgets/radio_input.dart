import 'package:flutter/material.dart';

import '../models/models.dart';
import '../theme/app_theme.dart';


class RadioInput extends StatefulWidget {
  final List<Cause>? causeEnum;
  final List<YesNot>? yesNotEnum;
  final List<ManoDominante>? manoDomEnum;
 
  final int index;
  final int tipoEnum;

  const RadioInput({Key? key, 
  required this.tipoEnum, 
  this.causeEnum, 
  this.yesNotEnum, 
  required this.index, 
  this.manoDomEnum }) : super(key: key);

  @override
  State<RadioInput> createState() => _RadioInputState();
}

class _RadioInputState extends State<RadioInput> {
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


  @override
  Widget build(BuildContext context) {

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
              ListTile(
              title: const Text('Diestro'),
              leading: Radio<ManoDominante>(
                activeColor: AppTheme.primary,
                fillColor: MaterialStateProperty.resolveWith(getColor),
                value: ManoDominante.diestro,
                groupValue: widget.manoDomEnum![widget.index],
                onChanged: (ManoDominante? value) {
                  setState(() {
                    widget.manoDomEnum![widget.index] = value!;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Zurdo'),
              leading: Radio<ManoDominante>(
                activeColor: AppTheme.primary,
                fillColor: MaterialStateProperty.resolveWith(getColor),
                value: ManoDominante.zurdo,
                groupValue: widget.manoDomEnum![widget.index],
                onChanged: (ManoDominante? value) {
                  setState(() {
                    widget.manoDomEnum![widget.index] = value!;
                  });
                },
              )
            ),
            ListTile(
              title: const Text('Ambos'),
              leading: Radio<ManoDominante>(
                activeColor: AppTheme.primary,
                fillColor: MaterialStateProperty.resolveWith(getColor),
                value: ManoDominante.ambos,
                groupValue: widget.manoDomEnum![widget.index],
                onChanged: (ManoDominante? value) {
                  setState(() {
                    widget.manoDomEnum![widget.index] = value!;
                  });
                },
              ),
            )
          ],
        );
  }
}
