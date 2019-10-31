import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  @override
  GameState get initialState => InitialGameState();

  @override
  Stream<GameState> mapEventToState(
    GameEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
