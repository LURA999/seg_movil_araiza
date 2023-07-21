import 'package:app_seguimiento_movil/services/services.dart';
import 'package:app_seguimiento_movil/widgets/widgets.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:app_seguimiento_movil/widgets/dropdown_button.dart';
import '../models/models.dart';

class Guard {
  String name;
  int id;

  Guard({
    required this.name,
    required this.id
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['id'] = id;
    return data;
  }
}

class MultiInputs extends StatefulWidget {

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
  final List<List<String>>? listSelect;
  final bool? autocompleteAsync;
  final int? screen; 
  final String formProperty;
  late Map<String, dynamic> formValue;
  final bool? autofocus;
  late  TextEditingController? controller;
  Function(dynamic,List<String>)? onFormValueChange;
  
  MultiInputs({
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
    this.autocompleteAsync,
    this.obscureText = false,
    required this.formProperty,
    required this.formValue, 
    required this.maxLines, 
    required this.autofocus,
    this.onFormValueChange, 
    this.controller, this.screen
    
  }) : super(key: key);

  @override
  State<MultiInputs> createState() => _formValuetate();
}

class _formValuetate extends State<MultiInputs> {
final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final RegExp regex = RegExp(
        r'^\d{2}\/(0[1-9]|1[0-2])\/\d{4}$',
    );

    //automcompletador
    if(widget.formValue[widget.formProperty]!.autocomplete ?? false){
      return AutocompleteCustom(
      formProperty: widget.formProperty,
      formValue: widget.formValue,
      autocompleteAsync: widget.autocompleteAsync!,
      labelText: widget.labelText,
      onFormValueChange: widget.onFormValueChange,
      screen: widget.screen!);
    }

    /** Ingrese una imagen*/
    if(widget.formValue[widget.formProperty]!.uploadFile ?? false){
      return ElevatedButton.icon(onPressed: () async {
         try{
          final XFile? image = await _picker.pickImage(source: ImageSource.camera);
          if (image != null) {
            widget.formValue[widget.formProperty]!.contenido = image.path;
          }
        }catch(Exception){
      }
      } , icon: const Icon(Icons.camera_alt_rounded), label: Text('Abrir camara',style: getTextStyleButtonField(context),));
    }
    
    /** Si entra aqui, entra para crear un select */
    if (widget.formValue[widget.formProperty]!.select ?? false) {
      int indice = 0;
      widget.formValue.forEach((key, value) {
        if(widget.formValue[key]!.select == true){
          indice++; 
          return;
        } 
      });
      return DropdownButtonWidget(list: widget.listSelect![indice-1],formValue: widget.formValue,formProperty: widget.formProperty);
    }

    if (widget.keyboardType.toString().contains('datetime')) {
      MaterialTapTargetSize tapTargetSize = MaterialTapTargetSize.padded;

        final format = DateFormat("yyyy-MM-dd HH:mm");
        return DateTimeField(
        controller: widget.controller,
        format: format,
        decoration: const InputDecoration(
          suffixIcon: Icon(Icons.date_range), 
          hintText: 'yyyy/mm/dd hh:mm'
        ),
        onShowPicker: (context, currentValue) async {
          return await showDatePicker(
            context: context,
            firstDate: DateTime(1900),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime(2100),
          ).then((DateTime? date) async {
            if (date != null) {
              final time = await showTimePicker(
              context: context,
              initialTime:
                  TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
              builder: (BuildContext context, Widget? child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    materialTapTargetSize: tapTargetSize,
                  ), 
                  child: 
                    MediaQuery(
                    data: MediaQuery.of(context).copyWith(
                      alwaysUse24HourFormat: true,
                    ), 
                    child: child!,
                  )
                );
                }
              );
              final sendFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
              widget.formValue[widget.formProperty]!.contenido = sendFormat.format(DateTimeField.combine(date, time)); 
              return DateTimeField.combine(date, time);
            } else {
              widget.formValue[widget.formProperty]!.contenido = currentValue;
              return currentValue;
            }
          });
        },
      );
    }

    /** Si entra aqui, entra a los 2 diferentes textformfield, 
     * como lo es el del calendario, y un input normal con diferentes personalizaciones (como subfijos,prefijos,hint etc)  */
    return TextFormField(
          maxLines: widget.maxLines,
          enabled: widget.formValue[widget.formProperty]!.enabled,
          controller: widget.controller,
          autofocus: widget.autofocus!,
          initialValue: widget.controller == null ? widget.formValue[widget.formProperty]!.contenido : null,
          textCapitalization: TextCapitalization.words,
          keyboardType: widget.keyboardType,
          obscureText: widget.obscureText,
          style: getTextStyleButtonField(context),
          onChanged: (value) {
            widget.formValue[widget.formProperty]!.contenido = value;
          },
          validator: widget.formValue[widget.formProperty]!.obligatorio == true ? (value) {
            if(value == null || value.isEmpty == true || value == ''){
              return 'Este campo es requerido';
            }else{
              if (widget.keyboardType.toString().contains('datetime')) {
                if (!regex.hasMatch(value)) return 'Este formato no es valido';
              }
            }
            return null;
          }:null,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration:  InputDecoration(
            hintText: widget.hintText,
            labelText: widget.labelText,      
            helperText: widget.helperText,
            counterText: widget.counterText,
            //dentro del input del lado derecho
            suffixIcon: (widget.suffixIcon == null ? null : Icon(widget.suffixIcon)),
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

  Future<void> openCamera() async {
  try{
  final XFile? image = await _picker.pickImage(source: ImageSource.camera);
  if (image != null) {
    widget.formValue[widget.formProperty]!.contenido = image.path;
  }
  }catch(Exception){
  }
  
}



  Future<String> observation() async {
    VehicleService vs = VehicleService();

     switch (widget.formProperty) {
      //es para trafico
      case 'description':
        AccessMap r = (await vs.getObservation(context));
        return r.container![0]['observation'].toString();

    }

    return '';
    
  }

}
