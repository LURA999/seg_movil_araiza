import 'package:app_seguimiento_movil/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:app_seguimiento_movil/services/services.dart';
import 'package:intl/intl.dart';


class ButtonForm extends StatelessWidget {
  final String textButton;
  final List<String> field;
  final Map<String, MultiInputs> MultiInputss;
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
    required this.MultiInputss,
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
                      newMethod(context, MultiInputss, btnPosition);
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
    Map<String, MultiInputs> MultiInputss, int btnPosition) {
    TextStyle myTextStyle = const TextStyle(
      color: Colors.black,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w700,
    );
    final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();
    List<Widget> inputFields = [];
    int i = 1;

    MultiInputss.forEach((key, value) {
      inputFields.add(const SizedBox(height: 15));
      if (key.substring(0, 4) == "date") {
        inputFields.add(
          MultiInputs(
            maxLines: 1,
            controller:controller,
            autofocus: i == 1 ? true : false,
            labelText: field[i],
            formProperty: key,
            MultiInputss: MultiInputss,
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
          MultiInputss: MultiInputss,
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
                              if (MultiInputss['sign']!.contenido != '' && MultiInputss['sign']!.contenido != null) {
                                t.name = MultiInputss['name']!.contenido;
                                t.sign = MultiInputss['sign']!.contenido;
                                t.turn = MultiInputss['turn']!.contenido;
                                await dpser.postTurnVehicle(t);
                              }else {
                                return ; 
                              }
                             
                            }
        
                            //registro 
                            if (btnPosition == 2) {
                              RegisterVehicle r= RegisterVehicle();
                              r.color = MultiInputss['color']!.contenido;
                              r.employeeName = MultiInputss['employeeName']!.contenido;
                              r.plates = MultiInputss['plates']!.contenido;
                              r.typevh = MultiInputss['typevh']!.contenido;
                              r.departament = MultiInputss['departament']!.contenido;
                              await dpser.postRegisterVehicle(r);
                              
                            }
        
                            //Agregar observaciones
                            if (btnPosition == 3) {
                              TurnVehicle t= TurnVehicle();
                              t.description = MultiInputss['description']!.contenido;
                              await dpser.postObvVehicle(t);
                            }
        
                            break;
                          case 2:                        
                            //Inicio turno
                            if (btnPosition == 1) {
                              TurnFood t= TurnFood();
                              if(MultiInputss['picture']!.contenido != '' && MultiInputss['picture']!.contenido != null){
                                t.plate = MultiInputss['plate']!.contenido;
                                t.garrison = MultiInputss['garrison']!.contenido;
                                t.dessert = MultiInputss['dessert']!.contenido;
                                t.received = MultiInputss['received_number']!.contenido;
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
                              r.numEmployee = MultiInputss['employee_number']!.contenido;
                              r.name = MultiInputss['name']!.contenido;
                              switch (MultiInputss['type_contract']!.contenido) {
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
                              t.description = MultiInputss['description']!.contenido;
                              await dpser.postObvFood(t);
                            }
                            break;
                          default:
                          //Descargar reporte
                            if(btnPosition == 4) {
                              DateExcel de = DateExcel();
                              // print(MultiInputss['date_start_hour']!.contenido);
                              de.dateStart = df.format(df2.parse(MultiInputss['date_start_hour']!.contenido!));
                              de.dateFinal = df.format(df2.parse(MultiInputss['date_final_hour']!.contenido!));
                              de.guard = MultiInputss['guard']!.contenido;
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
