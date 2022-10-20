import 'package:Aroma/utils/commons.dart';
import 'package:flutter/material.dart';

class FoodScreenCategoryGroupItem extends StatelessWidget {
  final String image;
  final int index;
  final String title;
  final String subTitle;

  const FoodScreenCategoryGroupItem(
      {Key key, this.image, this.index, this.title, this.subTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 2, 8, 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Stack(
          children: [
            Container(
              height: 75,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [green_dark, green_light],
                    end: Alignment.topCenter,
                    begin: Alignment.bottomCenter),
              ),
            ),
            Positioned(
              right: -30,
              bottom: -25,
              child: ClipRect(
                child: Image.asset(
                  this.image,
                  width: 115,
                  height: 115,
                ),
              ),
            ),
            Align(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    this.subTitle,
                    style: fontFoodCategoryItemSubTitle,
                  ),
                  Text(
                    this.title,
                    style: fontFoodCategoryItemTitle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
