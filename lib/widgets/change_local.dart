import 'package:app_seguimiento_movil/models/models.dart';
import 'package:app_seguimiento_movil/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:app_seguimiento_movil/services/services.dart';
import '../models/multi_inputs_model.dart';


class ChangeLocal {

  final List<Map<String, dynamic>> arrList = [];
  final storage = FlutterSecureStorage();

  Future<void> chargeHotel(BuildContext context ) async {
    arrList.clear();
      LocalService lc = LocalService();
      final locals = await lc.getLocal(context);

      for (var el in locals.container) {
        if (int.parse(el['idLocal']) > 0) {
          arrList.add(el);
        }
      }
      final Map<String, MultiInputsForm> selectHotel = {
      'selectHotel': MultiInputsForm(
        contenido: await storage.read(key: 'idHotelRegister'), obligatorio: true, select: true, listSelectForm: arrList),
      };
      await obtenerIdentificadorApp(selectHotel,context);
  }


  String generarIdentificadorUnico(Map<String, MultiInputsForm> selectHotel) {
    return selectHotel['selectHotel']!.contenido!;
  }

  Future<void> obtenerIdentificadorApp(
    Map<String, MultiInputsForm> selectHotel, BuildContext context) async {
    String? identifier = await storage.read(key: 'idHotelRegister');
    final TextEditingController controller = TextEditingController();
    final TextEditingController controller2 = TextEditingController();
    bool obscureText = true;
    String password = '';
    bool autofucus = true;
    bool desactivar = false;

    // print(selectHotel['selectHotel']!.listselect);
    // ignore: use_build_context_synchronously
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return 
          StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return GestureDetector(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SingleChildScrollView(
                    child: AlertDialog(
                      title: Text('Seleccione el hotel',
                          style: getTextStyleTitle2(context, null)),
                      content: Column(children: [
                        MultiInputs(
                          formProperty: 'selectHotel',
                          formValue: selectHotel,
                          labelText: 'Selecciona un hotel',
                          listSelectForm:
                              selectHotel['selectHotel']!.listSelectForm,
                          autofocus: false,
                          controller: controller,
                          activeListSelect: true,
                          maxLines: 1,
                        ),
                        const SizedBox(height: 10,),
                        TextFormField(
                        controller: controller2,
                        enabled: true,
                        textAlign: TextAlign.center,
                        autofocus: autofucus,
                        obscureText: obscureText,
                        decoration: InputDecoration(
                        suffixIcon:IconButton(
                        icon: Icon( Icons.visibility ),
                        onPressed: () {
                           setState(() {
                             obscureText = !obscureText;
                           });
                        }),
                      ),
                      style: getTextStyleButtonField(context),
                      onChanged: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty || value == '' ) {
                            return 'Ingrese la contraseña';
                          } 
                          return null;
                        },
                      ),
                        ElevatedButton(
                        onPressed: () async {
                          LocalService lc = LocalService();
                          Access obj = await lc.compararPass(controller2.text, int.parse(selectHotel['selectHotel']!.contenido!), context);
                          if(obj.container['status']){
                          identifier =
                          generarIdentificadorUnico(selectHotel);
                          storage.write(
                              key: 'idHotelRegister',
                              value: identifier
                            );
                          Navigator.of(context).pop();
                          }
                          
                        },
                        child: Text('Aceptar',
                            style: getTextStyleButtonField(context)
                          )
                        ),
                      ]),
                    ),
                  )
                ],
              ),
            );
          });
        
      });
    
  }
}
  
