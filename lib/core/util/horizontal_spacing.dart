import 'package:flutter/material.dart';

class HorizontalSpacing extends SizedBox {
  static const _baseWidth = 5.0;
  const HorizontalSpacing({@required double width}) : super(width: width);
  const HorizontalSpacing.extraSmall() : super(width: _baseWidth);
  const HorizontalSpacing.small() : super(width: _baseWidth * 2);
  const HorizontalSpacing.medium() : super(width: _baseWidth * 4);
  const HorizontalSpacing.large() : super(width: _baseWidth * 12);
}
