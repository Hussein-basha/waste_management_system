// ignore_for_file: avoid_print
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waste_app/controller/register_cubit/cubit.dart';
import 'package:waste_app/controller/register_cubit/states.dart';
import 'package:waste_app/screens/user_login_screen.dart';
import '../controller/app_cubit/cubit.dart';
import '../screens/selected_role.dart';
import '../shared/componentes.dart';
import '../shared/constants.dart';
import '../shared/icon_broken.dart';

//ignore: must_be_immutable
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var regionController = TextEditingController();
  var imageController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is SaveUserDataSuccessState) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const SelectedRole(),
              ),
              (Route<dynamic> route) => false,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: defaultColor,
              actions: [
                backBottom(context: context),
              ],
              iconTheme: const IconThemeData(
                color: Colors.white,
              ),
              leading: IconButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserLoginScreen(),
                    ),
                    (Route<dynamic> route) => false,
                  );
                },
                icon: const Icon(
                  IconBroken.Arrow___Left_2,
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Opacity(
                        opacity: 0.5,
                        child: ClipPath(
                          clipper: WaveClipper(),
                          child: Container(
                            color: defaultColor,
                            height: 200,
                          ),
                        ),
                      ),
                      ClipPath(
                        clipper: WaveClipper(),
                        child: Container(
                          color: defaultColor,
                          height: 170,
                          alignment: Alignment.center,
                          child: const Text(
                            'Help for a better future!',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Register',
                            style: TextStyle(
                              fontSize: 35.0,
                              fontWeight: FontWeight.w900,
                              color: defaultColor,
                            ),
                          ),
                          const SizedBox(
                            height: 7.0,
                          ),
                          Center(
                            child: Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                Container(
                                  height: 125,
                                  width: 125,
                                  clipBehavior: Clip.hardEdge,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: defaultColor,
                                  ),
                                ),
                                Stack(
                                  alignment: AlignmentDirectional.bottomEnd,
                                  children: [
                                    Container(
                                      height: 120,
                                      width: 120,
                                      clipBehavior: Clip.hardEdge,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                      ),
                                      child: RegisterCubit.get(context)
                                                  .userImageFile !=
                                              null
                                          ? Image(
                                              image: FileImage(
                                                  RegisterCubit.get(context)
                                                      .userImageFile!),
                                            )
                                          : Image.asset(
                                              'images/user_1.png',
                                            ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        RegisterCubit.get(context)
                                            .getUserImageFile();
                                      },
                                      child: const CircleAvatar(
                                        backgroundColor: defaultColor,
                                        radius: 20,
                                        child: Icon(
                                          IconBroken.Camera,
                                          size: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          defaultTextFormField(
                            controller: nameController,
                            type: TextInputType.name,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please enter your name!';
                              }
                              return null;
                            },
                            onSubmit: (String? value) {
                              return null;
                            },
                            label: 'User Name',
                            prefix: IconBroken.User,
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          defaultTextFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please enter your email address!';
                              }
                              return null;
                            },
                            onSubmit: (String? value) {
                              return null;
                            },
                            label: 'Email Address',
                            prefix: IconBroken.Message,
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          defaultTextFormField(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please is to shot!';
                              }
                              return null;
                            },
                            onSubmit: (value) {
                              return null;
                            },
                            label: 'Password',
                            prefix: IconBroken.Lock,
                            suffix: RegisterCubit.get(context).suffix,
                            isPassword: RegisterCubit.get(context).isPassword,
                            suffixPressed: () {
                              RegisterCubit.get(context)
                                  .changePasswordVisibility();
                            },
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          defaultTextFormField(
                            controller: phoneController,
                            type: TextInputType.phone,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please enter your Phone!';
                              }
                              return null;
                            },
                            onSubmit: (String? value) {
                              return null;
                            },
                            label: 'Phone',
                            prefix: IconBroken.Call,
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          defaultTextFormField(
                            controller: regionController,
                            type: TextInputType.text,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please select your location!';
                              }
                              return null;
                            },
                            onSubmit: (String? value) {
                              return null;
                            },
                            label: 'Location',
                            prefix: IconBroken.Location,
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          defaultClickedButton(
                            contentWidget: state is CreateUserLoadingState ||
                                    state is SaveUserDataLoadingState ||
                                    state is CreateUserSuccessStates
                                ? const CupertinoActivityIndicator(
                                    color: Colors.white,
                                  )
                                : Text(
                                    "Register".toUpperCase(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                            minWidth: double.infinity,
                            onTap: () async {
                              WasteAppCubit.get(context).subscribing();
                              // WasteAppCubit.get(context).subscribe();
                              if (RegisterCubit.get(context).userImageFile !=
                                      null &&
                                  formKey.currentState!.validate()) {
                                await RegisterCubit.get(context).createUser(
                                  location: regionController.text,
                                  image: imageController.text,
                                  phone: phoneController.text,
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                                await WasteAppCubit.get(context).getUserData();
                              } else if (RegisterCubit.get(context)
                                      .userImageFile ==
                                  null) {
                                RegisterCubit.get(context).userImageFile =
                                    const NetworkImage(
                                  'https://firebasestorage.googleapis.com/v0/b/social-app-96619.appspot.com/o/users%2Fimage_picker806166524626709285.jpg?alt=media&token=1da787b3-43ce-4a25-888b-0450deb9e613',
                                ) as File?;
                                showToast(
                                  text: "choose an Image and try again!",
                                  state: ToastState.ERROR,
                                );
                              }
                            },
                            padding: const EdgeInsets.all(
                              10,
                            ),
                            roundedRectangleBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                25.0,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Have an account!! ',
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UserLoginScreen(),
                                    ),
                                    (Route<dynamic> route) => false,
                                  );
                                },
                                child: const Text(
                                  'LOGIN',
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    color: defaultColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
