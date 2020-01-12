import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import './bloc.dart';
import '../../../../core/extensions/either_extensions.dart';
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
  GameState get initialState => InitialGameState();

  /// Transforms event into a stream of states
  @override
  Stream<GameState> mapEventToState(GameEvent event) async* {
    if (event is MoveEvent) {
      yield* _handleMoveEvent(event);
    }

    if (event is LoadInitialBoardEvent) {
      yield* _handleLoadInitialBoardEvent(event);
    }

    if (event is NewGameEvent) {
      yield* _handleNewGameEvent(event);
    }

    if (event is LoadHighscoreEvent) {
      yield* _handleLoadHighscoreEvent(event);
    }

    if (event is UndoEvent) {
      yield* _handleUndoEvent(event);
    }
  }

  /// Handle [MoveEvent] event and yield the right output
  Stream<GameState> _handleMoveEvent(MoveEvent event) async* {
    // send the start state
    yield UpdateBoardStartState();

    // get the current board
    final currentBoard = await getCurrentBoard(NoParams());

    // call the use case to update the current [board] with the given [direction]
    final usecaseResult = await updateBoard(
      update_board.UpdateBoardParams(
        board: currentBoard?.getRight(),
        direction: event.direction,
      ),
    );

    final output = usecaseResult?.getRight();

    if (output.over) {
      // send the game over state with the boad and highscore
      yield GameOverState(output);

      // get the new highscore
      final highscore = await getHighscore(NoParams());

      // send highscore loaded event
      yield HighscoreLoadedState(highscore?.getRight());
    } else {
      // send the end state with the updated board
      yield UpdateBoardEndState(output);
    }
  }

  /// Handle [LoadInitialBoardEvent] event and yield the right output
  Stream<GameState> _handleLoadInitialBoardEvent(LoadInitialBoardEvent event) async* {
    // send the start state
    yield UpdateBoardStartState();

    // call the use case to get the current board
    final output = await getCurrentBoard(NoParams());

    // send the end state with the initial board
    yield UpdateBoardEndState(output?.getRight());
  }

  /// Handle [NewGameEvent] event and yield the right output
  Stream<GameState> _handleNewGameEvent(NewGameEvent event) async* {
    // send the start state
    yield UpdateBoardStartState();

    // call the use case to get the current board
    final output = await resetBoard(NoParams());

    // send the end state with the new board
    yield UpdateBoardEndState(output?.getRight());

    // send the updated highscore
    final highscore = await getHighscore(NoParams());

    yield HighscoreLoadedState(highscore?.getRight());
  }

  /// Handle [LoadHighscoreEvent] event and yield the right output
  Stream<GameState> _handleLoadHighscoreEvent(LoadHighscoreEvent event) async* {
    // get the previous highscore
    final output = await getHighscore(NoParams());

    // send the event with the previous highscore
    yield HighscoreLoadedState(output?.getRight());
  }

  /// Handle [UndoEvent] event and yield the right output
  Stream<GameState> _handleUndoEvent(UndoEvent event) async* {
    // send the start state
    yield UpdateBoardStartState();

    // call the use case to get the previous board
    final output = await getPreviousBoard(NoParams());

    // send the end state with the new board
    yield UpdateBoardEndState(output?.getRight());
  }
}
