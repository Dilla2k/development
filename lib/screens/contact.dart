import 'package:Aroma/utils/commons.dart';
import 'package:Aroma/widgets/appBar.dart';
import 'package:Aroma/widgets/contactBottomNavigationBar.dart';
import 'package:Aroma/widgets/menu.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Contact extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: AromaAppBar(
            sFkey: _scaffoldKey,
            hasHeader: false,
          ),
        ),
        endDrawer: Menu(),
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Text(
                    "Kontakt",
                    style: GoogleFonts.raleway(
                      fontSize: 35,
                      color: green_light,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Pizzeria Aroma",
                    style: GoogleFonts.raleway(
                      fontSize: 18,
                      color: purple_light,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Achenbacher Straße 117",
                    style: GoogleFonts.raleway(
                      fontSize: 18,
                      color: purple_light,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "57072 Siegen",
                    style: GoogleFonts.raleway(
                      fontSize: 18,
                      color: purple_light,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "E-Mail: kontakt@aroma-siegen.de",
                    style: GoogleFonts.raleway(
                      fontSize: 18,
                      color: purple_light,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.95,
                    height: 80,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [purple_dark, purple_light],
                          end: Alignment.centerRight,
                          begin: Alignment.centerLeft),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Öffnungszeiten",
                            style: GoogleFonts.raleway(
                                color: white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Montag-Sonntag: 12:00 - 21:30 Uhr",
                            style: GoogleFonts.raleway(
                                color: white,
                                fontSize: 18,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: 80,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [green_dark, green_light],
                          end: Alignment.centerRight,
                          begin: Alignment.centerLeft),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Lieferzeiten",
                            style: GoogleFonts.raleway(
                                color: white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Montag-Sonntag: 12:00 - 21:30 Uhr",
                            style: GoogleFonts.raleway(
                                color: white,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: ContactBottomNavigationBar(),
      ),
    );
  }
}
