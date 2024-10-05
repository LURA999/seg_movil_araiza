import 'package:app_seguimiento_movil/services/services.dart';
import 'package:app_seguimiento_movil/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/models.dart';

class SehControl extends StatelessWidget {
  const SehControl({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
  bool desactivar = false;
  final DepartamentService depService = DepartamentService(); 
  String password = '';
  bool autofucus = true;
  bool obscureText = true; 

   List<Option> opciones = [
      Option(
        title: 'Recorrido de áreas',
        description: 'Revisión de las instalaciones por el comité de Seguridad e Higiene.',
        img: 'assets/images/main/tour_of_areas.svg',
        width : 0.3,
        navigator: () {
          Navigator.of(context).pushNamed('routes_seh');
        }
      ),
       Option(
        title: 'Examen médico',
        description: 'Creación y consulta de expedientes de colaboradores.',
        img: 'assets/images/main/medical_exam.svg',
        width :  0.1,
        navigator:  () {
          TextEditingController textController = TextEditingController();

          showDialog(
          context: context, // Accede al contexto del widget actual
          builder: (BuildContext context) {
            return 
            Stack(
              children: [
                const ModalBarrier(
                  dismissible: false,
                  color:  Color.fromARGB(80, 0, 0, 0),
                ),
                StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) { 
                    handleButtonPressed() async {
                    setState(() {
                      desactivar = true;
                    }); 
                    var pass = await depService.checkPassWord(password, 4,context);
                    if (pass.status == 200) {
                      autofucus = false;
                      Navigator.of(context).pushNamed('medical_records');
                    }else{
                    setState(() {
                        desactivar = false;
                      });
                    }
                    }
                      return Dialog(
                        insetPadding: 
                        MediaQuery.of(context).size.height < 960 && MediaQuery.of(context).size.width <500  ?
                          //para celulares
                          EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width * .2,
                          MediaQuery.of(context).size.height * .0,
                          MediaQuery.of(context).size.width * .2,
                          MediaQuery.of(context).size.height * .0,
                        ):
                        //para tablets
                        EdgeInsets.fromLTRB(
                        MediaQuery.of(context).size.width * .3,
                        MediaQuery.of(context).size.height * .0,
                        MediaQuery.of(context).size.width * .3,
                        MediaQuery.of(context).size.height * .0,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          SystemChannels.textInput.invokeMethod('TextInput.hide');
                        },
                      child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column ( 
                        children:[
                        Container(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Center(child: Text('Ingrese la contraseña ',style: getTextStyleTitle2(context,null))),
                        ),
                        TextFormField(
                        controller: textController,
                        enabled: true,
                        textAlign: TextAlign.center,
                        autofocus: autofucus,
                        obscureText: obscureText,
                        decoration: InputDecoration(
                        suffixIcon:IconButton(
                        icon: const Icon( Icons.visibility ),
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
                      onEditingComplete: desactivar == false ? handleButtonPressed : null,
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Salir',style:  getTextStyleButtonField(context)),
                          ),
                          const SizedBox(width: 10,), 
                          ElevatedButton(
                          onPressed:  desactivar == false ? handleButtonPressed : null,
                          child: Text('Ingresar',style:  getTextStyleButtonField(context)),
                          ),
                        ],
                      )]
                      ),
                    ),
                ),
                )
              );
          })]);
        }
       );
  })];


    return Scaffold(
      
      backgroundColor: const Color.fromRGBO(246, 247, 252, 2),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: 
                    MediaQuery.of(context).orientation == Orientation.portrait ? 
                    EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * .05,
                    MediaQuery.of(context).size.height * .05,
                    MediaQuery.of(context).size.width * .05,
                    MediaQuery.of(context).size.height * .02)
                    :
                    EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * .05,
                    MediaQuery.of(context).size.height * .1,
                    MediaQuery.of(context).size.width * .05,
                    MediaQuery.of(context).size.height * .02)
                    ,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Text('Seguridad e Higiene',style: getTextStyleTitle(context, null) ),
                        Text('Selecciona una opción:',style: getTextStyleTitle2(context, null)),
                        ]
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * .05,
                    MediaQuery.of(context).size.height * .0,
                    MediaQuery.of(context).size.width * .05,
                    MediaQuery.of(context).size.height * .0),
                    child:  TableCustom(opciones: opciones),
                  ),
                 
                ],
              ),
            ),
          ),
          const SizedBox(child: Navbar(contexto2: 'control_seh'))
        ],
      ),
    );
  }
}

