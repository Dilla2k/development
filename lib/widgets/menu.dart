import 'package:Aroma/notifier/usernotifier.dart';
import 'package:Aroma/screens/closeStore.dart';
import 'package:Aroma/screens/contact.dart';
import 'package:Aroma/screens/home.dart';
import 'package:Aroma/screens/imprint.dart';
import 'package:Aroma/screens/shoppingCart.dart';
import 'package:Aroma/screens/user.dart';
import 'package:Aroma/screens/userLogin.dart';
import 'package:Aroma/utils/aroma_icons_icons.dart';
import 'package:Aroma/utils/commons.dart';
import 'package:Aroma/widgets/menuItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Menu extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    var userNotifier = Provider.of<UserNotifier>(context);
    //userNotifier.autoLogin();
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Drawer(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [purple_dark, purple_light],
                end: Alignment.topCenter,
                begin: Alignment.bottomCenter),
            image: DecorationImage(
              image: AssetImage('assets/gemuese.png'),
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.03), BlendMode.dstATop),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView(padding: EdgeInsets.zero, children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            MenuItem(
              title: "Startseite",
              icon: AromaIcons.home,
              pageRoute: Home(),
            ),
            MenuItem(
              title: "Warenkorb",
              icon: AromaIcons.warenkorb,
              pageRoute: ShoppingCartPage(),
            ),
            /*MenuItem(
              title: "Zusatzstoffe",
              icon: Icons.info_outline,
              pageRoute: IndigrendDetails(),
            ),*/
            MenuItem(
              title: "Kontakt",
              icon: AromaIcons.telefon,
              pageRoute: Contact(),
            ),
            MenuItem(
              title: "Meine Daten",
              icon: AromaIcons.einstellung,
              pageRoute:
                  userNotifier.isLoggedIn ? UserScreen() : UserLogin(),
            ),
            MenuItem(
              title: "Impressum",
              icon: AromaIcons.impressum,
              pageRoute: Imprint(),
            ),
            userNotifier.userId == "1"
                ? MenuItem(
                    title: "Schließen",
                    icon: Icons.close,
                    pageRoute: CloseStore(),
                  )
                : Container(),
          ]),
        ),
      ),
    );
  }
}
