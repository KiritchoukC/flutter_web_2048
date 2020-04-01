import 'package:flutter/material.dart';

import '../../../../../core/util/tile_color_converter.dart';
import 'tile_score_widget.dart';

class ValueTileWidget extends StatelessWidget {
  final int value;

  const ValueTileWidget({Key key, this.value}) : super(key: key);

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
              color: mapTileValueToColor(value),
            ),
            TileScoreWidget(point: value),
          ],
        ),
      ),
    );
  }
}
