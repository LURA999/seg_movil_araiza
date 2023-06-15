import 'package:app_seguimiento_movil/models/models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_seguimiento_movil/services/services.dart';
import 'package:app_seguimiento_movil/widgets/widgets.dart';
import 'package:intl/intl.dart';


class ButtonForm extends StatelessWidget {
  final String textButton;
  final List<String> field;
  final Map<String, List<Object?>> formValues;
  final bool enabled;
  final List<List<String>>? listSelect;
  final int btnPosition;
  final int control;
  
  const ButtonForm({
    super.key,
    required this.textButton,
    required this.btnPosition,
    this.listSelect,
    required this.field,
    required this.formValues,
    required this.enabled, 
    required this.control,
    
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
          child: Text(textButton,style: MediaQuery.of(context).size.height < 960 && MediaQuery.of(context).size.width <600  ?
                    //para celulares
                    TextStyle(fontSize: MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .03: 0.015)):
                    //para tablets
                    TextStyle(fontSize: MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .02: 0.015),)
                    ),
                  )
                );
              }

  Future<String?> newMethod(BuildContext context,
    Map<String, List<Object?>> formValues, int btnPosition) {
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
      if (key.substring(0, 4) == "date") {
        inputFields.add(
          CustomInputField(
            maxLines: 1,
            autofocus: i == 1 ? true : false,
            labelText: field[i],
            formProperty: key,
            formValues: formValues,
            keyboardType: TextInputType.datetime),
        );
      } else {
        inputFields.add(
        CustomInputField(
          maxLines: key.contains("description")? 5 : 1 ,
          labelText: field[i], 
          autofocus: i == 1 ? true : false,
          formProperty: key,
          listSelect: listSelect,
          formValues: formValues,
          keyboardType: key.contains("number")? TextInputType.number : TextInputType.text));
      }

      i++;
      inputFields.add(const SizedBox(height: 15));

      
    });

    return showDialog<String>(
      context: context,
      builder: (BuildContext ) => Dialog(
        insetPadding: EdgeInsets.fromLTRB(
          MediaQuery.of(context).size.width * .07,
          MediaQuery.of(context).size.height * .07,
          MediaQuery.of(context).size.width * .07,
          MediaQuery.of(context).size.height * .07,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
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
                      Navigator.pop(context);
                    },
                    child:  Text('Cerrar',style: MediaQuery.of(context).size.height < 960 && MediaQuery.of(context).size.width <600  ?
                    //para celulares
                    TextStyle(fontSize: MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .03: 0.015)):
                    //para tablets
                    TextStyle(fontSize: MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .02: 0.015),)),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                      if(!myFormKey.currentState!.validate()){
                        return ;
                      }
                      DepartamentService dpser = DepartamentService();

                      Provider.of<VarProvider>(context, listen: false).updateVariable(true);
                      DateFormat df = DateFormat("yyyy-MM-dd HH:mm:ss");
                      DateFormat df2 = DateFormat("dd/MM/yyyy");

                      switch (control) {
                        case 1:
                           //Inicio turno
                          if (btnPosition == 1) {
                            TurnVehicle t= TurnVehicle();
                            
                            t.name = formValues['name']![0].toString();
                            t.sign = formValues['sign']![0].toString();
                            t.turn = formValues['turn']![0].toString();
                            await dpser.postTurnVehicle(t);
                          }

                          //registro
                          if (btnPosition == 2) {
                            RegisterVehicle r= RegisterVehicle();
                            r.color = formValues['color']![0].toString();
                            r.employeeName = formValues['employeeName']![0].toString();
                            r.plates = formValues['plates']![0].toString();
                            r.typevh = formValues['typevh']![0].toString();
                            r.departament = formValues['departament']![0].toString();
                            await dpser.postRegisterVehicle(r);
                            
                          }

                          //Agregar observaciones
                          if (btnPosition == 3) {
                            TurnVehicle t= TurnVehicle();
                            t.description = formValues['description']![0].toString();
                            await dpser.postObvVehicle(t);
                          }

                          break;
                        case 2:                        
                          //Inicio turno
                          if (btnPosition == 1) {
                            TurnFood t= TurnFood();
                            t.plate = formValues['plate']![0].toString();
                            t.garrison = formValues['garrison']![0].toString();
                            t.dessert = formValues['dessert']![0].toString();
                            t.received = formValues['received_number']![0].toString();
                            await dpser.postTurnFood(t);
                          }

                          //registro
                          if (btnPosition == 2) {
                            RegisterFood r= RegisterFood();
                            r.numEmployee = formValues['employee_number']![0].toString();
                            r.name = formValues['name']![0].toString();
                            switch (formValues['type_contract']![0].toString()) {
                              case 'Sindicalizado':
                                r.contract = '1';
                                break;
                              case 'No sindicalizado':
                                r.contract = '2';
                                break;
                              case 'Corporativo':
                                r.contract = '3';
                                break;  
                              default:
                            }
                            await dpser.postRegisterFood(r);
                            
                          }

                          //Agregar observaciones
                          if (btnPosition == 3) {
                            TurnFood t= TurnFood();
                            t.description = formValues['description']![0].toString();
                            await dpser.postObvFood(t);
                          }
                          break;
                        default:
                        //Descargar reporte
                          if(btnPosition == 4) {
                            DateExcel de = DateExcel();
                            // print(formValues['date_start_hour']![0].toString());
                            de.dateStart = df.format(df2.parse(formValues['date_start_hour']![0].toString()));
                            de.dateFinal = df.format(df2.parse(formValues['date_final_hour']![0].toString()));
                            de.guard = formValues['guard']![0].toString();
                            var jsonStr = await dpser.selectDate(de);
                            // '[{"Nombre": "Juan", "Edad": 25, "Color de cabello": "Rojo","Estado civil": "casado"},{"Nombre": "Lizett", "Edad": 24, "Color de cabello": "Cafe","Estado civil": "casada"}, {"Nombre": "María", "Edad": 30, "Color de cabello": "verde","Estado civil": "soltera"}, {"Nombre": "Alonso", "Edad": 24, "Color de cabello":"negro","Estado civil": "casado"}]';
                            DateTime now = DateTime.now();
                            String formattedDate = DateFormat('yyyyMMddss').format(now);
                            String fileName = '$formattedDate.xlsx';
                            jsonToExcel(jsonStr, fileName, context);                        
                          }
                          break;
                      }
                     
                    Navigator.pop(context);

                    },
                    child: Text(field[0],style: MediaQuery.of(context).size.height < 960 && MediaQuery.of(context).size.width <600  ?
                    //para celulares
                    TextStyle(fontSize: MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .03: 0.015)):
                    //para tablets
                    TextStyle(fontSize: MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .02: 0.015),)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}
