import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final IconData icon;

  const CustomTextField({Key key, this.hintText, this.labelText, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Theme(
        data: ThemeData(
          primaryColor: Colors.redAccent,
          primaryColorDark: Colors.red,
        ),
        child: TextField(
          decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal)),
              hintText: '$hintText',
              labelText: '$labelText',
              prefixIcon: Icon(
                this.icon,
                color: Colors.green,
              ),
              suffixStyle: const TextStyle(color: Colors.green)),
        ),
      ),
    );
  }
}
