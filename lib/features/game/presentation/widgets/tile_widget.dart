

import 'package:flutter/material.dart';

import '../../../../core/util/tile_color_converter.dart';
import '../../domain/entities/tile.dart';

class TileWidget extends StatelessWidget {
  final Tile tile;

  const TileWidget({Key key, this.tile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildTile(tile);
  }

  Widget _buildTile(Tile tile) {
    var children = <Widget>[];
    children.add(
      Container(
        color: TileColorConverter.mapTileValueToColor(tile?.value),
      ),
    );

    if (tile != null) {
      children.add(
        Text(
          tile.value.toString(),
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade900,
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Stack(alignment: AlignmentDirectional.topEnd, children: children),
    );
  }
}