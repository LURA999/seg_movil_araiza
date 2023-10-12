import 'package:flutter/material.dart';

import '../models/models.dart';
import '../theme/app_theme.dart';


class RadioInput extends StatefulWidget {
  final List<Cause>? causeEnum;
  final List<YesNot>? yesNotEnum;
  final List<ManoDominante>? manoDomEnum;
  final List<MetodoAnti>? metodoAntiEnum;

  final int index;
  final int tipoEnum;
  const RadioInput({Key? key, required this.tipoEnum, this.causeEnum, this.yesNotEnum,this.metodoAntiEnum, required this.index, this.manoDomEnum}) : super(key: key);

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
            ListTile(
              title: const Text('Ninguno'),
              leading: Radio<Cause>(
                activeColor: AppTheme.primary,
                fillColor: MaterialStateProperty.resolveWith(getColor),
                value: Cause.none,
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
        case 3:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
              SizedBox(
              width: 180,
                child: ListTile(
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
            ),
            SizedBox(
              width: 180,
              child: ListTile(
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
            ),
            SizedBox(
              width: 180,
              child: ListTile(
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
              ),
            )
          ],
        );
      case 4:
      return Row(
          children: [
            SizedBox(
              width: 120,
                child: ListTile(
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
              ),
            SizedBox(
              width: 120,
              child: ListTile(
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
            ),
          ],
        );
      case 5:
      return Column(
          children: [
            SizedBox(
              width: 180,
                child: ListTile(
                title: const Text('Pastillas'),
                leading: Radio<MetodoAnti>(
                  activeColor: AppTheme.primary,
                  fillColor: MaterialStateProperty.resolveWith(getColor),
                  value: MetodoAnti.pastillas,
                  groupValue: widget.metodoAntiEnum![widget.index],
                  onChanged: (MetodoAnti? value) {
                    setState(() {
                      widget.metodoAntiEnum![widget.index] = value!;
                    });
                  },
                ),
                          ),
              ),
            SizedBox(
              width: 180,
              child: ListTile(
                title: const Text('Dispositivo'),
                leading: Radio<MetodoAnti>(
                  activeColor: AppTheme.primary,
                  fillColor: MaterialStateProperty.resolveWith(getColor),
                  value: MetodoAnti.dispositivo,
                  groupValue: widget.metodoAntiEnum![widget.index],
                  onChanged: (MetodoAnti? value) {
                    setState(() {
                      widget.metodoAntiEnum![widget.index] = value!;
                    });
                  },
                ),
              ),
            ), 
            SizedBox(
              width: 180,
                child: ListTile(
                title: const Text('Condón'),
                leading: Radio<MetodoAnti>(
                  activeColor: AppTheme.primary,
                  fillColor: MaterialStateProperty.resolveWith(getColor),
                  value: MetodoAnti.condon,
                  groupValue: widget.metodoAntiEnum![widget.index],
                  onChanged: (MetodoAnti? value) {
                    setState(() {
                      widget.metodoAntiEnum![widget.index] = value!;
                    });
                  },
                ),
                          ),
              ),
            SizedBox(
              width: 180,
              child: ListTile(
                title: const Text('OTB'),
                leading: Radio<MetodoAnti>(
                  activeColor: AppTheme.primary,
                  fillColor: MaterialStateProperty.resolveWith(getColor),
                  value: MetodoAnti.otb,
                  groupValue: widget.metodoAntiEnum![widget.index],
                  onChanged: (MetodoAnti? value) {
                    setState(() {
                      widget.metodoAntiEnum![widget.index] = value!;
                    });
                  },
                ),
              ),
            ), 
            SizedBox(
              width: 180,
                child: ListTile(
                title: const Text('Inyección'),
                leading: Radio<MetodoAnti>(
                  activeColor: AppTheme.primary,
                  fillColor: MaterialStateProperty.resolveWith(getColor),
                  value: MetodoAnti.inyeccion,
                  groupValue: widget.metodoAntiEnum![widget.index],
                  onChanged: (MetodoAnti? value) {
                    setState(() {
                      widget.metodoAntiEnum![widget.index] = value!;
                    });
                  },
                ),
              ),
            ),
            SizedBox(
              width: 180,
                child: ListTile(
                title: const Text('Implante'),
                leading: Radio<MetodoAnti>(
                  activeColor: AppTheme.primary,
                  fillColor: MaterialStateProperty.resolveWith(getColor),
                  value: MetodoAnti.implante,
                  groupValue: widget.metodoAntiEnum![widget.index],
                  onChanged: (MetodoAnti? value) {
                    setState(() {
                      widget.metodoAntiEnum![widget.index] = value!;
                    });
                  },
                ),
              ),
            ),
            SizedBox(
              width: 180,
                child: ListTile(
                title: const Text('Ninguno'),
                leading: Radio<MetodoAnti>(
                  activeColor: AppTheme.primary,
                  fillColor: MaterialStateProperty.resolveWith(getColor),
                  value: MetodoAnti.none,
                  groupValue: widget.metodoAntiEnum![widget.index],
                  onChanged: (MetodoAnti? value) {
                    setState(() {
                      widget.metodoAntiEnum![widget.index] = value!;
                    });
                  },
                ),
              ),
            ),
          ],
        );
      case 6 :
      return Row(
          children: [
            SizedBox(
              width: 150,
                child: ListTile(
                title: const Text('Normal'),
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
              ),
            SizedBox(
              width: 180,
              child: ListTile(
                title: const Text('Fuera de rango'),
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
            ),
          ],
        );
      default :
      
      return Column(
          children: [
              ListTile(
              title: const Text('Inicial'),
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
              title: const Text('Pre-Ingreso'),
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

    }
  }
}
