import 'package:flutter/material.dart';

class AnonymousSigninButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {},
      child: Text(
        'Signin Anonymously',
        style: TextStyle(color: Colors.grey.shade700),
      ),
      padding: EdgeInsets.symmetric(horizontal: 45.0),
    );
  }
}
