import 'package:Aroma/model/order.dart';
import 'package:Aroma/utils/commons.dart';
import 'package:Aroma/widgets/appBar.dart';
import 'package:Aroma/widgets/menu.dart';
import 'package:Aroma/widgets/orderItem.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyOrderScreen extends StatefulWidget {
  final String userId;

  const MyOrderScreen({Key key, this.userId}) : super(key: key);

  @override
  _MyOrderScreenState createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _getOrders(widget.userId);
  }

  Future _getOrders(String userId) async {
    var result = await Order.getOrdersByUserIdFromDB(userId);
    return result;
  }

  Widget _dataBody() {
    return FutureBuilder(
      builder: (context, projectSnap) {
        if (projectSnap.connectionState == ConnectionState.none &&
            projectSnap.hasData == null) {
          return Container();
        }
        if (!projectSnap.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.builder(
            itemCount: projectSnap.data.length,
            itemBuilder: (context, dynamic index) {
              Order myOrder = projectSnap.data[index];
              return OrderItem(
                date: myOrder.date,
                price: myOrder.price,
              );
            },
          );
        }
      },
      future: _getOrders(widget.userId),
    );
  }

  @override
  Widget build(BuildContext context) {
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
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Meine bisherigen",
                            style: GoogleFonts.raleway(
                                color: white,
                                fontSize: 13,
                                fontWeight: FontWeight.w300),
                          ),
                          Text(
                            "Bestellungen",
                            style: GoogleFonts.raleway(
                                color: white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: Container(child: _dataBody()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
