import 'package:equatable/equatable.dart';

abstract class GameState extends Equatable {
  const GameState();
}

class InitialGameState extends GameState {
  @override
  List<Object> get props => [];
}
