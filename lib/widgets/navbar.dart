import 'package:app_seguimiento_movil/routers/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:app_seguimiento_movil/services/services.dart';

class Navbar extends StatelessWidget {

  final String contexto2;
  final int auxPrevDirectory = 1;

  const Navbar({
    super.key, 
    required this.contexto2
    });

  @override
  Widget build(BuildContext context) {
    
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Ink(
        color: Colors.white,
        height: height * (
          MediaQuery.of(context).size.height < 960 && MediaQuery.of(context).size.width <900  ?
          (MediaQuery.of(context).orientation == Orientation.portrait ? 0.1: 0.2)
          : 
          (MediaQuery.of(context).orientation == Orientation.portrait ? 0.1: 0.15)
          ),
        width: width,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
           children:  [
            ButtonNavSvg(img:'assets/images/main/arrow_prev.svg', 
            height: (height * (MediaQuery.of(context).size.height < 960 && MediaQuery.of(context).size.width <900  ?
            (MediaQuery.of(context).orientation == Orientation.portrait ? .05: 0.1)
            : 
            (MediaQuery.of(context).orientation == Orientation.portrait ? .05: .07))

            ), 
            route:'prev', contexto2: contexto2),
            SizedBox(width: width * 0.15),

            ButtonNavSvg(img:'assets/images/main/home.svg', 
            height:(height * (MediaQuery.of(context).size.height < 960 && MediaQuery.of(context).size.width <900  ?
            (MediaQuery.of(context).orientation == Orientation.portrait ? .05: 0.1)
            : 
            (MediaQuery.of(context).orientation == Orientation.portrait ? .05: .07))), 
            route:'home', contexto2: contexto2),
            SizedBox(width: width * 0.15),

            ButtonNavSvg(img:'assets/images/main/arrow_next.svg', 
            height:(height * (MediaQuery.of(context).size.height < 960 && MediaQuery.of(context).size.width <900  ?
            (MediaQuery.of(context).orientation == Orientation.portrait ? .05: 0.1)
            : 
            (MediaQuery.of(context).orientation == Orientation.portrait ? .05: .07))), 
            route:'next', contexto2: contexto2),
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

  const ButtonNavSvg({
    super.key, 
    required this.img, 
    required this.height, 
    this.route, 
    required this.contexto2
  });

  @override
  State<ButtonNavSvg> createState() => _ButtonNavSvgState();
}

class _ButtonNavSvgState extends State<ButtonNavSvg> {
  bool _isTapped = false;
  

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _isTapped = true;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _isTapped = false;
    });
  }
  
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
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01) /* EdgeInsets.fromLTRB(
            MediaQuery.of(context).size.width * .01,
            MediaQuery.of(context).size.height * .01,
            MediaQuery.of(context).size.width * .01,
            MediaQuery.of(context).size.height * .01,
          ) */,
          child: SvgPicture.asset(
            widget.img,
            height: widget.height,
          ),
        ),
        onTap: () {
          int auxPrevDirectory = Provider.of<VarProvider>(context,listen: false).auxPrevDirectory;
          int auxNextDirectory = Provider.of<VarProvider>(context,listen: false).auxNextDirectory;
    
          if (widget.route == 'home') {
            auxPrevDirectory = 1;
            auxNextDirectory = 0;
            Provider.of<VarProvider>(context,listen: false).updatePrev(auxPrevDirectory);
            Navigator.of(context).pushNamed('home');
          }
    
          if (widget.route == 'prev') {
            final routes = Navigator.of(context).widget.observers
            .whereType<HistoryNavigator>()
            .first.history;
            try {
              if (routes.length > 1) {
                final previousRouteSettings = routes[routes.indexOf(routes.firstWhere((e) => e.settings.name == widget.contexto2)) - 1].settings;
                final previousRouteName = previousRouteSettings.name== '/' ? 'home' : previousRouteSettings.name;
                
                Navigator.of(context).pushNamed(previousRouteName!);
              } 
            } catch (e) {
              return;
            }
          }
          
         if (widget.route == 'next') {
            final routes = Navigator.of(context).widget.observers
            .whereType<HistoryNavigator>()
            .first.history;
            List<Set<String>> namesRoute = Routers.namesRouter;
            try {
              int indice = namesRoute.indexWhere((conjunto) => conjunto.contains(widget.contexto2));
              // "Donde se encuentra la pantalla actual : ${routes.indexOf(routes.firstWhere((e) => e.settings.name == widget.contexto2))}: ${widget.contexto2} = el numero de pantalla que son en total : ${Routers.namesRouter.length}");
              // 'El historial a crecido hasta ${routes.length} widgets');
              // 'Estas en la pantalla ${widget.contexto2} y quieres ir para adelante a la pantalla ${routes.indexOf(routes.reversed.firstWhere((e) => e.settings.name == widget.contexto2)) + 1}');
              if (indice <  namesRoute.length-1) { 
                indice+=1;
                //se disminuye uno, porque estamos accediendo a la ultima vista, que se accedio, ignorando la actual.
                final previousRouteSettings = routes[routes.indexOf(routes.reversed.firstWhere((e) => e.settings.name == widget.contexto2)) -(indice - 1)].settings;
                // var valido = namesRoute[indice].firstWhere((screen) => screen == previousRouteSettings.name);
                if(namesRoute[indice].contains(previousRouteSettings.name)){
                  final previousRouteName = previousRouteSettings.name;
                  if( previousRouteName == 'medical_records' ) {
                    TextEditingController textController = TextEditingController();
                    showDialog(
                    context: context, // Accede al contexto del widget actual
                    builder: (BuildContext context) {
                      return 
                      Stack( children: [
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
                            Navigator.of(context).pushNamed(previousRouteName!);
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
                          )
                        ]
                        ),
                      ),
                    ),
                    )
                  );
              })]);
              }
            );
            }
            else{
              Navigator.of(context).pushNamed(previousRouteName!);
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

