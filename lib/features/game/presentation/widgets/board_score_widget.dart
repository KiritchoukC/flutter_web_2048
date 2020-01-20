import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/util/horizontal_spacing.dart';
import '../bloc/bloc.dart';

class BoardScoreWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const ScoreWidget(),
          const HorizontalSpacing.small(),
          HighscoreWidget(),
        ],
      ),
    );
  }
}

class ScoreWidget extends StatelessWidget {
  const ScoreWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      condition: (previousState, state) {
        if (previousState is GameOverState) {
          return false;
        }

        if (state is UpdateBoardEndState || state is GameOverState) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        int score = 0;

        if (state is UpdateBoardEndState) {
          score = state.board.score;
        }

        if (state is GameOverState) {
          score = state.board.score;
        }

        return Text(
          score.toString(),
          semanticsLabel: 'The game score',
        );
      },
    );
  }
}

class HighscoreWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      condition: (previousState, state) {
        if (state is HighscoreLoadedState || state is InitialGameState) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        int _highscore = 0;
        if (state is InitialGameState) {
          BlocProvider.of<GameBloc>(context).add(LoadHighscoreEvent());
        }

        if (state is HighscoreLoadedState) {
          _highscore = state.highscore;
        }

        return Opacity(
          opacity: 0.5,
          child: Text(
            '(${_highscore.toString()})',
            semanticsLabel: 'The previous highscore',
            style: const TextStyle(fontSize: 20.0),
          ),
        );
      },
    );
  }
}
