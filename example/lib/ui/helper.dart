import 'package:flutter/material.dart';

Widget decorateFirstItemPicker(Widget child) {
  return Container(
    color: Colors.white24,
    padding: EdgeInsets.all(16),
    child: child,
  );
}

Widget decorateSecondItemPicker(Widget child) {
  return Container(
    height: 400,
    padding: EdgeInsets.all(16),
    child: child,
  );
}
