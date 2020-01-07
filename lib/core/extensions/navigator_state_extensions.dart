import 'package:flutter/material.dart';

extension NavigatorStateExtensions on NavigatorState {
  String getCurrentRoute() {
    String currentRoute = '';

    this.popUntil((route) {
      currentRoute = route.settings.name;
      return true;
    });

    return currentRoute;
  }
}
