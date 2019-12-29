import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/game/presentation/bloc/bloc.dart';
import '../../features/game/presentation/bloc/game_event.dart';
import '../router/route_paths.dart';
import '../theme/custom_colors.dart';
import '../util/horizontal_spacing.dart';

class DefaultLayout extends StatelessWidget {
  final Widget body;
  final Widget title;
  final List<Widget> actions;
  final isAuthenticated = false;

  DefaultLayout({
    @required this.body,
    @required this.title,
    @required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title,
        actions: actions,
        centerTitle: true,
      ),
      body: Center(child: body),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            isAuthenticated ? AuthenticatedDrawerHeader() : AnonymousDrawerHeader(),
            ListTile(
              title: Text(
                'Reset game',
                style: TextStyle(color: Colors.white),
                semanticsLabel: 'Reset the game',
              ),
              trailing: Icon(Icons.refresh),
              onTap: () {
                BlocProvider.of<GameBloc>(context).add(NewGame());
              },
            ),
          ],
        ),
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
              style: Theme.of(context).textTheme.display1,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(
                onPressed: () {},
                child: Text(
                  'Sign in',
                  style: TextStyle(color: Colors.black54),
                ),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(RoutePaths.Authentication);
                },
                child: Text('Sign up', style: TextStyle(color: Colors.black)),
              ),
              HorizontalSpacing.extraSmall()
            ],
          ),
        ],
      ),
    );
  }
}

class AuthenticatedDrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(
        color: CustomColors.accentColor,
      ),
      accountEmail: Text(
        'sample@mail.com',
        style: TextStyle(color: Colors.grey.shade800),
      ),
      accountName: Text(
        'Username Placeholder',
        style: TextStyle(color: Colors.black),
      ),
      currentAccountPicture: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.fill,
            image: NetworkImage(
                "https://upload.wikimedia.org/wikipedia/commons/8/89/Portrait_Placeholder.png"),
          ),
        ),
      ),
    );
  }
}
