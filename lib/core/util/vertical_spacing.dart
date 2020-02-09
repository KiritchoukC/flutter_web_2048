import 'package:flutter/material.dart';

class VerticalSpacing extends SizedBox {
  static const _baseHeight = 10.0;
  const VerticalSpacing({@required double height}) : super(height: height);
  const VerticalSpacing.extraSmall() : super(height: _baseHeight);
  const VerticalSpacing.small() : super(height: _baseHeight * 2);
  const VerticalSpacing.medium() : super(height: _baseHeight * 4);
  const VerticalSpacing.large() : super(height: _baseHeight * 12);
}
