// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waste_app/controller/app_cubit/cubit.dart';
import '../controller/app_cubit/states.dart';
import '../shared/constants.dart';
import '../shared/icon_broken.dart';

//ignore: must_be_immutable
class NewPostScreen extends StatelessWidget {
  NewPostScreen({Key? key}) : super(key: key);

  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WasteAppCubit, WasteAppState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  if (state is WasteAppCreatePostLoadingState)
                    const LinearProgressIndicator(),
                  if (state is WasteAppCreatePostLoadingState)
                    const SizedBox(
                      height: 10,
                    ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(
                          '${WasteAppCubit.get(context).userModel!.image}',
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        '${WasteAppCubit.get(context).userModel!.name}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const Spacer(),
                      OutlinedButton(
                        onPressed: () {
                          WasteAppCubit.get(context).getPosts();
                          var now = DateTime.now();
                          if (WasteAppCubit.get(context).postImage == null) {
                            WasteAppCubit.get(context)
                                .createPost(
                              dateTime: now.toString(),
                              text: textController.text,
                            )
                                .then((value) {
                              textController.text = '';
                              WasteAppCubit.get(context).postImage = null;
                            });
                          } else {
                            WasteAppCubit.get(context)
                                .uploadPostImage(
                              dateTime: now.toString(),
                              text: textController.text,
                            )
                                .then((value) {
                              textController.text = '';
                              WasteAppCubit.get(context).postImage = null;
                            });
                          }
                          textController.text = "";
                          WasteAppCubit.get(context).postImage = null;
                        },
                        child: const Text(
                          'Post',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: textController,
                      decoration: const InputDecoration(
                        hintText: 'What do you want to publish ...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (WasteAppCubit.get(context).postImage != null)
                    Expanded(
                      child: Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          Container(
                            height: 160,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                5,
                              ),
                              image: DecorationImage(
                                image: FileImage(
                                  WasteAppCubit.get(context).postImage!,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: defaultColor,
                            child: IconButton(
                              onPressed: () {
                                WasteAppCubit.get(context).removePostImage();
                              },
                              icon: const Icon(
                                Icons.close,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            WasteAppCubit.get(context).getPostImage();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                IconBroken.Image,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'add photo',
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
