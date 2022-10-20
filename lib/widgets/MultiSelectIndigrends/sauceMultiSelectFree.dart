import 'package:Aroma/model/indigrends.dart';
import 'package:flutter/material.dart';
import '../foodItem.dart';
import 'sauceMultiselectFree_formfield.dart';

class SauceMultiSelectFree extends StatefulWidget {
  final List<Indigrends> datasource;
  final String titleText;
  final String hintText;
  final FoodItem foodItem;

  const SauceMultiSelectFree(
      {Key key, this.datasource, this.titleText, this.hintText, this.foodItem})
      : super(key: key);

  @override
  _SauceMultiSelectFreeState createState() => _SauceMultiSelectFreeState();
}

class _SauceMultiSelectFreeState extends State<SauceMultiSelectFree> {
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
              child: SauceMultiSelectFreeFormField(
                formKey: formKey,
                titleText: widget.titleText,
                dataSource: widget.datasource,
                textField: 'value',
                valueField: 'value',
                okButtonLabel: 'Auswählen',
                cancelButtonLabel: 'Zurück',
                foodItem: widget.foodItem,
                // required: true,
                hintText: widget.hintText,
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
