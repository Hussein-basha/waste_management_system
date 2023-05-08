// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:waste_app/screens/register_screen.dart';
import 'package:waste_app/screens/user_login_screen.dart';
import 'package:waste_app/shared/componentes.dart';
import 'package:waste_app/shared/constants.dart';

//ignore: must_be_immutable
class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'images/login2.png',
              height: 350,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            defaultButton(
              function: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserLoginScreen(),
                  ),
                  (Route<dynamic> route) => false,
                );
              },
              text: 'Login',
              width: 300,
              isUpperCase: true,
              background: defaultColor,
            ),
            const SizedBox(
              height: 20,
            ),
            defaultButton(
              function: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RegisterScreen(),
                  ),
                  (Route<dynamic> route) => false,
                );
              },
              text: 'Create an Account',
              width: 300,
              isUpperCase: true,
              background: defaultColor,
            ),
            // defaultButton(
            //   function: () {
            //     Navigator.pushAndRemoveUntil(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => UserLoginScreen(),
            //       ),
            //       (Route<dynamic> route) => false,
            //     );
            //   },
            //   text: 'User',
            //   width: 300,
            //   background: defaultColor,
            // ),
            // const SizedBox(
            //   height: 15.0,
            // ),
            // defaultButton(
            //   function: () {
            //     Navigator.pushAndRemoveUntil(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => WorkerLoginScreen(),
            //       ),
            //       (Route<dynamic> route) => false,
            //     );
            //   },
            //   text: 'Worker',
            //   width: 300,
            //   isUpperCase: true,
            //   background: defaultColor,
            // ),
          ],
        ),
      ),
    );
  }
}
