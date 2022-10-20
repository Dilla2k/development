import 'package:Aroma/notifier/opening_notifier.dart';
import 'package:Aroma/utils/commons.dart';
import 'package:Aroma/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:marquee/marquee.dart';

class StatusWidget extends StatefulWidget {
  @override
  _StatusWidgetState createState() => _StatusWidgetState();
}

class _StatusWidgetState extends State<StatusWidget> {
  OpeningNotifier notifier;
  String statusText = "test";
  LinearGradient status;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  _getOpeningColor() async {
    await Utils.isRestaurantOpened(context).then((_) {
      DateFormat dateFormat = new DateFormat.Hm();
      DateTime currentTimeStamp = DateTime.now();

      DateTime current = new DateTime(
          currentTimeStamp.year,
          currentTimeStamp.month,
          currentTimeStamp.day,
          currentTimeStamp.hour,
          currentTimeStamp.minute);

      DateTime yellow = dateFormat.parse("11:00");
      yellow = new DateTime(currentTimeStamp.year, currentTimeStamp.month,
          currentTimeStamp.day, yellow.hour, yellow.minute);

      DateTime green = dateFormat.parse("12:00");
      green = new DateTime(currentTimeStamp.year, currentTimeStamp.month,
          currentTimeStamp.day, green.hour, green.minute);

      DateTime red = dateFormat.parse("21:00");
      red = new DateTime(currentTimeStamp.year, currentTimeStamp.month,
          currentTimeStamp.day, red.hour, red.minute);

      if (current.isBefore(green) && current.isAfter(yellow)) {
        status = LinearGradient(
          colors: [
            Colors.yellow[700],
            Colors.yellow[200],
          ],
          end: Alignment.topCenter,
          begin: Alignment.bottomCenter,
        );
        statusText = "Wir schließen bald";
      } else if (notifier.isOpened &&
          current.isAfter(green) &&
          current.isBefore(red)) {
        status = LinearGradient(
            colors: [green_dark, green_light],
            end: Alignment.topCenter,
            begin: Alignment.bottomCenter);
        statusText = "Wir haben geöffnet";
      } else {
        status = LinearGradient(
            colors: [red_dark, red_light],
            end: Alignment.topCenter,
            begin: Alignment.bottomCenter);
        statusText = "Wir haben geschlossen";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<OpeningNotifier>(context, listen: true);
    _getOpeningColor();
    return FutureBuilder(
        future: _getOpeningColor(),
        builder: (context, projectSnap) {
          if ((projectSnap.connectionState == ConnectionState.none) ||
              (projectSnap.connectionState == ConnectionState.waiting &&
                  projectSnap.data == null)) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
              ),
            );
          } else {
            return Padding(
              padding:
                  const EdgeInsets.only(right: 4, left: 4, top: 4, bottom: 2),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    //borderRadius: BorderRadius.circular(5),
                    gradient: status,
                  ),
                  child: Marquee(
                    text: statusText,
                    startAfter: Duration(seconds: 1),
                    style: fontCategoryItemTitle,
                    blankSpace: MediaQuery.of(context).size.width * 0.8,
                  ),
                ),
              ),
            );
          }
        });
  }
}
