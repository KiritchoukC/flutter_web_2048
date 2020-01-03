import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_web_2048/core/enums/direction.dart';
import 'package:flutter_web_2048/features/game/domain/entities/board.dart';
import 'package:flutter_web_2048/features/game/domain/entities/tile.dart';
import 'package:flutter_web_2048/features/game/domain/usecases/get_current_board.dart';
import 'package:flutter_web_2048/features/game/domain/usecases/get_highscore.dart';
import 'package:flutter_web_2048/features/game/domain/usecases/get_previous_board.dart';
import 'package:flutter_web_2048/features/game/domain/usecases/reset_board.dart';
import 'package:flutter_web_2048/features/game/domain/usecases/update_board.dart';
import 'package:flutter_web_2048/features/game/presentation/bloc/bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:piecemeal/piecemeal.dart' as pm;

class MockGetCurrentBoard extends Mock implements GetCurrentBoard {}

class MockUpdateBoard extends Mock implements UpdateBoard {}

class MockResetBoard extends Mock implements ResetBoard {}

class MockGetHighscore extends Mock implements GetHighscore {}

class MockGetPreviousBoard extends Mock implements GetPreviousBoard {}

void main() {
  GameBloc bloc;
  MockGetCurrentBoard mockGetCurrentBoard;
  MockUpdateBoard mockUpdateBoard;
  MockResetBoard mockResetBoard;
  MockGetHighscore mockGetHighscore;
  MockGetPreviousBoard mockGetPreviousBoard;

  setUp(() {
    mockGetCurrentBoard = MockGetCurrentBoard();
    mockUpdateBoard = MockUpdateBoard();
    mockResetBoard = MockResetBoard();
    mockGetHighscore = MockGetHighscore();
    mockGetPreviousBoard = MockGetPreviousBoard();

    bloc = GameBloc(
      getCurrentBoard: mockGetCurrentBoard,
      updateBoard: mockUpdateBoard,
      resetBoard: mockResetBoard,
      getHighscore: mockGetHighscore,
      getPreviousBoard: mockGetPreviousBoard,
    );
  });

  tearDown(() {
    bloc?.close();
  });

  test('should throw when initialized with null argument', () async {
    // ACT & ASSERT
    expect(
        () => GameBloc(
            getCurrentBoard: null,
            updateBoard: mockUpdateBoard,
            resetBoard: mockResetBoard,
            getHighscore: mockGetHighscore,
            getPreviousBoard: mockGetPreviousBoard),
        throwsA(isA<AssertionError>()));
    expect(
        () => GameBloc(
            getCurrentBoard: mockGetCurrentBoard,
            updateBoard: null,
            resetBoard: mockResetBoard,
            getHighscore: mockGetHighscore,
            getPreviousBoard: mockGetPreviousBoard),
        throwsA(isA<AssertionError>()));
    expect(
        () => GameBloc(
            getCurrentBoard: mockGetCurrentBoard,
            updateBoard: mockUpdateBoard,
            resetBoard: null,
            getHighscore: mockGetHighscore,
            getPreviousBoard: mockGetPreviousBoard),
        throwsA(isA<AssertionError>()));
    expect(
        () => GameBloc(
            getCurrentBoard: mockGetCurrentBoard,
            updateBoard: mockUpdateBoard,
            resetBoard: mockResetBoard,
            getHighscore: null,
            getPreviousBoard: mockGetPreviousBoard),
        throwsA(isA<AssertionError>()));
    expect(
        () => GameBloc(
            getCurrentBoard: mockGetCurrentBoard,
            updateBoard: mockUpdateBoard,
            resetBoard: mockResetBoard,
            getHighscore: mockGetHighscore,
            getPreviousBoard: null),
        throwsA(isA<AssertionError>()));
  });

  test('Initial state should be [InitialGame]', () {
    // ASSERT
    expect(bloc.initialState, equals(InitialGame()));
  });

  test('close should not emit new states', () {
    // ASSERT Later
    expectLater(
      bloc,
      emitsInOrder([InitialGame(), emitsDone]),
    );

    // ACT
    bloc.close();
  });

  group('LoadInitialBoard', () {
    test('should call [GetCurentBoard] usecase', () async {
      // ARRANGE
      when(mockGetCurrentBoard.call(any))
          .thenAnswer((_) async => Right(Board(pm.Array2D<Tile>(4, 4))));

      // ACT
      bloc.add(LoadInitialBoard());
      await untilCalled(mockGetCurrentBoard.call(any));

      // ASSERT
      verify(mockGetCurrentBoard.call(any));
    });

    test('should emit [InitialGame, UpdateBoardStart, UpdateBoardEnd]', () {
      // ARRANGE
      final usecaseOutput = Board(pm.Array2D<Tile>(4, 4));
      when(mockGetCurrentBoard.call(any)).thenAnswer((_) async => Right(usecaseOutput));

      // ASSERT LATER
      final expected = [
        InitialGame(),
        UpdateBoardStart(),
        UpdateBoardEnd(usecaseOutput),
      ];

      expectLater(
        bloc,
        emitsInOrder(expected),
      );

      bloc.add(LoadInitialBoard());
    });
  });

  group('Move', () {
    test('should call [UpdateBoard] usecase', () async {
      // ARRANGE
      when(mockUpdateBoard.call(any)).thenAnswer((_) async => Right(Board(pm.Array2D<Tile>(4, 4))));

      // ACT
      bloc.add(Move(direction: Direction.down));
      await untilCalled(mockUpdateBoard.call(any));

      // ASSERT
      verify(mockUpdateBoard.call(any));
    });

    test('should emit [InitialGame, UpdateBoardStart, UpdateBoardEnd]', () {
      // ARRANGE
      final direction = Direction.down;
      final usecaseOutput = Board(pm.Array2D<Tile>(4, 4));
      when(mockGetCurrentBoard.call(any)).thenAnswer((_) async => Right(usecaseOutput));
      when(mockUpdateBoard.call(any)).thenAnswer((_) async => Right(usecaseOutput));

      // ASSERT LATER
      final expected = [
        InitialGame(),
        UpdateBoardStart(),
        UpdateBoardEnd(usecaseOutput),
      ];

      expectLater(
        bloc,
        emitsInOrder(expected),
      );

      bloc.add(Move(direction: direction));
    });

    test(
        'should emit [InitialGame, UpdateBoardStart, GameOver, HighscoreLoaded] when the game is over',
        () {
      // ARRANGE
      final direction = Direction.down;
      // generate board in a game over state
      var tiles = pm.Array2D<Tile>.generated(4, 4, (x, y) => Tile(2, x: x, y: y));
      tiles.set(1, 0, Tile(4, x: 1, y: 0));
      tiles.set(3, 0, Tile(4, x: 3, y: 0));
      tiles.set(0, 1, Tile(4, x: 0, y: 1));
      tiles.set(2, 1, Tile(4, x: 2, y: 1));
      tiles.set(1, 2, Tile(4, x: 1, y: 2));
      tiles.set(3, 2, Tile(4, x: 3, y: 2));
      tiles.set(0, 3, Tile(4, x: 0, y: 3));
      tiles.set(2, 3, Tile(4, x: 2, y: 3));
      final usecaseOutput = Board(tiles);

      when(mockGetCurrentBoard.call(any)).thenAnswer((_) async => Right(usecaseOutput));
      when(mockUpdateBoard.call(any)).thenAnswer((_) async => Right(usecaseOutput));
      final highscore = 9000;
      when(mockGetHighscore.call(any)).thenAnswer((_) async => Right(highscore));

      // ASSERT LATER
      final expected = [
        InitialGame(),
        UpdateBoardStart(),
        GameOver(usecaseOutput),
        HighscoreLoaded(highscore)
      ];

      expectLater(
        bloc,
        emitsInOrder(expected),
      );

      bloc.add(Move(direction: direction));
    });
  });

  group('NewGame', () {
    test('should call [ResetBoard] usecase', () async {
      // ARRANGE
      when(mockResetBoard.call(any)).thenAnswer((_) async => Right(Board(pm.Array2D<Tile>(4, 4))));

      // ACT
      bloc.add(NewGame());
      await untilCalled(mockResetBoard.call(any));

      // ASSERT
      verify(mockResetBoard.call(any));
    });

    test('should emit [InitialGame, UpdateBoardStart, UpdateBoardEnd, HighscoreLoaded]', () {
      // ARRANGE
      final usecaseOutput = Board(pm.Array2D<Tile>(4, 4));
      when(mockResetBoard.call(any)).thenAnswer((_) async => Right(usecaseOutput));
      final highscore = 9000;
      when(mockGetHighscore.call(any)).thenAnswer((_) async => Right(highscore));

      // ASSERT LATER
      final expected = [
        InitialGame(),
        UpdateBoardStart(),
        UpdateBoardEnd(usecaseOutput),
        HighscoreLoaded(highscore),
      ];

      expectLater(
        bloc,
        emitsInOrder(expected),
      );

      bloc.add(NewGame());
    });
  });

  group('LoadHighscore', () {
    test('should call [GetHighscore] usecase', () async {
      // ARRANGE
      when(mockGetHighscore.call(any)).thenAnswer((_) async => Right(9000));

      // ACT
      bloc.add(LoadHighscore());
      await untilCalled(mockGetHighscore.call(any));

      // ASSERT
      verify(mockGetHighscore.call(any));
    });

    test('should emit [InitialGame, HighscoreLoaded]', () {
      // ARRANGE
      final usecaseOutput = 9000;
      when(mockGetHighscore.call(any)).thenAnswer((_) async => Right(usecaseOutput));

      // ASSERT LATER
      final expected = [
        InitialGame(),
        HighscoreLoaded(usecaseOutput),
      ];

      expectLater(
        bloc,
        emitsInOrder(expected),
      );

      bloc.add(LoadHighscore());
    });
  });

  group('Undo', () {
    test('should call [GetPreviousBoard] usecase', () async {
      // ARRANGE
      when(mockGetPreviousBoard.call(any))
          .thenAnswer((_) async => Right(Board(pm.Array2D<Tile>(4, 4))));

      // ACT
      bloc.add(Undo());
      await untilCalled(mockGetPreviousBoard.call(any));

      // ASSERT
      verify(mockGetPreviousBoard.call(any));
    });

    test('should emit [InitialGame, HighscoreLoaded]', () {
      // ARRANGE
      final usecaseOutput = Board(pm.Array2D<Tile>(4, 4));
      when(mockGetPreviousBoard.call(any)).thenAnswer((_) async => Right(usecaseOutput));

      // ASSERT LATER
      final expected = [
        InitialGame(),
        UpdateBoardStart(),
        UpdateBoardEnd(usecaseOutput),
      ];

      expectLater(
        bloc,
        emitsInOrder(expected),
      );

      bloc.add(Undo());
    });
  });
}
