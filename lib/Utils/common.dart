import 'package:flutter/material.dart';

import '../Model/category.dart';

const int tableNo = 32;

//const String serverName = "http://192.168.2.157/";
//const String serverName = "http://192.168.23.49/";
//const String serverName = "http://192.168.23.56/";
const String serverName = "http://192.168.14.223/";

const Color shoppingCartBackgroundColor = Colors.white;
const Color drinkItemColor = Colors.white;
const Color primaryColor = Colors.blueGrey;

const List<int> singleSizeProducts = [
  Category.cocktailsWithAlc,
  Category.cocktailsWithoutAlc,
  Category.softdrinks,
  Category.juice,
  Category.energy,
  Category.iceTea,
  Category.homemadeIceTea,
  Category.milkshakes,
  Category.shots,
  Category.spirits,
  Category.aperitiv,
  Category.beer,
  Category.coffeeAndHot,
  Category.tea,
  Category.packages,
];

const List<int> discountProducts = [
  88,
  89,
  90,
  91,
  92,
  119,
  120,
  121,
  122,
  123
];
const List<int> productsWithAdditionalIndigrends = [
  1,
  2,
  3,
  4,
  5,
  6,
  7,
  8,
  9,
  10,
  11,
  119,
  120,
  121,
  122,
  123,
  124,
  125,
  126,
  127,
  129,
  131,
  132,
  133,
  134,
  149,
  150,
  151
];
const List<int> juiceProducts = [2, 4, 11, 132, 149];
const List<int> softDrinkProducts = [
  1,
  3,
  5,
  6,
  7,
  9,
  134,
  124,
  129,
  130,
  122,
  123,
  151
];
const List<int> energyProducts = [8, 10, 133, 125, 150];
const List<int> energyAndJuiceProducts = [131, 127, 119, 120, 121];
