// ignore_for_file: avoid_print
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waste_app/shared/constants.dart';
import '../controller/app_cubit/cubit.dart';
import '../controller/app_cubit/states.dart';
import '../model/post_model.dart';
import '../model/user_model.dart';
import '../shared/icon_broken.dart';
import 'chat_details_screen.dart';

//ignore: must_be_immutable
class FeedsScreens extends StatefulWidget {
  const FeedsScreens({Key? key}) : super(key: key);

  @override
  State<FeedsScreens> createState() => _FeedsScreensState();
}

class _FeedsScreensState extends State<FeedsScreens> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WasteAppCubit, WasteAppState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (WasteAppCubit.get(context).posts.isEmpty ||
              WasteAppCubit.get(context).userModel == null) {
            WasteAppCubit.get(context).getUserData();
          }
          return Scaffold(
            body: state is GetUsersPostsLoadingState ||
                    WasteAppCubit.get(context).userModel?.image == null
                ? const Center(
                    child: CupertinoActivityIndicator(),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 5,
                          margin: const EdgeInsets.all(10),
                          child: Image.asset(
                            'images/image1.png',
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        if (WasteAppCubit.get(context).userModel?.image != null)
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => buildPostItem(
                              WasteAppCubit.get(context).posts[index],
                              context,
                              index,
                              // usermodel: WasteAppCubit.get(context).usersData[index]
                            ),
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 10,
                            ),
                            itemCount: WasteAppCubit.get(context).posts.length,
                          ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
          );
        });
  }

  Widget buildPostItem(
    PostModel model,
    context,
    index,
    // {required UserModel usermodel}
  ) =>
      Card(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(
                      '${model.image}',
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${model.name}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Text(
                          '${model.dateTime}',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                ),
                child: Container(
                  height: 1,
                  color: Colors.grey[300],
                ),
              ),
              Text(
                '${model.text}',
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w900,
                ),
              ),
              if (model.postImage != null)
                Padding(
                  padding: const EdgeInsetsDirectional.only(top: 15.0),
                  child: Container(
                    height: 160,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                        image: NetworkImage(
                          '${model.postImage}',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              // const SizedBox(
              //   height: 10,
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(
              //     10.0,
              //   ),
              //   child: Row(
              //     children: [
              //       Expanded(
              //         child: InkWell(
              //           onTap: () {
              //             Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                 builder: (context) => ChatDetailsScreen(
              //                   receiverUserDataModel: usermodel,
              //                 ),
              //               ),
              //             );
              //           },
              //           child: Row(
              //             children: [
              //               const Icon(
              //                 IconBroken.Chat,
              //                 color: defaultColor,
              //               ),
              //               const SizedBox(
              //                 width: 10,
              //               ),
              //               Text(
              //                 'communicate with ${model.name}',
              //                 style: const TextStyle(
              //                   fontWeight: FontWeight.w800,
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      );
}
