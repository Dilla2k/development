import 'package:Aroma/model/order.dart';
import 'package:Aroma/model/user.dart';
import 'package:Aroma/notifier/cart_notifier.dart';
import 'package:Aroma/notifier/opening_notifier.dart';
import 'package:Aroma/notifier/order_type_notifier.dart';
import 'package:Aroma/notifier/payment_notifier.dart';
import 'package:Aroma/notifier/usernotifier.dart';
import 'package:Aroma/screens/thankYou.dart';
import 'package:Aroma/utils/Papal/PaypalPayment.dart';
import 'package:Aroma/utils/aroma_icons_icons.dart';
import 'package:Aroma/utils/utils.dart';
import 'package:Aroma/widgets/menu.dart';
import 'package:Aroma/widgets/shoppingCartItem.dart';
import 'package:Aroma/widgets/timeSpinner.dart';
import 'package:Aroma/utils/commons.dart';
import 'package:Aroma/widgets/appBar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKeyDelivery = GlobalKey<FormState>();
  final _formKeyTakeAway = GlobalKey<FormState>();
  User user;
  String checkNumber = "";

  TextEditingController nameController = new TextEditingController();
  TextEditingController firstNameController = new TextEditingController();
  TextEditingController streetController = new TextEditingController();
  TextEditingController postCodeController = new TextEditingController();
  TextEditingController cityController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();

  getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await User.getUserByEmail(prefs.getString('userEmail')).then((value) {
      user = value;
      if (user != null) {
        nameController.text = user.name;
        firstNameController.text = user.firstName;
        streetController.text = user.street;
        postCodeController.text = user.postCode;
        cityController.text = user.city;
        emailController.text = user.email;
        phoneController.text = user.phone;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    OrderTypeNotifier orderTypeNotifier =
        Provider.of<OrderTypeNotifier>(context, listen: true);
    CartNotifier cartNotifier = Provider.of<CartNotifier>(context);
    UserNotifier userNotifier = Provider.of<UserNotifier>(context);
    PaymentNotifier paymentNotifier = Provider.of<PaymentNotifier>(context);
    OpeningNotifier openNotifier = Provider.of<OpeningNotifier>(context);

    double shoppingCartPrice = cartNotifier.finalPrice;

    _takeAwayBody() {
      return SizedBox(
        child: Container(
          margin: EdgeInsets.all(15.0),
          child: Form(
            key: _formKeyTakeAway,
            child: Column(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Vorname*",
                      style: fontFoodItemPrice,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: grey)),
                      child: TextFormField(
                        autofillHints: [AutofillHints.name],
                        keyboardType: TextInputType.name,
                        controller: firstNameController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: grey, width: 0.5),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: green_light),
                          ),
                        ),
                        cursorColor: green_light,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Bitte Vornamen eingeben';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Nachname*",
                      style: fontFoodItemPrice,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: grey)),
                      child: TextFormField(
                        autofillHints: [AutofillHints.familyName],
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: grey, width: 0.5),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: green_light),
                          ),
                        ),
                        controller: nameController,
                        cursorColor: green_light,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Bitte Nachnamen eingeben';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Email*",
                      style: fontFoodItemPrice,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: grey)),
                      child: TextFormField(
                        // The validator receives the text that the user has entered.
                        autofillHints: [AutofillHints.email],
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: grey, width: 0.5),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: green_light),
                          ),
                        ),
                        cursorColor: green_light,
                        controller: emailController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Bitte Email eingeben';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Telefon (Für eventuelle Rückfragen)",
                      style: fontFoodItemPrice,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: grey)),
                      child: TextFormField(
                        autofillHints: [AutofillHints.telephoneNumber],
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: grey, width: 0.5),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: green_light),
                          ),
                        ),
                        cursorColor: green_light,
                        controller: phoneController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Bitte Telefonnummer eingeben';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Wann möchten Sie Ihr Essen abholen?",
                      style: fontFoodItemPrice,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TimeSpinner(),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }

    _deliveryBody() {
      return SizedBox(
        child: Container(
          margin: EdgeInsets.all(15.0),
          child: Form(
            key: _formKeyDelivery,
            child: Column(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Vorname*",
                      style: fontFoodItemPrice,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: grey)),
                      child: TextFormField(
                        autofillHints: [AutofillHints.name],
                        controller: firstNameController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: grey, width: 0.5),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: green_light),
                          ),
                        ),
                        cursorColor: green_light,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Bitte Vornamen eingeben';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Nachname*",
                      style: fontFoodItemPrice,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: grey)),
                      child: TextFormField(
                        autofillHints: [AutofillHints.familyName],
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: grey, width: 0.5),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: green_light),
                          ),
                        ),
                        controller: nameController,
                        cursorColor: green_light,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Bitte Nachnamen eingeben';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Straße, Nr.*",
                      style: fontFoodItemPrice,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: grey)),
                      child: TextFormField(
                        autofillHints: [AutofillHints.streetAddressLevel1],
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: grey, width: 0.5),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: green_light),
                          ),
                        ),
                        cursorColor: green_light,
                        controller: streetController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Bitte Straße eingeben';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "PLZ*",
                      style: fontFoodItemPrice,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: grey)),
                      child: TextFormField(
                        autofillHints: [AutofillHints.postalCode],
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: grey, width: 0.5),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: green_light),
                          ),
                        ),
                        cursorColor: green_light,
                        controller: postCodeController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Bitte PLZ eingeben';
                          }
                          if (!Utils.isValidPostCode(value)) {
                            return 'PLZ außerhalb des Lieferbereichs';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Ort*",
                      style: fontFoodItemPrice,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: grey)),
                      child: TextFormField(
                        autofillHints: [AutofillHints.addressCity],
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: grey, width: 0.5),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: green_light),
                          ),
                        ),
                        cursorColor: green_light,
                        controller: cityController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Bitte Ort eingeben';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Email*",
                      style: fontFoodItemPrice,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: grey)),
                      child: TextFormField(
                        autofillHints: [AutofillHints.email],
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: grey, width: 0.5),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: green_light),
                          ),
                        ),
                        cursorColor: green_light,
                        controller: emailController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Bitte Email eingeben';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Telefon (Für eventuelle Rückfragen)",
                      style: fontFoodItemPrice,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: grey)),
                      child: TextFormField(
                        autofillHints: [AutofillHints.telephoneNumber],
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: grey, width: 0.5),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: green_light),
                          ),
                        ),
                        cursorColor: green_light,
                        controller: phoneController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Bitte Telefonnummer eingeben';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Wann sollen wir Ihr Essen liefern?",
                          style: fontFoodItemPrice,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TimeSpinner(),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: white,
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AromaAppBar(
          sFkey: _scaffoldKey,
          hasHeader: true,
        ),
      ),
      endDrawer: Menu(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    top: 5, left: 8.0, right: 8.0, bottom: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
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
                                  "Ihr heutiger",
                                  style: GoogleFonts.raleway(
                                      color: white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w300),
                                ),
                                Text(
                                  "Warenkorb",
                                  style: GoogleFonts.raleway(
                                      color: white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Text(
                                "Gesamtsumme " +
                                    shoppingCartPrice.toStringAsFixed(2) +
                                    " €",
                                style: GoogleFonts.raleway(
                                    color: white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 12),
                              child: Column(
                                children: [
                                  Icon(
                                    AromaIcons.warenkorb,
                                    color: Colors.white70,
                                    size: 30,
                                  ),
                                  paymentNotifier.paymentType == 1
                                      ? Icon(
                                          AromaIcons.paypal,
                                          color: Colors.white70,
                                          size: 36,
                                        )
                                      : Padding(
                                          padding:
                                              const EdgeInsets.only(top: 12.0),
                                          child: Text(
                                            "Barzahlung",
                                            style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    orderTypeNotifier.orderType == 0
                        ? _takeAwayBody()
                        : _deliveryBody(),
                    InkWell(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.95,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          gradient: LinearGradient(
                              colors: [green_dark, green_light],
                              end: Alignment.centerRight,
                              begin: Alignment.centerLeft),
                          image: DecorationImage(
                            image: AssetImage('assets/gemuese.png'),
                            colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.03),
                                BlendMode.dstATop),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Bestellung abschließen!",
                            style: GoogleFonts.raleway(
                                color: white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      onTap: () {
                        bool isValid = false;
                        switch (orderTypeNotifier.orderType) {
                          case 0:
                            if (_formKeyTakeAway.currentState.validate()) {
                              isValid = true;
                            }
                            break;
                          case 1:
                            if (_formKeyDelivery.currentState.validate()) {
                              isValid = true;
                            }
                            break;
                        }
                        if (isValid) {
                          if (openNotifier.isOpened) {
                            if (shoppingCartPrice < 18.0 &&
                                orderTypeNotifier.orderType == 1) {
                              final snackBar = SnackBar(
                                  content: Text(
                                      'Der Mindestbestellwert beträgt 18,00€'));

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else if (shoppingCartPrice == 0 &&
                                orderTypeNotifier.orderType == 0) {
                              final snackBar = SnackBar(
                                  content: Text(
                                      'Sie haben keine Artikel im Warenkorb'));

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else {
                              String firstName = firstNameController.text;
                              String name = nameController.text;
                              String street = streetController.text;
                              String postCode = postCodeController.text;
                              String city = cityController.text;
                              String email = emailController.text;
                              String phone = phoneController.text;
                              String userId = "";
                              List<ShoppingCartItem> cartItems =
                                  cartNotifier.cart.toList();
                              if (userNotifier.isLoggedIn) {
                                userId = user.id;
                              }
                              String orderId = Utils.keyGenerator(5);
                              if (paymentNotifier.paymentType == 0) {
                                Order.makeOrder(
                                    id: orderId,
                                    userId: userId,
                                    price: shoppingCartPrice,
                                    userName: name,
                                    userFirstName: firstName,
                                    userStreet: street,
                                    userPostCode: postCode,
                                    userCity: city,
                                    userEmail: email,
                                    userPhone: phone,
                                    orderType: orderTypeNotifier.orderType,
                                    orderTime: orderTypeNotifier.orderTime,
                                    payed:
                                        paymentNotifier.paymentType.toString(),
                                    foodItems: cartItems);
                                cartNotifier.clearAll();
                                Order.sendMail(email);
                                Order.sendMailToRestaurant(orderId);
                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          ThankYou()),
                                  ModalRoute.withName('/'),
                                );
                              } else {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        PaypalPayment(
                                      price: shoppingCartPrice,
                                      onFinish: (number) async {
                                        if (number.toString() != checkNumber) {
                                          checkNumber = number.toString();
                                          Order.makeOrder(
                                              id: orderId,
                                              userId: userId,
                                              price: shoppingCartPrice,
                                              userName: name,
                                              userFirstName: firstName,
                                              userStreet: street,
                                              userPostCode: postCode,
                                              userCity: city,
                                              userEmail: email,
                                              userPhone: phone,
                                              orderType:
                                                  orderTypeNotifier.orderType,
                                              orderTime:
                                                  orderTypeNotifier.orderTime,
                                              payed: paymentNotifier.paymentType
                                                  .toString(),
                                              foodItems: cartItems);
                                          cartNotifier.clearAll();
                                          Order.sendMail(email);
                                        }
                                      },
                                    ),
                                  ),
                                );
                              }
                            }
                          } else {
                            final snackBar = SnackBar(
                              content: Text(
                                  'Leider haben wir derzeit nicht geöffnet!'),
                            );

                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        }
                      },
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
