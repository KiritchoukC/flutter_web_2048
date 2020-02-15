import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_2048/core/config/config.dart';
import 'package:flutter_web_2048/features/authentication/presentation/bloc/bloc.dart';

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
  FocusNode _passwordFocusNode;

  @override
  void initState() {
    _passwordFocusNode = FocusNode();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  Widget get _emailField => DefaultTextFormFieldWidget(
        controller: _emailController,
        labelText: 'Email',
        textInputAction: TextInputAction.next,
        onEditingComplete: () {
          _passwordFocusNode.requestFocus();
        },
        prefixIcon: Icons.email,
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter your email';
          }
          if (!emailValidationRegex.hasMatch(value)) {
            return 'Oops, you\'ve entered an invalid email';
          }
          return null;
        },
      );

  Widget get _passwordField => DefaultTextFormFieldWidget(
        controller: _passwordController,
        obscureText: true,
        labelText: 'Password',
        prefixIcon: Icons.lock,
        focusNode: _passwordFocusNode,
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter a password with at least 8 characters';
          }
          if (value.length < 8) {
            return 'Your password should contain at least 8 characters';
          }
          return null;
        },
      );

  Widget get _submitButton => ButtonBar(
        alignment: MainAxisAlignment.end,
        buttonMinWidth: 180,
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              if (_formKey.currentState.validate()) {
                BlocProvider.of<AuthenticationBloc>(context).add(
                  SignInEvent(
                    email: _emailController.value.text,
                    password: _passwordController.value.text,
                  ),
                );
              }
            },
            color: CustomColors.accentColor,
            child: const Text('Sign In'),
          )
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        width: 320.0,
        child: Column(
          children: <Widget>[
            _emailField,
            const VerticalSpacing.extraSmall(),
            _passwordField,
            _submitButton,
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _passwordFocusNode?.dispose();
    _emailController?.dispose();
    _passwordController?.dispose();
    super.dispose();
  }
}
