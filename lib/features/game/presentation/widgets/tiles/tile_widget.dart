import 'package:flutter/material.dart';

import '../../../../../core/util/tile_color_converter.dart';
import '../../../domain/entities/tile.dart';
import 'merged_value_tile_widget.dart';
import 'new_value_tile_widget.dart';
import 'value_tile_widget.dart';

class TileWidget extends StatelessWidget {
  final Tile tile;

  const TileWidget({Key key, this.tile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (tile == null) {
      return EmptyTile();
    }

    if (tile.isNew) {
      return NewValueTileWidget(value: tile.value);
    }

    if (tile.merged) {
      return MergedValueTileWidget(value: tile.value);
    }

    return ValueTileWidget(value: tile.value);
  }
}

class EmptyTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: <Widget>[
        Container(
          color: mapTileValueToColor(null),
        )
      ],
    );
  }
}
