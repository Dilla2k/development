import 'package:Aroma/model/food.dart';
import 'package:Aroma/notifier/category_notifier.dart';
import 'package:Aroma/utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FoodScreenCategoryItem extends StatefulWidget {
  final String image;
  final int index;
  final String title;
  final String subTitle;

  const FoodScreenCategoryItem(
      {Key key, this.image, this.index, this.title, this.subTitle})
      : super(key: key);

  @override
  _FoodScreenCategoryItemState createState() => _FoodScreenCategoryItemState();
}

class _FoodScreenCategoryItemState extends State<FoodScreenCategoryItem> {
  @override
  Widget build(BuildContext context) {
    var categoryNotifier = Provider.of<CategoryNotifier>(context, listen: true);
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Stack(
            children: [
              Container(
                width: 150,
                height: 75,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors:
                          categoryNotifier.topNavigationBarIndex == widget.index
                              ? [purple_dark, purple_light]
                              : [green_dark, green_light],
                      end: Alignment.topCenter,
                      begin: Alignment.bottomCenter),
                ),
              ),
              Positioned(
                left: 100,
                bottom: -20,
                child: ClipRect(
                  child: Image.asset(
                    this.widget.image,
                    width: 75,
                    height: 75,
                  ),
                ),
              ),
              Positioned.fill(
                child: Align(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        this.widget.subTitle,
                        style: fontFoodCategoryItemSubTitle,
                      ),
                      Text(
                        this.widget.title,
                        style: fontFoodCategoryItemTitle,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () async {
        categoryNotifier.setTopNavigationBarIndex(widget.index);
        switch (widget.index) {
          case Food.DREHSPIESS:
            categoryNotifier.jumpToIndex(1);
            break;
          case Food.PIZZA:
            categoryNotifier.jumpToIndex(14);
            break;
          case Food.PASTA:
            categoryNotifier.jumpToIndex(41);
            break;
          case Food.SCHNITZEL:
            categoryNotifier.jumpToIndex(55);
            break;
          case Food.SALAT:
            categoryNotifier.jumpToIndex(63);
            break;
          /*case Food.BURGER:
            categoryNotifier.jumpToIndex(62);
            break;
            case Food.IMBISS:
            categoryNotifier.jumpToIndex(66);
            break;*/
          case Food.IMBISS:
            categoryNotifier.jumpToIndex(70);
            break;
          /*case Food.SWEETS:
            categoryNotifier.jumpToIndex(66);
            break;
            case Food.GETRAENKE:
            categoryNotifier.jumpToIndex(77);
            break;*/
          case Food.GETRAENKE:
            categoryNotifier.jumpToIndex(81);
            break;
          default:
            categoryNotifier.jumpToIndex(1);
            break;
        }
      },
    );
  }
}
