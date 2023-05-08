// ignore_for_file: avoid_print
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../controller/app_cubit/cubit.dart';
import '../shared/componentes.dart';
import '../shared/constants.dart';
import '../shared/icon_broken.dart';
import 'all_rates_screen.dart';
import 'home_screen.dart';

//ignore: must_be_immutable
class RateUserScrean extends StatefulWidget {
  const RateUserScrean({Key? key}) : super(key: key);

  @override
  State<RateUserScrean> createState() => _RateUserScreanState();
}

class _RateUserScreanState extends State<RateUserScrean> {
  final controller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  dynamic rating = 1;
  late Image image2;

  @override
  void initState() {
    super.initState();
    image2 = Image.asset(
      'images/img3.png',
    );
  }

  addRateToUser() async {
    final firestore = FirebaseFirestore.instance.collection('users');
    firestore
        .where('email', isEqualTo: WasteAppCubit.get(context).userModel?.email!)
        .get()
        .then(
      (value) async {
        if (value.docs.isNotEmpty) {
          await firestore.doc(value.docs.first.id).update(
              {"comment": controller.text.trim(), "rate": "$rating"}).then(
            (value) {
              showToast(
                text: 'Your rating added successfully . Thank You .',
                state: ToastState.SUCCESS,
              );
            },
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Rate US',
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            IconBroken.Arrow___Left_2,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(
          20,
        ),
        children: [
          Image.asset(
            'images/img3.png',
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            '\t\tWrite your opinion ....',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.all(
              10,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(
                30,
              ),
            ),
            child: Form(
              key: formKey,
              child: TextFormField(
                controller: controller,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'comment required *';
                  }
                  return null;
                },
                decoration: const InputDecoration(border: InputBorder.none),
                maxLines: 4,
                maxLength: 500,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Spacer(),
              RatingBar.builder(
                initialRating: 1,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 30,
                itemPadding: const EdgeInsets.symmetric(
                  horizontal: 4.0,
                ),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (r) {
                  setState(() {
                    if (r < 1) {
                      rating = 1;
                    } else {
                      rating = r;
                    }
                  });
                },
              ),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          defaultButton(
            text: 'Send',
            background: defaultColor,
            function: () async {
              formKey.currentState!.validate();
              if (formKey.currentState!.validate()) {
                await addRateToUser().then(
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WestAppLayout(),
                    ),
                    (Route<dynamic> route) => false,
                  ),
                );
              } else {
                showToast(
                  text: 'comment required!!',
                  state: ToastState.ERROR,
                );
              }
            },
          ),
          const SizedBox(
            height: 15,
          ),
          OutlinedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AllRatesScreen(),
                ),
              );
            },
            child: const Text(
              'Show All Rates',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 17,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
