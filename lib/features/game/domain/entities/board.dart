import 'coordinate.dart';
import 'destination.dart';
import 'tile.dart';
import 'vector.dart';

class Board {
  List<List<Tile>> tiles;

  List<Tile> get flatTiles => tiles.expand((i) => i).toList();

  Board(this.tiles);

  /// Returns all the empty tile positions in the [board]
  Iterable<Coordinate> getEmptyTileCoordinates() sync* {
    for (var y = 0; y < this.tiles.length; y++) {
      for (var x = 0; x < this.tiles[y].length; x++) {
        if (this.tiles[x][y] == null) {
          yield Coordinate(x, y);
        }
      }
    }
  }

  /// Returns the given tile final destination and if
  /// it needs to be merged with another tile
  Destination getTileDestination(Tile tile, Vector vector) {
    // set the initial destination with the tile position
    var destination = Destination(x: tile.x, y: tile.y, hasMerged: false, hasMoved: false);

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

      var nextTile = this.tiles[x][y];

      // if next tile is empty set the new destination 
      // and continue with the next one
      if (nextTile == null) {
        destination = Destination(y: y, x: x, hasMerged: false, hasMoved: true);
        continue;
      }

      // break if next tile is not empty and have a different value
      if (nextTile.value != tile.value) {
        break;
      }

      // if tiles have the same value, merge them and break
      destination = Destination(y: y, x: x, hasMerged: true, hasMoved: true);
      break;
    }

    return destination;
  }
}