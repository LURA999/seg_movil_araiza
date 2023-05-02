import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_seguimiento_movil/services/services.dart';
import 'package:app_seguimiento_movil/widgets/widgets.dart';


class ButtonForm extends StatelessWidget {
  final String textButton;
  final List<String> field;
  final Map<String, List<String>> formValues;
  final bool enabled;
  final int btnPosition;
  const ButtonForm({
    super.key,
    required this.textButton,
    required this.btnPosition,
    required this.field,
    required this.formValues,
    required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
            ),
          ),
          onPressed:
              (Provider.of<VarProvider>(context).myGlobalVariable || enabled)
                  ? () {
                      newMethod(context, formValues, btnPosition);
                    }
                  : null,
          child: Text(textButton),
        ));
  }

  Future<String?> newMethod(BuildContext context,
    Map<String, List<String>> formValues, int btnPosition) {
    TextStyle myTextStyle = const TextStyle(
      color: Colors.black,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w700,
    );
    final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();
    List<Widget> inputFields = [];
    int i = 1;

    formValues.forEach((key, value) {
      inputFields.add(const SizedBox(height: 15));
      if (key.substring(0, 5) == "fecha") {
        inputFields.add(
          CustomInputField(
            maxLines: 1,
            labelText: field[i],
            formProperty: key,
            formValues: formValues,
            keyboardType: TextInputType.datetime),
        );
      } else {
        inputFields.add(CustomInputField(
          maxLines: key.contains("descripcion")? 5 : 1 ,
          labelText: field[i], 
          formProperty: key, 
          formValues: formValues));
      }
      i++;
      inputFields.add(const SizedBox(height: 15));

      
    });

    return showDialog<String>(
      context: context,
      builder: (BuildContext context2) => Dialog(
        insetPadding: EdgeInsets.fromLTRB(
          MediaQuery.of(context2).size.width * .07,
          MediaQuery.of(context2).size.height * .07,
          MediaQuery.of(context2).size.width * .07,
          MediaQuery.of(context2).size.height * .07,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            //Este codigo es para mentener el encabezado en la parte superior
            /* Padding(
              padding: EdgeInsets.fromLTRB(
                 MediaQuery.of(context).size.width * .1,
                 MediaQuery.of(context).size.height * .1,
                 MediaQuery.of(context).size.width * .1,
                 MediaQuery.of(context).size.height * .1,
               ),
              child: Text(
                field[0],
                style: myTextStyle.copyWith(
                  fontSize: MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .08 : 0.04),
                ),
              ),
            ), */
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * .07,
                    MediaQuery.of(context).size.height * .1,
                    MediaQuery.of(context).size.width * .1,
                    MediaQuery.of(context).size.height * .07,
                  ),
                  child: Form(
                    key: myFormKey,
                    child: Column(children: [
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(field[0],
                            style: myTextStyle.copyWith(
                              fontSize: MediaQuery.of(context).size.width *
                                  (MediaQuery.of(context).orientation ==
                                          Orientation.portrait
                                      ? .08
                                      : 0.04),
                            )),
                      ),
                      ...inputFields,
                    ]),
                  ),
                ),
              ),
            ),
            SizedBox(
              child: ButtonBar(
                alignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context2);
                    },
                    child: const Text('Cerrar'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if(!myFormKey.currentState!.validate()){
                        return ;
                      }


                      if (btnPosition == 1) {
                        Provider.of<VarProvider>(context2, listen: false)
                            .updateVariable(true);
                        Navigator.pop(context2);
                      }

                      if(btnPosition == 4) {
                        const jsonStr = 
                        '[{"Nombre": "Juan", "Edad": 25, "Color de cabello": "Rojo","Estado civil": "casado"},{"Nombre": "Lizett", "Edad": 24, "Color de cabello": "Cafe","Estado civil": "casada"}, {"Nombre": "María", "Edad": 30, "Color de cabello": "verde","Estado civil": "soltera"}, {"Nombre": "Alonso", "Edad": 24, "Color de cabello":"negro","Estado civil": "casado"}]';
                        const fileName = 'ejemplo.xlsx';
                        jsonToExcel(jsonStr, fileName, context2);                        
                      }
                    },
                    child: Text(field[0]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void converExcel(){

  }
}
