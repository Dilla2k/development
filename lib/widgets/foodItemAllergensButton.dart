import 'package:flutter/material.dart';

import 'allergenDialog.dart';
import 'foodItem.dart';

class FoodItemAllergensButton extends StatelessWidget {

  final FoodItem foodItem;

  const FoodItemAllergensButton({Key key, this.foodItem}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
                      children: [
                        SizedBox(width: 20),
                        InkWell(
                          child: Row(
                            children: [
                              Icon(
                                Icons.info_outline,
                                size: 15,
                                color: Colors.black54,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Informationen zu den Zusatzstoffen in diesem Gericht",
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 10),
                              )
                            ],
                          ),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => AllergenDialog(
                                title: "Allergene",
                                foodItem: foodItem,
                                buttonText: "Schließen",
                              ),
                            );
                          },
                        ),
                      ],
                    );
  }
}