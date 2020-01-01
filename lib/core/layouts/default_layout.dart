import 'package:flutter/material.dart';

import 'default_drawer.dart';

class DefaultLayout extends StatelessWidget {
  final Widget body;
  final Widget title;
  final List<Widget> actions;
  final Widget leading;

  DefaultLayout({
    @required this.body,
    @required this.title,
    @required this.actions,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title,
        actions: actions,
        centerTitle: true,
        leading: leading,
      ),
      body: Center(child: body),
      drawer: DefaultDrawer(),
      resizeToAvoidBottomPadding: false,
    );
  }
}
