import 'package:flutter/material.dart';

import 'value_tile_widget.dart';

class NewValueTileWidget extends StatefulWidget {
  final int value;

  NewValueTileWidget({Key key, this.value}) : super(key: key);

  @override
  _NewValueTileWidgetState createState() => _NewValueTileWidgetState();
}

class _NewValueTileWidgetState extends State<NewValueTileWidget>
    with SingleTickerProviderStateMixin {
  Animation<double> _opacity;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _opacity = Tween<double>(begin: 0, end: 1).animate(_controller);

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: ValueTileWidget(value: widget.value),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
