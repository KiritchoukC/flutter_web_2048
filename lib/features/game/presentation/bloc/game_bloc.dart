import 'dart:async';
import 'package:flutter_web_2048/core/usecases/usecase.dart';
import 'package:flutter_web_2048/features/game/domain/usecases/generate_initial_board.dart';
import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';

import './bloc.dart';
import '../../../../core/enums/direction.dart';
import '../../../../core/error/failures.dart';
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

      // What happens when use case fails
      final onFailure = (failure) async* {
        yield Error(_mapFailureToMessage(failure));
      };

      // What happens when use case succeed
      final onSuccess = (board) async* {
        yield UpdateBoardEnd(board);
      };

      // Fold the usecase response
      yield* output.fold(onFailure, onSuccess);
    }

    if (event is LoadInitialBoard) {
      // Send the start state
      yield UpdateBoardStart(null);

      // call the use case
      final output = await generateInitialBoard(NoParams());

      // What happens when use case fails
      final onFailure = (failure) async* {
        yield Error(_mapFailureToMessage(failure));
      };

      // What happens when use case succeed
      final onSuccess = (board) async* {
        yield UpdateBoardEnd(board);
      };

      // Fold the usecase response
      yield* output.fold(onFailure, onSuccess);
    }
  }
}

String _mapFailureToMessage(Failure failure) {
  // Instead of a regular 'if (failure is ServerFailure)...'
  switch (failure.runtimeType) {
    case ServerFailure:
      return serverFailureMessage;
    case NetworkFailure:
      return networkFailureMessage;
    default:
      return 'Unexpected Error';
  }
}
