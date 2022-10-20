library multiselect_formfield;

import 'package:Aroma/model/indigrends.dart';
import 'package:Aroma/utils/commons.dart';
import 'package:Aroma/widgets/foodItem.dart';
import 'package:flutter/material.dart';

import 'indigrendsMultiselect_dialog.dart';

class IndigrendsMultiSelectFormField extends FormField<dynamic> {
  final String titleText;
  final String hintText;
  final bool required;
  final String errorText;
  final List<Indigrends> dataSource;
  final String textField;
  final String valueField;
  final Function change;
  final Function open;
  final Function close;
  final Widget leading;
  final Widget trailing;
  final String okButtonLabel;
  final String cancelButtonLabel;
  final Color fillColor;
  final InputBorder border;
  final GlobalKey<FormState> formKey;
  final FoodItem foodItem;

  IndigrendsMultiSelectFormField(
      {FormFieldSetter<Indigrends> onSaved,
      this.formKey,
      FormFieldValidator<Indigrends> validator,
      dynamic initialValue,
      this.titleText = 'Title',
      this.hintText = 'Tap to select one or more',
      this.required = false,
      this.errorText = 'Please select one or more options',
      this.leading,
      this.dataSource,
      this.textField,
      this.valueField,
      this.change,
      this.open,
      this.close,
      this.okButtonLabel = 'Auswählen',
      this.cancelButtonLabel = 'Zurück',
      this.fillColor,
      this.foodItem, 
      this.border,
      this.trailing})
      : super(
          onSaved: onSaved,
          validator: validator,
          initialValue: initialValue,
          builder: (FormFieldState<dynamic> state) {
            List<Widget> _buildSelectedOptions(state) {
              List<Widget> selectedOptions = [];

              if (state.value != null) {
                state.value.forEach((item) {
                  var existingItem = dataSource.singleWhere(
                      (itm) => itm.id == item.id,
                      orElse: () => null);
                  selectedOptions.add(Chip(
                    backgroundColor: grey,
                    label: Text(existingItem.name,
                        style: TextStyle(color: white, fontSize: 11),
                        overflow: TextOverflow.ellipsis),
                  ));
                });
              }

              return selectedOptions;
            }

            return InkWell(
              onTap: () async {
                List<dynamic> initialSelected = state.value;
                if (initialSelected == null) {
                  initialSelected = List();
                }

                final items =
                    List<IndigrendsMultiSelectDialogItem<Indigrends>>();
                dataSource.forEach((item) {
                  items.add(IndigrendsMultiSelectDialogItem(item,
                      item.name + " " + item.price.toStringAsFixed(2) + "€"));
                });

                List selectedValues = await showDialog<List>(
                  context: state.context,
                  builder: (BuildContext context) {
                    return IndigrendsMultiSelectDialog(
                      title: titleText,
                      okButtonLabel: okButtonLabel,
                      cancelButtonLabel: cancelButtonLabel,
                      items: items,
                      foodItem : foodItem,
                      initialSelectedValues: initialSelected,
                    );
                  },
                );

                if (selectedValues != null) {
                  state.didChange(selectedValues);
                  state.save();
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Image.asset(
                          "assets/extras.png",
                          fit: BoxFit.contain,
                          width: 150,
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                  state.value != null && state.value.length > 0
                      ? Wrap(
                          spacing: 2.0,
                          runSpacing: 0.0,
                          children: _buildSelectedOptions(state),
                        )
                      : Container()
                ],
              ),
            );
          },
        );
}
