import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/authentication/domain/entities/user.dart';
import '../../features/authentication/presentation/bloc/bloc.dart';
import '../../features/game/presentation/bloc/bloc.dart';
import '../config/config.dart';
import '../router/route_paths.dart';
import '../theme/custom_colors.dart';
import '../util/horizontal_spacing.dart';

class DefaultDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DefaultDrawerHeader(),
          const DrawerMenu(),
        ],
      ),
    );
  }
}

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        'Reset game',
        style: TextStyle(color: Colors.white),
        semanticsLabel: 'Reset the game',
      ),
      trailing: Icon(Icons.refresh),
      onTap: () {
        BlocProvider.of<GameBloc>(context).add(NewGameEvent());
      },
    );
  }
}

class DefaultDrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is SignedInState || state is SignedOutState) {
          Navigator.of(context).pop();
        }
      },
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        condition: (previousState, state) {
          if (state is SignedInState || state is SignedOutState) {
            return true;
          }
          return false;
        },
        builder: (context, state) {
          if (state is SignedInState) {
            return AuthenticatedDrawerHeader(user: state.user);
          }

          return AnonymousDrawerHeader();
        },
      ),
    );
  }
}

class AnonymousDrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomColors.accentColor,
      height: 120,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 4.0, 0.0, 0.0),
            child: Text(
              '2048 Game',
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              SizedBox(
                width: 150.0,
                child: RaisedButton(
                  color: CustomColors.accentColor.shade200,
                  onPressed: () {
                    Navigator.of(context).pushNamed(RoutePaths.authentication);
                  },
                  child: Text('Sign up', style: TextStyle(color: Colors.black)),
                ),
              ),
              const HorizontalSpacing.extraSmall()
            ],
          ),
        ],
      ),
    );
  }
}

class AuthenticatedDrawerHeader extends StatelessWidget {
  final User _user;

  String get _email => _user.email == null || _user.email == '' ? 'Anonymous' : _user.email;

  const AuthenticatedDrawerHeader({Key key, User user})
      : _user = user,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(
        color: CustomColors.accentColor,
      ),
      accountEmail: Text(
        _email,
        style: TextStyle(color: Colors.grey.shade800),
      ),
      accountName: Text(
        _user.username ?? '',
        style: TextStyle(color: Colors.black),
      ),
      currentAccountPicture: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.fill,
            image: NetworkImage(_user.picture ?? anonymousPicture),
          ),
        ),
      ),
      otherAccountsPictures: <Widget>[
        FloatingActionButton(
          backgroundColor: CustomColors.accentColor.shade100,
          onPressed: () {
            BlocProvider.of<AuthenticationBloc>(context).add(SignOutEvent());
          },
          child: Icon(
            Icons.exit_to_app,
            color: Colors.black,
          ),
        )
      ],
    );
  }
}
