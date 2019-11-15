import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swipedetector/swipedetector.dart';

const String ArrowLeftKeyLabel = "ArrowLeft";
const String ArrowUpKeyLabel = "ArrowUp";
const String ArrowRightKeyLabel = "ArrowRight";
const String ArrowDownKeyLabel = "ArrowDown";

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
    _focusNode.requestFocus();
    return RawKeyboardListener(
      focusNode: _focusNode,
      onKey: (RawKeyEvent event) {
        if (event is RawKeyDownEvent) {
          if (event.data.keyLabel == ArrowDownKeyLabel) {
            widget.onDown();
          }
          if (event.data.keyLabel == ArrowUpKeyLabel) {
            widget.onUp();
          }
          if (event.data.keyLabel == ArrowRightKeyLabel) {
            widget.onRight();
          }
          if (event.data.keyLabel == ArrowLeftKeyLabel) {
            widget.onLeft();
          }
        }
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
        swipeConfiguration: SwipeConfiguration(
          verticalSwipeMinVelocity: 1.0,
          verticalSwipeMinDisplacement: 1.0,
          verticalSwipeMaxWidthThreshold: 1000.0,
          horizontalSwipeMaxHeightThreshold: 1000.0,
          horizontalSwipeMinDisplacement: 1.0,
          horizontalSwipeMinVelocity: 1.0,
        ),
        child: widget.child,
      ),
    );
  }
}
