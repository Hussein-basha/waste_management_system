// ignore_for_file: avoid_print
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:waste_app/shared/componentes.dart';
import '../controller/app_cubit/cubit.dart';
import '../shared/icon_broken.dart';

//ignore: must_be_immutable
class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  var getResult = 'QR Code Result';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'QR Scanner',
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                scanQRCode();
              },
              child: const Text(
                'Scan QR',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            if (getResult == 'waste_app_7_14')
              Text(
                'QR Code true => $getResult',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            const SizedBox(
              height: 20.0,
            ),
            if (getResult == 'waste_app_7_14')
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: () async {
                      await WasteAppCubit.get(context).getUserData();
                      await WasteAppCubit.get(context).getUsersData();
                      WasteAppCubit.get(context).userModel!.subscribe = false;
                      await WasteAppCubit.get(context).unsubscribe(
                        toast: ToastState.SUCCESS,
                        title: 'your are now subscribe as a worker...',
                      );
                      await WasteAppCubit.get(context).getUserData();
                      FirebaseMessaging.instance.unsubscribeFromTopic(
                        'announcements',
                      );
                      log(
                        'Worker',
                      );
                      await WasteAppCubit.get(context).navToHomeScreen(context);
                    },
                    child: const Text(
                      'Start as a Worker!!',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  void scanQRCode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      );
      if (!mounted) return;
      setState(() {
        getResult = qrCode;
      });
      print(
        "QRCode_Result:--",
      );
      print(qrCode);
    } on PlatformException {
      getResult = 'Failed to scan QR Code.';
    }
  }
}
