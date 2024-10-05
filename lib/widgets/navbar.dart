import 'package:app_seguimiento_movil/routers/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:app_seguimiento_movil/services/services.dart';

class Navbar extends StatelessWidget {
  final String contexto2;
  final int auxPrevDirectory = 1;

  const Navbar({super.key, required this.contexto2});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Ink(
        color: Colors.white,
        height: height *
            (MediaQuery.of(context).size.height < 960 &&
                    MediaQuery.of(context).size.width < 900
                ? (MediaQuery.of(context).orientation == Orientation.portrait
                    ? 0.1
                    : 0.2)
                : (MediaQuery.of(context).orientation == Orientation.portrait
                    ? 0.1
                    : 0.15)),
        width: width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonNavSvg(
                img: 'assets/images/main/arrow_prev.svg',
                height: (height *
                    (MediaQuery.of(context).size.height < 960 &&
                            MediaQuery.of(context).size.width < 900
                        ? (MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? .05
                            : 0.1)
                        : (MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? .05
                            : .07))),
                route: 'prev',
                contexto2: contexto2),
            SizedBox(width: width * 0.15),
            ButtonNavSvg(
                img: 'assets/images/main/home.svg',
                height: (height *
                    (MediaQuery.of(context).size.height < 960 &&
                            MediaQuery.of(context).size.width < 900
                        ? (MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? .05
                            : 0.1)
                        : (MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? .05
                            : .07))),
                route: 'home',
                contexto2: contexto2),
            SizedBox(width: width * 0.15),
            ButtonNavSvg(
                img: 'assets/images/main/arrow_next.svg',
                height: (height *
                    (MediaQuery.of(context).size.height < 960 &&
                            MediaQuery.of(context).size.width < 900
                        ? (MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? .05
                            : 0.1)
                        : (MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? .05
                            : .07))),
                route: 'next',
                contexto2: contexto2),
          ],
        ),
      ),
    );
  }
}

class ButtonNavSvg extends StatefulWidget {
  final String img;
  final String? route;
  final double height;
  final String contexto2;

  const ButtonNavSvg(
      {super.key,
      required this.img,
      required this.height,
      this.route,
      required this.contexto2});

  @override
  State<ButtonNavSvg> createState() => _ButtonNavSvgState();
}

class _ButtonNavSvgState extends State<ButtonNavSvg> {
  /* bool _isTapped = false;

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _isTapped = true;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _isTapped = false;
    });
  } */

  @override
  Widget build(BuildContext context) {
    bool desactivar = false;
    final DepartamentService depService = DepartamentService();
    String password = '';
    bool autofucus = true;
    bool obscureText = true;
    return Ink(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40.0),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
          child: SvgPicture.asset(
            widget.img,
            height: widget.height,
          ),
        ),
        onTap: () {
          if (widget.route == 'home') {
            Provider.of<VarProvider>(context, listen: false).updatePrev(0);
            Provider.of<VarProvider>(context, listen: false).updateNext(1);
            Provider.of<VarProvider>(context, listen: false).updateEnableNav(false);
            Navigator.of(context).pushNamed('home');
          }

          if (widget.route == 'prev') {
            Provider.of<VarProvider>(context, listen: false).updatePrev( 
              Provider.of<VarProvider>(context, listen: false).auxPrevDirectory++
            );
            Provider.of<VarProvider>(context, listen: false).updateNext(1);
            Provider.of<VarProvider>(context, listen: false).updateEnableNav(true);

            final routes = Navigator.of(context)
                .widget
                .observers
                .whereType<HistoryNavigator>()
                .first
                .history;
            try {
              if (routes.length > 1) {
                final previousRouteSettings = routes[routes.indexWhere(
                            (e) => e.settings.name == widget.contexto2) -
                        1]
                    .settings;
                final previousRouteName = previousRouteSettings.name == '/'
                    ? 'home'
                    : previousRouteSettings.name;

                if (previousRouteName == 'home') {
                  Provider.of<VarProvider>(context, listen: false).updatePrev(0);
                  Provider.of<VarProvider>(context, listen: false).updateNext(1);
                  Provider.of<VarProvider>(context, listen: false).updateEnableNav(false);
                }

                Navigator.of(context).pushNamed(previousRouteName!);
              }
            } catch (e) {
              return;
            }
          }

          if (widget.route == 'next' && Provider.of<VarProvider>(context, listen: false).enableNav) {
            final routes = Navigator.of(context)
                .widget
                .observers
                .whereType<HistoryNavigator>()
                .first
                .history;
            List<Set<String>> namesRoute = Routers.namesRouter;
            try {
              int indice = namesRoute.indexWhere(
                  (conjunto) => conjunto.contains(widget.contexto2));
              if (indice < namesRoute.length - 1) {
                indice += 1;
                int indicePrincipal = routes.lastIndexWhere( (e) => e.settings.name == widget.contexto2) -
                Provider.of<VarProvider>(context, listen: false).auxNextDirectory;

                Provider.of<VarProvider>(context, listen: false).updatePrev(0);
                Provider.of<VarProvider>(context, listen: false).updateNext(
                Provider.of<VarProvider>(context, listen: false).auxNextDirectory +2
                );

                //se disminuye uno, porque estamos accediendo a la ultima vista, que se accedio, ignorando la actual.
                final previousRouteSettings = routes[indicePrincipal].settings;
                if (namesRoute[indice].contains(previousRouteSettings.name)) {
                  final previousRouteName = previousRouteSettings.name;
                  if (previousRouteName == 'medical_records') {
                    TextEditingController textController =
                        TextEditingController();
                    showDialog(
                        context:
                            context, // Accede al contexto del widget actual
                        builder: (BuildContext context) {
                          return Stack(children: [
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
                                    password, 4, context);
                                if (pass.status == 200) {
                                  autofucus = false;
                                  Navigator.of(context).pushNamed(previousRouteName!);
                                } else {
                                  setState(() {
                                    desactivar = false;
                                  });
                                }
                              }

                              return Dialog(
                                  insetPadding: 
                                  MediaQuery.of(context) .size .height < 960 && MediaQuery.of(context).size.width < 500 ?
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
                                      SystemChannels.textInput.invokeMethod('TextInput.hide');
                                    },
                                    child: SingleChildScrollView(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(children: [
                                          Container(
                                            padding: const EdgeInsets.only(
                                                bottom: 10),
                                            child: Center(
                                                child: Text(
                                                    'Ingrese la contraseña ',
                                                    style: getTextStyleTitle2(
                                                        context, null))),
                                          ),
                                          TextFormField(
                                            controller: textController,
                                            enabled: true,
                                            textAlign: TextAlign.center,
                                            autofocus: autofucus,
                                            obscureText: obscureText,
                                            decoration: InputDecoration(
                                              suffixIcon: IconButton(
                                                  icon: const Icon(
                                                      Icons.visibility),
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
                                            onEditingComplete:
                                                desactivar == false
                                                    ? handleButtonPressed
                                                    : null,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              ElevatedButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: Text('Salir',
                                                    style:
                                                        getTextStyleButtonField( context)),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              ElevatedButton(
                                                onPressed: desactivar == false
                                                    ? handleButtonPressed
                                                    : null,
                                                child: Text('Ingresar',
                                                    style:
                                                        getTextStyleButtonField(context)),
                                              ),
                                            ],
                                          )
                                        ]),
                                      ),
                                    ),
                                  ));
                            })
                          ]);
                        });
                  } else {
                    switch (previousRouteName) {
                      case 'tour_seh_tr1_a':
                        Navigator.of(context)
                            .pushNamed(previousRouteName!, arguments: {
                          'periodo': 1,
                          'recorrido': 1,
                          'form': 1,
                          'nameContext': previousRouteName,
                          'title': '1er trimestre - Área A'
                        });
                        break;
                      case 'tour_seh_tr1_b':
                        Navigator.of(context)
                            .pushNamed(previousRouteName!, arguments: {
                          'periodo': 1,
                          'recorrido': 2,
                          'form': 2,
                          'nameContext': previousRouteName,
                          'title': '1er trimestre - Área B'
                        });
                        break;
                      case 'tour_seh_tr1_c':
                        Navigator.of(context)
                            .pushNamed(previousRouteName!, arguments: {
                          'periodo': 1,
                          'recorrido': 3,
                          'form': 3,
                          'nameContext': previousRouteName,
                          'title': '1er trimestre - Área C'
                        });
                        break;
                      case 'tour_seh_tr2_a':
                        Navigator.of(context)
                            .pushNamed(previousRouteName!, arguments: {
                          'periodo': 2,
                          'recorrido': 1,
                          'form': 4,
                          'nameContext': previousRouteName,
                          'title': '2do trimestre - Área A'
                        });
                        break;
                      case 'tour_seh_tr2_b':
                        Navigator.of(context)
                            .pushNamed(previousRouteName!, arguments: {
                          'periodo': 2,
                          'recorrido': 2,
                          'form': 5,
                          'nameContext': previousRouteName,
                          'title': '2do trimestre - Área B'
                        });
                        break;
                      case 'tour_seh_tr2_c':
                        Navigator.of(context)
                            .pushNamed(previousRouteName!, arguments: {
                          'periodo': 2,
                          'recorrido': 3,
                          'form': 6,
                          'nameContext': previousRouteName,
                          'title': '2do trimestre - Área C'
                        });
                        break;
                      case 'tour_seh_tr3_a':
                        Navigator.of(context)
                            .pushNamed(previousRouteName!, arguments: {
                          'periodo': 3,
                          'recorrido': 1,
                          'form': 7,
                          'nameContext': previousRouteName,
                          'title': '3er trimestre - Área A'
                        });
                        break;
                      case 'tour_seh_tr3_b':
                        Navigator.of(context)
                            .pushNamed(previousRouteName!, arguments: {
                          'periodo': 3,
                          'recorrido': 2,
                          'form': 8,
                          'nameContext': previousRouteName,
                          'title': '3er trimestre - Área B'
                        });
                        break;
                      case 'tour_seh_tr3_c':
                        Navigator.of(context)
                            .pushNamed(previousRouteName!, arguments: {
                          'periodo': 3,
                          'recorrido': 3,
                          'form': 9,
                          'nameContext': previousRouteName,
                          'title': '3er trimestre - Área C'
                        });
                        break;
                      case 'tour_seh_tr4_a':
                        Navigator.of(context)
                            .pushNamed(previousRouteName!, arguments: {
                          'periodo': 4,
                          'recorrido': 1,
                          'form': 10,
                          'nameContext': previousRouteName,
                          'title': '4to trimestre - Área A'
                        });
                        break;
                      case 'tour_seh_tr4_b':
                        Navigator.of(context)
                            .pushNamed(previousRouteName!, arguments: {
                          'periodo': 4,
                          'recorrido': 2,
                          'form': 11,
                          'nameContext': previousRouteName,
                          'title': '4to trimestre - Área B'
                        });
                        break;
                      case 'tour_seh_tr4_c':
                        Navigator.of(context)
                            .pushNamed(previousRouteName!, arguments: {
                          'periodo': 4,
                          'recorrido': 3,
                          'form': 12,
                          'nameContext': previousRouteName,
                          'title': '4to trimestre - Área C'
                        });
                        break;
                      case 'scanner_qr_vehicles':
                        Navigator.of(context).pushNamed(previousRouteName!,
                            arguments: {'dataKey': previousRouteName});
                        break;
                      case 'scanner_qr_assistance':
                        Navigator.of(context).pushNamed(previousRouteName!,
                            arguments: {'dataKey': previousRouteName});
                        break;
                      case 'scanner_qr_food':
                        Navigator.of(context).pushNamed(previousRouteName!,
                            arguments: {'dataKey': previousRouteName});
                        break;
                      default:
                        Navigator.of(context).pushNamed(previousRouteName!);

                        break;
                    }
                  }
                }
              }
            } catch (e) {
              return;
            }
          }
        },
      ),
    );
  }
}
