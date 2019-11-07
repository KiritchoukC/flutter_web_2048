import 'tile.dart';

class Board {
  List<List<Tile>> tiles;
  List<Tile> get flatTiles => tiles.expand((i) => i).toList();
  Board(this.tiles);
}
