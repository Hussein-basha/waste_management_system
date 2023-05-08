// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import '../controller/app_cubit/cubit.dart';
import '../screens/location_screen.dart';
import '../screens/profile_details_screen.dart';
import '../screens/rate_user_screan.dart';
import '../screens/settings_screen.dart';
import 'constants.dart';
import 'icon_broken.dart';

//ignore: must_be_immutable
class NavigationDrawerWidget extends StatefulWidget {
  const NavigationDrawerWidget({Key? key}) : super(key: key);

  @override
  State<NavigationDrawerWidget> createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  bool lights = false;
  final padding = const EdgeInsets.symmetric(
    horizontal: 10,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var userModel = WasteAppCubit.get(context).userModel;
    var cubit = WasteAppCubit.get(context);
    final image = userModel!.image!;
    final name = userModel.name!;
    final email = userModel.email!;
    final phone = userModel.phone!;
    final location = userModel.location!;

    return Drawer(
      child: Material(
        color: defaultColor,
        child: ListView(
          children: <Widget>[
            buildHeader(
              image: image,
              name: name,
              email: email,
              phone: phone,
              location: location,
              onClicked: () {
                WasteAppCubit.get(context).getUserData();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileDetailsScreen(),
                  ),
                );
              },
            ),
            Divider(
              color: Colors.grey[400],
              thickness: 2,
              indent: 10,
              endIndent: 10,
            ),
            Container(
              padding: padding,
              child: Column(
                children: [
                  buildMenuItem(
                    text: 'Settings',
                    text2: 'Update your information',
                    icon: IconBroken.Setting,
                    onClicked: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingsScreen(),
                        ),
                      );
                    },
                  ),
                  if (cubit.userModel!.subscribe == true)
                    buildMenuItem(
                      text: 'Location',
                      text2: 'Defines the region',
                      icon: IconBroken.Location,
                      onClicked: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LocationScreen(),
                          ),
                        );
                      },
                    ),
                  if (cubit.userModel!.subscribe == true)
                    buildMenuItem(
                      text: 'Rate Us',
                      text2: 'Rate our app',
                      icon: IconBroken.Star,
                      onClicked: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RateUserScrean(),
                          ),
                        );
                      },
                    ),
                  buildMenuItem(
                    text: 'Share App',
                    text2: 'Share app with other',
                    icon: Icons.share,
                    onClicked: () {},
                  ),
                  buildMenuItem(
                    text: 'About Us',
                    text2: 'About Salla app',
                    icon: IconBroken.Info_Circle,
                    onClicked: () {},
                  ),
                  buildMenuItem(
                    text: 'Sign Out',
                    text2: 'Logout From the app',
                    icon: Icons.logout_rounded,
                    onClicked: () {
                      logout(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader({
    required String image,
    required String name,
    required String email,
    required String phone,
    required String location,
    required VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: padding.add(
            const EdgeInsets.symmetric(
              vertical: 40,
            ),
          ),
          child: Row(
            children: [
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 59,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 55,
                      backgroundImage: NetworkImage(
                        image,
                      ),
                    ),
                  ),
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    email,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    phone,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    location,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
      );

  Widget buildMenuItem({
    required String text,
    required String text2,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    const hoverColor = Colors.white;
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.white,
        size: 25,
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          Text(
            text2,
            style: TextStyle(
              // fontSize: ,
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }
}
