import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import './bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/get_current_board.dart';
import '../../domain/usecases/update_board.dart';

/// Handles the game event and send the game states
class GameBloc extends Bloc<GameEvent, GameState> {
  // update board usecase
  final UpdateBoard updateBoard;
  // get current board usecase
  final GetCurrentBoard getCurrentBoard;

  GameBloc({
    @required this.updateBoard,
    @required this.getCurrentBoard,
  })  : assert(updateBoard != null),
        assert(getCurrentBoard != null);

  @override
  GameState get initialState => InitialGame();

  /// Transforms event into a stream of states
  @override
  Stream<GameState> mapEventToState(
    GameEvent event,
  ) async* {
    if (event is Move) {
      // send the start state
      yield UpdateBoardStart(event.direction);

      // get the current board
      final currentBoard = await getCurrentBoard(NoParams());

      // call the use case to update the current [board] with the given [direction]
      final output = await updateBoard(
        Params(
          board: currentBoard,
          direction: event.direction,
        ),
      );

      // send the end state with the updated board
      yield UpdateBoardEnd(output);
    }

    if (event is LoadInitialBoard) {
      // send the start state without move
      yield UpdateBoardStart(null);

      // call the use case to get the current board
      final output = await getCurrentBoard(NoParams());

      // send the end state with the initial board
      yield UpdateBoardEnd(output);
    }
  }
}
