import 'destination.dart';
import 'tile.dart';
import 'vector.dart';

class Board {
  List<List<Tile>> tiles;
  List<Tile> get flatTiles => tiles.expand((i) => i).toList();
  Board(this.tiles);

  /// Returns all the empty tiles in the [board]
  Iterable<Map<String, int>> getEmptyTiles() sync* {
    for (var y = 0; y < this.tiles.length; y++) {
      for (var x = 0; x < this.tiles[y].length; x++) {
        if (this.tiles[x][y] == null) {
          yield {'x': x, 'y': y};
        }
      }
    }
  }

  /// Returns the given tile final destination and if
  /// it needs to be merged with another tile
  Destination getTileDestination(Tile tile, Vector vector) {
    var destination = Destination(x: tile.x, y: tile.y, merged: false);

    while (destination.x < 3 && destination.y < 3 && destination.x > 0 && destination.y > 0) {
      destination = Destination(
        x: destination.x + vector.x,
        y: destination.y + vector.y,
        merged: false,
      );
    }

    return destination;
  }
}