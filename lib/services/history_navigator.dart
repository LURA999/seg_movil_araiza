import 'package:flutter/material.dart';

class HistoryNavigator extends NavigatorObserver {
  final List<Route<dynamic>> _history = [];


  List<Route> get history => _history;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _history.add(route);
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