import 'package:Aroma/notifier/animation_notifier.dart';
import 'package:Aroma/notifier/cart_notifier.dart';
import 'package:Aroma/screens/shoppingCart.dart';
import 'package:Aroma/utils/animations.dart';
import 'package:Aroma/utils/aroma_icons_icons.dart';
import 'package:Aroma/utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShoppingCartFloatingActionButton extends StatefulWidget {
  @override
  _ShoppingCartFloatingActionButtonState createState() =>
      _ShoppingCartFloatingActionButtonState();
}

class _ShoppingCartFloatingActionButtonState
    extends State<ShoppingCartFloatingActionButton>
    with TickerProviderStateMixin {
  AnimationController _animationController;

  bool sent = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));

    _animationController.addListener(() {
      setState(() {
        sent = true;
      });
    });
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        sent = false;
        
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      AnimateNotifier animationNotifier =
          Provider.of<AnimateNotifier>(context, listen: false);
      animationNotifier.setAnimationController(_animationController);
    });
  }

  @override
  Widget build(BuildContext context) {
    CartNotifier cartNotifier =
        Provider.of<CartNotifier>(context, listen: true);

    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      child: Stack(
        children: [
          AnimatedSize(
            vsync: this,
            duration: Duration(milliseconds: 200),
            child: sent
                ? FloatingActionButton(
                    child: Icon(
                      Icons.done,
                      color: white,
                    ),
                    backgroundColor: green_light,
                    onPressed: () {
                      Navigator.of(context)
                          .push(createRoute(ShoppingCartPage()));
                    },
                  )
                : FloatingActionButton(
                    child: Icon(AromaIcons.warenkorb),
                    backgroundColor: purple_light,
                    onPressed: () {
                      Navigator.of(context)
                          .push(createRoute(ShoppingCartPage()));
                    },
                  ),
          ),
          Positioned(
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: purple_light,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.brightness_1,
                    size: 20.0,
                    color: Colors.white,
                  ),
                ),
                Positioned(
                  top: 3.0,
                  right: 7,
                  child: Center(
                    child: Text(
                      cartNotifier.cart.length.toString(),
                      style: TextStyle(
                          color: purple_light,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
