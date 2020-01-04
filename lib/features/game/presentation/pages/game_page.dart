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
        UndoButton(),
      ],
    );
  }
}

class UndoButton extends StatefulWidget {
  @override
  _UndoButtonState createState() => _UndoButtonState();
}

class _UndoButtonState extends State<UndoButton> {
  // button state
  bool _disabled = false;
  // check if board moved more than once
  int _moved = 0;

  _undo() {
    // disanle the button when undoing
    setState(() {
      _disabled = true;
    });
    // send undo event
    BlocProvider.of<GameBloc>(context).add(Undo());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GameBloc, GameState>(
      condition: (previousState, newState) {
        if (_disabled && newState is UpdateBoardEndState) {
          if (_moved > 0) {
            _moved = 0;
            return true;
          }
          if (_moved > 1) {
            return true;
          }
          _moved++;
          return false;
        }
        return false;
      },
      listener: (context, state) {
        if (state is UpdateBoardEndState) {
          setState(() {
            _disabled = false;
          });
        }
      },
      child: IconButton(
        icon: Icon(Icons.undo),
        onPressed: _disabled ? null : _undo,
      ),
    );
  }
}
