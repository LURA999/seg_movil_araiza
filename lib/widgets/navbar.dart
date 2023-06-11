import 'package:app_seguimiento_movil/routers/router.dart';
import 'package:flutter/material.dart';
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
      child: Container(
        color: Colors.white,
        height: height * (
          MediaQuery.of(context).size.height < 960 && MediaQuery.of(context).size.width <600  ?
          (MediaQuery.of(context).orientation == Orientation.portrait ? 0.1: 0.18)
          : 
          (MediaQuery.of(context).orientation == Orientation.portrait ? 0.1: 0.15)
          ),
        width: width,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
           children:  [
            ButtonNavSvg(img:'assets/images/main/arrow_prev.svg', height: (height * (MediaQuery.of(context).orientation == Orientation.portrait ? .05 : .07)), route:'prev', contexto2: contexto2),
            SizedBox(width: width * 0.15),
            ButtonNavSvg(img:'assets/images/main/home.svg', height:(height * (MediaQuery.of(context).orientation == Orientation.portrait ? .05 : .07)), route:'home', contexto2: contexto2),
            SizedBox(width: width * 0.15),
            ButtonNavSvg(img:'assets/images/main/arrow_next.svg', height:(height * (MediaQuery.of(context).orientation == Orientation.portrait ? .05 : .07)), route:'next', contexto2: contexto2),
            
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
    return InkWell(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      child: AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding:  EdgeInsets.fromLTRB(
          MediaQuery.of(context).size.width * .01,
          MediaQuery.of(context).size.height * .01,
          MediaQuery.of(context).size.width * .01,
          MediaQuery.of(context).size.height * .01,
        ),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(40)),
          color: _isTapped ? const Color.fromARGB(255, 245, 245, 245) : Colors.white ,
        ),
        child: SvgPicture.asset(
          widget.img,
          height: widget.height,
        ),
      ),
      onTap: () {
        int auxPrevDirectory = Provider.of<VarProvider>(context,listen: false).auxPrevDirectory;
        int auxNextDirectory = Provider.of<VarProvider>(context,listen: false).auxNextDirectory;

        if (widget.route=='home') {
          auxPrevDirectory = 1;
          auxNextDirectory = 0;
          Provider.of<VarProvider>(context,listen: false).updatePrev(auxPrevDirectory);
          Navigator.of(context).pushNamed('home');
        }

        if (widget.route=='prev') {
          final routes = Navigator.of(context).widget.observers
          .whereType<HistoryNavigator>()
          .first.history;
          try {
            // print(routes.length);
            if (routes.length > 1) {
              final previousRouteSettings = routes[routes.indexOf(routes.firstWhere((e) => e.settings.name == widget.contexto2)) - 1].settings;
              final previousRouteName = previousRouteSettings.name;
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
            // print("Donde se encuentra la pantalla actual : ${routes.indexOf(routes.firstWhere((e) => e.settings.name == widget.contexto2))}: ${widget.contexto2} = el numero de pantalla que son en total : ${Routers.namesRouter.length}");
            // print('El historial a crecido hasta ${routes.length} widgets');
            // print('Estas en la pantalla ${widget.contexto2} y quieres ir para adelante a la pantalla ${routes.indexOf(routes.reversed.firstWhere((e) => e.settings.name == widget.contexto2)) + 1}');
          
            if (indice <  namesRoute.length-1) { 
              indice+=1;
              //se disminuye uno, porque estamos accediendo a la ultima vista, que se accedio, ignorando la actual.
              final previousRouteSettings = routes[routes.indexOf(routes.reversed.firstWhere((e) => e.settings.name == widget.contexto2)) -(indice - 1)].settings;
              if(namesRoute[indice].first == previousRouteSettings.name){
                final previousRouteName = previousRouteSettings.name;
                Navigator.of(context).pushNamed(previousRouteName!);
              }
              
            } 
          } catch (e) {
            return;
          }
        }
      },
    );
  }
}

