import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/layouts/default_layout.dart';
import '../../../../core/util/horizontal_spacing.dart';
import '../../../../core/util/vertical_spacing.dart';
import '../bloc/bloc.dart';
import '../widgets/buttons/anonymous_signin_button.dart';
import '../widgets/buttons/facebook_signin_button.dart';
import '../widgets/buttons/google_signin_button.dart';
import '../widgets/buttons/twitter_signin_button.dart';
import '../widgets/login_form_widget.dart';

/// The main page of authentication feature
class AuthenticationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: Text('Authentication'),
      actions: <Widget>[],
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      body: SingleChildScrollView(
        child: BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is LoggedInState) {
              Navigator.of(context).pop();
            }
          },
          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              if (state is InitialAuthenticationState) {
                return InitialAuthenticationPage();
              }

              if (state is AuthenticationLoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
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
        VerticalSpacing.medium(),
        LoginFormWidget(),
        VerticalSpacing.medium(),
        OrDivider(),
        VerticalSpacing.medium(),
        AnonymousSigninButton(),
        VerticalSpacing.small(),
        GoogleSigninButton(),
        VerticalSpacing.small(),
        FacebookSigninButton(),
        VerticalSpacing.small(),
        TwitterSigninButton(),
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
        HorizontalSpacing.medium(),
        Text(
          'OR',
          style: TextStyle(color: Colors.white60),
        ),
        HorizontalSpacing.medium(),
        Container(
          width: 120,
          height: 1,
          color: Colors.white60,
        ),
      ],
    );
  }
}
