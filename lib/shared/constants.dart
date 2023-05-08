// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:waste_app/controller/app_cubit/cubit.dart';
import 'package:waste_app/network/local/cache_helper.dart';
import 'package:waste_app/screens/start_screen.dart';

import '../screens/cateogries_screen.dart';

//ignore: must_be_immutable
dynamic token = '';
dynamic uId;
dynamic subscribe;
const defaultColor = Palette.kToDark;
final controller = TextEditingController();
dynamic rating = 1;

List<Items> item = [
  Items(
    image: 'images/HOUSEHOLD.jpg',
    itemTitle: 'HOUSEHOLD WASTE',
    itemText:
        'Sorting of recoverable and reuse residues from household waste! ',
    url:
        'https://www.citizensinformation.ie/en/environment/waste_and_recycling/domestic_refuse.html',
  ),
  Items(
    image: 'images/WOOD.jpg',
    itemTitle: 'WOOD WASTE',
    itemText: 'Separation of wood waste! ',
    url: 'https://evreka.co/blog/12-simple-and-creative-scrap-wood-projects/',
  ),
  Items(
    image: 'images/PLASTIC.png',
    itemTitle: 'PLASTIC WASTE',
    itemText: 'Sorting and reusing plastics! ',
    url:
        'https://www.fairharborclothing.com/blogs/news/30-ways-to-reuse-plastic',
  ),
  Items(
    image: 'images/PAPER.png',
    itemTitle: 'PAPER WASTE',
    itemText: 'Sort and reuse paper, cardboard and paperboard! ',
    url: 'https://www.wikihow.com/Reuse-Paper',
  ),
];

bool isLoggedIn() {
  return CacheHelper.getData(key: 'uid') != null;
}

AssetImage userImage = const AssetImage(
  'images/user_1.png',
);

Future logout(BuildContext context) async {
  // clear all user data
  WasteAppCubit.get(context).clearUserData();
  // navigate to start page
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => const StartPage(),
    ),
    (Route<dynamic> route) => false,
  );
}

class Palette {
  static const MaterialColor kToDark = MaterialColor(
    0xff2e7b55,
    <int, Color>{
      50: Color(0xff011e50), //10%
      100: Color(0xff3a64b7), //20%
      200: Color(0xff3237a0), //30%
      300: Color(0xff2b5d89), //40%
      400: Color(0xff245d73), //50%
      500: Color(0xff1d485c), //60%
      600: Color(0xffff4a20), //70%
      700: Color(0xff0e1a2e), //80%
      800: Color(0xff070b17), //90%
      900: Color(0xff2e7b55), //100%
    },
  );
}
