import 'package:meta/meta.dart';

class Destination{
  final bool hasMoved;
  final int x;
  final int y;
  final bool hasMerged;

  const Destination({@required this.x, @required this.y, @required this.hasMerged, @required this.hasMoved});
}