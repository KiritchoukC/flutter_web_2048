import 'package:meta/meta.dart';

import 'vector.dart';

class Traversal {
  final List<int> x;
  final List<int> y;

  Traversal({@required this.x, @required this.y});

  /// Returns the board traversal direction
  factory Traversal.fromVector(Vector vector, int size) {
    // Get the default traversals, start from the top left (x:0, y:O) to bottom right (x:3, y:3)
    var traversal = Traversal.init(size);

    // Always traverse from the farthest cell in the chosen direction
    if (vector.x == 1) {
      // If going right, start from the top right (x:3, y:O)
      // and end on the bottom left (x:O, y:3)
      traversal = Traversal(x: traversal.x.reversed.toList(), y: traversal.y);
    }
    if (vector.y == 1) {
      // If going down, start from the bottom left (x:0, y:3)
      // and end on the top right (x:3, y:0)
      traversal = Traversal(x: traversal.x, y: traversal.y.reversed.toList());
    }

    return traversal;
  }

  /// Get the default traversals, start from the top left (x:0, y:O) to bottom right (x:[size-1], y:[size-1])
  factory Traversal.init(int size) {
    final traversal = Traversal(x: <int>[], y: <int>[]);

    for (var pos = 0; pos < size; pos++) {
      traversal.x.add(pos);
      traversal.y.add(pos);
    }

    return traversal;
  }
}
