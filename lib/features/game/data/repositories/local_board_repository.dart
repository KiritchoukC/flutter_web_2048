import 'dart:math';

import 'package:flutter_web_2048/core/enums/direction.dart';
import 'package:flutter_web_2048/core/helpers/board_helper.dart';
import 'package:flutter_web_2048/features/game/domain/entities/board.dart';
import 'package:flutter_web_2048/features/game/domain/entities/tile.dart';

import '../../domain/repositories/board_repository.dart';

class LocalBoardRepository implements BoardRepository {
  Board _currentBoard;
  final Random _random;

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
    // bool hasBoardBeenUpdated = false;
    // for (var i = 0; i < board.tiles.length; i++) {
    //   var tile = board.tiles[i];
    //   // skip if this is an empty tile
    //   if (tile.value == 0) {
    //     continue;
    //   }

    //   switch (direction) {
    //     case Direction.down:
    //       BoardHelper.moveTileDown(board, tile, i);
    //       break;
    //     case Direction.up:
    //       final nextTile = i - 4;
    //       break;
    //     case Direction.left:
    //       final nextTile = i - 1;
    //       break;
    //     case Direction.right:
    //       final nextTile = i + 1;
    //       break;
    //     default:
    //   }
    // }

    // // If board has been updated then add a new tile
    // if (hasBoardBeenUpdated) {
    //   // Get a random index in the empty tiles
    //   int randomEmptyTileIndex = getRandomEmptyTile(board);
    //   // set the value of a empty tile
    //   board.tiles[randomEmptyTileIndex] = Tile(2);
    // }

    return board;
  }

  /// Get the index of an empty tile
  Map<String, int> getRandomEmptyTile(Board board) {
    // get the empty tile indices
    var emptyTiles = BoardHelper.getEmptyTiles(board);
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
    var randomFirstTiles = _getRandomFirtTiles().toList();

    // generate all the tiles with the first tile at the random position
    var tiles = _generateTiles(
      randomFirstTiles.toList()[0],
      randomFirstTiles.toList()[1],
    );
    // create and return the new board.
    return Board(tiles);
  }

  /// Get random positioned tiles
  Iterable<Tile> _getRandomFirtTiles() sync* {
    // get the length of row and column with the square of max
    int square = 4;
    // generate the first tile
    var firstTile = Tile(
      2,
      x: _random.nextInt(square),
      y: _random.nextInt(square),
    );
    yield firstTile;
    // generate the second index
    int half = square ~/ 2;

    int secondTileX = 0;

    if (firstTile.x < half) {
      secondTileX = half + _random.nextInt(half);
    } else {
      secondTileX = _random.nextInt(half);
    }

    int secondTileY = 0;

    if (firstTile.y < half) {
      secondTileY = half + _random.nextInt(half);
    } else {
      secondTileY = _random.nextInt(half);
    }

    yield Tile(2, x: secondTileX, y: secondTileY);
  }

  /// Generate the board tiles with the first tile positionned at the given index
  List<List<Tile>> _generateTiles(Tile firstRandomTile, Tile secondRandomTile) {
    return List<List<Tile>>.generate(
      4,
      (x) {
        return List<Tile>.generate(
          4,
          (y) {
            if (firstRandomTile.x == x && firstRandomTile.y == y) {
              return firstRandomTile;
            }

            if (secondRandomTile.x == x && secondRandomTile.y == y) {
              return secondRandomTile;
            }

            return null;
          },
          growable: false,
        );
      },
      growable: false,
    );
  }
}
