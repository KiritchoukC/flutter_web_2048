import 'package:flutter_web_2048/core/enums/direction.dart';
import 'package:flutter_web_2048/features/game/domain/entities/board.dart';
import 'package:flutter_web_2048/features/game/domain/entities/tile.dart';

class BoardHelper {
  static Iterable<int> getEmptyTileIndices(Board board) sync* {
    for (var i = 0; i < board.tiles.length; i++) {
      if (board.tiles[i].value == 0) {
        yield i;
      }
    }
  }

  /// Move the [tile] at [index] down in the [board]
  static Board moveTileDown(Board board, Tile tile, int index) {
    final nextTileIndex = index + 4;
    // exit if next tile index is outside of board
    if (nextTileIndex >= board.tiles.length) {
      return board;
    }
    // get the next tile
    var nextTile = board.tiles[nextTileIndex];
    // if it's an empty cell the move it down
    if (nextTile.value == 0) {
      // get the final destination index
      int destinationIndex = getDestinationIndex(Direction.down, board, index);
      // update the destination tile with the current tile value
      board.tiles[destinationIndex] = tile;
      // reset the current tile
      board.tiles[index] = Tile(0);

      return board;
    }
    // if current tile is the same value as the next tile then merge them
    if (nextTile.value == tile.value) {
      // update the next tile with the current tile value
      board.tiles[nextTileIndex] = Tile(tile.value * 2);
      // reset the current tile
      board.tiles[index] = Tile(0);

      return board;
    }

    return board;
  }

  static int getDestinationIndex(
      Direction direction, Board board, int tileIndex) {
    // Get the next tile index
    int nextTileIndex = getNextTileIndex(direction, tileIndex);

    // return the tile index is the next on is outside of board
    if (nextTileIndex >= board.tiles.length) {
      return tileIndex;
    }

    // if the next tile is not empty then return the current tile index
    if (board.tiles[nextTileIndex].value != 0) {
      return tileIndex;
    }

    return getDestinationIndex(direction, board, nextTileIndex);
  }

  static int getNextTileIndex(Direction direction, int tileIndex) {
    switch (direction) {
      case Direction.down:
        return tileIndex + 4;
      case Direction.up:
        return tileIndex - 4;
      case Direction.right:
        return tileIndex + 1;
      case Direction.left:
        return tileIndex - 1;
    }

    throw Error();
  }
}
