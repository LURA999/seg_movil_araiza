import 'package:flutter/material.dart';
import 'package:app_seguimiento_movil/theme/app_theme.dart';


class DropdownButtonWidget extends StatefulWidget {
  List<String>? list;
  final String formProperty;
  final Map<String, List<Object?>> formValues;

  DropdownButtonWidget({
  Key? key, 
  this.list, 
  required this.formProperty, 
  required this.formValues
  }) : super(key: key);

  @override
  State<DropdownButtonWidget> createState() => _DropdownButtonWidgetState();
}

class _DropdownButtonWidgetState extends State<DropdownButtonWidget> {
 late List<String> list;
  late String? dropdownValue;


  @override
  Widget build(BuildContext context) {
    widget.formValues[widget.formProperty]![0] = dropdownValue;

    return OutlinedButton(
        onPressed:  null,
        style: OutlinedButton.styleFrom(
          side:  const BorderSide(color: AppTheme.primary),
        ),
        child: Container(
          height: 65,
          alignment: Alignment.center,
          child: DropdownButton<String>(
          value: dropdownValue,
          icon: const Icon(Icons.arrow_drop_down_circle_rounded,color: AppTheme.primary),
          elevation: 16,
          isExpanded: true,
          // style: const TextStyle(color: Colors.deepPurple),
          underline: Container(
            height: 2,
          ),
          onChanged: (String? value) {
            // This is called when the user selects an item.
            setState(() {
              dropdownValue = value;
              widget.formValues[widget.formProperty]![0] = value;
            });
          },
          items: list.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value,style: TextStyle(fontSize: MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .03: 0.015))),
            );
          }).toList(),
            ),
        ),
      );
  }

  @override
  void initState() {
    super.initState();
    list = [...widget.list!];
    dropdownValue = widget.list!.first;
  }

}
