import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class CustomInputField extends StatelessWidget {

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

  final String formProperty;
  final Map<String, List<String>> formValues;

  const CustomInputField({
    Key? key, 
    this.hintText, 
    this.labelText, 
    this.helperText, 
    this.counterText,
    this.icon,
    this.suffixIcon,
    this.prefix,
    this.keyboardType,
    this.obscureText = false,
    required this.formProperty,
    required this.formValues, 
    required this.maxLines
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RegExp regex = RegExp(
        r'^\d{2}\/(0[1-9]|1[0-2])\/\d{4}$',
    );
    final TextEditingController controller = TextEditingController();
    final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    return TextFormField(
      maxLines: maxLines,
      controller: controller,
      autofocus: false,
     // initialValue: '',
      textCapitalization: TextCapitalization.words,
      keyboardType: keyboardType,
      obscureText: obscureText,
      onChanged: (value) {
        formValues[formProperty]![0] = value;
      },
      validator: formValues[formProperty]![1] == '1' ? (value) {
        if(value == null || value.isEmpty == true || value == ''){
          return 'Este campo es requerido';
        }else{
          if (keyboardType.toString().contains('datetime')) {
            if (!regex.hasMatch(value)) return 'Este formato no es valido';
          }
        }
        return null;
      }:null,
      onTap: keyboardType.toString().contains('datetime') ? () async {
        DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(DateTime.now().year+5),
        );
        if (pickedDate != null) {
          String formattedDate = dateFormat.format(pickedDate);
          controller.text = formattedDate;
                  formValues[formProperty]![0] = controller.text;

        }
      }:null,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration:  InputDecoration(
        hintText: keyboardType.toString().contains('datetime') ? 'DD/MM/YYYY' : hintText,
        labelText: labelText,      
        helperText: helperText,
        counterText: counterText,
        //dentro del input del lado derecho
        suffixIcon: keyboardType.toString().contains('datetime') ? const Icon(Icons.date_range) : (suffixIcon == null ? null : Icon(suffixIcon)),
        //dentro del input del lado izquierdo
        prefix: prefix == null ? null : Icon(prefix),
        //afuera del input lado izquierdo
        icon: icon == null ? null : Icon(icon),
        //aplica como border normal cuando seleccionas el input
         border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
        )
      ), 
    );
  }
}