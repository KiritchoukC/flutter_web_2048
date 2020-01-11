import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../bloc/bloc.dart';

class AnonymousSignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SignInButtonBuilder(
      backgroundColor: Theme.of(context).primaryColor,
      text: 'Sign in Anonymously',
      onPressed: () {
        BlocProvider.of<AuthenticationBloc>(context).add(AnonymousSignInEvent());
      },
      textColor: Colors.grey.shade500,
      icon: FontAwesomeIcons.userSecret,
    );
  }
}
