import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/layouts/default_layout.dart';
import '../../../../core/util/horizontal_spacing.dart';
import '../../../../core/util/vertical_spacing.dart';
import '../bloc/bloc.dart';
import '../widgets/buttons/anonymous_signin_button.dart';
import '../widgets/buttons/google_signin_button.dart';
import '../widgets/login_form_widget.dart';

/// The main page of authentication feature
class AuthenticationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: const Text('Authentication'),
      actions: const <Widget>[],
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      body: SingleChildScrollView(
        child: BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is AuthenticationErrorState) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white),
                  ),
                  duration: const Duration(seconds: 3),
                  backgroundColor: Colors.grey.shade700,
                ),
              );
            }
          },
          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              if (state is InitialAuthenticationState ||
                  state is AuthenticationErrorState ||
                  state is SignedOutState) {
                return const InitialAuthenticationPage();
              }

              if (state is AuthenticationLoadingState) {
                return Center(
                  child: Container(
                    margin: const EdgeInsets.all(10.0),
                    child: const CircularProgressIndicator(),
                  ),
                );
              }

              return Container();
            },
          ),
        ),
      ),
    );
  }
}

class InitialAuthenticationPage extends StatelessWidget {
  const InitialAuthenticationPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const VerticalSpacing.medium(),
        LoginFormWidget(),
        const VerticalSpacing.medium(),
        OrDivider(),
        const VerticalSpacing.medium(),
        AnonymousSignInButton(),
        const VerticalSpacing.small(),
        const GoogleSignInButton(),
      ],
    );
  }
}

/// Horizontal divider with OR label
class OrDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 120,
          height: 1,
          color: Colors.white60,
        ),
        const HorizontalSpacing.medium(),
        Text(
          'OR',
          style: TextStyle(color: Colors.white60),
        ),
        const HorizontalSpacing.medium(),
        Container(
          width: 120,
          height: 1,
          color: Colors.white60,
        ),
      ],
    );
  }
}
