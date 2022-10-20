import 'dart:io';
import 'package:Aroma/utils/commons.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactBottomNavigationBar extends StatelessWidget {
  _launchTel() async {
    const url = 'tel://027138750613';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchWa() async {
    String url;
    if (Platform.isIOS) {
      url = "whatsapp://wa.me/+4917684225007/";
    } else {
      url = "whatsapp://send?phone=+4917684225007";
    }
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      color: purple,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: TextButton(
              child: Row(
                children: <Widget>[
                  Image.asset(
                    "assets/whatsapp.png",
                    width: 40,
                    height: 40,
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  AutoSizeText(
                    "0176 84 22 50 07",
                    style: TextStyle(color: white),
                  ),
                ],
              ),
              onPressed: () {
                _launchWa();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: TextButton(
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.call,
                    color: white,
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  AutoSizeText(
                    "0271 38 75 06 13",
                    style: TextStyle(color: white),
                  ),
                ],
              ),
              onPressed: () {
                _launchTel();
              },
            ),
          ),
        ],
      ),
    );
  }
}
