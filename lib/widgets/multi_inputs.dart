import 'dart:convert';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:app_seguimiento_movil/models/models.dart';
import 'package:app_seguimiento_movil/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:app_seguimiento_movil/widgets/dropdown_button.dart';
import 'package:flutter_signature_pad/flutter_signature_pad.dart';
import 'dart:ui' as ui;



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
  final String formProperty;
  final Map<String, dynamic> formValue;
  final bool? autofocus;
  final TextEditingController? controller;

  
  const MultiInputs({
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
    required this.formValue, 
    required this.maxLines, 
    required this.autofocus, 
    this.controller
    
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
    final DateFormat dateFormat = DateFormat('dd/MM/yyyy');

    /** Ingrese una imagen*/
    if(widget.formValue[widget.formProperty]!.uploadFile == true){
      return ElevatedButton.icon(onPressed: openCamera, icon: const Icon(Icons.camera_alt_rounded), label: const Text('Abrir camara'));
    }
    
    /**SI entra aqui, es porque este espacio es un paint_asignature */
    if(widget.formValue[widget.formProperty]!.paintSignature == true){
      final _sign = GlobalKey<SignatureState>();
      ByteData _img = ByteData(0);

      return Column(
        children: [
          Text( widget.labelText.toString()),
          SizedBox(
            height: MediaQuery.of(context).size.height *.3,
            width: MediaQuery.of(context).size.width,
            child: Container( 
              decoration: BoxDecoration(
              border: Border.all(color: AppTheme.primary)
            ),
              child: Signature(
                key: _sign,
                onSign: () async {
                    final sign = _sign.currentState;
                     final image = await sign!.getData();
                      var data = await image.toByteData(format: ui.ImageByteFormat.png);
                      final encoded = base64.encode(data!.buffer.asUint8List());
                      widget.formValue[widget.formProperty]!.contenido = encoded;
                },
                color: Colors.black,
                strokeWidth: 3,
              ),
            ),
          ),
          _img.buffer.lengthInBytes == 0 ? Container() : LimitedBox(maxHeight: 200.0, child: Image.memory(_img.buffer.asUint8List())),
           ElevatedButton.icon(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              final sign = _sign.currentState;
              sign!.clear();
              setState(() {
                _img = ByteData(0);
                widget.formValue[widget.formProperty]!.contenido = null;
              });
              // debugPrint("cleared");
            },
            label: const Text('BORRAR'),
            
            ),
        ],
      );
    }

    /** Si entra aqui, entra para crear un select */
    if (widget.formValue[widget.formProperty]!.select == true) {
      int indice = 0;
      widget.formValue.forEach((key, value) {
        if(widget.formValue[key]!.select == true){
          indice++; 
          return;
        } 
      });
      return DropdownButtonWidget(list: widget.listSelect![indice-1],formValue: widget.formValue,formProperty: widget.formProperty);
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
          style: 
          MediaQuery.of(context).size.height < 960 && MediaQuery.of(context).size.width <600  ?
          //para celulares
          TextStyle(fontSize: MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .03: 0.015)):
          //para tablets
          TextStyle(fontSize: MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .02: 0.015)),
          
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
          onTap: widget.keyboardType.toString().contains('datetime') ? () async {
            DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime(DateTime.now().year+5),
            );
            if (pickedDate != null) {
              String formattedDate = dateFormat.format(pickedDate);
              widget.controller!.text = formattedDate;
              widget.formValue[widget.formProperty]!.contenido = widget.controller!.text;
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

  Future<void> openCamera() async {
  final XFile? image = await _picker.pickImage(source: ImageSource.camera);
  if (image != null) {
    widget.formValue[widget.formProperty]!.contenido = image.path;
  }
}

}
