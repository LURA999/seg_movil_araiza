import 'package:flutter/material.dart';

import '../models/models.dart';
import '../theme/app_theme.dart';


class RadioInputRateRoute extends StatefulWidget {
  final List<Cause>? causeEnum;
  final List<YesNot>? yesNotEnum;
  final List<rateRoute>? rateRoutes;
  final List<String>? titulo;

  final int index;
  final int tipoEnum;

  const RadioInputRateRoute({Key? key, 
  required this.tipoEnum, 
  this.causeEnum, 
  this.yesNotEnum, 
  required this.index, 
  this.rateRoutes, 
  required this.titulo}) : super(key: key);

  @override
  State<RadioInputRateRoute> createState() => _RadioInputRateRouteState();
}

class _RadioInputRateRouteState extends State<RadioInputRateRoute> {
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
              SizedBox(
                child: ListTile(
                title: Text(widget.titulo![0]),
                leading: Radio<rateRoute>(
                  activeColor: AppTheme.primary,
                  fillColor: MaterialStateProperty.resolveWith(getColor),
                  value: rateRoute.bueno,
                  groupValue: widget.rateRoutes![widget.index],
                  onChanged: (rateRoute? value) {
                    setState(() {
                      widget.rateRoutes![widget.index] = value!;
                    });
                  },
                ),
                          ),
              ),
            SizedBox(
              width: 180,
              child: ListTile(
                title: Text(widget.titulo![1]),
                leading: Radio<rateRoute>(
                  activeColor: AppTheme.primary,
                  fillColor: MaterialStateProperty.resolveWith(getColor),
                  value: rateRoute.regular,
                  groupValue: widget.rateRoutes![widget.index],
                  onChanged: (rateRoute? value) {
                    setState(() {
                      widget.rateRoutes![widget.index] = value!;
                    });
                  },
                )
              ),
            ),
            SizedBox(
              width: 180,
              child: ListTile(
                title: Text(widget.titulo![2]),
                leading: Radio<rateRoute>(
                  activeColor: AppTheme.primary,
                  fillColor: MaterialStateProperty.resolveWith(getColor),
                  value: rateRoute.malo,
                  groupValue: widget.rateRoutes![widget.index],
                  onChanged: (rateRoute? value) {
                    setState(() {
                      widget.rateRoutes![widget.index] = value!;
                    });
                  },
                ),
              ),
            )
          ],
        );
  }
}
