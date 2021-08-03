import 'package:animated_item_picker/animated_item_picker.dart';
import 'package:example/model/day_of_week.dart';
import 'package:example/model/level.dart';
import 'package:example/ui/helper.dart';
import 'package:example/ui/item_widgets.dart';
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
      decorateFirstItemPicker(
        AnimatedItemPicker(
            axis: Axis.horizontal,
            multipleSelection: false,
            itemCount: Level.LIST.length,
            pressedOpacity: 0.85,
            initialSelection: {Level.LIST.indexOf(Level.BEGINNER)},
            onItemPicked: (index, selected) {
              print("Gender: ${Level.LIST[index]}, selected: $selected");
            },
            itemBuilder: (index, animValue) => GenderItemWidget(
                  name: Level.LIST[index].toString(),
                  borderColor: _firstPickerColorTween2.transform(animValue)!,
                  textColor: _firstPickerColorTween1.transform(animValue)!,
                )),
      ),
      decorateSecondItemPicker(
        AnimatedItemPicker(
          axis: Axis.vertical,
          multipleSelection: true,
          itemCount: DayOfWeek.LIST.length,
          maxItemSelectionCount: 6,
          initialSelection: {1},
          onItemPicked: (index, selected) {
            print("Day: ${DayOfWeek.LIST[index]}, selected: $selected");
          },
          itemBuilder: (index, animValue) => DayItemWidget(
            name: DayOfWeek.LIST[index],
            textColor: _secondPickerColorTween2.transform(animValue)!,
            backgroundColor: _secondPickerColorTween1.transform(animValue)!,
          ),
        ),
      ),
    ]);
  }
}
