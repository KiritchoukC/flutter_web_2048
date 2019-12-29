import 'package:flutter/material.dart';
import 'package:flutter_web_2048/core/layouts/default_layout.dart';

class AuthenticationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: Text('Authentication'),
      actions: <Widget>[],
      body: Center(
        child: Text('Authentication'),
      ),
    );
  }
}
