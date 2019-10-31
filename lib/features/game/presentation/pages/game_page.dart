import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../core/enums/direction.dart';
import '../../../../core/layouts/default_layout.dart';
import '../../../../core/util/color_value.dart';

class GamePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '2048',
      body: AspectRatio(
        aspectRatio: 1,
        child: GestureDetector(
          onVerticalDragEnd: (DragEndDetails dragEndDetails) {
            Direction direction =
                dragEndDetails.velocity.pixelsPerSecond.dy > 0
                    ? Direction.down
                    : Direction.up;
            print(direction);
          },
          onHorizontalDragEnd: (DragEndDetails dragEndDetails) {
            Direction direction =
                dragEndDetails.velocity.pixelsPerSecond.dx > 0
                    ? Direction.right
                    : Direction.left;
            print(direction);
          },
          child: GridView.count(
            crossAxisCount: 4,
            children: List.generate(
              16,
              (index) {
                return Tile(value: pow(2, index + 1));
              },
              growable: false,
            ),
          ),
        ),
      ),
    );
  }
}

class Tile extends StatelessWidget {
  final int value;

  const Tile({Key key, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: <Widget>[
          Container(
            color:
                value == null ? Colors.grey.shade200 : ColorValue.colors[value],
          ),
          Text(
            value.toString(),
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
