import 'package:Aroma/notifier/payment_notifier.dart';
import 'package:Aroma/screens/order.dart';
import 'package:Aroma/utils/animations.dart';
import 'package:Aroma/utils/commons.dart';
import 'package:Aroma/widgets/appBar.dart';
import 'package:Aroma/widgets/menu.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PaymentMethod extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    PaymentNotifier paymentNotifier = Provider.of<PaymentNotifier>(context);

    return Scaffold(
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
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 8.0, right: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * 0.95,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        gradient: LinearGradient(
                            colors: [green_dark, green_light],
                            end: Alignment.centerRight,
                            begin: Alignment.centerLeft),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Zahlart auswählen",
                                  style: GoogleFonts.raleway(
                                      color: white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                            Icon(
                              Icons.euro,
                              color: Colors.white70,
                              size: 50,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              InkWell(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: Image.asset(
                    "assets/paypal.jpeg",
                    fit: BoxFit.contain,
                  ),
                ),
                onTap: () {
                  paymentNotifier.setPaymentType(1);
                  Navigator.of(context).push(createRoute(OrderScreen()));
                },
              ),
              SizedBox(
                height: 5,
              ),
              InkWell(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: Image.asset(
                    "assets/barzahlung.jpeg",
                    fit: BoxFit.contain,
                  ),
                ),
                onTap: () {
                  paymentNotifier.setPaymentType(0);
                  Navigator.of(context).push(createRoute(OrderScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
