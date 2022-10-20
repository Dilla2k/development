import 'package:Aroma/utils/commons.dart';
import 'package:flutter/material.dart';

import 'customTextField.dart';

class CheckoutDelivery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.81,
      child: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          CustomTextField(
            hintText: "Bitte geben Sie Ihren Vornamen ein",
            labelText: "Vorname",
          ),
          CustomTextField(
            hintText: "Bitte geben Sie Ihren Nachnamen ein",
            labelText: "Nachname",
          ),
          CustomTextField(
            hintText: "Bitte geben Sie Ihre Straße ein",
            labelText: "Straße",
          ),
          CustomTextField(
            hintText: "Bitte geben Sie Ihre Postleitzahl ein",
            labelText: "PLZ",
          ),
          CustomTextField(
            hintText: "Bitte geben Sie Ihren Ort ein",
            labelText: "Ort",
          ),
          CustomTextField(
            hintText: "Bitte geben Sie Ihre Email-Adresse ein",
            labelText: "Email",
          ),
          CustomTextField(
            hintText: "Bitte geben Sie Ihren Telefonnummer ein",
            labelText: "Telefon",
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
          SizedBox(
            height: 5,
          ),
          Divider(
            color: black,
            thickness: 2,
          ),
          Center(
            child: Text(
              "Sparen Sie jetzt bares Geld",
              style: fontFoodItemName,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          /*authNotifier.user == null
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Center(
                    child: ButtonTheme(
                      minWidth: MediaQuery.of(context).size.width * 0.9,
                      height: 60,
                      child: RaisedButton(
                        color: green,
                        child: Text(
                          "Jetzt registieren oder anmelden ",
                          style: fontFoodItemName,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(createRoute(Login()));
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                )
              : Container(),*/
        ],
      ),
    );
  }
}
