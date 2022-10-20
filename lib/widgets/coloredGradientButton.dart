import 'package:Aroma/model/user.dart';
import 'package:Aroma/notifier/usernotifier.dart';
import 'package:Aroma/utils/animations.dart';
import 'package:Aroma/utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ColoredGradientButton extends StatelessWidget {
  final Color startColor;
  final Color endColor;
  final String buttonText;
  final Widget route;
  final bool pushAndRemove;
  final bool isLogout;

  const ColoredGradientButton(
      {Key key,
      this.startColor,
      this.endColor,
      this.buttonText,
      this.route,
      this.pushAndRemove, this.isLogout})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userNotifier = Provider.of<UserNotifier>(context);
    return InkWell(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.95,
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          gradient: LinearGradient(
              colors: [this.startColor, this.endColor],
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
            this.buttonText,
            style: GoogleFonts.raleway(
                color: white, fontSize: 20, fontWeight: FontWeight.w700),
          ),
        ),
      ),
      onTap: () {
        if(isLogout != null && isLogout == true){
          userNotifier.logout();
        }
        this.pushAndRemove
            ? Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (BuildContext context) => this.route),
                ModalRoute.withName('/'),
              )
            : createRouteScale(this.route);
      },
    );
  }
}
