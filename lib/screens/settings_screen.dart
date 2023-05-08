// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controller/app_cubit/cubit.dart';
import '../controller/app_cubit/states.dart';
import '../shared/componentes.dart';
import '../shared/constants.dart';
import '../shared/icon_broken.dart';
import 'edit_profile_screen.dart';

//ignore: must_be_immutable
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WasteAppCubit, WasteAppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = WasteAppCubit.get(context).userModel;
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                IconBroken.Arrow___Left_2,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(
              20.0,
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 70,
                  backgroundImage: NetworkImage(
                    '${userModel!.image}',
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Text(
                  '${userModel.name}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '${userModel.phone}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '${userModel.location}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 17,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        child: const Text(
                          'Edit Profile',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProfileScreen(),
                          ),
                        );
                      },
                      child: const Icon(
                        IconBroken.Edit,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                defaultButton(
                  background: defaultColor,
                  function: () {
                    logout(context);
                  },
                  text: 'Logout',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
