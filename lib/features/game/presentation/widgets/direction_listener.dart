

import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swipedetector/swipedetector.dart';

class DirectionListener extends StatefulWidget {
  final Function onLeft;
  final Function onRight;
  final Function onUp;
  final Function onDown;
  final Widget child;

  const DirectionListener({
    Key key,
    @required this.child,
    @required this.onLeft,
    @required this.onRight,
    @required this.onUp,
    @required this.onDown,
  }) : super(key: key);

  @override
  _DirectionListenerState createState() => _DirectionListenerState();
}

class _DirectionListenerState extends State<DirectionListener> {
  FocusNode _focusNode;

  @override
  void initState() {
    _focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: _focusNode,
      onKey: (RawKeyEvent event) {
        if (event is RawKeyDownEvent) {
          if (event.logicalKey.keyId == KeyCode.DOWN) {
            widget.onDown();
          }
          if (event.logicalKey.keyId == KeyCode.UP) {
            widget.onUp();
          }
          if (event.logicalKey.keyId == KeyCode.RIGHT) {
            widget.onRight();
          }
          if (event.logicalKey.keyId == KeyCode.LEFT) {
            widget.onLeft();
          }
        }
      },
      child: GestureDetector(
        onTap: () {
          print(_focusNode);
          FocusScope.of(context).requestFocus(_focusNode);
          print(_focusNode);
        },
        child: SwipeDetector(
          onSwipeDown: () {
            widget.onDown();
          },
          onSwipeUp: () {
            widget.onUp();
          },
          onSwipeRight: () {
            widget.onRight();
          },
          onSwipeLeft: () {
            widget.onLeft();
          },
          child: widget.child,
        ),
      ),
    );
  }
}
