import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:piecemeal/piecemeal.dart' as pm;

import '../../../../core/enums/direction.dart';
import 'coordinate.dart';
import 'destination.dart';
import 'tile.dart';
import 'vector.dart';

class Board {
  pm.Array2D<Tile> tiles;
  int score = 0;
  final Random _random;
  // game is over if there is no empty cells left and no more moves available
  bool get over => getEmptyCellsCoordinate().isEmpty && isBlocked();
  List<Tile> get mergedTiles => tiles.where((tile) => tile != null && tile.merged).toList();

  Board(this.tiles) : _random = Random();

  Board.clone(Board board) : _random = board?._random {
    ArgumentError.checkNotNull(board);

    if (board != null) {
      score = board.score;
      tiles = pm.Array2D<Tile>(4, 4);
      for (var x = 0; x < board.tiles.width; x++) {
        for (var y = 0; y < board.tiles.height; y++) {
          final tile = board.tiles.get(x, y);
          if (tile != null) {
            tiles.set(x, y, Tile.clone(tile));
          }
        }
      }
    }
  }

  factory Board.initialize() {
    // get the random position for each tile
    final randomFirstTiles = _getRandomFirstTiles().toList();

    // generate all the tiles with the first tile at the random position
    final tiles = _generateTiles(
      randomFirstTiles.toList()[0],
      randomFirstTiles.toList()[1],
    );

    // create and return the new board.
    return Board(tiles);
  }

  /// Returns all the empty tile positions in the [board]
  Iterable<Coordinate> getEmptyCellsCoordinate() sync* {
    for (var x = 0; x < tiles.width; x++) {
      for (var y = 0; y < tiles.height; y++) {
        if (tiles.get(x, y) == null) {
          yield Coordinate(x, y);
        }
      }
    }
  }

  /// Returns the given tile final destination and if
  /// it needs to be merged with another tile
  Destination getTileDestination(Tile tile, Vector vector) {
    // set the initial destination with the tile position
    var destination = Destination(
      x: tile.x,
      y: tile.y,
      hasMerged: false,
      hasMoved: false,
    );

    while (true) {
      final int x = destination.x + vector.x;
      // break if [x] is out of the board
      if (x > 3 || x < 0) {
        break;
      }

      final int y = destination.y + vector.y;
      // break if [y] is out of the board
      if (y > 3 || y < 0) {
        break;
      }

      final nextTile = tiles.get(x, y);

      // if next tile is empty set the new destination
      // and continue with the next one
      if (nextTile == null) {
        destination = Destination(
          y: y,
          x: x,
          hasMerged: false,
          hasMoved: true,
        );
        continue;
      }

      // break if next tile is not empty and have a different value
      if (nextTile.value != tile.value) {
        break;
      }

      // break if next tile has already been merged
      if (nextTile.merged) {
        break;
      }

      // if tiles have the same value, merge them and break
      destination = Destination(
        y: y,
        x: x,
        hasMerged: true,
        hasMoved: true,
      );
      break;
    }

    return destination;
  }

  int updateScore() {
    // get the merged tiles
    final mergedTiles = tiles.where((tile) => tile != null && tile.merged);
    // update score if there is merging
    if (mergedTiles.isNotEmpty) {
      final points = mergedTiles.length == 1
          ? mergedTiles.first.value
          : mergedTiles.map((tile) => tile.value).reduce((total, value) => total + value);

      score += points;
    }

    return score;
  }

  // Returns either bool on failre or Tile on success
  Either<bool, Tile> addRandomTile() {
    // get the coordinate of an empty random cell
    final newTileCoordinate = getRandomEmptyTileCoordinate();

    // return false on failure
    if (newTileCoordinate.isLeft()) {
      return Left(false);
    }

    final coordinate = newTileCoordinate.getOrElse(() => null);

    // get the new tile value with 10% chance of being 4 instead of 2
    final newTileValue = _random.nextInt(10) == 0 ? 4 : 2;
    // generate the new tile
    final newTile = Tile(
      newTileValue,
      x: coordinate.x,
      y: coordinate.y,
      isNew: true,
    );

    // set the new tile in the current board
    tiles.set(coordinate.x, coordinate.y, newTile);

    // return success
    return Right(newTile);
  }

  /// Returns either bool on fail or Coordinate on success
  Either<bool, Coordinate> getRandomEmptyTileCoordinate() {
    // get the empty cells coordinate
    final emptyCells = getEmptyCellsCoordinate();

    // return fail if no empty cell left
    if (emptyCells.isEmpty) {
      return Left(false);
    }

    // return a random empty tile index
    final randomEmptyCell = emptyCells.toList()[_random.nextInt(emptyCells.length)];

    // return the random empty cell
    return Right(randomEmptyCell);
  }

  /// Get random positioned tiles
  static Iterable<Tile> _getRandomFirstTiles() sync* {
    // get the length of row and column with the square of max
    const int square = 4;
    final _random = Random();

    final int firstTileX = _random.nextInt(square);
    final int firstTileY = _random.nextInt(square);

    // generate the first tile
    final firstTile = Tile(
      2,
      x: firstTileX,
      y: firstTileY,
    );

    // return the first generated tile
    yield firstTile;

    // generate the second index
    const int half = square ~/ 2;

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

  /// Generate the board tiles with the given random tiles
  static pm.Array2D<Tile> _generateTiles(Tile firstRandomTile, Tile secondRandomTile) {
    return pm.Array2D<Tile>.generated(4, 4, (x, y) {
      // generate the first random tile
      if (firstRandomTile.x == x && firstRandomTile.y == y) {
        return firstRandomTile;
      }

      // generate the second random tile
      if (secondRandomTile.x == x && secondRandomTile.y == y) {
        return secondRandomTile;
      }

      return null;
    });
  }

  // set false on all the tiles [merged] property
  void resetMergedTiles() {
    tiles.where((tile) => tile != null && tile.merged).forEach((tile) => tile.merged = false);
  }

  // set false on all the tiles [isNew] property
  void resetNewTiles() {
    tiles.where((tile) => tile != null && tile.isNew).forEach((tile) => tile.isNew = false);
  }

  // check if the board is blocked and no more moves are possible
  bool isBlocked() {
    for (var x = 0; x < tiles.width; x++) {
      for (var y = 0; y < tiles.height; y++) {
        final currentCell = tiles.get(x, y);

        // if there is an empty cell return false
        if (currentCell == null) {
          return false;
        }

        // check each direction for an available merge
        for (var i = 0; i < Direction.values.length; i++) {
          final currentDirection = Direction.values[i];
          final vector = Vector.fromDirection(currentDirection);

          // get the [x] position of the next cell
          final int nextX = currentCell.x + vector.x;

          // skip if out of board
          if (nextX < 0 || nextX > 3) {
            continue;
          }

          // get the [y] position of the next cell
          final int nextY = currentCell.y + vector.y;

          // skip if out of board
          if (nextY < 0 || nextY > 3) {
            continue;
          }

          // get next cell
          final nextCell = tiles.get(nextX, nextY);

          // if the next cell is empty then a move is available
          if (nextCell == null) {
            return false;
          }

          // if current and next value are the same then a merge is available
          if (currentCell.value == nextCell.value) {
            return false;
          }
        }
      }
    }

    // return true if no moves have been found
    return true;
  }
}
