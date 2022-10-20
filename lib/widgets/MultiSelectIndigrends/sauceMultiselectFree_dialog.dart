import 'package:Aroma/notifier/choosen_sauce_notifier.dart';
import 'package:Aroma/utils/commons.dart';
import 'package:Aroma/widgets/foodItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SauceMultiSelectFreeDialogItem<Indigrends> {
  const SauceMultiSelectFreeDialogItem(this.value, this.label);

  final Indigrends value;
  final String label;
}

class SauceMultiSelectFreeDialog<Indigrends> extends StatefulWidget {
  SauceMultiSelectFreeDialog({
    Key key,
    this.items,
    this.initialSelectedValues,
    this.title,
    this.okButtonLabel,
    this.cancelButtonLabel, this.foodItem,
  }) : super(key: key);

  final List<SauceMultiSelectFreeDialogItem<Indigrends>> items;
  final List<Indigrends> initialSelectedValues;
  final String title;
  final String okButtonLabel;
  final String cancelButtonLabel;
  final FoodItem foodItem;
  

  @override
  State<StatefulWidget> createState() =>
      _SauceMultiSelectFreeDialogState<Indigrends>();
}

class _SauceMultiSelectFreeDialogState<Indigrends>
    extends State<SauceMultiSelectFreeDialog<Indigrends>> {
  final _selectedValues = List<Indigrends>();

  void initState() {
    super.initState();
    if (widget.initialSelectedValues != null) {
      _selectedValues.addAll(widget.initialSelectedValues);
    }
  }

  void _onItemCheckedChange(Indigrends itemValue, bool checked) {
    setState(() {
      if (checked) {
        _selectedValues.add(itemValue);
      } else {
        _selectedValues.remove(itemValue);
      }
    });
  }

  void _onCancelTap() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    var sauceNotifier = Provider.of<ChoosenSauceNotifier>(context);
    return AlertDialog(
      title: Text(
        widget.title,
        style: fontFoodItemName,
      ),
      contentPadding: EdgeInsets.only(top: 5.0),
      content: SingleChildScrollView(
        child: ListTileTheme(
          contentPadding: EdgeInsets.fromLTRB(14.0, 0.0, 24.0, 0.0),
          child: ListBody(
            children: widget.items.map(_buildItem).toList(),
          ),
        ),
      ),
      actions: <Widget>[
        RaisedButton(
          child: Text(
            widget.cancelButtonLabel,
            style: TextStyle(color: black),
          ),
          color: grey,
          onPressed: _onCancelTap,
        ),
        RaisedButton(
          child: Text(
            widget.okButtonLabel,
            style: TextStyle(color: white),
          ),
          color: green_light,
          onPressed: () {
            sauceNotifier.addChoosenSauce(_selectedValues,widget.foodItem);
            Navigator.pop(context, _selectedValues);
          },
        )
      ],
    );
  }

  Widget _buildItem(SauceMultiSelectFreeDialogItem<Indigrends> item) {
    final checked = _selectedValues.contains(item.value);
    return CheckboxListTile(
      value: checked,
      checkColor: white,
      activeColor: green_light,
      title: Text(
        item.label,
        style: TextStyle(color: purple_light),
      ),
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (checked) => _onItemCheckedChange(item.value, checked),
    );
  }
}
