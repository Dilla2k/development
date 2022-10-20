import 'package:Aroma/notifier/usernotifier.dart';
import 'package:Aroma/screens/myOrders.dart';
import 'package:Aroma/screens/userLogin.dart';
import 'package:Aroma/utils/commons.dart';
import 'package:Aroma/widgets/appBar.dart';
import 'package:Aroma/widgets/menu.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ThankYouRegister extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var userNotifier = Provider.of<UserNotifier>(context);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AromaAppBar(
          sFkey: _scaffoldKey,
          hasHeader: false,
        ),
      ),
      endDrawer: Menu(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 12.0, right: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                  padding: const EdgeInsets.only(
                    left: 30,
                    right: 30,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Wir sagen",
                            style: GoogleFonts.raleway(
                                color: white,
                                fontSize: 13,
                                fontWeight: FontWeight.w300),
                          ),
                          Text(
                            "Danke!",
                            style: GoogleFonts.raleway(
                                color: white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.favorite_border,
                        color: white,
                        size: 35,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                "Vielen Dank für Ihre Registrierung bei Aroma Siegen",
                style: GoogleFonts.raleway(
                  fontSize: 15,
                  color: purple_light,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Flexible(
                child: SizedBox(
                  child: Text(
                    "Sie können nun unter Meine Bestellungen Ihre bisherigen Betellungen einsehen.",
                    style: GoogleFonts.raleway(
                      fontSize: 13,
                      color: purple_light,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Flexible(
                child: SizedBox(
                  child: Text(
                    "Wir freuen uns auf ihre nächste Bestellung und wünschen Ihnen einen guten Appetit",
                    style: GoogleFonts.raleway(
                      fontSize: 13,
                      color: purple_light,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Ihr Aroma Siegen Team!",
                style: GoogleFonts.raleway(
                  fontSize: 13,
                  color: green_light,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Image.asset(
                "assets/aroma-logo.png",
                height: 60,
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    gradient: LinearGradient(
                        colors: [purple_dark, purple_light],
                        end: Alignment.centerRight,
                        begin: Alignment.centerLeft),
                    image: DecorationImage(
                      image: AssetImage('assets/gemuese.png'),
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.03), BlendMode.dstATop),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Zu meinen Bestellungen",
                      style: GoogleFonts.raleway(
                          color: white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                onTap: () {
                  if (userNotifier.isLoggedIn) {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (BuildContext context) => MyOrderScreen()),
                      ModalRoute.withName('/'),
                    );
                  } else {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (BuildContext context) => UserLogin()),
                      ModalRoute.withName('/'),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
