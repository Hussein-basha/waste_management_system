// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waste_app/screens/selected_role.dart';
import 'package:waste_app/shared/constants.dart';
import '../controller/app_cubit/cubit.dart';
import '../controller/app_cubit/states.dart';
import '../map/map_worker.dart';
import '../shared/drawer.dart';
import '../shared/icon_broken.dart';

//ignore: must_be_immutable
class WestAppLayout extends StatelessWidget {
  const WestAppLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WasteAppCubit, WasteAppState>(
      listener: (context, state) async {
        WasteAppCubit.get(context).userModel;
      },
      builder: (context, state) {
        var cubit = WasteAppCubit.get(context);
        // get user data
        if (cubit.userModel == null) {
          cubit.getUserData();
        }
        if (cubit.userModel!.subscribe == true) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                cubit.titles[cubit.currentIndex],
              ),
            ),
            drawer:
                cubit.userModel != null ? const NavigationDrawerWidget() : null,
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeBottomScreen(index);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Home,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Category,
                  ),
                  label: 'Recycling Category',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Paper_Upload,
                  ),
                  label: 'Post',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Message,
                  ),
                  label: 'Chats',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Location,
                  ),
                  label: 'Baskets Location',
                ),
              ],
            ),
          );
        } else if (cubit.userModel!.subscribe == false) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                "Worker",
              ),
              elevation: 0.0,
              backgroundColor: Colors.white,
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark,
              ),
              titleTextStyle: const TextStyle(
                color: Colors.black,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
              centerTitle: true,
              iconTheme: const IconThemeData(
                color: Colors.black,
              ),
            ),
            drawer: WasteAppCubit.get(context).userModel != null
                ? const NavigationDrawerWidget()
                : null,
            floatingActionButton: FloatingActionButton(
              backgroundColor: defaultColor,
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const MapWorkerWasteManagementSystem(),
                  ),
                  (Route<dynamic> route) => false,
                );
              },
              child: const Icon(
                IconBroken.Location,
                size: 30,
                color: Colors.black,
              ),
            ),
          );
        } else {
          return const SelectedRole();
        }
      },
    );
  }
}
