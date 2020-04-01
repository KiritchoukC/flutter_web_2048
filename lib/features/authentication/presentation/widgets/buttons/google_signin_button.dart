import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter_web_2048/features/authentication/presentation/bloc/bloc.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SignInButton(
      Buttons.Google,
      onPressed: () {
        BlocProvider.of<AuthenticationBloc>(context).add(const GoogleSignInEvent());
      },
    );
  }
}
