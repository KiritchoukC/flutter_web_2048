import 'package:flutter/material.dart';

class TileScoreWidget extends StatelessWidget {
  final int point;

  const TileScoreWidget({Key key, this.point}) : super(key: key);

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
            shadows: [
              Shadow(
                blurRadius: 5.0,
                color: Colors.grey.shade100.withOpacity(0.3),
                offset: const Offset(1.0, 1.0),
              )
            ]),
      ),
    );
  }
}
