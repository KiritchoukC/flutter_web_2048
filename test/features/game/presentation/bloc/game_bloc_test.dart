import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_web_2048/core/enums/direction.dart';
import 'package:flutter_web_2048/features/game/domain/entities/board.dart';
import 'package:flutter_web_2048/features/game/domain/entities/tile.dart';
import 'package:flutter_web_2048/features/game/domain/usecases/get_current_board.dart';
import 'package:flutter_web_2048/features/game/domain/usecases/update_board.dart';
import 'package:flutter_web_2048/features/game/presentation/bloc/bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:piecemeal/piecemeal.dart' as pm;

class MockGetCurrentBoard extends Mock implements GetCurrentBoard {}

class MockUpdateBoard extends Mock implements UpdateBoard {}

void main() {
  GameBloc bloc;
  MockGetCurrentBoard mockGetCurrentBoard;
  MockUpdateBoard mockUpdateBoard;

  setUp(() {
    mockGetCurrentBoard = MockGetCurrentBoard();
    mockUpdateBoard = MockUpdateBoard();

    bloc = GameBloc(
      getCurrentBoard: mockGetCurrentBoard,
      updateBoard: mockUpdateBoard,
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
              updateBoard: null,
            ),
        throwsA(isA<AssertionError>()));
    expect(
        () => GameBloc(
              getCurrentBoard: mockGetCurrentBoard,
              updateBoard: null,
            ),
        throwsA(isA<AssertionError>()));
    expect(
        () => GameBloc(
              getCurrentBoard: null,
              updateBoard: mockUpdateBoard,
            ),
        throwsA(isA<AssertionError>()));
  });

  test('Initial state should be [InitialGame]', () {
    // ASSERT
    expect(bloc.initialState, equals(InitialGame()));
  });

  test('close should not emit new states', () {
    expectLater(
      bloc,
      emitsInOrder([InitialGame(), emitsDone]),
    );
    bloc.close();
  });

  group('LoadInitialBoard', () {
    test('should call [GetCurentBoard] usecase', () async {
      // ARRANGE
      when(mockGetCurrentBoard.call(any)).thenAnswer((_) async => Board(pm.Array2D<Tile>(4, 4)));

      // ACT
      bloc.add(LoadInitialBoard());
      await untilCalled(mockGetCurrentBoard.call(any));

      // ASSERT
      verify(mockGetCurrentBoard.call(any));
    });

    test('should emit [InitialGame, UpdateBoardStart, UpdateBoardEnd]', () {
      // ARRANGE
      final usecaseOutput = Board(pm.Array2D<Tile>(4, 4));
      when(mockGetCurrentBoard.call(any)).thenAnswer((_) async => usecaseOutput);

      // ASSERT LATER
      final expected = [
        InitialGame(),
        UpdateBoardStart(null),
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
      when(mockUpdateBoard.call(any)).thenAnswer((_) async => Board(pm.Array2D<Tile>(4, 4)));

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
      when(mockGetCurrentBoard.call(any)).thenAnswer((_) async => usecaseOutput);
      when(mockUpdateBoard.call(any)).thenAnswer((_) async => usecaseOutput);

      // ASSERT LATER
      final expected = [
        InitialGame(),
        UpdateBoardStart(direction),
        UpdateBoardEnd(usecaseOutput),
      ];

      expectLater(
        bloc,
        emitsInOrder(expected),
      );

      bloc.add(Move(direction: direction));
    });
  });
}
