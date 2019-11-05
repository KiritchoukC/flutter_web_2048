import 'package:flutter_web_2048/features/game/domain/entities/board.dart';

class BoardHelper{
  static Iterable<int> getEmptyTileIndices(Board board) sync*{
    for (var i = 0; i < board.tiles.length; i++) {
      if (board.tiles[i].value == 0) {
        yield i;
      }
    }
  }
}