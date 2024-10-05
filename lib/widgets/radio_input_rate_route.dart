import 'package:app_seguimiento_movil/services/services.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';
import '../theme/app_theme.dart';


// ignore: must_be_immutable
class RadioInputRateRoute extends StatefulWidget {
  final List<Cause>? causeEnum;
  late  List<rateRoute>? rateRoutes;
  final List<String>? titulo;
  final int index;
  final int tipoEnum;

   RadioInputRateRoute({Key? key, 
  required this.tipoEnum, 
  this.causeEnum, 
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
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
            SizedBox(
            width: 180,
              child: ListTile(
              title: Text(widget.titulo![0], style: getTextStyleText(context,null,null)),
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
            width: 190,
            child: ListTile(
              title: Text(widget.titulo![1], style: getTextStyleText(context,null,null),),
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
              title: Text(widget.titulo![2], style: getTextStyleText(context,null,null)),
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
      ),
    );
  }
}
