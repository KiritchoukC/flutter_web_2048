import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import './bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/generate_initial_board.dart';
import '../../domain/usecases/update_board.dart';

const String serverFailureMessage = 'Server Failure';
const String networkFailureMessage = 'Verify your network connection';

class GameBloc extends Bloc<GameEvent, GameState> {
  final UpdateBoard updateBoard;
  final GenerateInitialBoard generateInitialBoard;

  GameBloc({
    @required this.updateBoard,
    @required this.generateInitialBoard,
  })  : assert(updateBoard != null),
        assert(generateInitialBoard != null);

  @override
  GameState get initialState => InitialGame();

  @override
  Stream<GameState> mapEventToState(
    GameEvent event,
  ) async* {
    if (event is Move) {
      // Send the start state
      yield UpdateBoardStart(event.direction);

      // Call the use case
      final output = await updateBoard(Params(direction: event.direction));

      yield UpdateBoardEnd(output);
    }

    if (event is LoadInitialBoard) {
      // Send the start state
      yield UpdateBoardStart(null);

      // call the use case
      final output = await generateInitialBoard(NoParams());

      yield UpdateBoardEnd(output);
    }
  }
}
