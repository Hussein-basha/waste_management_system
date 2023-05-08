// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../screens/start_screen.dart';
import 'constants.dart';

//ignore: must_be_immutable
Widget backBottom({context}) => TextButton(
      onPressed: () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const StartPage(),
          ),
          (Route<dynamic> route) => false,
        );
      },
      child: const Text(
        'BACK',
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w900,
          color: Colors.white,
        ),
      ),
    );

//ignore: must_be_immutable
Widget defaultButton({
  double height = 50,
  double width = double.infinity,
  Color background = defaultColor,
  double radius = 25.0,
  bool isUpperCase = true,
  required Function function,
  required String? text,
}) =>
    Container(
      width: width,
      height: height,
      child: MaterialButton(
        onPressed: () {
          function();
        },
        // onPressed: function,
        child: Text(
          isUpperCase ? text!.toUpperCase() : text!,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,
      ),
    );

Widget defaultClickedButton(
    {required Function() onTap,
    required Widget contentWidget,
    double height = 50,
    double? minWidth,
    dynamic padding,
    Color backgroundColor = defaultColor,
    dynamic roundedRectangleBorder}) {
  return MaterialButton(
    onPressed: onTap,
    height: height,
    minWidth: minWidth,
    padding: padding,
    elevation: 0,
    color: backgroundColor,
    shape: roundedRectangleBorder,
    child: contentWidget,
  );
}

Widget defaultTextFormField({
  required TextEditingController controller,
  required TextInputType type,
  required validate,
  onSubmit,
  required String? label,
  required IconData? prefix,
  Function? suffixPressed,
  bool isPassword = false,
  IconData? suffix,
  fillColor = Colors.white,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: onSubmit,
      validator: validate,
      obscureText: isPassword,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(
            25.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(
            25.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(
            25.0,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(
            25.0,
          ),
        ),
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: () {
                  suffixPressed!();
                },
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: const OutlineInputBorder(),
      ),
    );

void showToast({
  required String text,
  required ToastState state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

enum ToastState { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastState state) {
  Color color;
  switch (state) {
    case ToastState.SUCCESS:
      color = Colors.green;
      break;
    case ToastState.ERROR:
      color = Colors.red;
      break;
    case ToastState.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    debugPrint(
      size.width.toString(),
    );
    var path = Path();
    path.lineTo(
      0,
      size.height,
    );
    // start path with this if you are making
    var firstStart = Offset(
      size.width / 7,
      size.height,
    );
    // fist point of quadratic bezier curve
    var firstEnd = Offset(
      size.width / 3,
      size.height - 40.0,
    );
    // second point of quadratic bezier curve
    path.quadraticBezierTo(
      firstStart.dx,
      firstStart.dy,
      firstEnd.dy,
      firstEnd.dy,
    );
    var secondStart = Offset(
      size.width - (size.width / 4),
      size.height - 100,
    );
    // third point of quadratic bezier curve
    var secondEnd = Offset(
      size.width,
      size.height - 0,
    );
    // fourth point of quadratic bezier curve
    path.quadraticBezierTo(
      secondStart.dx,
      secondStart.dy,
      secondEnd.dx,
      secondEnd.dy,
    );
    path.lineTo(
      size.width,
      0,
    );
    // end with this path if you are making
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
// TODO: implement shouldReclip
    return true;
  }
}
