// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controller/app_cubit/cubit.dart';
import '../controller/app_cubit/states.dart';
import '../shared/componentes.dart';
import '../shared/constants.dart';
import '../shared/icon_broken.dart';

//ignore: must_be_immutable
class EditProfileScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var locationController = TextEditingController();
  var commentController = TextEditingController();

  EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WasteAppCubit, WasteAppState>(
        listener: (context, state) {},
        builder: (context, state) {
          var userModel = WasteAppCubit.get(context).userModel;
          var profileImage = WasteAppCubit.get(context).profileImage;
          nameController.text = userModel!.name!;
          phoneController.text = userModel.phone!;
          locationController.text = userModel.location!;
          if (userModel.comment == null) {
            commentController.text = 'give your feedback';
          } else {
            commentController.text = userModel.comment!;
          }
          return Scaffold(
            appBar: AppBar(
              elevation: .5,
              centerTitle: false,
              titleSpacing: 5.0,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  IconBroken.Arrow___Left_2,
                ),
              ),
              title: const Text(
                'Edit Profile',
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 20.0,
                  left: 20.0,
                  right: 20.0,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Spacer(),
                        OutlinedButton(
                          onPressed: () {
                            WasteAppCubit.get(context).updateUser(
                              name: nameController.text,
                              phone: phoneController.text,
                              location: locationController.text,
                              comment: commentController.text,
                            );
                          },
                          child: const Text(
                            'UPDATE',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 200,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 80,
                                backgroundImage: profileImage == null
                                    ? NetworkImage(userModel.image!)
                                    : FileImage(profileImage) as ImageProvider,
                              ),
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: defaultColor,
                                child: IconButton(
                                  onPressed: () {
                                    WasteAppCubit.get(context).updateUser(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      location: locationController.text,
                                      comment: commentController.text,
                                    );
                                    WasteAppCubit.get(context)
                                        .getProfileImage();
                                  },
                                  icon: const Icon(
                                    IconBroken.Camera,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    if (WasteAppCubit.get(context).profileImage != null)
                      Row(
                        children: [
                          if (WasteAppCubit.get(context).profileImage != null)
                            Expanded(
                              child: Column(
                                children: [
                                  defaultButton(
                                    function: () {
                                      WasteAppCubit.get(context)
                                          .uploadProfileImage(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        location: locationController.text,
                                        comment: commentController.text,
                                      );
                                    },
                                    text: 'Upload Profile',
                                    background: defaultColor,
                                    isUpperCase: false,
                                  ),
                                  if (state is WasteAppUserUpdateLoadingState)
                                    const SizedBox(
                                      height: 8.0,
                                    ),
                                  if (state is WasteAppUserUpdateLoadingState)
                                    const LinearProgressIndicator(),
                                ],
                              ),
                            ),
                          const SizedBox(
                            width: 5.0,
                          ),
                        ],
                      ),
                    if (WasteAppCubit.get(context).profileImage != null)
                      const SizedBox(
                        height: 20.0,
                      ),
                    defaultTextFormField(
                      controller: nameController,
                      type: TextInputType.name,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'Name must not be empty';
                        }
                        return null;
                      },
                      label: 'Name',
                      prefix: IconBroken.User,
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    defaultTextFormField(
                      controller: phoneController,
                      type: TextInputType.phone,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'Phone must not be empty';
                        }
                        return null;
                      },
                      label: 'Phone',
                      prefix: IconBroken.Call,
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    defaultTextFormField(
                      controller: locationController,
                      type: TextInputType.text,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'Location must not be empty';
                        }
                        return null;
                      },
                      label: 'Location',
                      prefix: IconBroken.Location,
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    defaultTextFormField(
                      controller: commentController,
                      type: TextInputType.text,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'Comment must not be empty';
                        }
                        return null;
                      },
                      label: 'Comment',
                      prefix: IconBroken.Info_Circle,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
