import 'dart:ui';
import 'package:app_seguimiento_movil/models/models.dart';
import 'package:app_seguimiento_movil/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:app_seguimiento_movil/services/services.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../models/multi_inputs_model.dart';
import 'package:universal_platform/universal_platform.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final storage = FlutterSecureStorage();

class _HomeScreenState extends State<HomeScreen> {
  String version = '3.3.2';
  
  final List<Map<String, dynamic>> arrList = [];

  Future<void> chargeHotel() async {
    String? identifier = await storage.read(key: 'idHotelRegister');
    if (identifier == null) {
      LocalService lc = LocalService();
      final locals = await lc.getLocal(context);
      // print('local ${locals.container.toString()}');
      for (var el in locals.container) {
        if (int.parse(el['idLocal']) > 0) {
          arrList.add(el);
        }
      }
      
      final Map<String, MultiInputsForm> selectHotel = {
      'selectHotel': MultiInputsForm(
        contenido: '', obligatorio: true, select: true, listSelectForm: arrList),
      };
      obtenerIdentificadorApp(selectHotel);
    }
    
  }

  DateTime now = DateTime.now();
  Future<void> downloadAndInstallUpdate(BuildContext context) async {
    VersionService versServ = VersionService();

    final versionLast = (await versServ.getLastVersion(context));
    if( versionLast[0]['version'] != version){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Actualizar la aplicación',style: getTextStyleText(context,FontWeight.bold,null),),
          content: Container(
            height: MediaQuery.of(context).size.height * 0.3,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('¿Deseas instalar la actualización "${versionLast[0]['version']}", usted tiene la version $version?',style: getTextStyleText(context,null,null),),
                  SizedBox(height:10),  
                  
                  Text(versionLast[0]['description'].replaceAll(r'\n', '\n'), style: getTextStyleText(context,null,null),)
                ],
              ),
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Instalar'),
              onPressed: () async {
                Navigator.of(context).pop();
                // Iniciar el proceso de instalación
                //  final String urlString = 'file://${file.path}';
                //  final url = Uri.parse('$urlString');
                // final documentsDirectory = (await getDownloadDirectoryPath());
                // final file = File('$documentsDirectory/app-movilDepartaments.apk');
                // await file.writeAsBytes(response.bodyBytes);

                // print(file.path);
                //  await OpenFile.open(file.path);
                if (await canLaunchUrlString('https://www.comunicadosaraiza.com/apps_release/app-movilDepartaments-${versionLast[0]['version']}.apk')) {
                   await launchUrlString('https://www.comunicadosaraiza.com/apps_release/app-movilDepartaments-${versionLast[0]['version']}.apk',
                  mode: LaunchMode.externalApplication);
                } 
              },
            ),
          ],
        );
      },
    );
    }
}


  String generarIdentificadorUnico(Map<String, MultiInputsForm> selectHotel) {
    return selectHotel['selectHotel']!.contenido!;
  }

  Future obtenerIdentificadorApp(
      Map<String, MultiInputsForm> selectHotel) async {
    String? identifier = await storage.read(key: 'idHotelRegister');
    final TextEditingController controller = TextEditingController();
    bool obscureText = true;
    String password = '';
    bool autofucus = true;
    bool desactivar = false;

    if (identifier == null) {
      // print(selectHotel['selectHotel']!.listselect);
      // ignore: use_build_context_synchronously
    showDialog(
      context: context,
      builder: (BuildContext context) {
      final TextEditingController controller2 = TextEditingController();
        return Stack(children: [
            BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0), // Ajusta el valor de sigmaX y sigmaY para controlar el desenfoque
            child: Container(
              color: const Color.fromARGB(40, 0, 0, 0).withOpacity(0.5), // Puedes ajustar la opacidad y el color
            ),
          ),
          const ModalBarrier(
            dismissible: false,
          ),
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
                              if (obj.container['status']) {
                                identifier =
                                generarIdentificadorUnico(selectHotel);
                                storage.write(
                                    key: 'idHotelRegister',
                                    value: identifier);
                              
                                Navigator.of(context).pop();
                              }
                             
                            },
                            child: Text('Aceptar',
                                style: getTextStyleButtonField(context))),
                      ]),
                    ),
                  )
                ],
              ),
            );
          })
        ]);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    SystemChannels.textInput.invokeMethod('TextInput.hide');

    chargeHotel().then((value) {
      if (!UniversalPlatform.isWeb ) {
        downloadAndInstallUpdate(context);
      }
    }
    
    ); 
    
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF293641),
        body: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * .05,
                  MediaQuery.of(context).size.height *
                      (MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? .1
                          : 0.15),
                  MediaQuery.of(context).size.width * .05,
                  MediaQuery.of(context).size.height *
                      (MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? .03
                          : 0.06),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Departamentos',
                        style: getTextStyleTitleHome(
                            context,
                            Colors
                                .white) /* myTextStyle.copyWith(fontSize: MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .08: 0.04) ) */),
                    Text('Selecciona una opción:',
                        style: getTextStyleTitle2(
                            context,
                            Colors
                                .white) /* myTextStyle.copyWith(fontSize: MediaQuery.of(context).size.width * (MediaQuery.of(context).orientation == Orientation.portrait ? .04 : 0.02)) */)
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35)),
                    color: Color.fromRGBO(246, 247, 252, 2)),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height *
                      (MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? 0.8
                          : 0.65),
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: MediaQuery.of(context).size.height < 960 &&
                            MediaQuery.of(context).size.width < 500
                        ?
                        //para celulares
                        EdgeInsets.fromLTRB(
                            MediaQuery.of(context).size.width * .03,
                            MediaQuery.of(context).size.height * .02,
                            MediaQuery.of(context).size.width * .03,
                            MediaQuery.of(context).size.height * .0,
                          )
                        :
                        //para tablets
                        EdgeInsets.fromLTRB(
                            MediaQuery.of(context).size.width * .05,
                            MediaQuery.of(context).size.height * .04,
                            MediaQuery.of(context).size.width * .05,
                            MediaQuery.of(context).size.height * .0,
                          ),
                    child: GridView.count(
                      primary: false,
                      padding: const EdgeInsets.all(20),
                      crossAxisSpacing: 25,
                      mainAxisSpacing: 25,
                      crossAxisCount: (MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? 2
                          : 3),
                      children: const [
                        ContainerOption(svg: 'Trafico', id: 1),
                        ContainerOption(svg: 'Recursos Humanos', id: 2),
                        ContainerOption(svg: 'Seguridad e Higiene', id: 3)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}


class ContainerOption extends StatefulWidget {
  final String svg;
  final int id;

  const ContainerOption({super.key, required this.svg, required this.id});

  @override
  State<ContainerOption> createState() => _ContainerOptionState();
}

Color color = Colors.white;

class _ContainerOptionState extends State<ContainerOption> {
  bool obscureText = true;
  final DepartamentService depService = DepartamentService();
  String? errorMessage;
  String password = '';
  bool autofucus = true;
  bool desactivar = false;
  
  clickMenu() {  
        setState(() {
          color = Colors.white;
        });
        TextEditingController textController = TextEditingController();
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return Stack(
                children: [
                  const ModalBarrier(
                    dismissible: false,
                    color: Color.fromARGB(80, 0, 0, 0),
                  ),
                  StatefulBuilder(builder:
                      (BuildContext context, StateSetter setState) {
                    handleButtonPressed() async {
                      setState(() {
                        desactivar = true;
                      });
                      var pass = await depService.checkPassWord(
                          password, widget.id, context);
                      setState(() {
                          desactivar = false;
                      });
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
                      } else {
                        setState(() {
                          desactivar = false;
                        });
                      }
                    }
    
                    return Dialog(
                        insetPadding:
                        MediaQuery.of(context).size.height < 960 &&
                                MediaQuery.of(context).size.width < 500
                        ?
                        //para celulares
                        EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width * .2,
                          MediaQuery.of(context).size.height * .0,
                          MediaQuery.of(context).size.width * .2,
                          MediaQuery.of(context).size.height * .0,
                        )
                        :
                        //para tablets
                        EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width * .3,
                          MediaQuery.of(context).size.height * .0,
                          MediaQuery.of(context).size.width * .3,
                          MediaQuery.of(context).size.height * .0,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            SystemChannels.textInput
                                .invokeMethod('TextInput.hide');
                          },
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(children: [
                                Container(
                                  padding:
                                      const EdgeInsets.only(bottom: 10),
                                  child: Center(
                                      child: Text('Ingrese la contraseña', 
                                          style: getTextStyleTitle2(
                                              context, null).copyWith(height: 1))),
                                ),
                                TextFormField(
                                  controller: textController,
                                  enabled: true,
                                  textAlign: TextAlign.center,
                                  autofocus: autofucus,
                                  obscureText: obscureText,
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                        icon: Icon(obscureText
                                            ? Icons.visibility
                                            : Icons.visibility_off),
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
                                    if (value == null ||
                                        value.isEmpty ||
                                        value == '') {
                                      return 'Ingrese la contraseña';
                                    }
                                    return null;
                                  },
                                  onEditingComplete: desactivar == false
                                      ? handleButtonPressed
                                      : null,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                ButtonBar(
                                  alignment: MainAxisAlignment.center,
                                  overflowButtonSpacing: 5,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        setState(() {
                                          desactivar = false;
                                        });
                                      },
                                      child: Text('Salir',
                                          style: getTextStyleButtonField(
                                              context)),
                                    ),
                                    ElevatedButton(
                                      onPressed: desactivar == false
                                          ? handleButtonPressed
                                          : null,
                                      child: Text('Ingresar',
                                          style: getTextStyleButtonField(
                                              context)),
                                    ),
                                  ],
                                )
                              ]),
                            ),
                          ),
                        ));
                  }),
                ],
              );
            });
      }

  @override
  Widget build(BuildContext context) {
    
    return GestureDetector(
      onTapDown: (details) {  
        setState(() {
          color = const Color.fromARGB(255, 230, 230, 230);
        });
      }, 
      onPanDown: (details) {
        setState(() {
          color = const Color.fromARGB(255, 230, 230, 230);
        });
      },
      onPanEnd: (details) {
        setState(() {
          color = Colors.white;
        });
      },
      onLongPressUp: clickMenu,
      onTap: clickMenu,
      child: Container(
         height: 100,
        decoration: BoxDecoration(
            color: /* Colors.white */ color, // Color de fondo del Ink
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.282),
                spreadRadius: 0.5,
                blurRadius: 1,
                offset: Offset(0, 1),
              ),
            ]),
        child: Padding(
          padding:  MediaQuery.of(context).size.height < 960 &&
                  MediaQuery.of(context).size.width < 500
              ? (MediaQuery.of(context).orientation == Orientation.portrait
                  ?
                  //pare celulares
                  EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width * .023,
                      MediaQuery.of(context).size.height * .023,
                      MediaQuery.of(context).size.width * .023,
                      MediaQuery.of(context).size.height * .023)
                  : EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width * .06,
                      MediaQuery.of(context).size.height * .06,
                      MediaQuery.of(context).size.width * .06,
                      MediaQuery.of(context).size.height * .06))
              :
              //para tablets
              (EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * .06,
                  MediaQuery.of(context).size.height * .06,
                  MediaQuery.of(context).size.width * .06,
                  MediaQuery.of(context).size.height * .06)),
          child: Image.asset(
              alignment: Alignment.center,
              'assets/images/main/${widget.svg}.png',
              
            ),
        ),
      ) 
    );
  }

}
