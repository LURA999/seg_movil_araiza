import 'package:flutter/material.dart';
import 'package:app_seguimiento_movil/theme/app_theme.dart';
import '../services/letter_mediaquery.dart';

class DropdownButtonWidget extends StatefulWidget {
  final List<String>? list;
  final String formProperty;
  final Map<String, dynamic> formValue;
  final List<Map<String,dynamic>>? arrSelect;
  final int type;
  DropdownButtonWidget({
  Key? key, 
  this.list, 
  required this.formProperty, 
  required this.formValue, 
  this.arrSelect, 
  required this.type, 
  }) : super(key: key);

  @override
  State<DropdownButtonWidget> createState() => _DropdownButtonWidgetState();
}

class _DropdownButtonWidgetState extends State<DropdownButtonWidget> {
  late List<String>? list;
  late List<Map<String,dynamic>>? arrSelect;
  late String? dropdownValue;



  @override
  Widget build(BuildContext context) {      
    if (widget.type != 1) {
      widget.formValue[widget.formProperty]!.contenido = (list!.indexOf(dropdownValue!)+1).toString();
    }

    return OutlinedButton(
        onPressed:  null,
        style: OutlinedButton.styleFrom(
          side:  const BorderSide(color: AppTheme.primary),
           shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
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
              if (widget.type == 1) {
                widget.formValue[widget.formProperty]!.contenido = value;
              } else {
                widget.formValue[widget.formProperty]!.contenido = (list!.indexOf(value!)+1).toString();
              }
            });
          },
          items: widget.type == 2 ?
          list!.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              enabled: widget.formValue[widget.formProperty].enabled ?? true,
              value: value,
              child: Text(value,style: getTextStyleText(context,null,null)),
            );
          }).toList()
          :
          arrSelect!.map<DropdownMenuItem<String>>((Map<String, dynamic> value) {
            final claves = value.keys.toList();
            return DropdownMenuItem<String>(
              enabled: widget.formValue[widget.formProperty].enabled ?? true,
              value: value[claves[0]],
              child: Text(value[claves[1]],style: getTextStyleText(context,null,null)),
            );
          }).toList()
          ,
          ),
        ),
      );
  }

  @override
  void initState() {
    super.initState();
    if (widget.type == 1) {
      arrSelect = [...widget.arrSelect!];
      final claves = widget.arrSelect![0].keys.toList();
      dropdownValue = widget.arrSelect![
      widget.formValue[widget.formProperty]!.contenido.toString() != '' ? 
      arrSelect!.indexWhere((el) => int.parse(el[claves[0]]) == int.parse(widget.formValue[widget.formProperty]!.contenido)) : 0 ][claves[0]];
      widget.formValue[widget.formProperty]!.contenido = dropdownValue;
    }else{
      list = [...widget.list!];
      dropdownValue = widget.list!.first;

    }
  }

}
