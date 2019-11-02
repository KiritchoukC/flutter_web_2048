import 'package:equatable/equatable.dart';
import 'package:flutter_web_2048/core/enums/direction.dart';
import 'package:flutter_web_2048/features/game/domain/entities/board.dart';

abstract class GameState extends Equatable {
  const GameState();
}

class InitialGame extends GameState {
  @override
  List<Object> get props => [];
}

class UpdateBoardStart extends GameState{
  final Direction direction;

  UpdateBoardStart(this.direction);

  @override
  List<Object> get props => [direction];
}

class UpdateBoardEnd extends GameState{
  final Board board;

  UpdateBoardEnd(this.board);

  @override
  List<Object> get props => [board];
}

class Error extends GameState{
  final String message;

  Error(this.message);

  @override
  List<Object> get props => [message];
}