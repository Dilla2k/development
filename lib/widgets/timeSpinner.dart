import 'package:Aroma/notifier/order_type_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';

class TimeSpinner extends StatefulWidget {
  @override
  _TimeSpinnerState createState() => _TimeSpinnerState();
}

class _TimeSpinnerState extends State<TimeSpinner> {
  String _time = "Auswählen";
  @override
  Widget build(BuildContext context) {
    var orderNotifier = Provider.of<OrderTypeNotifier>(context);
    return Container(
        child: RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      elevation: 4.0,
      onPressed: () {
        DatePicker.showTimePicker(
          context,
          theme: DatePickerTheme(
            containerHeight: 210.0,
          ),
          showTitleActions: true,
          onConfirm: (time) {
            _time = '${time.hour} : ${time.minute}';
            orderNotifier.setOrderTime(_time);
            setState(() {});
          },
          currentTime: DateTime.now(),
          showSecondsColumn: false,
          locale: LocaleType.de,
        );
        setState(() {});
      },
      child: Container(
        alignment: Alignment.center,
        height: 50.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.access_time,
                        size: 18.0,
                        color: Colors.teal,
                      ),
                      Text(
                        " $_time",
                        style: TextStyle(
                            color: Colors.teal,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      color: Colors.white,
    ));
  }
}
