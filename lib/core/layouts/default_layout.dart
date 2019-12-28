import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/game/presentation/bloc/bloc.dart';
import '../../features/game/presentation/bloc/game_event.dart';
import '../theme/custom_colors.dart';

class DefaultLayout extends StatelessWidget {
  final Widget body;
  final Widget title;
  final List<Widget> actions;
  final isAuthenticated = true;

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
    return DrawerHeader(
      child: Text('Drawer Header'),
      decoration: BoxDecoration(
        color: CustomColors.accentColor,
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
        style: TextStyle(color: Colors.black87),
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
