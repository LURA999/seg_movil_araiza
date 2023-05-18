import 'package:app_seguimiento_movil/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class CustomInputField extends StatefulWidget {

  final String? hintText;
  final int maxLines;
  final String? labelText;
  final String? helperText;
  final String? counterText;
  final IconData? suffixIcon;
  final IconData? prefix;
  final IconData? icon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final List<String>? listSelect;
  final String formProperty;
  final Map<String, List<Object?>> formValues;

  const CustomInputField({
    Key? key, 
    this.hintText, 
    this.labelText, 
    this.helperText, 
    this.counterText,
    this.icon,
    this.suffixIcon,
    this.prefix,
    this.listSelect,
    this.keyboardType,
    this.obscureText = false,
    required this.formProperty,
    required this.formValues, 
    required this.maxLines, 
    
  }) : super(key: key);

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  @override
  Widget build(BuildContext context) {
    final RegExp regex = RegExp(
        r'^\d{2}\/(0[1-9]|1[0-2])\/\d{4}$',
    );
    final TextEditingController controller = TextEditingController();
    final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    if (widget.formValues[widget.formProperty]![2] == true) {
      List<String> list = widget.listSelect!;
      String dropdownValue = list.first;
      return OutlinedButton(
        onPressed:  null,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppTheme.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Container(
          height: 70,
          alignment: Alignment.center,
          child: DropdownButton<String>(
          value: dropdownValue,
          icon: const Icon(Icons.arrow_downward),
          elevation: 16,
          isExpanded: true,
          // style: const TextStyle(color: Colors.deepPurple),
          underline: Container(
            height: 2,
          ),
          onChanged: (String? value) {
            // This is called when the user selects an item.
            setState(() {
              dropdownValue = value!;
            });
          },
          items: list.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
            ),
        ),
      );

    }
    return TextFormField(
      maxLines: widget.maxLines,
      controller: controller,
      autofocus: false,
     // initialValue: '',
      textCapitalization: TextCapitalization.words,
      keyboardType: widget.keyboardType,
      obscureText: widget.obscureText,
      onChanged: (value) {
        widget.formValues[widget.formProperty]![0] = value;
      },
      validator: widget.formValues[widget.formProperty]![1] == '1' ? (value) {
        if(value == null || value.isEmpty == true || value == ''){
          return 'Este campo es requerido';
        }else{
          if (widget.keyboardType.toString().contains('datetime')) {
            if (!regex.hasMatch(value)) return 'Este formato no es valido';
          }
        }
        return null;
      }:null,
      onTap: widget.keyboardType.toString().contains('datetime') ? () async {
        DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(DateTime.now().year+5),
        );
        if (pickedDate != null) {
          String formattedDate = dateFormat.format(pickedDate);
          controller.text = formattedDate;
                  widget.formValues[widget.formProperty]![0] = controller.text;

        }
      }:null,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration:  InputDecoration(
        hintText: widget.keyboardType.toString().contains('datetime') ? 'DD/MM/YYYY' : widget.hintText,
        labelText: widget.labelText,      
        helperText: widget.helperText,
        counterText: widget.counterText,
        //dentro del input del lado derecho
        suffixIcon: widget.keyboardType.toString().contains('datetime') ? const Icon(Icons.date_range) : (widget.suffixIcon == null ? null : Icon(widget.suffixIcon)),
        //dentro del input del lado izquierdo
        prefix: widget.prefix == null ? null : Icon(widget.prefix),
        //afuera del input lado izquierdo
        icon: widget.icon == null ? null : Icon(widget.icon),
        //aplica como border normal cuando seleccionas el input
         border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
        )
      ), 
    );
  }
}