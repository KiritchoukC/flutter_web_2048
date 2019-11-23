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

class ValueTile extends StatelessWidget {
  final Tile tile;

  const ValueTile({Key key, this.tile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: <Widget>[
        Container(
          color: TileColorConverter.mapTileValueToColor(tile.value),
        ),
        TilePoint(point: tile.value),
      ],
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
        semanticsLabel: 'A tile of value $point',
        style: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: Colors.grey.shade900,
        ),
      ),
    );
  }
}
