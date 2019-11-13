import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_2048/core/theme/custom_colors.dart';

import '../bloc/bloc.dart';

class BoardScoreWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 10, 10, 0),
      child: BlocBuilder<GameBloc, GameState>(
        builder: (context, state) {
          int score = 0;

          if (state is UpdateBoardEnd) {
            score = state.board.score;
          }

          return Text(
            score.toString(),
            semanticsLabel: 'The game score',
          );
        },
      ),
    );
  }
}
