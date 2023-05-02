import 'package:app_seguimiento_movil/services/history_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Navbar extends StatelessWidget {

  final String contexto2;
  
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
        height: height * (MediaQuery.of(context).orientation == Orientation.portrait ? 0.1: 0.13),
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

class ButtonNavSvg extends StatelessWidget {
  final String img;
  final String? route;
  final double height;
  final String contexto2;
  
  const ButtonNavSvg({
    super.key, 
    required this.img, 
    required this.height, 
    this.route, 
    required this.contexto2,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
         padding: const EdgeInsets.all(5),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(40)),
          //  border: Border.all(color: Colors.red)
        ),
        child: SvgPicture.asset(
          img,
          height: height,
        ),
      ),
      onTap: () {
        if (route=='home') {
          final historyNavigator = Navigator.of(context).widget.observers
          .whereType<HistoryNavigator>()
          .first;
          ModalRoute<Object?>? currentRoute = ModalRoute.of(context);
          Route<dynamic>? previousRoute = historyNavigator.history.isNotEmpty ? historyNavigator.history.last : null;
          // historyNavigator.didPush(currentRoute!, previousRoute);
         /*  print('----3');
          print(historyNavigator.history.length);
          print('----3'); */
          Navigator.of(context).pushNamed('home');
        }

        if (route=='prev') {
          final routes = Navigator.of(context).widget.observers
          .whereType<HistoryNavigator>()
          .first.history;
         if (routes.length > 1) {
          /* print("entro a IF");
            // String? currentRoute = ModalRoute.of(context)!.settings.name;

            print('Contexto actual REAL: ${contexto2})}'); */

            final previousRouteSettings = routes[routes.indexOf(ModalRoute.of(context)!) - 1].settings;
            final previousRouteName = previousRouteSettings.name;
            // print(routes);
            Navigator.of(context).pushReplacementNamed(previousRouteName!);
          }
        }

       if (route == 'next') {
          final routes = Navigator.of(context).widget.observers
              .whereType<HistoryNavigator>()
              .first.history;
          if (routes.isNotEmpty) {
            final currentRouteIndex = routes.indexOf(ModalRoute.of(context)!);
            if (currentRouteIndex < routes.length - 1) {
              final nextRoute = routes[currentRouteIndex + 1];
              Navigator.of(context).push(nextRoute);
            }
          }
        }
      },
    );
  }
}

