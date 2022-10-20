import 'dart:math';
import 'package:Aroma/model/food.dart';
import 'package:Aroma/model/indigrends.dart';
import 'package:Aroma/model/user.dart';
import 'package:Aroma/notifier/opening_notifier.dart';
import 'package:Aroma/widgets/categoryItem.dart';
import 'package:Aroma/widgets/foodItem.dart';
import 'package:Aroma/widgets/foodScreenCategoryGroupItem.dart';
import 'package:Aroma/widgets/foodScreenCategoryItem.dart';
import 'package:Aroma/widgets/shoppingCartItem.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Utils {
  static const double DEHSPIESS_TOPBAR_SCROLLOFFSET = 0;
  static const double PIZZA_TOPBAR_SCROLLOFFSET = 157;
  static const double PASTA_TOPBAR_SCROLLOFFSET = 314;
  static const double SCHNITZEL_TOPBAR_SCROLLOFFSET = 471;
  static const double SALAT_TOPBAR_SCROLLOFFSET = 628;
  static const double BURGER_TOPBAR_SCROLLOFFSET = 785;
  //static const double BURGER_TOPBAR_SCROLLOFFSET = 785;
  static const double IMBISS_TOPBAR_SCROLLOFFSET = 650;
  //static const double IMBISS_TOPBAR_SCROLLOFFSET = 935;
  static const double SWEETS_TOPBAR_SCROLLOFFSET = 993;
  //static const double GETRAENKE_TOPBAR_SCROLLOFFSET = 993;
  static const double GETRAENKE_TOPBAR_SCROLLOFFSET = 700;

  static const String RESTAURANT_EMAIL = "kontakt@aroma-siegen.de";

  static Future<bool> isRestaurantOpened(BuildContext context) async {
    DateFormat dateFormat = new DateFormat.Hm();
    var notifier = Provider.of<OpeningNotifier>(context, listen: false);
    DateTime currentTimeStamp = DateTime.now();

    DateTime current = new DateTime(
        currentTimeStamp.year,
        currentTimeStamp.month,
        currentTimeStamp.day,
        currentTimeStamp.hour,
        currentTimeStamp.minute);

    DateTime open = dateFormat.parse("11:00");
    open = new DateTime(currentTimeStamp.year, currentTimeStamp.month,
        currentTimeStamp.day, open.hour, open.minute);
    DateTime close = dateFormat.parse("21:30");
    close = new DateTime(currentTimeStamp.year, currentTimeStamp.month,
        currentTimeStamp.day, close.hour, close.minute);
    if (current.isAfter(open) &&
        (close.difference(current) >= Duration(minutes: 30))) {
      if (await User.isStoreOpened()) {
        notifier.setIsOpened(true);
        return true;
      } else {
        notifier.setIsOpened(false);
        return false;
      }
    } else {
      notifier.setIsOpened(false);
      return false;
    }
  }

  static String idGenerator() {
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();
    String startString = "#Aroma";
    String getRandomString(int length) =>
        String.fromCharCodes(Iterable.generate(
            length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

    return startString = startString +
        getRandomString(3) +
        "#" +
        getRandomString(15) +
        "#" +
        getRandomString(15);
  }

  static String keyGenerator(int count) {
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();
    String getRandomString(int length) =>
        String.fromCharCodes(Iterable.generate(
            length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

    return getRandomString(count);
  }

  static bool isValidPostCode(String postCode) {
    switch (postCode) {
      case "57072":
        return true;
        break;
      case "57074":
        return true;
        break;
      case "57080":
        return true;
        break;
      case "57555":
        return true;
        break;
      case "57076":
        return true;
        break;
      default:
        return false;
    }
  }

  static final foodScreenCategoryList = [
    FoodScreenCategoryItem(
        image: "assets/lahmacun1.png",
        title: "Kebap & Gerolltes",
        subTitle: "orientalisches",
        index: Food.DREHSPIESS),
    FoodScreenCategoryItem(
        image: "assets/championsleague.png",
        title: "Pizza",
        subTitle: "Steinofen",
        index: Food.PIZZA),
    FoodScreenCategoryItem(
        image: "assets/gnocchi.png",
        title: "Pastagerichte",
        subTitle: "aromatische",
        index: Food.PASTA),
    FoodScreenCategoryItem(
        image: "assets/achenbacher.png",
        title: "Schnitzel",
        subTitle: "leckere",
        index: Food.SCHNITZEL),
    FoodScreenCategoryItem(
        image: "assets/aroma-salat.png",
        title: "Salatgerichte",
        subTitle: "frische",
        index: Food.SALAT),
    /*FoodScreenCategoryItem(
        image: "assets/burger_neu.png",
        title: "Burger",
        subTitle: "saftige",
        index: Food.BURGER),*/
    FoodScreenCategoryItem(
        image: "assets/currywurst-pommes.png",
        title: "Imbiss",
        subTitle: "bürgerlicher",
        index: Food.IMBISS),
    /*FoodScreenCategoryItem(
        image: "assets/getraenke.png",
        title: "Süßes und Saures",
        subTitle: "",
        index: Food.IMBISS),*/
    FoodScreenCategoryItem(
        image: "assets/getraenke_neu.png",
        title: "Getränke",
        subTitle: "erfrischende",
        index: Food.GETRAENKE),
  ];
  static final categoryList = [
    CategoryItem(
        image: "assets/lahmacun1.png",
        title: "Kebap & Gerolltes",
        subTitle: "orientalisches",
        isPromoted: false,
        isImplemented: true,
        animate: true,
        index: Food.DREHSPIESS),
    CategoryItem(
        image: "assets/championsleague.png",
        title: "Pizza",
        subTitle: "Steinofen",
        isPromoted: false,
        isImplemented: true,
        animate: true,
        index: Food.PIZZA),
    /*CategoryItem(
        title: "Angebot für dich",
        subTitle: "Unser",
        isPromoted: true,
        isImplemented: false,
        animate: false,
        index: Food.PROMOTED),*/
    CategoryItem(
        image: "assets/gnocchi.png",
        title: "Pastagerichte",
        subTitle: "aromatische",
        isPromoted: false,
        isImplemented: true,
        animate: true,
        index: Food.PASTA),
    CategoryItem(
        image: "assets/achenbacher.png",
        title: "Schnitzel",
        subTitle: "leckere",
        isPromoted: false,
        isImplemented: true,
        animate: false,
        index: Food.SCHNITZEL),
    CategoryItem(
        image: "assets/aroma-salat.png",
        title: "Salatgerichte",
        subTitle: "frische",
        isPromoted: false,
        isImplemented: true,
        animate: true,
        index: Food.SALAT),
    /*CategoryItem(
        image: "assets/burger_neu.png",
        title: "Burger",
        subTitle: "saftige",
        isPromoted: false,
        isImplemented: true,
        animate: false,
        index: Food.BURGER),*/
    CategoryItem(
        image: "assets/currywurst-pommes.png",
        title: "Imbiss",
        subTitle: "bürgerlicher",
        isPromoted: false,
        isImplemented: true,
        animate: false,
        index: Food.IMBISS),
    /*CategoryItem(
        //image: "assets/Teller_04.png",
        title: "Süßes & Saures",
        subTitle: "",
        isPromoted: false,
        isImplemented: true,
        animate: false,
        index: Food.SWEETS),*/
    CategoryItem(
        image: "assets/getraenke_neu.png",
        title: "Getränke",
        subTitle: "erfrischende",
        isPromoted: false,
        isImplemented: true,
        animate: false,
        index: Food.GETRAENKE),
    CategoryItem(
        image: "",
        title: "",
        subTitle: "",
        isPromoted: false,
        isImplemented: true,
        animate: false,
        index: null),
  ];

  static final foodScreencategoryGroupList = [
    FoodScreenCategoryGroupItem(
        image: "assets/lahmacun1.png",
        title: "Kebap & Gerolltes",
        subTitle: "orientalisches",
        index: Food.DREHSPIESS),
    FoodScreenCategoryGroupItem(
        image: "assets/championsleague.png",
        title: "Pizza",
        subTitle: "Steinofen",
        index: Food.PIZZA),
    FoodScreenCategoryGroupItem(
        image: "assets/gnocchi.png",
        title: "Pastagerichte",
        subTitle: "aromatische",
        index: Food.PASTA),
    FoodScreenCategoryGroupItem(
        image: "assets/achenbacher.png",
        title: "Schnitzel",
        subTitle: "leckere",
        index: Food.SCHNITZEL),
    FoodScreenCategoryGroupItem(
        image: "assets/aroma-salat.png",
        title: "Salatgerichte",
        subTitle: "frische",
        index: Food.SALAT),
    /*FoodScreenCategoryGroupItem(
        image: "assets/burger_neu.png",
        title: "Burger",
        subTitle: "saftige",
        index: Food.BURGER),*/
    FoodScreenCategoryGroupItem(
        image: "assets/currywurst-pommes.png",
        title: "Imbiss",
        subTitle: "bürgerlicher",
        index: Food.IMBISS),
    /*FoodScreenCategoryGroupItem(
        image: "assets/currywurst-pommes.png",
        title: "Süßes & Saures",
        subTitle: "",
        index: Food.SWEETS),*/
    FoodScreenCategoryGroupItem(
        image: "assets/getraenke_neu.png",
        title: "Getränke",
        subTitle: "erfrischende",
        index: Food.GETRAENKE),
  ];

  static double calcFoodItemPrice(
      int quantity, FoodItem foodItem, List<dynamic> choosenIndigrends) {
    double price;
    if (foodItem.isSmall) {
      price = foodItem.priceSmall;
    } else {
      price = foodItem.price;
    }

    double indigrendsPrice = 0.0;
    if (choosenIndigrends != null) {
      if (choosenIndigrends.length > 0) {
        choosenIndigrends.sort((a, b) => a.category.compareTo(b.category));
        for (Indigrends actualIndigrend in choosenIndigrends) {
          if (foodItem.category == Food.DREHSPIESS) {
            if (actualIndigrend == choosenIndigrends[0] &&
                actualIndigrend.category == 0) {
              continue;
            }
          }
          indigrendsPrice += actualIndigrend.price;
        }
      }
    }
    return quantity * (price + indigrendsPrice);
  }

  static double calcShoppingCartItemPrice(int quantity,
      ShoppingCartItem shoppingCartItem, List<dynamic> choosenIndigrends) {
    double price;
    if (shoppingCartItem.isSmall) {
      price = shoppingCartItem.foodItem.priceSmall;
    } else {
      price = shoppingCartItem.foodItem.price;
    }

    double indigrendsPrice = 0.0;
    if (choosenIndigrends != null) {
      if (choosenIndigrends.length > 0) {
        choosenIndigrends.sort((a, b) => a.category.compareTo(b.category));
        for (Indigrends actualIndigrend in choosenIndigrends) {
          if (shoppingCartItem.foodItem.category == Food.DREHSPIESS) {
            if (actualIndigrend == choosenIndigrends[0] &&
                actualIndigrend.category == 0) {
              continue;
            }
          }
          indigrendsPrice += actualIndigrend.price;
        }
      }
    }
    return quantity * (price + indigrendsPrice);
  }

  static double calcIndigrendsPrice(ShoppingCartItem shoppingCartItem) {
    double price = 0.00;
    List<dynamic> choosenIndigrends = shoppingCartItem.choosenIndigrends;
    if (choosenIndigrends != null) {
      if (choosenIndigrends.length > 0) {
        choosenIndigrends.sort((a, b) => a.category.compareTo(b.category));
        if (shoppingCartItem.foodItem.category == Food.DREHSPIESS) {
          for (Indigrends actualIndigrend in choosenIndigrends) {
            if (actualIndigrend.category == 0 &&
                actualIndigrend == choosenIndigrends[0]) {
              continue;
            } else {
              price += actualIndigrend.price;
            }
          }
        } else {
          for (Indigrends actualIndigrend in choosenIndigrends) {
            price += actualIndigrend.price;
          }
        }
      }
    }
    return price;
  }

  static double calcShoppingCartPrice(List<ShoppingCartItem> foodMap) {
    double price = 0.00;
    for (ShoppingCartItem value in foodMap) {
      double indigrendsPrice = calcIndigrendsPrice(value);
      double calc;
      if (value.isSmall != null) {
        if (value.isSmall) {
          calc = value.foodItem.priceSmall;
        } else {
          calc = value.foodItem.price;
        }
      } else {
        calc = value.foodItem.price;
      }

      int quantity = value.quantity;
      price += (calc + indigrendsPrice) * quantity;
    }
    return price;
  }

  static double calcShoppingCartSalePrice(
      double shoppingCartPrice, int discount) {
    return shoppingCartPrice * ((100 - discount) / 100);
  }

  static double calcShoppingCartDiscount(
    double shoppingCartPrice,
    int discount,
  ) {
    return shoppingCartPrice * (discount / 100);
  }

  static List<Indigrends> getIndigrends(
      int category, List<Indigrends> indigrendsList, FoodItem foodItem) {
    switch (category) {
      case Food.DREHSPIESS:
        if (foodItem.index < 11) {
          return indigrendsList
              .where((element) =>
                  element.category == 1 ||
                  element.category == 3 ||
                  element.category == 7)
              .toList();
        } else {
          return indigrendsList
              .where((element) =>
                  element.category == 1 ||
                  element.category == 3 ||
                  element.category == 8)
              .toList();
        }
        break;
      case Food.PASTA:
        break;
      case Food.PIZZA:
        if (foodItem.index == 44) {
          return indigrendsList
              .where((element) => element.category == 9)
              .toList();
        } else {
          return indigrendsList
              .where((element) => element.category == 4)
              .toList();
        }
        break;
      case Food.IMBISS:
        return indigrendsList
            .where((element) => element.category == 0 || element.category == 3)
            .toList();
        break;
      case Food.SALAT:
        return indigrendsList
            .where((element) => element.category == 4)
            .toList();
        break;
      case Food.SCHNITZEL:
        return indigrendsList
            .where((element) =>
                element.id == 11 || element.id == 15 || element.category == 3)
            .toList();
        break;
      case Food.GETRAENKE:
        break;
      default:
    }
  }

  static List<Indigrends> getSauces(
      int category, List<Indigrends> indigrendsList) {
    switch (category) {
      case Food.DREHSPIESS:
        return indigrendsList
            .where((element) => element.category == 0)
            .toList();
        break;
      case Food.PASTA:
        break;
      case Food.PIZZA:
        return indigrendsList
            .where((element) => element.category == 0)
            .toList();
        break;
      case Food.IMBISS:
        break;
      case Food.SALAT:
        return indigrendsList
            .where((element) => element.category == 2)
            .toList();
        break;
      case Food.SCHNITZEL:
        return indigrendsList
            .where((element) =>
                element.category == 6 || element.id == 1 || element.id == 2)
            .toList();
        break;
      case Food.GETRAENKE:
        break;
      default:
    }
  }
}
