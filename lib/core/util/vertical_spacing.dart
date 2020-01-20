import 'package:flutter/material.dart';

class VerticalSpacing extends SizedBox {
  const VerticalSpacing({@required double height}) : super(height: height);
  const VerticalSpacing.extraSmall() : super(height: 5.0);
  const VerticalSpacing.small() : super(height: 10.0);
  const VerticalSpacing.medium() : super(height: 20.0);
  const VerticalSpacing.large() : super(height: 60.0);
}
