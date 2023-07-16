import 'package:flutter/material.dart';

import '../services/services.dart';

class AutocompleteCustom extends StatefulWidget {
  List<String>? goptions;  
  List<int>? goptionsId;
  final bool autocompleteAsync;
  final String? labelText;
  final String? formProperty;
  late Map<String, dynamic>? formValue;

   AutocompleteCustom({
    Key? key,
    required this.autocompleteAsync,
    this.labelText,
    required this.formProperty,
    required this.formValue,
    }) : super(key: key);

  @override
  State<AutocompleteCustom> createState() => __AutocompleteCustomState();
}

class __AutocompleteCustomState extends State<AutocompleteCustom> {
  List<String>? tempOptions; // Variable temporal para almacenar los resultados de la base de datos

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => 
      Autocomplete<String>(
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (widget.autocompleteAsync) {
            if (textEditingValue.text == '') {
              return const Iterable<String>.empty();
            } 
          }
          return (tempOptions ?? widget.goptions)!.where((String option) {
            return option.contains(textEditingValue.text.toLowerCase());
          });
        },
        onSelected: (String selection) {
        },
        optionsViewBuilder: (BuildContext context, AutocompleteOnSelected<String> onSelected,
          Iterable<String> options) {
            int index = 0;
            return Align(
              alignment: Alignment.topLeft,
              child: SizedBox( 
                height: options.length <4? options.length*65 : 65*3, // Ajusta la altura de la lista desplegable según sea necesario
                width: constraints.maxWidth, // Ajusta el ancho de la lista desplegable según sea necesario
                child:  Material(  
                  elevation: 3.0,
                  child: SingleChildScrollView(
                    child: Column(
                      key: widget.key,
                      children: options.isNotEmpty ? options.map((String option) => ListTile(
                        title: Text(option),
                        onTap: () {
                          onSelected(option);
                          if (!widget.autocompleteAsync) {
                            widget.formValue![widget.formProperty]!.contenido = widget.goptionsId![index];
                          }else{
                            widget.formValue![widget.formProperty]!.contenido = option;
                          }
                          index++;
                        },
                      )).toList() : [],
                    ),
                  ),
                ),
              ),
            );
          }, 
          fieldViewBuilder: (BuildContext context, TextEditingController fieldController,
          FocusNode fieldFocusNode, VoidCallback onFieldSubmitted) {
            return TextField(
              controller: fieldController,
              focusNode: fieldFocusNode,
              decoration: InputDecoration(
                hintText: widget.labelText
              ),
              key: widget.key,
              onChanged: (value) async {
                if (widget.autocompleteAsync) {
                  setState(() { 
                    tempOptions = [];
                  });
                    DepartamentService dp = DepartamentService();
                    List<Map<String,dynamic>> arr=  await dp.nameGuard(value);
                    for (var i = 0; i < arr.length; i++) {
                      setState(() { 
                        tempOptions!.add(arr[i]['name']);
                      });
                    }   
                  
                        
                  widget.formValue![widget.formProperty]!.contenido = value;
                    setState(() {
                      widget.goptions = tempOptions;
                      tempOptions = null; // Reiniciar la variable temporal
                    });
                  }
              },
            );
          },
        ),
    ); 
  }

  @override
  void initState() {
    // TODO: implement initState
    widget.goptions = [];
    widget.goptionsId = [];
    if (!widget.autocompleteAsync) {
      llenarOpciones();
    }
    super.initState();
  }

  Future llenarOpciones() async {
   DepartamentService dp = DepartamentService();
    List<Map<String,dynamic>> arr=  await dp.namesGuard();
    for (var i = 0; i < arr.length; i++) {
      widget.goptions!.add(arr[i]['name']);
      widget.goptionsId!.add(int.parse(arr[i]['id']));
    }
  }

}


