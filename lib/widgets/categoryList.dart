import 'package:Aroma/utils/utils.dart';
import 'package:flutter/material.dart';

class CategoryList extends StatefulWidget {
  final ValueChanged<int> parentAction;

  const CategoryList({Key key, this.parentAction}) : super(key: key);

  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

    return Container(
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: (itemWidth / itemHeight) + 0.2,
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        children: List.generate(
            Utils.categoryList.length, (index) => Utils.categoryList[index]),
      ),
    );
  }
}
