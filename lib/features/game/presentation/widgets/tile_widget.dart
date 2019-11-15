import 'package:flutter/material.dart';

import '../../../../core/util/tile_color_converter.dart';
import '../../domain/entities/tile.dart';

class TileWidget extends StatelessWidget {
  final Tile tile;

  const TileWidget({Key key, this.tile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return tile == null ? EmptyTile() : ValueTile(tile: tile);
  }
}

class EmptyTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: <Widget>[
        Container(
          color: TileColorConverter.mapTileValueToColor(null),
        )
      ],
    );
  }
}

class ValueTile extends StatefulWidget {
  final Tile tile;

  const ValueTile({Key key, this.tile}) : super(key: key);

  @override
  _ValueTileState createState() => _ValueTileState();
}

class _ValueTileState extends State<ValueTile> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _opacity;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );

    _opacity = Tween<double>(begin:0, end: 1)
        .animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() { 
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: <Widget>[
          Container(
            color: TileColorConverter.mapTileValueToColor(widget.tile.value),
          ),
          TilePoint(point: widget.tile.value),
        ],
      ),
    );
  }
}

class TilePoint extends StatelessWidget {
  final int point;

  const TilePoint({Key key, this.point}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 5.0),
      child: Text(
        point.toString(),
        style: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: Colors.grey.shade900,
        ),
      ),
    );
  }
}
