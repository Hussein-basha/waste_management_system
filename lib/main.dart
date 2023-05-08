// ignore_for_file: avoid_print
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waste_app/screens/on_boarding_screen.dart';
import 'package:waste_app/screens/selected_role.dart';
import 'package:waste_app/screens/start_screen.dart';
import 'package:waste_app/shared/constants.dart';
import 'controller/app_cubit/cubit.dart';
import 'network/bloc_observer/bloc_observer.dart';
import 'network/local/cache_helper.dart';

//ignore: must_be_immutable
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp();
  await CacheHelper.init();

  Widget widget;

  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  uId = CacheHelper.getData(key: 'uid');

  if (onBoarding != null) {
    if (uId != null) {
      widget = const SelectedRole();
    } else {
      widget = const StartPage();
    }
  } else {
    widget = const OnBoardingScreen();
  }

  runApp(MyApp(startWidget: widget));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  const MyApp({Key? key, required this.startWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => WasteAppCubit()..getPosts(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Palette.kToDark,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            elevation: 0.0,
            backgroundColor: Colors.white,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
            ),
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
            centerTitle: true,
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: defaultColor,
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            unselectedItemColor: Colors.grey[400],
            type: BottomNavigationBarType.fixed,
            selectedItemColor: defaultColor,
            backgroundColor: Colors.white,
            elevation: 20.0,
          ),
        ),
        home: startWidget,
      ),
    );
  }
}
