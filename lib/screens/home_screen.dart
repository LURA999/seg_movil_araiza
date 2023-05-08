import 'package:flutter/material.dart';


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
            child: Container(
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

  bool isHovering = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTapDown: (value) {
          setState(() {
            isHovering = true;
          });
        },
        onTapUp: (value) {
          setState(() {
            isHovering = false;
          });
        },
        onTap: () {
           

            showDialog(
              context: context,
              builder: (BuildContext context) {
                final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();
                final textController = TextEditingController();
                
                 handleButtonPressed() {
                    FocusScope.of(context).requestFocus( FocusNode());

                    if(!myFormKey.currentState!.validate()){
                      return ;
                    } 
                    if (widget.id == 1) {
                        Navigator.of(context).pushNamed('control_vehiculos');
                    }
                  }
              return  Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AlertDialog(
                    title: const Text('Ingrese la contraseña '),
                    content: Form(
                      key: myFormKey,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextFormField(
                              controller: textController,
                              enabled: widget.id == 1 ? true : false,
                              textAlign: TextAlign.center,
                              obscureText: true,
                              validator: (value) {
                              if (value == null || value.isEmpty || value == '') {
                                return 'Ingrese la contraseña';
                              } else if (value != '1234') {
                                return 'Contraseña invalida';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10,),
                          ElevatedButton(
                            onPressed: widget.id == 1 ? handleButtonPressed : null,
                            child: const Text('Ingresar',style: TextStyle()),
                          )
                          ]
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
          );
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: MediaQuery.of(context).size.height * (MediaQuery.of(context).orientation == Orientation.portrait ? 0.005 : 0.005),
          padding: EdgeInsets.all((MediaQuery.of(context).orientation == Orientation.portrait ? 8 : 20)),
          decoration: BoxDecoration(
            color: isHovering ?const Color.fromARGB(255, 245, 245, 245) : Colors.white,
            boxShadow: const[
              BoxShadow(
                color:  Color.fromRGBO(0, 0, 0, 0.282),
                spreadRadius: 0.5,
                blurRadius: 1,
                offset:  Offset(0, 1),
              ),
            ],
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * .05,
                  MediaQuery.of(context).size.height * .05,
                  MediaQuery.of(context).size.width * .05,
                  MediaQuery.of(context).size.height * .05,
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
}