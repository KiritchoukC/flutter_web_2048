import 'package:flutter/material.dart';

import '../../../../core/layouts/default_layout.dart';
import '../widgets/game_widget.dart';

class GamePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '2048',
      body: GameWidget(),
    );
  }
}