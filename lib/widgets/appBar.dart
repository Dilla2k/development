import 'package:Aroma/utils/aroma_icons_icons.dart';
import 'package:Aroma/utils/commons.dart';
import 'package:Aroma/widgets/orderSwitch.dart';
import 'package:flutter/material.dart';

class AromaAppBar extends StatefulWidget {
  final GlobalKey<ScaffoldState> sFkey;
  final bool hasHeader;

  const AromaAppBar({Key key, this.sFkey, this.hasHeader}) : super(key: key);

  @override
  _AromaAppBarState createState() => _AromaAppBarState();
}

class _AromaAppBarState extends State<AromaAppBar> {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => (AppBar(
        backgroundColor: purple_light,
        automaticallyImplyLeading: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [purple_light, purple_light],
                end: Alignment.topCenter,
                begin: Alignment.bottomCenter),
            image: DecorationImage(
              image: AssetImage('assets/gemuese.png'),
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.09), BlendMode.dstATop),
              fit: BoxFit.cover,
            ),
          ),
        ),
        centerTitle: true,
        title: widget.hasHeader
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  OrderSwitch(),
                ],
              )
            : Container(),
        actions: [
          IconButton(
            icon: Icon(
              AromaIcons.menu,
              color: white,
            ),
            onPressed: () => widget.sFkey.currentState.openEndDrawer(),
          ),
        ],
      )),
    );
  }
}
