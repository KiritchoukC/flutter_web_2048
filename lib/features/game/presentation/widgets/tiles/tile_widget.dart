import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../../core/util/tile_color_converter.dart';
import '../../../domain/entities/tile.dart';
import 'tile_score_widget.dart';

class TileWidget extends StatelessWidget {
  final Tile tile;

  const TileWidget({Key key, this.tile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (tile == null) {
      return EmptyTile();
    }

    if (tile.isNew) {
      return AnimatedValueTile(value: tile.value);
    }

    return ValueTile(value: tile.value);
  }
}

class AnimatedValueTile extends StatefulWidget {
  final int value;

  AnimatedValueTile({Key key, this.value}) : super(key: key);

  @override
  _AnimatedValueTileState createState() => _AnimatedValueTileState();
}

class _AnimatedValueTileState extends State<AnimatedValueTile> with SingleTickerProviderStateMixin {
  Animation<double> _opacity;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _opacity = Tween<double>(begin: 0, end: 1).animate(controller);

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: ValueTile(value: widget.value),
    );
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
