import 'package:flutter/material.dart';

/// TextFormField with default parameter
class DefaultTextFormFieldWidget extends TextFormField {
  DefaultTextFormFieldWidget({
    Key key,
    @required TextEditingController controller,
    bool obscureText = false,
    bool autocorrect = false,
    String Function(String) validator,
    TextStyle style = const TextStyle(color: Colors.white),
    InputDecoration decoration,
    String labelText,
  }) : super(
          key: key,
          controller: controller,
          autocorrect: autocorrect,
          validator: validator,
          style: style,
          obscureText: obscureText,
          decoration: decoration ??
              InputDecoration(
                border: OutlineInputBorder(),
                labelText: labelText,
              ),
        );
}
