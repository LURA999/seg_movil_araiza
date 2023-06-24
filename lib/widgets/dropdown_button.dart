import 'package:app_seguimiento_movil/models/models.dart';
import 'package:flutter/material.dart';
import 'package:app_seguimiento_movil/theme/app_theme.dart';


class DropdownButtonWidget extends StatefulWidget {
  List<String>? list;
  final String formProperty;
  final Map<String, dynamic> formValue;

  DropdownButtonWidget({
  Key? key, 
  this.list, 
  required this.formProperty, 
  required this.formValue
  }) : super(key: key);

  @override
  State<DropdownButtonWidget> createState() => _DropdownButtonWidgetState();
}

class _DropdownButtonWidgetState extends State<DropdownButtonWidget> {
 late List<String> list;
  late String? dropdownValue;


  @override
  Widget build(BuildContext context) {
    widget.formValue[widget.formProperty]!.contenido = dropdownValue!;

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
              widget.formValue[widget.formProperty]!.contenido = value!;
            });
          },
          items: list.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value,style: MediaQuery.of(context).size.height < 960 && MediaQuery.of(context).size.width <600  ?
              //para celulares
              TextStyle(fontSize: MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .03: 0.015)):
              //para tablets
              TextStyle(fontSize: MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .02: 0.015),),),
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
