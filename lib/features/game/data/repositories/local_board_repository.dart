import 'dart:math';

import '../../../../core/enums/direction.dart';
import '../../domain/entities/board.dart';
import '../../domain/entities/coordinate.dart';
import '../../domain/entities/tile.dart';
import '../../domain/entities/traversal.dart';
import '../../domain/entities/vector.dart';
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
    final int size = 4;
    final vector = Vector.fromDirection(direction);
    final traversal = Traversal.fromVector(vector, size);
    bool hasBoardMoved = false;

    // reset merged tiles
    board.flatTiles
        .where((tile) => tile != null && tile.merged)
        .forEach((tile) => tile.merged = false);

    // traverse the grid
    for (var i = 0; i < size; i++) {
      int x = traversal.x[i];
      for (var j = 0; j < size; j++) {
        int y = traversal.y[j];

        // get the tile at the current position [x][y]
        var currentTile = board.tiles[x][y];

        // skip empty cell
        if (currentTile == null) {
          continue;
        }

        // get the tile final destination
        var destination = board.getTileDestination(currentTile, vector);

        // skip if tile does not move
        if (!destination.hasMoved) {
          continue;
        }

        // check if the board moved only if it has not been moved yet
        hasBoardMoved = hasBoardMoved || destination.hasMoved;

        // empty the current cell
        board.tiles[x][y] = null;

        // get the new tile
        final newTile = Tile.fromDestination(currentTile.value, x, y, destination);

        // move the tile in its new cell
        board.tiles[destination.x][destination.y] = newTile;
      }
    }

    if (hasBoardMoved) {
      var newTileCoordinate = getRandomEmptyTileCoordinate(board);
      var newTileValue = _random.nextInt(10) == 0 ? 4 : 2;
      var newTile = Tile(
        newTileValue,
        x: newTileCoordinate.x,
        y: newTileCoordinate.y,
      );

      board.tiles[newTileCoordinate.x][newTileCoordinate.y] = newTile;
    }

    // get the merged tiles
    final mergedTiles = board.flatTiles.where((tile) => tile != null && tile.merged);
    // update score if there is merging
    if (mergedTiles.length > 0) {
      final points = mergedTiles.length == 1
          ? mergedTiles.first.value
          : mergedTiles.map((tile) => tile.value).reduce((total, value) => total + value);

      board.score += points;
    }

    return board;
  }

  /// Get the index of an empty tile
  Coordinate getRandomEmptyTileCoordinate(Board board) {
    // get the empty tile indices
    var emptyTiles = board.getEmptyTileCoordinates();
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
    var randomFirstTiles = _getRandomFirstTiles().toList();

    // generate all the tiles with the first tile at the random position
    var tiles = _generateTiles(
      randomFirstTiles.toList()[0],
      randomFirstTiles.toList()[1],
    );

    // create and return the new board.
    return Board(tiles);
  }

  /// Get random positioned tiles
  Iterable<Tile> _getRandomFirstTiles() sync* {
    // get the length of row and column with the square of max
    int square = 4;

    int firstTileX = _random.nextInt(square);
    int firstTileY = _random.nextInt(square);

    // generate the first tile
    var firstTile = Tile(
      2,
      x: firstTileX,
      y: firstTileY,
    );

    // return the first generated tile
    yield firstTile;

    // generate the second index
    int half = square ~/ 2;

    // get the second tile x position
    int secondTileX = 0;
    if (firstTile.x < half) {
      secondTileX = half + _random.nextInt(half);
    } else {
      secondTileX = _random.nextInt(half);
    }

    // get the second tile y position
    int secondTileY = 0;
    if (firstTile.y < half) {
      secondTileY = half + _random.nextInt(half);
    } else {
      secondTileY = _random.nextInt(half);
    }

    // generate and return the second random tile
    yield Tile(
      2,
      x: secondTileX,
      y: secondTileY,
    );
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
