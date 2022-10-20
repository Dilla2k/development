import 'package:Aroma/utils/animations.dart';
import 'package:Aroma/utils/commons.dart';
import 'package:flutter/material.dart';

class MenuItem extends StatefulWidget {
  final IconData icon;
  final String title;
  final Widget pageRoute;

  const MenuItem({Key key, this.icon, this.title, this.pageRoute})
      : super(key: key);

  @override
  _MenuItemState createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Icon(
              widget.icon,
              color: white,
              size: 30,
            ),
            SizedBox(height: 8),
            Text(
              widget.title,
              style: TextStyle(color: white),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        Navigator.of(context).push(createRoute(widget.pageRoute));
      },
    );
  }
}
