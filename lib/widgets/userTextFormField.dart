import 'package:Aroma/utils/commons.dart';
import 'package:flutter/material.dart';

class UserTextFormField extends StatefulWidget {
  final String description;
  final String validationFailureText;
  final TextEditingController controller;
  final String autofill;
  final TextInputType inputType;

  const UserTextFormField(
      {Key key,
      this.description,
      this.validationFailureText,
      this.controller,
      this.autofill,
      this.inputType})
      : super(key: key);

  @override
  _UserTextFormFieldState createState() => _UserTextFormFieldState();
}

class _UserTextFormFieldState extends State<UserTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.description,
          style: fontFoodItemPrice,
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          height: 45,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: grey)),
          child: TextFormField(
            // The validator receives the text that the user has entered.
            autofillHints: [widget.autofill],
            keyboardType: widget.inputType,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: grey, width: 0.5),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: green_light),
              ),
            ),
            cursorColor: green_light,
            controller: widget.controller,
            validator: (value) {
              if (value.isEmpty) {
                return widget.validationFailureText;
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
