import 'package:flutter_web_2048/features/game/domain/entities/board.dart';

class BoardHelper {
  static Iterable<Map<String, int>> getEmptyTiles(Board board) sync* {
    for (var y = 0; y < board.tiles.length; y++) {
      for (var x = 0; x < board.tiles[y].length; x++) {
        if (board.tiles[x][y] == null) {
          yield {'x': x, 'y': y};
        }
      }
    }
  }
}
