import 'dart:math';

import 'package:flutter_web_2048/core/enums/direction.dart';
import 'package:flutter_web_2048/features/game/domain/entities/board.dart';
import 'package:flutter_web_2048/features/game/domain/entities/tile.dart';

import '../../domain/repositories/board_repository.dart';

class LocalBoardRepository implements BoardRepository {
  Board _currentBoard;

  /// Get the starting board with a single random '2' tile in it.
  @override
  Future<Board> getCurrentBoard() async {
    // Initialize the current board if it does not exist yet.
    _currentBoard = _currentBoard ?? initializeBoard();

    return _currentBoard;
  }

  @override
  Future<Board> updateBoard(Board board, Direction direction) async {
    board.tiles.removeWhere((tile) => tile.value == 0);
    board.tiles.add(Tile(2));

    return board;
  }

  @override
  Future resetBoard() async {
    _currentBoard = null;
  }

  /// Initialize the board
  Board initializeBoard() {
    // get the random position for each tile
    var indices = _getRandomIndices().toList();
    int firstTileIndex = indices[0];
    int secondTileIndex = indices[1];
    // generate all the tiles with the first tile at the random position
    var tiles = _generateTiles(firstTileIndex, secondTileIndex);
    // create and return the new board.
    return Board(tiles);
  }

  /// Get random ints between 0 and 15
  Iterable<int> _getRandomIndices() sync* {
    var random = Random();
    // generate the first index
    var firstIndex = random.nextInt(16);
    yield firstIndex;
    // generate the second index
    if (firstIndex <= 7) {
      // If the first index is less or equal to 7 then the second one should be at least 8
      yield 8 + random.nextInt(8);
    }
    else{
      // If the first index is more than 7 then the second one should be less or equal to 7
      yield random.nextInt(8);
    }
  }

  /// Generate the board tiles with the first tile positionned at the given index
  List<Tile> _generateTiles(int firstTileIndex, int secondTileIndex) {
    return List<Tile>.generate(
      16,
      (index) {
        if (index == firstTileIndex || index == secondTileIndex) {
          return Tile(2);
        }
        return Tile(0);
      },
      growable: false,
    );
  }
}
