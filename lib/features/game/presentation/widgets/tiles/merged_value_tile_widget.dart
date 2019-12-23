import 'package:flutter/material.dart';

import 'value_tile_widget.dart';

class MergedValueTileWidget extends StatefulWidget {
  final int value;

  MergedValueTileWidget({Key key, this.value}) : super(key: key);

  @override
  _MergedValueTileWidgetState createState() => _MergedValueTileWidgetState();
}

class _MergedValueTileWidgetState extends State<MergedValueTileWidget>
    with SingleTickerProviderStateMixin {
  Animation<double> _scale;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scale = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
      ),
    );

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget child) {
        return Transform.scale(
          scale: _scale.value,
          child: ValueTileWidget(value: widget.value),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
