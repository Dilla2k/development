import 'package:Aroma/model/indigrends.dart';
import 'package:Aroma/widgets/MultiSelectIndigrends/sauceMultiselect_formfield.dart';
import 'package:Aroma/widgets/foodItem.dart';
import 'package:flutter/material.dart';

class SauceMultiSelect extends StatefulWidget {
  final List<Indigrends> datasource;
  final String titleText;
  final String hintText;
  final FoodItem foodItem;

  const SauceMultiSelect(
      {Key key, this.datasource, this.titleText, this.hintText, this.foodItem})
      : super(key: key);

  @override
  _SauceMultiSelectState createState() => _SauceMultiSelectState();
}

class _SauceMultiSelectState extends State<SauceMultiSelect> {
  List _myActivities;
  String _myActivitiesResult;
  final formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _myActivities = [];
    _myActivitiesResult = '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              child: SauceMultiSelectFormField(
                formKey: formKey,
                titleText: widget.titleText,
                dataSource: widget.datasource,
                textField: 'value',
                valueField: 'value',
                okButtonLabel: 'Auswählen',
                cancelButtonLabel: 'Zurück',
                // required: true,
                hintText: widget.hintText,
                foodItem: widget.foodItem,
                initialValue: _myActivities,
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 5),
              child: Text(_myActivitiesResult),
            )
          ],
        ),
      ),
    );
  }
}
