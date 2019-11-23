import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/layouts/default_layout.dart';
import '../bloc/bloc.dart';
import '../widgets/board_score_widget.dart';
import '../widgets/game_widget.dart';

class GamePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: BoardScoreWidget(),
      body: GameWidget(),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            BlocProvider.of<GameBloc>(context).add(NewGame());
          },
          child: Text('New Game', semanticsLabel: 'Start a new game'),
        )
      ],
    );
  }
}
