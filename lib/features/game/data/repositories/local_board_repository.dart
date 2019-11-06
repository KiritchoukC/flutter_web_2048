import 'dart:math';

import 'package:flutter_web_2048/core/enums/direction.dart';
import 'package:flutter_web_2048/core/helpers/board_helper.dart';
import 'package:flutter_web_2048/features/game/domain/entities/board.dart';
import 'package:flutter_web_2048/features/game/domain/entities/tile.dart';

import '../../domain/repositories/board_repository.dart';

class LocalBoardRepository implements BoardRepository {
  Board _currentBoard;
  final Random _random;
  final int numberOfTiles = 16;

  LocalBoardRepository() : _random = Random();

  /// Get the starting board with a single random '2' tile in it.
  @override
  Future<Board> getCurrentBoard() async {
    // Initialize the current board if it does not exist yet.
    _currentBoard = _currentBoard ?? initializeBoard();

    return _currentBoard;
  }

  /// Update the [board] by moving the tiles in the given [direction]
  @override
  Future<Board> updateBoard(Board board, Direction direction) async {
    bool hasBoardBeenUpdated = false;
    for (var i = 0; i < board.tiles.length; i++) {
      var tile = board.tiles[i];
      // skip if this is an empty tile
      if (tile.value == 0) {
        continue;
      }

      switch (direction) {
        case Direction.down:
          BoardHelper.moveTileDown(board, tile, i);
          break;
        case Direction.up:
          final nextTile = i - 4;
          break;
        case Direction.left:
          final nextTile = i - 1;
          break;
        case Direction.right:
          final nextTile = i + 1;
          break;
        default:
      }
    }

    // If board has been updated then add a new tile
    if (hasBoardBeenUpdated) {
      // Get a random index in the empty tiles
      int randomEmptyTileIndex = getRandomEmptyTileIndex(board);
      // set the value of a empty tile
      board.tiles[randomEmptyTileIndex] = Tile(2);
    }

    return board;
  }

  /// Get the index of an empty tile
  int getRandomEmptyTileIndex(Board board) {
    // get the empty tile indices
    var emptyTiles = BoardHelper.getEmptyTileIndices(board);
    // return a random empty tile index
    return emptyTiles.toList()[_random.nextInt(emptyTiles.length)];
  }

  @override
  Future resetBoard() async {
    _currentBoard = null;
  }

  /// Initialize the board
  Board initializeBoard() {
    // get the random position for each tile
    var indices = _getRandomIndices(numberOfTiles).toList();
    int firstTileIndex = indices[0];
    int secondTileIndex = indices[1];
    // generate all the tiles with the first tile at the random position
    var tiles = _generateTiles(numberOfTiles, firstTileIndex, secondTileIndex);
    // create and return the new board.
    return Board(tiles);
  }

  /// Get random ints between 0 and [max]
  Iterable<int> _getRandomIndices(int max) sync* {
    // generate the first index
    var firstIndex = _random.nextInt(max);
    yield firstIndex;
    // generate the second index
    int half = max ~/ 2;
    if (firstIndex < (half)) {
      // If the first index is less than half the number of tiles
      // then the second one should be at least half of the number
      // of tiles
      yield half + _random.nextInt(half);
    } else {
      // If the first index is more than the half or equal then the
      // second one should be not more than half of the number of tiles
      yield _random.nextInt(half);
    }
  }

  /// Generate the board tiles with the first tile positionned at the given index
  List<Tile> _generateTiles(
      int numberOfTiles, int firstTileIndex, int secondTileIndex) {
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
