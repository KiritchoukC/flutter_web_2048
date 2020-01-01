import 'package:flutter/material.dart';

import '../../../../core/theme/custom_colors.dart';
import '../../../../core/util/vertical_spacing.dart';
import '../../../../core/widgets/default_text_form_field.dart';

/// Login form with email and password text field.
class LoginFormWidget extends StatefulWidget {
  @override
  _LoginFormWidgetState createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  static final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController;
  TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  Widget get _emailField => DefaultTextFormFieldWidget(
        controller: _emailController,
        labelText: 'Email',
      );

  Widget get _passwordField => DefaultTextFormFieldWidget(
        controller: _passwordController,
        obscureText: true,
        labelText: 'Password',
      );

  Widget get _submitButton => Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: ButtonBar(
          alignment: MainAxisAlignment.end,
          buttonMinWidth: 180,
          children: <Widget>[
            RaisedButton(
              onPressed: () {},
              child: Text('Sign in'),
              color: CustomColors.accentColor,
            )
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.email),
            title: _emailField,
          ),
          VerticalSpacing.extraSmall(),
          ListTile(
            leading: Icon(Icons.lock),
            title: _passwordField,
          ),
          _submitButton,
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController?.dispose();
    _passwordController?.dispose();
    super.dispose();
  }
}
