import 'dart:math';

import 'package:flutter_web_2048/core/enums/direction.dart';
import 'package:flutter_web_2048/features/game/domain/entities/board.dart';
import 'package:flutter_web_2048/features/game/domain/entities/tile.dart';

import '../../domain/repositories/board_repository.dart';

class LocalBoardRepository implements BoardRepository {
  Board _currentBoard;

  /// Get the starting board with a single random '2' tile in it.
  @override
  Future<Board> getInitialBoard() async {
    // get the random tile position
    int randomIndex = _getRandomIndex();
    // generate all the tiles with the first tile at the random position
    var tiles = _generateTiles(randomIndex);
    // Create and return the board
    _currentBoard = Board(tiles);
    return _currentBoard;
  }

  @override
  Future<Board> updateBoard(Direction direction) {
    // TODO: implement updateBoard
    return null;
  }

  /// Get a random int between 0 and 15
  int _getRandomIndex() {
    var random = Random();
    return random.nextInt(16);
  }

  /// Generate the board tiles with the first tile positionned at the given index
  List<Tile> _generateTiles(int firstTileIndex) {
    return List<Tile>.generate(
      16,
      (index) {
        if (index == firstTileIndex) {
          return Tile(2);
        }
        return Tile(0);
      },
      growable: false,
    );
  }
}
