import 'package:Aroma/model/allergens.dart';
import 'package:Aroma/utils/commons.dart';
import 'package:Aroma/widgets/foodItem.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AllergenDialog extends StatelessWidget {
  final String title, buttonText;
  final Image image;
  final FoodItem foodItem;

  AllergenDialog({
    @required this.title,
    @required this.buttonText,
    this.image, this.foodItem,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.padding),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: Consts.avatarRadius + Consts.padding,
            bottom: Consts.padding,
            left: Consts.padding,
            right: Consts.padding,
          ),
          margin: EdgeInsets.only(top: Consts.avatarRadius),
          decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(Consts.padding),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              Text(title,
                  style: GoogleFonts.raleway(
                    fontSize: 25,
                    color: purple_light,
                    fontWeight: FontWeight.w800,
                  )),
              SizedBox(height: 16.0),
              Text(
                Allergen.getAllergenList(foodItem.allergens).toString().replaceAll("[", "").replaceAll("]", ""),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 24.0),
              Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // To close the dialog
                  },
                  child: Text(buttonText),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: Consts.padding,
          right: Consts.padding,
          child: CircleAvatar(
            backgroundColor: green_light,
            radius: Consts.avatarRadius,
          ),
        ),
        Positioned(
          left: Consts.padding,
          right: Consts.padding,
          top: Consts.paddingSymbolTop,
          child: Icon(
           Icons.info_outline,
           size: 50,
           color: white,
          ),
        ),
      ],
    );
  }
}

class Consts {
  Consts._();

  static const double padding = 16.0;
  static const double avatarRadius = 66.0;
  static const double paddingSymbolTop = 40.0;
}
