import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_web_2048/features/game/domain/usecases/get_current_board.dart';
import 'package:meta/meta.dart';

import './bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/update_board.dart';

const String serverFailureMessage = 'Server Failure';
const String networkFailureMessage = 'Verify your network connection';

class GameBloc extends Bloc<GameEvent, GameState> {
  final UpdateBoard updateBoard;
  final GetCurrentBoard getCurrentBoard;

  GameBloc({
    @required this.updateBoard,
    @required this.getCurrentBoard,
  })  : assert(updateBoard != null),
        assert(getCurrentBoard != null);

  @override
  GameState get initialState => InitialGame();

  @override
  Stream<GameState> mapEventToState(
    GameEvent event,
  ) async* {
    if (event is Move) {
      // Send the start state
      yield UpdateBoardStart(event.direction);

      final currentBoard = await getCurrentBoard(NoParams());

      // Call the use case
      final output = await updateBoard(
        Params(
          board: currentBoard,
          direction: event.direction,
        ),
      );

      yield UpdateBoardEnd(output);
    }

    if (event is LoadInitialBoard) {
      // Send the start state
      yield UpdateBoardStart(null);

      // call the use case
      final output = await getCurrentBoard(NoParams());

      yield UpdateBoardEnd(output);
    }
  }
}
