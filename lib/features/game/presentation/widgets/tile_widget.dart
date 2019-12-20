import 'package:flutter/material.dart';

import '../../../../core/util/tile_color_converter.dart';
import '../../domain/entities/tile.dart';
import 'tile_score_widget.dart';

class TileWidget extends StatelessWidget {
  final Tile tile;

  const TileWidget({Key key, this.tile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return tile == null ? EmptyTile() : ValueTile(value: tile.value);
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
  final int value;

  const ValueTile({Key key, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: Stack(
          alignment: AlignmentDirectional.topEnd,
          children: <Widget>[
            Container(
              color: TileColorConverter.mapTileValueToColor(value),
            ),
            TileScoreWidget(point: value),
          ],
        ),
      ),
    );
  }
}
