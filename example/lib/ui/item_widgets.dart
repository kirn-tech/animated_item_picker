import 'package:example/model/day_of_week.dart';

import 'package:flutter/material.dart';

class DayItemWidget extends StatelessWidget {
  final DayOfWeek name;
  final Color textColor;
  final Color backgroundColor;

  DayItemWidget({required this.name, required this.textColor, required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: Colors.black, shape: BoxShape.rectangle),
      padding: const EdgeInsets.all(6),
      margin: const EdgeInsets.only(top: 4, bottom: 4),
      child: Row(
        children: [
          SizedBox(width: 6),
          Container(
              width: 26,
              height: 26,
              child: const Icon(Icons.done, size: 23, color: Colors.black),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: backgroundColor, border: Border.all(color: Colors.yellow))),
          SizedBox(width: 12),
          Align(
            alignment: Alignment.center,
            child: Text(
              name.name,
              textAlign: TextAlign.center,
              style: _textStyle.copyWith(
                fontSize: 16,
                color: textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GenderItemWidget extends StatelessWidget {
  final String name;
  final Color borderColor;
  final Color textColor;

  GenderItemWidget({required this.name, required this.borderColor, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: borderColor),
          color: Colors.black,
          shape: BoxShape.rectangle),
      child: Container(
        color: Colors.black,
        padding: EdgeInsets.zero,
        child: Text(
          name,
          textAlign: TextAlign.center,
          style: _textStyle.copyWith(color: textColor),
        ),
      ),
    );
  }
}

TextStyle _textStyle = TextStyle(
    fontStyle: FontStyle.normal, color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700, fontFamily: 'Roboto');
