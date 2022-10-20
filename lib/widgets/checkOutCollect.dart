import 'package:Aroma/utils/commons.dart';
import 'package:Aroma/widgets/timeSpinner.dart';
import 'package:flutter/material.dart';

class CheckOutCollect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          Text(
            "Wann möchten Sie Ihr Essen abholen?",
            style: fontFoodItemName,
          ),
          TimeSpinner(),
          SizedBox(
            height: 40,
          ),
          Center(
            child: ButtonTheme(
              minWidth: MediaQuery.of(context).size.width * 0.9,
              height: 60,
              child: RaisedButton(
                color: black,
                child: Text(
                  "Bezahlen",
                  style: TextStyle(color: white),
                ),
                onPressed: () {
                  //Navigator.of(context).push(createRoute(Login()));
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
