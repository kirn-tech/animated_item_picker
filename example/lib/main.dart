import 'package:animated_item_picker/animated_item_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Material(child: HomePage(), color: Colors.black));
  }
}

class HomePage extends StatelessWidget {
  static ColorTween _firstPickerColorTween1 = ColorTween(begin: Colors.white, end: Colors.redAccent);
  static ColorTween _firstPickerColorTween2 = ColorTween(begin: Colors.black, end: Colors.redAccent);

  static ColorTween _secondPickerColorTween1 = ColorTween(begin: Colors.black, end: Colors.yellow);
  static ColorTween _secondPickerColorTween2 = ColorTween(begin: Colors.white, end: Colors.yellow);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      _decorateFirstItemPicker(
        AnimatedItemPicker(
          axis: Axis.horizontal,
          multipleSelection: false,
          itemCount: Level.LIST.length,
          pressedOpacity: 0.85,
          initialSelection: {Level.LIST.indexOf(Level.BEGINNER)},
          onItemPicked: (index, selected) {
            print("Gender: ${Level.LIST[index]}, selected: $selected");
          },
          itemBuilder: (index, animValue) => _GenderItemWidget(
            index: index,
            borderColor: _firstPickerColorTween2.transform(animValue)!,
            child: Text(
              Level.LIST[index].toString(),
              textAlign: TextAlign.center,
              style: _textStyle.copyWith(color: _firstPickerColorTween1.transform(animValue)),
            ),
          ),
        ),
      ),
      _decorateSecondItemPicker(
        AnimatedItemPicker(
          axis: Axis.vertical,
          multipleSelection: true,
          itemCount: DayOfWeek.LIST.length,
          maxItemSelectionCount: 6,
          initialSelection: {1},
          onItemPicked: (index, selected) {
            print("Gender: ${DayOfWeek.LIST[index]}, selected: $selected");
          },
          itemBuilder: (index, animValue) => _DayItemWidget(
            day: DayOfWeek.LIST[index],
            textColor: _secondPickerColorTween2.transform(animValue)!,
            backgroundColor: _secondPickerColorTween1.transform(animValue)!,
          ),
        ),
      ),
    ]);
  }

  Widget _decorateFirstItemPicker(Widget child) {
    return Container(
      color: Colors.white24,
      padding: EdgeInsets.all(16),
      child: child,
    );
  }

  Widget _decorateSecondItemPicker(Widget child) {
    return Container(
      height: 400,
      padding: EdgeInsets.all(16),
      child: child,
    );
  }
}

class _DayItemWidget extends StatelessWidget {
  final DayOfWeek day;
  final Color textColor;
  final Color backgroundColor;

  _DayItemWidget({required this.day, required this.textColor, required this.backgroundColor});

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
              day.name,
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

class _GenderItemWidget extends StatelessWidget {
  final Widget child;
  final Color borderColor;
  final int index;

  _GenderItemWidget({required this.child, required this.index, required this.borderColor});

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
        child: child,
      ),
    );
  }
}

class Level {
  static const BEGINNER = Level("BEGINNER");
  static const MEDIUM = Level("MEDIUM");
  static const ADVANCED = Level("ADVANCED");

  final String name;

  const Level(this.name);

  @override
  String toString() {
    return name;
  }

  static const List<Level> LIST = <Level>[BEGINNER, MEDIUM, ADVANCED];
}

class DayOfWeek {
  static const MONDAY = DayOfWeek._(name: 'MONDAY');
  static const TUESDAY = DayOfWeek._(name: 'TUESDAY');
  static const WEDNESDAY = DayOfWeek._(name: 'WEDNESDAY');
  static const THURSDAY = DayOfWeek._(name: 'THURSDAY');
  static const FRIDAY = DayOfWeek._(name: 'FRIDAY');
  static const SATURDAY = DayOfWeek._(name: 'SATURDAY');
  static const SUNDAY = DayOfWeek._(name: 'SUNDAY');

  static const LIST = const [MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY, SUNDAY];

  final String name;

  int index() => LIST.indexOf(this);

  const DayOfWeek._({required this.name});
}

TextStyle _textStyle = TextStyle(
    fontStyle: FontStyle.normal, color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700, fontFamily: 'Roboto');
