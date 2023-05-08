// ignore_for_file: avoid_print
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waste_app/screens/scan_screen.dart';
import '../controller/app_cubit/cubit.dart';
import '../controller/app_cubit/states.dart';
import '../shared/componentes.dart';
import '../shared/icon_broken.dart';

//ignore: must_be_immutable
class SelectedRole extends StatelessWidget {
  const SelectedRole({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WasteAppCubit, WasteAppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = WasteAppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Home',
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(
              20.0,
            ),
            child: Column(
              children: [
                Image.asset(
                  'images/image2.png',
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                  height: 10,
                ),
                OutlinedButton(
                  onPressed: () async {
                    await cubit.subscribe();
                    await cubit.getUserData();
                    await cubit.getUsersData();
                    cubit.userModel!.subscribe = true;
                    FirebaseMessaging.instance.subscribeToTopic(
                      'announcements',
                    );
                    log('User');
                    await cubit.navToHomeScreen(context);
                  },
                  child: const Text(
                    'Start as a User!!',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: () async {
                        await cubit.getUserData();
                        await cubit.getUsersData();
                        cubit.userModel!.subscribe = false;
                        await cubit.unsubscribe(
                          toast: ToastState.ERROR,
                          title: 'Scan QR Code to subscribe as a worker...',
                        );
                        await cubit.getUserData();
                        FirebaseMessaging.instance.unsubscribeFromTopic(
                          'announcements',
                        );
                        log(
                          'Worker',
                        );
                        //كومنت عشان لو عايز اخش ع ال worker من غير م اعمل scan
                        // await cubit.navToHomeScreen(context);
                      },
                      child: const Text(
                        'Scan QR Code!!',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ScanScreen(),
                          ),
                        );
                      },
                      child: const Icon(
                        IconBroken.Scan,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
