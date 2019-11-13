import 'package:meta/meta.dart';

import 'tile.dart';

class Destination {
  final bool hasMoved;
  final int x;
  final int y;
  final bool hasMerged;
  final Tile mergedWith;

  const Destination({
    @required this.x,
    @required this.y,
    @required this.hasMerged,
    @required this.hasMoved,
    @required this.mergedWith,
  });
}
