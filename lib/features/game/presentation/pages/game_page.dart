import 'package:flutter/material.dart';

import '../../../../core/layouts/default_layout.dart';
import '../widgets/board_score_widget.dart';
import '../widgets/game_widget.dart';

class GamePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: BoardScoreWidget(),
      body: GameWidget(),
      actions: <Widget>[],
    );
  }
}
