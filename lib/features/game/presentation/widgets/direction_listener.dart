import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swipedetector/swipedetector.dart';

import '../../../../core/util/web_helper.dart';

/// Listen to swipe direction on mobile or keyboard arrow on web
class DirectionListener extends StatelessWidget {
  /// callback when detecting left direction
  final Function onLeft;

  /// callback when detecting right direction
  final Function onRight;

  /// callback when detecting up direction
  final Function onUp;

  /// callback when detecting down direction
  final Function onDown;

  /// the widget below this widget in the tree
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
  Widget build(BuildContext context) {
    return kIsWeb
        ? WebDirectionListener(
            onLeft: onLeft,
            onRight: onRight,
            onUp: onUp,
            onDown: onDown,
            child: child,
          )
        : MobileDirectionListener(
            onLeft: onLeft,
            onRight: onRight,
            onUp: onUp,
            onDown: onDown,
            child: child,
          );
  }
}

/// Listen to keyboard arrow direction
class WebDirectionListener extends StatefulWidget {
  /// callback when detecting left direction
  final Function onLeft;

  /// callback when detecting right direction
  final Function onRight;

  /// callback when detecting up direction
  final Function onUp;

  /// callback when detecting down direction
  final Function onDown;

  /// the widget below this widget in the tree
  final Widget child;

  const WebDirectionListener({
    Key key,
    @required this.child,
    @required this.onLeft,
    @required this.onRight,
    @required this.onUp,
    @required this.onDown,
  }) : super(key: key);

  @override
  _WebDirectionListenerState createState() => _WebDirectionListenerState();
}

class _WebDirectionListenerState extends State<WebDirectionListener> {
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
          if (event.data.keyLabel == arrowDownKeyLabel) {
            widget.onDown();
          }
          if (event.data.keyLabel == arrowUpKeyLabel) {
            widget.onUp();
          }
          if (event.data.keyLabel == arrowRightKeyLabel) {
            widget.onRight();
          }
          if (event.data.keyLabel == arrowLeftKeyLabel) {
            widget.onLeft();
          }
        }
      },
      child: widget.child,
    );
  }
}

/// Listen to swipe direction
class MobileDirectionListener extends StatefulWidget {
  /// callback when detecting left direction
  final Function onLeft;

  /// callback when detecting right direction
  final Function onRight;

  /// callback when detecting up direction
  final Function onUp;

  /// callback when detecting down direction
  final Function onDown;

  /// the widget below this widget in the tree
  final Widget child;

  const MobileDirectionListener({
    Key key,
    @required this.child,
    @required this.onLeft,
    @required this.onRight,
    @required this.onUp,
    @required this.onDown,
  }) : super(key: key);

  @override
  _MobileDirectionListenerState createState() => _MobileDirectionListenerState();
}

class _MobileDirectionListenerState extends State<MobileDirectionListener> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SwipeDetector(
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
        verticalSwipeMinVelocity: 5.0,
        verticalSwipeMinDisplacement: 5.0,
        verticalSwipeMaxWidthThreshold: 1000.0,
        horizontalSwipeMaxHeightThreshold: 1000.0,
        horizontalSwipeMinDisplacement: 5.0,
        horizontalSwipeMinVelocity: 5.0,
      ),
      child: widget.child,
    );
  }
}
