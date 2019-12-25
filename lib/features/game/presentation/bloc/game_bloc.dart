import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import './bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/get_current_board.dart';
import '../../domain/usecases/get_highscore.dart';
import '../../domain/usecases/get_previous_board.dart';
import '../../domain/usecases/reset_board.dart';
import '../../domain/usecases/update_board.dart' as update_board;

/// Handles the game event and send the game states
class GameBloc extends Bloc<GameEvent, GameState> {
  // update board usecase
  final update_board.UpdateBoard updateBoard;
  // get current board usecase
  final GetCurrentBoard getCurrentBoard;
  // reset board usecase
  final ResetBoard resetBoard;
  // get highscore usecase
  final GetHighscore getHighscore;
  // get previous board usecase
  final GetPreviousBoard getPreviousBoard;

  GameBloc({
    @required this.updateBoard,
    @required this.getCurrentBoard,
    @required this.resetBoard,
    @required this.getHighscore,
    @required this.getPreviousBoard,
  })  : assert(updateBoard != null),
        assert(getCurrentBoard != null),
        assert(resetBoard != null),
        assert(getHighscore != null),
        assert(getPreviousBoard != null);

  @override
  GameState get initialState => InitialGame();

  /// Transforms event into a stream of states
  @override
  Stream<GameState> mapEventToState(
    GameEvent event,
  ) async* {
    // handle [Move] event
    if (event is Move) {
      // send the start state
      yield UpdateBoardStart();

      // get the current board
      final currentBoard = await getCurrentBoard(NoParams());

      // call the use case to update the current [board] with the given [direction]
      final output = await updateBoard(
        update_board.Params(
          board: currentBoard,
          direction: event.direction,
        ),
      );

      if (output.over) {
        // send the game over state with the boad and highscore
        yield GameOver(output);

        // get the new highscore
        final highscore = await getHighscore(NoParams());
        // send highscore loaded event
        yield HighscoreLoaded(highscore);
      } else {
        // send the end state with the updated board
        yield UpdateBoardEnd(output);
      }
    }

    // handle [LoadInitialBoard] event
    if (event is LoadInitialBoard) {
      // send the start state
      yield UpdateBoardStart();

      // call the use case to get the current board
      final output = await getCurrentBoard(NoParams());

      // send the end state with the initial board
      yield UpdateBoardEnd(output);
    }

    // handle [NewGame] event
    if (event is NewGame) {
      // send the start state
      yield UpdateBoardStart();

      // call the use case to get the current board
      final output = await resetBoard(NoParams());

      // send the end state with the new board
      yield UpdateBoardEnd(output);

      // send the updated highscore
      final highscore = await getHighscore(NoParams());
      yield HighscoreLoaded(highscore);
    }

    // handle [LoadHighscore] event
    if (event is LoadHighscore) {
      // get the previous highscore
      final output = await getHighscore(NoParams());

      // send the event with the previous highscore
      yield HighscoreLoaded(output);
    }

    // handle [Undo] event
    if (event is Undo) {
      // send the start state
      yield UpdateBoardStart();

      // call the use case to get the previous board
      final output = await getPreviousBoard(NoParams());

      // send the end state with the new board
      yield UpdateBoardEnd(output);
    }
  }
}
