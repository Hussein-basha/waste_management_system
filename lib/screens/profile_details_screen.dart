// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controller/app_cubit/cubit.dart';
import '../controller/app_cubit/states.dart';
import '../shared/icon_broken.dart';

//ignore: must_be_immutable
class ProfileDetailsScreen extends StatefulWidget {
  const ProfileDetailsScreen({Key? key}) : super(key: key);

  @override
  State<ProfileDetailsScreen> createState() => _ProfileDetailsScreenState();
}

class _ProfileDetailsScreenState extends State<ProfileDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WasteAppCubit, WasteAppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = WasteAppCubit.get(context);
        WasteAppCubit.get(context).getUserData();
        var userModel = WasteAppCubit.get(context).userModel;
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () async {
                await cubit.getUserData();
                await cubit.getUsersData();
                Navigator.pop(context);
              },
              icon: const Icon(
                IconBroken.Arrow___Left_2,
              ),
            ),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(
                8.0,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 420,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              height: 160,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(
                                    4.0,
                                  ),
                                  topRight: Radius.circular(
                                    4.0,
                                  ),
                                ),
                                image: DecorationImage(
                                  image: AssetImage(
                                    'images/img2.jpg',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          CircleAvatar(
                            radius: 120,
                            backgroundImage: NetworkImage(
                              '${userModel!.image}',
                            ),
                          ),
                        ],
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
                      '${userModel.email}',
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
                    if (userModel.subscribe == true)
                      const Text(
                        'Subscribed as a user',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 17,
                        ),
                      )
                    else
                      const Text(
                        'Subscribed as a worker',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 17,
                        ),
                      ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (userModel.comment != null && userModel.subscribe == true)
                      Text(
                        '${userModel.comment}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 17,
                        ),
                      )
                    else
                      Text(
                        'Give Your Feedback',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15.0,
                          color: Colors.grey[600],
                        ),
                      ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (userModel.comment != null && userModel.subscribe == true)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${userModel.rate}  Stars',
                            style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 17,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                        ],
                      )
                    else
                      Text(
                        'Rate the Application',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15.0,
                          color: Colors.grey[600],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
