import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/board.dart';

abstract class GameState extends Equatable {
  const GameState();

  @override
  List<Object> get props => [];
}

class InitialGameState extends GameState {}

class UpdateBoardStartState extends GameState {}

class UpdateBoardEndState extends GameState {
  final Board board;

  const UpdateBoardEndState({@required this.board});

  @override
  List<Object> get props => [board];
}

class GameOverState extends GameState {
  final Board board;

  const GameOverState({@required this.board});

  @override
  List<Object> get props => [board];
}

class GameErrorState extends GameState {
  final String message;

  const GameErrorState({@required this.message});

  @override
  List<Object> get props => [message];
}

class HighscoreLoadedState extends GameState {
  final int highscore;

  const HighscoreLoadedState({@required this.highscore});

  @override
  List<Object> get props => [highscore];
}
