import 'package:Aroma/model/user.dart';
import 'package:Aroma/notifier/opening_notifier.dart';
import 'package:Aroma/utils/commons.dart';
import 'package:Aroma/widgets/appBar.dart';
import 'package:Aroma/widgets/menu.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CloseStore extends StatefulWidget {
  @override
  _CloseStoreState createState() => _CloseStoreState();
}

class _CloseStoreState extends State<CloseStore> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var openingNotifier = Provider.of<OpeningNotifier>(context);
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
            child: Column(
              children: [
                SizedBox(
                  height: 55,
                ),
                openingNotifier.isOpened
                    ? Text(
                        "Das Geschäft ist derzeit geöffnet",
                        style: GoogleFonts.raleway(
                            color: black,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      )
                    : Text(
                        "Das Geschäft ist derzeit geschlossen",
                        style: GoogleFonts.raleway(
                            color: black,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.95,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        gradient: LinearGradient(
                            colors: [red_dark, red_light],
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
                          "Geschäft schließen!",
                          style: GoogleFonts.raleway(
                              color: white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        openingNotifier.setIsOpened(false);
                        User.closeStore(false);
                      });
                    }),
                SizedBox(
                  height: 10,
                ),
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
                          "Geschäft öffnen!",
                          style: GoogleFonts.raleway(
                              color: white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        openingNotifier.setIsOpened(true);
                        User.closeStore(true);
                      });
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
