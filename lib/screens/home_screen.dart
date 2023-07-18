import 'package:flutter/material.dart';
import 'package:app_seguimiento_movil/services/services.dart';
import 'package:flutter/services.dart';

import '../services/letter_mediaquery.dart';

class HomeScreen extends StatelessWidget {
  
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle myTextStyle = const TextStyle(
      color: Colors.white,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w900,
    );
    
    return Scaffold(
        backgroundColor: const Color(0xFF293641),
        body: Column(
          children: [ 
           Container(
             alignment: Alignment.centerLeft,
             child: Padding(
               padding: EdgeInsets.fromLTRB(
                 MediaQuery.of(context).size.width * .05,
                 MediaQuery.of(context).size.height * (MediaQuery.of(context).orientation == Orientation.portrait ? .1 : 0.15),
                 MediaQuery.of(context).size.width * .05,
                 MediaQuery.of(context).size.height * (MediaQuery.of(context).orientation == Orientation.portrait ? .03 : 0.06),
               ),
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children:  [
                 Text('Departamentos',style: myTextStyle.copyWith(fontSize: MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .08: 0.04) )),
                 Text('Selecciona una opción:',style: myTextStyle.copyWith(fontSize: MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04 : 0.02))) 
                 ],
               ),
             ),
           ),
          Expanded(
              child: Ink(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only( topLeft: Radius.circular(35), topRight: Radius.circular(35) ),
                    color: Color.fromRGBO(246, 247, 252, 2)
                  ),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * (MediaQuery.of(context).orientation == Orientation.portrait ? 0.8 : 0.65),
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding:  EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width * .05,
                      MediaQuery.of(context).size.height * .05,
                      MediaQuery.of(context).size.width * .05,
                      MediaQuery.of(context).size.height * 0,
                    ),
                      child: GridView.count(
                        primary: false,
                        padding: const EdgeInsets.all(20),
                        crossAxisSpacing: 25,
                        mainAxisSpacing: 25,
                        crossAxisCount: (MediaQuery.of(context).orientation == Orientation.portrait ? 2: 3),
                        children: const [
                         ContainerOption(svg: 'Trafico',id: 1),
                         ContainerOption(svg: 'Recursos Humanos',id: 2),
                         ContainerOption(svg: 'Seguridad e Higiene',id: 3)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
    );
  }
}


class ContainerOption extends StatefulWidget {
  final String svg; 
  final int id; 

  const ContainerOption({
    super.key, 
    required this.svg,
    required this.id
  });

  @override
  State<ContainerOption> createState() => _ContainerOptionState();
}

class _ContainerOptionState extends State<ContainerOption> {
  final DepartamentService depService = DepartamentService(); 
  String? errorMessage;
  String password = '';
  bool autofucus = true;

  handleButtonPressed() async {
  var pass = await depService.checkPassWord(password, widget.id,context);
  if (pass.status == 200) {
    autofucus = false;
    switch (widget.id) {
      case 1:
        Navigator.of(context).pushNamed('control_vehicles');
        break;
      case 2:
        Navigator.of(context).pushNamed('control_rh');
        break;
      case 3:
        Navigator.of(context).pushNamed('control_seh');
        break;
      default:
    }
  }

  }

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Ink(
        height: 100,
        decoration: BoxDecoration(
            color: Colors.white, // Color de fondo del Ink
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.282),
                spreadRadius: 0.5,
                blurRadius: 1,
                offset: Offset(0, 1),
              ),
            ]),
        child: InkWell(
          onTap: () {
              TextEditingController textController = TextEditingController();
              showDialog(
                context: context,
                builder: (BuildContext context) => Dialog(
                insetPadding: 
                MediaQuery.of(context).size.height < 960 && MediaQuery.of(context).size.width <600  ?
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
                        child: Text('Ingrese la contraseña ',style: MediaQuery.of(context).size.height < 960 && MediaQuery.of(context).size.width <600  ?
                        //para celulares
                        TextStyle(fontSize: MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04: 0.015),fontWeight: FontWeight.bold):
                        //para tablets
                        TextStyle(fontSize: MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .02: 0.015),fontWeight: FontWeight.bold,)),
                      ),
                      TextFormField(
                      controller: textController,
                      enabled: true,
                      textAlign: TextAlign.center,
                      autofocus: autofucus,
                      obscureText: true,
                      style: getTextStyleButtonField(context),
                      onChanged: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                            return 'Ingrese la contraseña';
                          } 
                          return null;
                        },
                      onEditingComplete: () => handleButtonPressed,
                      ),
                      
                      const SizedBox(height: 10,),
                      ElevatedButton(
                      onPressed: handleButtonPressed,
                      child: Text('Ingresar',style:  getTextStyleButtonField(context)),
                      )
                      ]
                      ),
                    ),
                ),
                )
              )
            );
          },
          child: Container(
            height: MediaQuery.of(context).size.height * (MediaQuery.of(context).orientation == Orientation.portrait ? 0.05 : 0.1),
            //Si es verdadero, se tiene que aplicar para celulares, y si no, para tablets
            /** Medidas genericas desde cuando un movil se convierte en una tablet */
            padding: MediaQuery.of(context).size.height < 960 && MediaQuery.of(context).size.width <600  ?
                  ( MediaQuery.of(context).orientation == Orientation.portrait ? 
                  EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * .03,
                    MediaQuery.of(context).size.height * .03,
                    MediaQuery.of(context).size.width * .03,
                    MediaQuery.of(context).size.height * .03) 
                  : EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * .06,
                    MediaQuery.of(context).size.height * .06,
                    MediaQuery.of(context).size.width * .06,
                    MediaQuery.of(context).size.height * .06 ) )
                  : (
                   EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * .06,
                    MediaQuery.of(context).size.height * .06,
                    MediaQuery.of(context).size.width * .06,
                    MediaQuery.of(context).size.height * .06 )
                  )
                  ,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Image.asset(
              'assets/images/main/${widget.svg}.png',
              height: 200,
            ),
          ),
        ),
      ),
    ); 
  }

  @override
  void initState() {
    super.initState();
    SystemChannels.textInput.invokeMethod('TextInput.hide');

  }
  
}


