import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/enums/direction.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();

  @override
  List<Object> get props => [];
}

class Move extends GameEvent {
  final Direction direction;

  Move({@required this.direction});
  @override
  List<Object> get props => [direction];
}

class LoadInitialBoard extends GameEvent {}

class NewGame extends GameEvent {}
