

# Animated Item Picker

Generic item picker that encapsulates single or multiple item selection logic. 

Suitable for fixed size item lists, e.g level, week day or gender selector etc.

Supports tapUp/tapDown item opacity animation.

## Preview

<p align="center">
	<img src="https://user-images.githubusercontent.com/16679732/127896491-aa2369ff-d08a-45db-9594-9931bc9ed06e.gif" />
</p>

## Usage

```dart
  @override
  Widget build(BuildContext context) {
    return AnimatedItemPicker(
          axis: Axis.horizontal,
          multipleSelection: false,
          itemCount: yourModelList.length,
          pressedOpacity: 0.85,
          initialSelection: {defaultItemIndex},
          onItemPicked: (index, selected) {
         
          },
          itemBuilder: (index, animValue, selected) => _YourItemWidget(
            name: yourModelList[index].name,
            borderColor: _colorTween1.transform(animValue),
            textColor: _colorTween2.transform(animValue),
            iconColor: _colorTween3.transform(animValue)
          ),
      );
  }
```


