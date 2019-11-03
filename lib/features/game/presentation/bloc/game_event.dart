import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/enums/direction.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();
}

class Move extends GameEvent {
  final Direction direction;

  Move({@required this.direction});
  @override
  List<Object> get props => [direction];
}

class LoadInitialBoard extends GameEvent {
  @override
  List<Object> get props => null;
}
