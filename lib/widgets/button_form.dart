import 'package:app_seguimiento_movil/models/models.dart';
import 'package:app_seguimiento_movil/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:app_seguimiento_movil/services/services.dart';
import 'package:intl/intl.dart';


class ButtonForm extends StatelessWidget {
  final String textButton;
  final List<String> field;
  final Map<String, MultiInputsForm> formValue;
  final bool enabled;
  final List<List<String>>? listSelect;
  final int btnPosition;
  final int control;
  final TextEditingController controller;

  const ButtonForm({
    super.key,
    required this.textButton,
    required this.btnPosition,
    this.listSelect,
    required this.field,
    required this.formValue,
    required this.enabled, 
    required this.control, 
    required this.controller,     
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
                      newMethod(context, formValue, btnPosition);
                    }
                  : null,
          child: Text(textButton/*, style: MediaQuery.of(context).size.height < 960 && MediaQuery.of(context).size.width <600  ?
                    //para celulares
                    TextStyle(fontSize: MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .03: 0.015)):
                    //para tablets
                    TextStyle(fontSize: MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .02: 0.015) ,)*/
                    ),
                  )
                );
              }

  Future<String?> newMethod(BuildContext context,
    Map<String, MultiInputsForm> formValue, int btnPosition) {
    TextStyle myTextStyle = const TextStyle(
      color: Colors.black,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w700,
    );
    final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();
    List<Widget> inputFields = [];
    int i = 1;

    formValue.forEach((key, value) {
      inputFields.add(const SizedBox(height: 15));
      if (key.substring(0, 4) == "date") {
        inputFields.add(
          MultiInputs(
            maxLines: 1,
            controller:controller,
            autofocus: i == 1 ? true : false,
            labelText: field[i],
            formProperty: key,
            formValue: formValue,
            keyboardType: TextInputType.datetime),
        );
      } else {
        inputFields.add(
        MultiInputs(
          maxLines: key.contains("description")? 5 : 1 ,
          labelText: field[i], 
          controller: controller,
          autofocus: i == 1 ? true : false,
          formProperty: key,
          listSelect: listSelect,
          formValue: formValue,
          keyboardType: key.contains("number")? TextInputType.number : TextInputType.text));
      }

      i++;
      inputFields.add(const SizedBox(height: 15));

      
    });

    return showDialog<String>(
      context: context,
      builder: (BuildContext context ) => Dialog(
        insetPadding: 
        MediaQuery.of(context).size.height < 960 && MediaQuery.of(context).size.width <600  ?
          //para celulares
          EdgeInsets.fromLTRB(
          MediaQuery.of(context).size.width * .07,
          MediaQuery.of(context).size.height * .07,
          MediaQuery.of(context).size.width * .07,
          MediaQuery.of(context).size.height * .07,
        ):
          //para tablets
          EdgeInsets.fromLTRB(
          MediaQuery.of(context).size.width * .07,
          MediaQuery.of(context).size.height * .0,
          MediaQuery.of(context).size.width * .07,
          MediaQuery.of(context).size.height * .0,
          ),
        child: GestureDetector(
          onTap: () {
            SystemChannels.textInput.invokeMethod('TextInput.hide');
          },
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
        
                        DateFormat df = DateFormat("yyyy-MM-dd HH:mm:ss");
                        DateFormat df2 = DateFormat("dd/MM/yyyy");
        
                        switch (control) {
                          case 1:
                             //Inicio turno
                            if (btnPosition == 1) {
                              TurnVehicle t= TurnVehicle();
                              if (formValue['sign']!.contenido != '' && formValue['sign']!.contenido != null) {
                                t.name = formValue['name']!.contenido;
                                t.sign = formValue['sign']!.contenido;
                                t.turn = formValue['turn']!.contenido;
                                await dpser.postTurnVehicle(t);
                              }else {
                                return ; 
                              }
                             
                            }
        
                            //registro 
                            if (btnPosition == 2) {
                              RegisterVehicle r= RegisterVehicle();
                              r.color = formValue['color']!.contenido;
                              r.employeeName = formValue['employeeName']!.contenido;
                              r.plates = formValue['plates']!.contenido;
                              r.typevh = formValue['typevh']!.contenido;
                              r.departament = formValue['departament']!.contenido;
                              await dpser.postRegisterVehicle(r);
                              
                            }
        
                            //Agregar observaciones
                            if (btnPosition == 3) {
                              TurnVehicle t= TurnVehicle();
                              t.description = formValue['description']!.contenido;
                              await dpser.postObvVehicle(t);
                            }
        
                            break;
                          case 2:                        
                            //Inicio turno
                            if (btnPosition == 1) {
                              TurnFood t= TurnFood();
                              if(formValue['picture']!.contenido != '' && formValue['picture']!.contenido != null){
                                t.plate = formValue['plate']!.contenido;
                                t.garrison = formValue['garrison']!.contenido;
                                t.dessert = formValue['dessert']!.contenido;
                                t.received = formValue['received_number']!.contenido;
                                await dpser.postTurnFood(t);
                              }else{
                                return showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Llene todos los campos'),
                                      content: const Text('Por favor suba una foto del platillo.'),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Aceptar'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                              
                            }
        
                            //registro
                            if (btnPosition == 2) {
                              RegisterFood r= RegisterFood();
                              r.numEmployee = formValue['employee_number']!.contenido;
                              r.name = formValue['name']!.contenido;
                              switch (formValue['type_contract']!.contenido) {
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
                              t.description = formValue['description']!.contenido;
                              await dpser.postObvFood(t);
                            }
                            break;
                          default:
                          //Descargar reporte
                            if(btnPosition == 4) {
                              DateExcel de = DateExcel();
                              // print(formValue['date_start_hour']!.contenido);
                              de.dateStart = df.format(df2.parse(formValue['date_start_hour']!.contenido!));
                              de.dateFinal = df.format(df2.parse(formValue['date_final_hour']!.contenido!));
                              de.guard = formValue['guard']!.contenido;
                              var jsonStr = await dpser.selectDate(de);
                              // '[{"Nombre": "Juan", "Edad": 25, "Color de cabello": "Rojo","Estado civil": "casado"},{"Nombre": "Lizett", "Edad": 24, "Color de cabello": "Cafe","Estado civil": "casada"}, {"Nombre": "María", "Edad": 30, "Color de cabello": "verde","Estado civil": "soltera"}, {"Nombre": "Alonso", "Edad": 24, "Color de cabello":"negro","Estado civil": "casado"}]';
                              DateTime now = DateTime.now();
                              String formattedDate = DateFormat('yyyyMMddss').format(now);
                              String fileName = '$formattedDate.xlsx';
                              jsonToExcel(jsonStr, fileName, context);                        
                            }
                            break;
                        }
                      Provider.of<VarProvider>(context, listen: false).updateVariable(true);
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
      ),
    );
  }

}
