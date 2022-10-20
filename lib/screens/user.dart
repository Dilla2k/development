import 'package:Aroma/model/user.dart';
import 'package:Aroma/notifier/usernotifier.dart';
import 'package:Aroma/screens/userLogin.dart';
import 'package:Aroma/utils/commons.dart';
import 'package:Aroma/widgets/appBar.dart';
import 'package:Aroma/widgets/coloredGradientButton.dart';
import 'package:Aroma/widgets/editUserDialog.dart';
import 'package:Aroma/widgets/menu.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'myOrders.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key key}) : super(key: key);

  @override
  _UserScreenState createState() => _UserScreenState();
}

Future _getUser() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String userEmail = prefs.getString('userEmail');
  var result = await User.getUserByEmail(userEmail);
  return result;
}

class _UserScreenState extends State<UserScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var userNotifier = Provider.of<UserNotifier>(context);
    return Scaffold(
      backgroundColor: white,
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
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 12.0, right: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15,
              ),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Ihre Daten",
                        style: GoogleFonts.raleway(
                            color: white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              FutureBuilder<dynamic>(
                future: _getUser(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    User actualUser = snapshot.data;
                    if (actualUser.id != null) {
                      return Center(
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Name:",
                                  style: GoogleFonts.raleway(
                                      color: purple_dark,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  "Straße:",
                                  style: GoogleFonts.raleway(
                                      color: purple_dark,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  "Ort:",
                                  style: GoogleFonts.raleway(
                                      color: purple_dark,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  "Telefon:",
                                  style: GoogleFonts.raleway(
                                      color: purple_dark,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  actualUser.firstName + " " + actualUser.name,
                                  style: GoogleFonts.raleway(
                                      color: green_light,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  actualUser.street,
                                  style: GoogleFonts.raleway(
                                      color: green_light,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  actualUser.postCode + " " + actualUser.city,
                                  style: GoogleFonts.raleway(
                                      color: green_light,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  actualUser.phone,
                                  style: GoogleFonts.raleway(
                                      color: green_light,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return EditUserDialog(
                                        user: actualUser,
                                      );
                                    });
                              },
                            ),
                          ],
                        ),
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
              SizedBox(
                height: 15,
              ),
              ColoredGradientButton(
                startColor: purple_dark,
                endColor: purple_light,
                buttonText: "Zu meinen Bestellungen",
                pushAndRemove: true,
                route: MyOrderScreen(
                  userId: userNotifier.userId,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ColoredGradientButton(
                startColor: red_dark,
                endColor: red_light,
                buttonText: "Abmelden",
                pushAndRemove: true,
                isLogout: true,
                route: UserLogin(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
