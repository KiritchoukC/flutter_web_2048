import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  final Widget body;
  final Widget title;
  final List<Widget> actions;

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
    );
  }
}
