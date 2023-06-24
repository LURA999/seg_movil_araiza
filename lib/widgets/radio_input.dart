import 'package:flutter/material.dart';

import '../models/models.dart';
import '../theme/app_theme.dart';


class RadioInput extends StatefulWidget {
  final List<Cause>? causeEnum;
  final List<YesNot>? yesNotEnum;
  final List<manoDominante>? manoDomEnum;

  final int index;
  final int tipoEnum;
  const RadioInput({Key? key, required this.tipoEnum, this.causeEnum, this.yesNotEnum, required this.index, this.manoDomEnum}) : super(key: key);

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

    switch (widget.tipoEnum) {
      case 1:
        return Column(
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
        default:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
              ListTile(
                
              title: const Text('Diestro'),
              leading: Radio<manoDominante>(
                activeColor: AppTheme.primary,
                fillColor: MaterialStateProperty.resolveWith(getColor),
                value: manoDominante.diestro,
                groupValue: widget.manoDomEnum![widget.index],
                onChanged: (manoDominante? value) {
                  setState(() {
                    widget.manoDomEnum![widget.index] = value!;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Zurdo'),
              leading: Radio<manoDominante>(
                activeColor: AppTheme.primary,
                fillColor: MaterialStateProperty.resolveWith(getColor),
                value: manoDominante.zurdo,
                groupValue: widget.manoDomEnum![widget.index],
                onChanged: (manoDominante? value) {
                  setState(() {
                    widget.manoDomEnum![widget.index] = value!;
                  });
                },
              )
            ),
            ListTile(
              title: const Text('Ambos'),
              leading: Radio<manoDominante>(
                activeColor: AppTheme.primary,
                fillColor: MaterialStateProperty.resolveWith(getColor),
                value: manoDominante.ambos,
                groupValue: widget.manoDomEnum![widget.index],
                onChanged: (manoDominante? value) {
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
}
