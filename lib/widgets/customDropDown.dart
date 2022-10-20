import 'package:Aroma/model/food.dart';
import 'package:Aroma/widgets/foodItem.dart';
import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';

class CustomDropDown extends StatefulWidget {
  final List<S2Choice<String>> list;
  final String initialValue;
  FoodItem foodItem;
  final Function() notifyParent;

  CustomDropDown(
      {Key key,
      @required this.list,
      @required this.initialValue,
      @required this.foodItem,
      @required this.notifyParent})
      : super(key: key);
  @override
  _CustomDropDownState createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  String _choosenValue;

  @override
  Widget build(BuildContext context) {
    _choosenValue = widget.initialValue;
    return SmartSelect<String>.single(
      title: 'Wähle eine Größe',
      value: _choosenValue,
      choiceItems: widget.list,
      onChange: (selected) {
        widget.foodItem.size = selected.valueTitle;
        if (selected.value == "6" ||
            selected.value == "26" ||
            selected.value == "small") {
          widget.foodItem.isSmall = true;
        } else {
          widget.foodItem.isSmall = false;
        }
        widget.notifyParent();
        setState(() => _choosenValue = selected.value);
      },
      modalType: S2ModalType.bottomSheet,
      tileBuilder: (context, state) {
        return S2Tile.fromState(
          state,
          isTwoLine: true,
        );
      },
    );
  }
}
