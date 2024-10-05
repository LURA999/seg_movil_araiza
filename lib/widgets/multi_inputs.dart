import 'package:app_seguimiento_movil/services/services.dart';
import 'package:app_seguimiento_movil/widgets/widgets.dart';
import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:flutter/services.dart';
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

// ignore: must_be_immutable
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
  final List<List<String>>? listSelectButton;
  final List<Map<String,dynamic>>? listSelectForm;
  final bool? autocompleteAsync;
  final int? screen; 
  final String formProperty;
  late Map<String, dynamic> formValue;
  final bool? activeListSelect;
  final bool? autofocus;
  final int? maxLength;
  late  TextEditingController? controller;
  Function(dynamic,List<String>)? onFormValueChange;
  Future<void> Function(dynamic)? onFieldSubmitted;
  
  MultiInputs({
    Key? key, 
    this.hintText, 
    this.maxLength,
    this.labelText, 
    this.helperText, 
    this.counterText,
    this.icon,
    this.suffixIcon,
    this.prefix,
    this.listSelectButton,
    this.listSelectForm,
    this.keyboardType,
    this.autocompleteAsync,
    this.onFieldSubmitted,
    this.obscureText = false,
    required this.formProperty,
    required this.formValue, 
    required this.maxLines, 
    required this.autofocus,
    this.onFormValueChange, 
    this.controller, 
    this.screen,
    this.activeListSelect, 
  }) : super(key: key);

  @override
  State<MultiInputs> createState() => _formValuetate();
}

class _formValuetate extends State<MultiInputs> {
final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    observation();
    setState(() { });
  }


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
      screen: widget.screen);
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
    if (widget.formValue[widget.formProperty]!.select ?? false ) {
      int indice = 0;
      widget.formValue.forEach((key, value) {
          if((widget.formValue[key] is RadioInput) == false ){
            if (((widget.formValue[key] as MultiInputsForm).select ?? false) == true /* && ((widget.formValue[key] as MultiInputsForm).activeListSelect ?? false) == true */) {
              indice++; 
              return;
            }
          } 
        });
      if (widget.activeListSelect == true || ((widget.formValue[widget.formProperty] as MultiInputsForm).activeListSelect ?? false) == true) {
        //En este puede cambiar el id de cada item de cada opcion, se hace por medio de
        return DropdownButtonWidget(arrSelect: widget.listSelectForm,formValue: widget.formValue,formProperty: widget.formProperty, type: 1,);
      } else {
        //En este ya viene una lista predefinida desde el mismo sistema, no hay un json predefinido, es solo un array
        return DropdownButtonWidget(list: widget.listSelectButton![indice-1],formValue: widget.formValue,formProperty: widget.formProperty, type: 2);
      }
    }

    if (widget.keyboardType.toString().contains('datetime') || widget.keyboardType == TextInputType.datetime) {
        MaterialTapTargetSize tapTargetSize = MaterialTapTargetSize.padded;
        DateFormat? format = DateFormat("yyyy-MM-dd${widget.formValue[widget.formProperty]!.activeClock == true?' HH:mm':''}");
        return DateTimeField(
        enabled: widget.formValue[widget.formProperty].enabled ?? true,
        initialValue: widget.formValue[widget.formProperty]!.contenido.toString()!= '0000-00-00' && widget.formValue[widget.formProperty]!.contenido.toString()!= '' && widget.formValue[widget.formProperty]!.contenido.toString() != 'null' ?DateFormat("yyyy-MM-dd").parse(widget.formValue[widget.formProperty]!.contenido.toString()): null,
        controller: widget.controller,
        style: getTextStyleText(context,null,null),
        format: format,
        onChanged: ((DateTime? date)  {
          if (date != null && widget.formValue[widget.formProperty]!.activeClock == true) {
              widget.formValue[widget.formProperty]!.contenido = DateFormat("yyyy-MM-dd HH:mm:ss").format(date);
            } else {
              if (date != null  && widget.formValue[widget.formProperty]!.activeClock == false) {
                widget.formValue[widget.formProperty]!.contenido = DateFormat("yyyy-MM-dd").format(date);
              }else{
                widget.formValue[widget.formProperty]!.contenido = '';
              }
            } 
        }),
        validator: widget.formValue[widget.formProperty]!.obligatorio == true ? (value ) {
            if(value == null || value == ''){
              return 'Este campo es requerido';
            }
            return null;
          }:null,
        decoration:  InputDecoration(
          enabled: widget.formValue[widget.formProperty].enabled ?? true,
          labelText: widget.labelText,
          labelStyle: getTextStyleText(context,null,null),
          prefixIcon: const Icon(Icons.date_range), 
          hintText: "yyyy-mm-dd ${widget.formValue[widget.formProperty]!.activeClock == true?'HH:mm':''}"
        ),
        onShowPicker: (context, currentValue) async {
          return await showDatePicker(
            context: context,
            firstDate: DateTime(1900),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime(2100),
            cancelText: 'Cancelar'
          ).then((DateTime? date) async {
            try {
              if (date != null && widget.formValue[widget.formProperty]!.activeClock == true) {
              final sendFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
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

              
              widget.formValue[widget.formProperty]!.contenido = sendFormat.format(DateTimeField.combine(date, time)); 
              return DateTimeField.combine(date, time);
            } else {

              if (date != null  && widget.formValue[widget.formProperty]!.activeClock == false) {
                final sendFormat = DateFormat("yyyy-MM-dd");
                sendFormat.format(date);
                widget.formValue[widget.formProperty]!.contenido = sendFormat.format(date);
                return DateTimeField.combine(date,null);
              }
              widget.formValue[widget.formProperty]!.contenido = currentValue;
              return currentValue;
            } 
            } catch (e) {
              print(e); 
            }
            return null;
            
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
          inputFormatters: widget.keyboardType == TextInputType.number ? [FilteringTextInputFormatter.digitsOnly] : null,
          onFieldSubmitted: widget.onFieldSubmitted,
          initialValue: widget.controller == null ? widget.formValue[widget.formProperty]!.contenido : null,
          keyboardType: widget.keyboardType,
          obscureText: widget.obscureText,
          maxLength: widget.maxLength,
          style: getTextStyleText(context,null,null),
          onChanged: (value) {
            setState(() {
             widget.formValue[widget.formProperty]!.contenido = value;

            });
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
            labelStyle: getTextStyleText(context,null,null),
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



  Future observation() async {
     switch (widget.formProperty) {
      //es para trafico
      case 'descriptionVehicle':
        VehicleService vs = VehicleService();
        AccessMap r = (await vs.getObservation(context));
        setState(() {
          widget.formValue['descriptionVehicle']!.contenido = r.container![0]['observation'];
          widget.controller!.text =  r.container![0]['observation'] ?? '';
        });
      break;
      case 'descriptionFood':
      FoodService fs = FoodService();
       AccessMap r = (await fs.getObservation(context));
        setState(() {
          widget.formValue['descriptionFood']!.contenido = r.container![0]['observation'];
          widget.controller!.text =  r.container![0]['observation']?? '';
        });
      break;
      case 'descriptionAssistance':
      AssistanceService as = AssistanceService();
       AccessMap r = (await as.getObservation(context));
       if(r.status == 200){
        setState(() {
          widget.formValue['descriptionAssistance']!.contenido = r.container![0]['observation'];
          widget.controller!.text =  r.container![0]['observation']?? '';
        });
       }
      break;
      case 'descriptionAssistance':
      AssistanceService as = AssistanceService();
       AccessMap r = (await as.getObservation(context));
       if(r.status == 200){
        setState(() {
          widget.formValue['descriptionAssistance']!.contenido = r.container![0]['observation'];
          widget.controller!.text =  r.container![0]['observation']?? '';
        });
       }
      break;
      default:

    }
    
  }

}
