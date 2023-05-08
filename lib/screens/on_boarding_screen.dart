// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:waste_app/screens/start_screen.dart';
import '../network/local/cache_helper.dart';
import '../shared/constants.dart';
import '../shared/icon_broken.dart';

//ignore: must_be_immutable
class BoardingModel {
  final String image;
  final String title;
  final String page;

  BoardingModel({
    required this.image,
    required this.title,
    required this.page,
  });
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
      image: "images/on_boared_1.jpeg",
      title: 'On Board_1 Title',
      page: 'On Board_1 Page',
    ),
    BoardingModel(
      image: 'images/on_boared_2.jpeg',
      title: 'On Board_2 Title',
      page: 'On Board_2 Page',
    ),
    BoardingModel(
      image: 'images/on_boared_3.jpeg',
      title: 'On Board_3 Title',
      page: 'On Board_3 Page',
    ),
  ];

  bool isLast = false;

  void submit() {
    CacheHelper.saveData(
      val: true,
      key: 'onBoarding',
    ).then((value) {
      if (value) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const StartPage(),
          ),
          (Route<dynamic> route) => false,
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              submit();
            },
            child: const Text(
              'SKIP',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w900,
                color: defaultColor,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: boardController,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey[500]!,
                    dotHeight: 10,
                    dotWidth: 10,
                    spacing: 5.0,
                    expansionFactor: 4,
                    activeDotColor: defaultColor,
                  ),
                  count: boarding.length,
                ),
                const Spacer(),
                FloatingActionButton(
                  mini: false,
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      boardController.nextPage(
                        duration: const Duration(
                          microseconds: 800,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: const Icon(
                    IconBroken.Arrow___Right_2,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage(model.image),
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          Text(
            model.title,
            style: const TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              color: defaultColor,
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          Text(
            model.page,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: defaultColor,
            ),
          ),
        ],
      );
}
