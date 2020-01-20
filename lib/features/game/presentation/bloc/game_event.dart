import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/enums/direction.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();

  @override
  List<Object> get props => [];
}

class MoveEvent extends GameEvent {
  final Direction direction;

  const MoveEvent({@required this.direction});
  @override
  List<Object> get props => [direction];
}

class LoadInitialBoardEvent extends GameEvent {}

class NewGameEvent extends GameEvent {}

class LoadHighscoreEvent extends GameEvent {}

class UndoEvent extends GameEvent {}
