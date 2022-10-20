import 'package:Aroma/model/indigrends.dart';
import 'package:Aroma/widgets/MultiSelectIndigrends/indigrendsMultiselect_formfield.dart';
import 'package:Aroma/widgets/foodItem.dart';
import 'package:flutter/material.dart';

class IndigrendsMultiSelect extends StatefulWidget {
  final List<Indigrends> datasource;
  final String titleText;
  final String hintText;
  final FoodItem foodItem;

  const IndigrendsMultiSelect(
      {Key key, this.datasource, this.titleText, this.hintText, this.foodItem})
      : super(key: key);

  @override
  _IndigrendsMultiSelectState createState() => _IndigrendsMultiSelectState();
}

class _IndigrendsMultiSelectState extends State<IndigrendsMultiSelect> {
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
              child: IndigrendsMultiSelectFormField(
                formKey: formKey,
                foodItem: widget.foodItem,
                titleText: widget.titleText,
                dataSource: widget.datasource,
                textField: 'value',
                valueField: 'value',
                okButtonLabel: 'Auswählen',
                cancelButtonLabel: 'Zurück',
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
