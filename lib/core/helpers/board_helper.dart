import 'package:flutter_web_2048/core/enums/direction.dart';
import 'package:flutter_web_2048/features/game/domain/entities/board.dart';

class BoardHelper {
  /// Returns all the empty tiles in the [board]
  static Iterable<Map<String, int>> getEmptyTiles(Board board) sync* {
    for (var y = 0; y < board.tiles.length; y++) {
      for (var x = 0; x < board.tiles[y].length; x++) {
        if (board.tiles[x][y] == null) {
          yield {'x': x, 'y': y};
        }
      }
    }
  }

  /// Returns the x/y vector for the given [direction]
  static Map<String, int> getVector(Direction direction) {
    var map = {
      Direction.up: {'x': 0, 'y': -1},
      Direction.right: {'x': 1, 'y': 0},
      Direction.down: {'x': 0, 'y': 1},
      Direction.left: {'x': -1, 'y': 0}
    };

    return map[direction];
  }

  /// Returns the board traversal direction
  static Map<String, List<int>> getTraversals(Map<String, int> vector, int size) {
    // Get the default traversals, start from the top left (x:0, y:O) to bottom right (x:3, y:3)
    var traversals = getDefaultTraversals(size);

    // Always traverse from the farthest cell in the chosen direction
    if (vector['x'] == 1) {
      // If going right, start from the top right (x:3, y:O)
      // and end on the bottom left (x:O, y:3)
      traversals['x'] = traversals['x'].reversed.toList();
    }
    if (vector['y'] == 1) {
      // If going down, start from the bottom left (x:0, y:3)
      // and end on the top right (x:3, y:0)
      traversals['y'] = traversals['y'].reversed.toList();
    }

    return traversals;
  }

  /// Get the default traversals, start from the top left (x:0, y:O) to bottom right (x:[size-1], y:[size-1])
  static Map<String, List<int>> getDefaultTraversals(int size) {
    var traversals = {'x': <int>[], 'y': <int>[]};

    for (var pos = 0; pos < size; pos++) {
      traversals['x'].add(pos);
      traversals['y'].add(pos);
    }

    return traversals;
  }
}
