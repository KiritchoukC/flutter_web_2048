import 'package:flutter/material.dart';

class HorizontalSpacing extends SizedBox {
  const HorizontalSpacing.extraSmall() : super(width: 5.0);
  const HorizontalSpacing.small() : super(width: 10.0);
  const HorizontalSpacing.medium() : super(width: 20.0);
  const HorizontalSpacing.large() : super(width: 60.0);
  const HorizontalSpacing({width}) : super(width: width);
}
