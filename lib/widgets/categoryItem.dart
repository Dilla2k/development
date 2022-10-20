import 'package:Aroma/model/food.dart';
import 'package:Aroma/notifier/category_notifier.dart';
import 'package:Aroma/screens/food.dart';
import 'package:Aroma/utils/animations.dart';
import 'package:Aroma/utils/commons.dart';
import 'package:Aroma/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

class CategoryItem extends StatefulWidget {
  final String image;
  final int index;
  final String title;
  final String subTitle;
  final bool isPromoted;
  final bool isImplemented;
  final bool animate;

  const CategoryItem(
      {Key key,
      this.image,
      this.index,
      this.title,
      this.subTitle,
      @required this.isPromoted,
      this.isImplemented,
      this.animate})
      : super(key: key);

  @override
  _CategoryItemState createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    animation = Tween<double>(
      begin: 0,
      end: 0.5 * math.pi,
    ).animate(animationController)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Navigator.of(context).push(createRouteScale(FoodScreen()));
          animationController.reset();
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    var categoryNotifier = Provider.of<CategoryNotifier>(context);
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: widget.isPromoted
                          ? [red_dark, red_light]
                          : [green_dark, green_light],
                      end: Alignment.topCenter,
                      begin: Alignment.bottomCenter),
                ),
              ),
              widget.image != null && widget.image != ""
                  ? Positioned(
                      left: MediaQuery.of(context).size.width * 0.09,
                      bottom: MediaQuery.of(context).size.width * -0.35,
                      child: Transform.rotate(
                        angle: widget.animate ? animation.value : 0,
                        child: Align(
                          alignment: Alignment.center,
                          child: widget.index == Food.IMBISS ||
                                  widget.index == Food.SCHNITZEL
                              ? Transform.rotate(
                                  angle: 0.5,
                                  child: Image.asset(
                                    widget.image,
                                    width: MediaQuery.of(context).size.width *
                                        0.55,
                                    height: MediaQuery.of(context).size.height *
                                        0.55,
                                  ),
                                )
                              : Image.asset(
                                  widget.image,
                                  width:
                                      MediaQuery.of(context).size.width * 0.55,
                                  height:
                                      MediaQuery.of(context).size.height * 0.55,
                                ),
                        ),
                      ),
                    )
                  : Container(),
              !widget.isImplemented
                  ? Padding(
                      padding: const EdgeInsets.all(30),
                      child: Center(
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          child: Image.asset(
                            "assets/aroma_5.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                  : Container(),
              widget.isImplemented
                  ? Align(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            this.widget.subTitle,
                            style: fontCategoryItemSubTitle,
                          ),
                          Text(
                            this.widget.title,
                            style: fontCategoryItemTitle,
                          ),
                        ],
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
      onTap: () {
        categoryNotifier.setSelectedCategory(widget.index);
        switch (widget.index) {
          case 0:
            //categoryNotifier.setControllerPosition(1);
            categoryNotifier.setTopNavigationBarIndex(Food.DREHSPIESS);
            categoryNotifier
                .setTopNavigationBarOffset(Utils.DEHSPIESS_TOPBAR_SCROLLOFFSET);
            break;
          case 1:
            //categoryNotifier.setControllerPosition(14);
            categoryNotifier.setTopNavigationBarIndex(Food.PIZZA);
            categoryNotifier
                .setTopNavigationBarOffset(Utils.PIZZA_TOPBAR_SCROLLOFFSET);
            break;
          case 2:
            //categoryNotifier.setControllerPosition(39);
            categoryNotifier.setTopNavigationBarIndex(Food.PASTA);
            categoryNotifier
                .setTopNavigationBarOffset(Utils.PASTA_TOPBAR_SCROLLOFFSET);
            break;
          case 3:
            //categoryNotifier.setControllerPosition(53);
            categoryNotifier.setTopNavigationBarIndex(Food.SCHNITZEL);
            categoryNotifier
                .setTopNavigationBarOffset(Utils.SCHNITZEL_TOPBAR_SCROLLOFFSET);
            break;
          case 4:
            //categoryNotifier.setControllerPosition(61);
            categoryNotifier.setTopNavigationBarIndex(Food.SALAT);
            categoryNotifier
                .setTopNavigationBarOffset(Utils.SALAT_TOPBAR_SCROLLOFFSET);
            break;
          /*case 8:
            //categoryNotifier.setControllerPosition(64);
            categoryNotifier.setTopNavigationBarIndex(Food.BURGER);
            categoryNotifier
                .setTopNavigationBarOffset(Utils.BURGER_TOPBAR_SCROLLOFFSET);
            break;*/
          case 5:
            //categoryNotifier.setControllerPosition(76);
            categoryNotifier.setTopNavigationBarIndex(Food.IMBISS);
            categoryNotifier
                .setTopNavigationBarOffset(Utils.IMBISS_TOPBAR_SCROLLOFFSET);
            break;
          /*case 9:
            //categoryNotifier.setControllerPosition(84);
            categoryNotifier.setTopNavigationBarIndex(Food.SWEETS);
            categoryNotifier
                .setTopNavigationBarOffset(Utils.SWEETS_TOPBAR_SCROLLOFFSET);
            break;*/
          case 6:
            // categoryNotifier.setControllerPosition(91);
            categoryNotifier.setTopNavigationBarIndex(Food.GETRAENKE);
            categoryNotifier
                .setTopNavigationBarOffset(Utils.GETRAENKE_TOPBAR_SCROLLOFFSET);
            break;
          default:
            //categoryNotifier.setControllerPosition(1);
            categoryNotifier.setTopNavigationBarIndex(Food.DREHSPIESS);
            categoryNotifier.setTopNavigationBarOffset(0);
        }
        /*double pixelRatio = MediaQuery.of(context).size.aspectRatio;
        switch (widget.index) {
          case 0:
            categoryNotifier.setControllerPosition(
                Utils.getOffset(pixelRatio, Utils.DREHSPIESS_SCROLLOFFSET));
            categoryNotifier.setTopNavigationBarIndex(Food.DREHSPIESS);
            categoryNotifier
                .setTopNavigationBarOffset(Utils.DEHSPIESS_TOPBAR_SCROLLOFFSET);
            break;
          case 1:
            categoryNotifier.setControllerPosition(
                Utils.getOffset(pixelRatio, Utils.PIZZA_SCROLLOFFSET));
            categoryNotifier.setTopNavigationBarIndex(Food.PIZZA);
            categoryNotifier
                .setTopNavigationBarOffset(Utils.PIZZA_TOPBAR_SCROLLOFFSET);
            break;
          case 2:
            categoryNotifier.setControllerPosition(
                Utils.getOffset(pixelRatio, Utils.PASTA_SCROLLOFFSET));
            categoryNotifier.setTopNavigationBarIndex(Food.PASTA);
            categoryNotifier
                .setTopNavigationBarOffset(Utils.PASTA_TOPBAR_SCROLLOFFSET);
            break;
          case 3:
            categoryNotifier.setControllerPosition(
                Utils.getOffset(pixelRatio, Utils.SCHNITZEL_SCROLLOFFSET));
            categoryNotifier.setTopNavigationBarIndex(Food.SCHNITZEL);
            categoryNotifier
                .setTopNavigationBarOffset(Utils.SCHNITZEL_TOPBAR_SCROLLOFFSET);
            break;
          case 4:
            categoryNotifier.setControllerPosition(
                Utils.getOffset(pixelRatio, Utils.SALAT_SCROLLOFFSET));
            categoryNotifier.setTopNavigationBarIndex(Food.SALAT);
            categoryNotifier
                .setTopNavigationBarOffset(Utils.SALAT_TOPBAR_SCROLLOFFSET);
            break;
          case 5:
            categoryNotifier.setControllerPosition(
                Utils.getOffset(pixelRatio, Utils.IMBISS_SCROLLOFFSET));
            categoryNotifier.setTopNavigationBarIndex(Food.IMBISS);
            categoryNotifier
                .setTopNavigationBarOffset(Utils.IMBISS_TOPBAR_SCROLLOFFSET);
            break;
          case 6:
            categoryNotifier.setControllerPosition(
                Utils.getOffset(pixelRatio, Utils.GETRAENKE_SCROLLOFFSET));
            categoryNotifier.setTopNavigationBarIndex(Food.GETRAENKE);
            categoryNotifier
                .setTopNavigationBarOffset(Utils.GETRAENKE_TOPBAR_SCROLLOFFSET);
            break;
          case 7:
            categoryNotifier.setControllerPosition(
                Utils.getOffset(pixelRatio, Utils.DREHSPIESS_SCROLLOFFSET));
            categoryNotifier.setTopNavigationBarIndex(Food.DREHSPIESS);
            categoryNotifier.setTopNavigationBarOffset(0);
            break;
          case 8:
            categoryNotifier.setControllerPosition(
                Utils.getOffset(pixelRatio, Utils.DREHSPIESS_SCROLLOFFSET));
            categoryNotifier.setTopNavigationBarIndex(Food.DREHSPIESS);
            categoryNotifier.setTopNavigationBarOffset(0);
            break;
          default:
            categoryNotifier.setControllerPosition(
                Utils.getOffset(pixelRatio, Utils.DREHSPIESS_SCROLLOFFSET));
            categoryNotifier.setTopNavigationBarIndex(Food.DREHSPIESS);
            categoryNotifier.setTopNavigationBarOffset(0);
        }*/
        if (widget.animate) {
          animationController.forward();
        } else {
          Navigator.of(context).push(
            createRouteScale(
              FoodScreen(),
            ),
          );
        }
      },
    );
  }
}
