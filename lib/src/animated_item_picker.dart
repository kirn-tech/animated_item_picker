import 'package:animated_item_picker/src/animated_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef Widget IndexedItemBuilder(int index, double animatedValue);

class AnimatedItemPicker extends StatefulWidget {
  /// `onItemPicked` callback is triggered once selection animation is completed.
  final Function(int, bool) onItemPicked;

  /// The `itemBuilder` callback will be called only with indices greater than
  /// or equal to zero and less than `itemCount`.
  final int itemCount;

  /// Builds your selectable widgets.
  ///
  /// `animatedValue` allows to animate your widgets on selection change.
  ///
  /// ```dart
  ///    itemBuilder: (index, animValue) => _YourItemWidget(
  ///        name: yourModelList[index].name,
  ///        borderColor: _colorTween1.transform(animValue),
  ///        textColor: _colorTween2.transform(animValue),
  ///        iconColor: _colorTween3.transform(animValue)
  ///    ),
  /// ```
  final IndexedItemBuilder itemBuilder;

  /// [Axis.horizontal] uses Row for [AnimatedItem] positioning, [Axis.vertical] - Column.
  final Axis axis;

  /// Allows multiple item selection. Defaults to false.
  final bool multipleSelection;

  /// Prevents selection if  [_AnimatedItemPickerState._selectedPositions].length == `maxItemSelectionCount`.
  final int? maxItemSelectionCount;

  /// Indices of initially selected Items.
  final Set<int> initialSelection;

  /// Pressed item opacity. Animates in onTapDown, animates out onTapUp.  Defaults to 0.9.
  final double pressedOpacity;

  /// Set `true` to give items equal size by wrapping in [Expanded].
  /// If [AnimatedItemPicker] is inside Row or Column setting `expandedItems` = true,  could cause "unbounded width/height" issue,
  /// to avoid it consider setting `expandedItems` = false and giving item size explicitly in 'itemBuilder'.
  /// Defaults to false.
  final bool expandedItems;

  /// Animation duration.
  final Duration duration;

  /// Animation curve.
  final Curve curve;

  AnimatedItemPicker({
    required this.axis,
    required this.itemCount,
    required this.itemBuilder,
    required this.onItemPicked,
    this.pressedOpacity = 0.9,
    this.duration = const Duration(milliseconds: DEFAULT_ITEM_PICKER_ANIMATION_DURATION),
    this.curve = Curves.easeIn,
    this.initialSelection = const {},
    this.multipleSelection = false,
    this.expandedItems = false,
    this.maxItemSelectionCount,
  });

  @override
  _AnimatedItemPickerState createState() => _AnimatedItemPickerState();
}

class _AnimatedItemPickerState extends State<AnimatedItemPicker> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;
  late int _selectedIndex;
  final List<_AnimatedItemValue> _animatedItemValues = [];
  Set<int> _selectedPositions = {};

  @override
  void initState() {
    super.initState();
    _selectedPositions.addAll(widget.initialSelection);

    _animationController = AnimationController(vsync: this, duration: widget.duration);
    _animation = CurvedAnimation(parent: _animationController, curve: widget.curve);
    for (int i = 0; i < widget.itemCount; i++) {
      _animatedItemValues.add(_AnimatedItemValue(i, widget.initialSelection));
    }
    _animationController.addListener(() {
      setState(() {
        _animatedItemValues.forEach((item) => item.apply(_selectedPositions, _animation.value));
      });
    });
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onItemPicked(_selectedIndex, _animatedItemValues[_selectedIndex]._selected);
      }
      if (widget.multipleSelection) {
        if (status == AnimationStatus.forward) {
          _resolveSelection(_selectedIndex);
        }
      } else {
        if (status == AnimationStatus.forward || status == AnimationStatus.dismissed) {
          _resolveSelection(_selectedIndex);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final children = _buildContent();
    return widget.axis == Axis.vertical
        ? Column(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.center, children: children)
        : Row(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.center, children: children);
  }

  List<Widget> _buildContent() {
    List<Widget> children = [];
    for (int i = 0; i < widget.itemCount; i++) {
      final animatedItemValue = _animatedItemValues[i];
      final child = widget.itemBuilder(i, animatedItemValue.get());
      final animatedItem =
          AnimatedItem(child: child, pressedOpacity: widget.pressedOpacity, onPressed: () => _onItemPressed(i));
      children.add(widget.expandedItems ? Expanded(child: animatedItem) : animatedItem);
    }

    return children;
  }

  void _onItemPressed(int index) {
    _selectedIndex = index;
    if (_animationController.isAnimating) {
      _animationController.animateBack(0.0);
    } else {
      _animationController.forward(from: 0.0);
    }
  }

  _resolveSelection(int selectedIndex) {
    if (widget.multipleSelection) {
      if (_selectedPositions.contains(selectedIndex)) {
        _selectedPositions.remove(selectedIndex);
      } else {
        if (widget.maxItemSelectionCount != null && widget.maxItemSelectionCount == _selectedPositions.length) {
          return;
        }
        _selectedPositions.add(selectedIndex);
      }
    } else {
      if (_selectedPositions.contains(selectedIndex)) {
        return;
      }
      _selectedPositions.clear();
      _selectedPositions.add(selectedIndex);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class _AnimatedItemValue {
  int _index;
  Set<int> _initialSelection;
  late bool _selected;
  late double _value;

  _AnimatedItemValue(this._index, this._initialSelection) {
    _selected = _initialSelection.contains(_index);
    if (_selected) {
      _value = 1.0;
    } else {
      _value = 0.0;
    }
  }

  double get() => _value;

  void apply(Set<int> _selectedPositions, double animValue) {
    //became selected -> anim up
    if (!_selected && _selectedPositions.contains(_index)) {
      _value = animValue;
    }

    //became unselected -> anim down
    if (_selected && !_selectedPositions.contains(_index)) {
      _value = 1 - animValue;
    }

    // once animation completed -> set new selected status
    if (animValue >= 1.0) {
      _selected = _selectedPositions.contains(_index);
    }
  }
}

const int DEFAULT_ITEM_PICKER_ANIMATION_DURATION = 150;
