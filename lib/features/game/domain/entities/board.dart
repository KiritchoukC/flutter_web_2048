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
  bool get over => getEmptyCellsCoordinate().length == 0 && isBlocked();

  List<Tile> get mergedTiles => tiles.where((tile) => tile != null && tile.merged).toList();

  Board(this.tiles) : _random = Random();

  factory Board.initialize() {
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

  /// Returns all the empty tile positions in the [board]
  Iterable<Coordinate> getEmptyCellsCoordinate() sync* {
    for (var x = 0; x < this.tiles.width; x++) {
      for (var y = 0; y < this.tiles.height; y++) {
        if (this.tiles.get(x, y) == null) {
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
      int x = destination.x + vector.x;
      // break if [x] is out of the board
      if (x > 3 || x < 0) {
        break;
      }

      int y = destination.y + vector.y;
      // break if [y] is out of the board
      if (y > 3 || y < 0) {
        break;
      }

      var nextTile = this.tiles.get(x, y);

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
    final mergedTiles = this.tiles.where((tile) => tile != null && tile.merged);
    // update score if there is merging
    if (mergedTiles.length > 0) {
      final points = mergedTiles.length == 1
          ? mergedTiles.first.value
          : mergedTiles.map((tile) => tile.value).reduce((total, value) => total + value);

      this.score += points;
    }

    return this.score;
  }

  // Returns either bool on failre or Tile on success
  Either<bool, Tile> addRandomTile() {
    // get the coordinate of an empty random cell
    var newTileCoordinate = this.getRandomEmptyTileCoordinate();

    // return false on failure
    if (newTileCoordinate.isLeft()) {
      return Left(false);
    }

    var coordinate = newTileCoordinate.getOrElse(() => null);

    // return fail if there is no coordinate
    if (coordinate == null) {
      return Left(false);
    }
    // get the new tile value with 10% chance of being 4 instead of 2
    var newTileValue = _random.nextInt(10) == 0 ? 4 : 2;
    // generate the new tile
    var newTile = Tile(
      newTileValue,
      x: coordinate.x,
      y: coordinate.y,
    );

    // set the new tile in the current board
    this.tiles.set(coordinate.x, coordinate.y, newTile);

    // return success
    return Right(newTile);
  }

  /// Returns either bool on fail or Coordinate on success
  Either<bool, Coordinate> getRandomEmptyTileCoordinate() {
    // get the empty cells coordinate
    var emptyCells = this.getEmptyCellsCoordinate();

    // return fail if no empty cell left
    if (emptyCells.length == 0) {
      return Left(false);
    }

    // return a random empty tile index
    var randomEmptyCell = emptyCells.toList()[_random.nextInt(emptyCells.length)];

    // return the random empty cell
    return Right(randomEmptyCell);
  }

  /// Get random positioned tiles
  static Iterable<Tile> _getRandomFirstTiles() sync* {
    // get the length of row and column with the square of max
    int square = 4;
    var _random = Random();

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
    this.tiles.where((tile) => tile != null && tile.merged).forEach((tile) => tile.merged = false);
  }

  // check if the board is blocked and no more moves are possible
  bool isBlocked() {
    for (var x = 0; x < this.tiles.width; x++) {
      for (var y = 0; y < this.tiles.height; y++) {
        final currentCell = this.tiles.get(x, y);

        // if there is an empty cell return false
        if (currentCell == null) {
          return false;
        }

        // check each direction for an available merge
        for (var i = 0; i < Direction.values.length; i++) {
          final currentDirection = Direction.values[i];
          final vector = Vector.fromDirection(currentDirection);

          // get the [x] position of the next cell
          int nextX = currentCell.x + vector.x;

          // skip if out of board
          if (nextX < 0 || nextX > 3) {
            continue;
          }

          // get the [y] position of the next cell
          int nextY = currentCell.y + vector.y;

          // skip if out of board
          if (nextY < 0 || nextY > 3) {
            continue;
          }

          // get next cell
          final nextCell = this.tiles.get(nextX, nextY);

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
