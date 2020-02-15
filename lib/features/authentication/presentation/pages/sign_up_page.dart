import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_2048/core/theme/custom_colors.dart';
import 'package:flutter_web_2048/core/util/vertical_spacing.dart';
import 'package:flutter_web_2048/features/authentication/presentation/bloc/bloc.dart';

class SignUpPageArguments {
  final String email;
  final String name;
  final String password;

  SignUpPageArguments({@required this.email, @required this.name, @required this.password});
}

class SignUpPage extends StatelessWidget {
  final String _name;
  final String _email;
  final String _password;

  const SignUpPage({
    Key key,
    @required String name,
    @required String email,
    @required String password,
  })  : _name = name,
        _email = email,
        _password = password,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).accentColor.withAlpha(50),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Welcome $_name !",
                style: Theme.of(context).textTheme.headline4.apply(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const VerticalSpacing.medium(),
              Text(
                "You're new here, would you like to sign up with $_email ?",
                style: Theme.of(context).textTheme.bodyText2.apply(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const VerticalSpacing.small(),
              ButtonBar(
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      BlocProvider.of<AuthenticationBloc>(context).add(const SignUpCancelEvent());
                      Navigator.of(context).pop();
                    },
                    child: const Text('Back'),
                  ),
                  RaisedButton(
                    onPressed: () {
                      BlocProvider.of<AuthenticationBloc>(context)
                          .add(SignUpEvent(email: _email, password: _password));
                      Navigator.of(context).pop();
                    },
                    color: CustomColors.accentColor.shade500,
                    child: const Text('Sign me up !'),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
