import 'package:app_seguimiento_movil/routers/router.dart';
import 'package:flutter/material.dart';


class HistoryNavigator extends NavigatorObserver {
  final List<Route<dynamic>> _history = [];


  List<Route> get history => _history;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    List<Set<String>> namesRoute = Routers.namesRouter;
    int indice = namesRoute.indexWhere((conjunto) => conjunto.contains(route.settings.name.toString()));

    if (indice >= 0 || route.settings.name.toString() == '/') {
      _history.add(route);      
    }

  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _history.remove(route);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _history.remove(route);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    final index = _history.indexOf(oldRoute!);
    if (index >= 0) {
      _history[index] = newRoute!;
    }
  }
}