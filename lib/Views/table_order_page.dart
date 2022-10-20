import '../Items/background_image.dart';
import '../Provider/shoppingcart_notifier.dart';
import '../Utils/common.dart';
import '../Utils/fade_route.dart';
import 'menu_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TableOrderPage extends StatelessWidget {
  static const String routeName = '/tableOrderPage';
  const TableOrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BackgroundImage(),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: primaryColor,
            elevation: 0.0,
            titleSpacing: 10.0,
            centerTitle: true,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: GridView.builder(
                  physics: const ScrollPhysics(),
                  itemCount: tableNo,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: primaryColor.withOpacity(0.8),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 25,
                            vertical: 25,
                          ),
                          textStyle: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          context
                              .read<ShoppingcartNotifier>()
                              .calcPrice(index + 1);
                          Navigator.push(
                            context,
                            FadeRoute(
                              page: MenuPage(
                                key: key,
                                tableNumber: index + 1,
                              ),
                            ),
                          );
                        },
                        child: Text(
                          "Tisch " + (index + 1).toString(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
