import 'package:Aroma/model/discount.dart';
import 'package:Aroma/notifier/cart_notifier.dart';
import 'package:Aroma/notifier/opening_notifier.dart';
import 'package:Aroma/notifier/order_type_notifier.dart';
import 'package:Aroma/screens/paymentMethod.dart';
import 'package:Aroma/utils/animations.dart';
import 'package:Aroma/utils/commons.dart';
import 'package:Aroma/utils/utils.dart';
import 'package:Aroma/widgets/appBar.dart';
import 'package:Aroma/widgets/menu.dart';
import 'package:Aroma/widgets/shoppingCartItem.dart';
import 'package:flutter/material.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ShoppingCartPage extends StatefulWidget {
  ShoppingCartPage({Key key}) : super(key: key);

  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCartPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String buttontext = "Prüfen";
  String discountText = "Rabatt: 5%";
  bool codeIsValid = false;
  TextEditingController controller = TextEditingController();
  double finalPrice = 0.0;
  double initialPrice = 0.0;
  int discountInPercent = 5;
  double discountPrice = 0.0;
  double discountInEuro = 10.0;
  CartNotifier cartProvider;
  OrderTypeNotifier orderTypeNotifier;
  OpeningNotifier openNotifier;

  Future _checkDiscountCode(String discountCode) async {
    SnackBar snackBar;
    await Discount.getDiscountCodesFromDB().then((discoutList) {
      bool check = true;
      for (Discount actualDiscount in discoutList) {
        if (actualDiscount.id == discountCode) {
          check = true;
          buttontext = "Entfernen";
        }
      }
      cartProvider.coupon = check;
      buttontext = "Löschen";
      if (cartProvider.coupon) {
        snackBar = SnackBar(content: Text('Ihr Gutscheincode ist gültig'));
      } else {
        snackBar = SnackBar(content: Text('Ihr Gutscheincode ist ungültig'));
      }

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      setState(() {});
    });
  }

  _calcShoppingCartPrice(List<ShoppingCartItem> cartItems) {
    initialPrice = Utils.calcShoppingCartPrice(cartItems);
    if (cartProvider.coupon) {
      discountText = "Rabatt:";
      discountPrice = discountInEuro;
      if (initialPrice < discountInEuro) {
        finalPrice = 0.0;
      } else {
        finalPrice = initialPrice - discountInEuro;
      }
    } else {
      discountText = "Rabatt: 5%";
      discountPrice =
          Utils.calcShoppingCartDiscount(initialPrice, discountInPercent);
      finalPrice = initialPrice; //- discountPrice;
    }
    cartProvider.finalPrice = finalPrice;
  }

  _removeDiscountCode() {
    cartProvider.coupon = false;
    buttontext = "Prüfen";
    setState(() {});
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    cartProvider = Provider.of<CartNotifier>(
      context,
      listen: true,
    );
    orderTypeNotifier = Provider.of<OrderTypeNotifier>(
      context,
      listen: true,
    );
    openNotifier = Provider.of<OpeningNotifier>(
      context,
      listen: false,
    );
    var cart = cartProvider.cart;
    if (cartProvider.coupon) {
      buttontext = "Löschen";
    }
    _calcShoppingCartPrice(cart);
    return Scaffold(
      backgroundColor: white,
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AromaAppBar(
          sFkey: _scaffoldKey,
          hasHeader: true,
        ),
      ),
      endDrawer: Menu(),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                left: 8.0,
                right: 8.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.95,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                        image: AssetImage('assets/gemuese.png'),
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.03), BlendMode.dstATop),
                        fit: BoxFit.cover,
                      ),
                      gradient: LinearGradient(
                          colors: [green_dark, green_light],
                          end: Alignment.centerRight,
                          begin: Alignment.centerLeft),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Ihr heutiger",
                            style: GoogleFonts.raleway(
                                color: white,
                                fontSize: 13,
                                fontWeight: FontWeight.w300),
                          ),
                          Text(
                            "Warenkorb",
                            style: GoogleFonts.raleway(
                                color: white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
                right: 8.0,
                top: 6.0,
                bottom: 6.0,
              ),
              child: ConstrainedBox(
                constraints: new BoxConstraints(
                  minHeight: 0.0,
                  maxHeight: MediaQuery.of(context).size.height * 0.33,
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: cart.length,
                  physics: const AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: cart[index],
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
                right: 8.0,
                bottom: 4.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.95,
                    height: 120,
                    decoration: BoxDecoration(
                      color: purple_light,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Gesamt",
                                style: GoogleFonts.raleway(
                                    color: white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              /*Text(
                                discountText,
                                style: GoogleFonts.raleway(
                                    color: white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w300),
                              ),*/
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Lieferkosten",
                                style: GoogleFonts.raleway(
                                    color: white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w300),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Endsumme",
                                style: GoogleFonts.raleway(
                                    color: white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                initialPrice.toStringAsFixed(2) + " €",
                                style: GoogleFonts.raleway(
                                    color: white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              /*Text(
                                "- " + discountPrice.toStringAsFixed(2) + " €",
                                style: GoogleFonts.raleway(
                                    color: white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700),
                              ),*/
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "0,00 €",
                                style: GoogleFonts.raleway(
                                    color: white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                finalPrice.toStringAsFixed(2) + " €",
                                style: GoogleFonts.raleway(
                                    color: white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 8, right: 8, top: 5, bottom: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.95,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        gradient: LinearGradient(
                            colors: [green_dark, green_light],
                            end: Alignment.centerRight,
                            begin: Alignment.centerLeft),
                        image: DecorationImage(
                          image: AssetImage('assets/gemuese.png'),
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.03),
                              BlendMode.dstATop),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Jetzt bestellen !",
                          style: GoogleFonts.raleway(
                              color: white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    onTap: () {
                      if (openNotifier.isOpened) {
                        if (initialPrice < 18.0 &&
                            orderTypeNotifier.orderType == 1) {
                          final snackBar = SnackBar(
                              content: Text(
                                  'Der Mindestbestellwert beträgt 18,00€'));

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else if (initialPrice == 0 &&
                            orderTypeNotifier.orderType == 0) {
                          final snackBar = SnackBar(
                              content:
                                  Text('Sie haben keine Artikel im Warenkorb'));

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          Navigator.of(context)
                              .push(createRoute(PaymentMethod()));
                        }
                      } else {
                        final snackBar = SnackBar(
                            content: Text(
                                'Leider haben wir derzeit nicht geöffnet!'));

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
