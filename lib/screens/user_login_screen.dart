// ignore_for_file: avoid_print
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waste_app/screens/register_screen.dart';
import '../controller/app_cubit/cubit.dart';
import '../screens/selected_role.dart';
import '../shared/componentes.dart';
import '../shared/constants.dart';
import '../shared/icon_broken.dart';
import '../controller/login_cubit/cubit.dart';
import '../controller/login_cubit/states.dart';

//ignore: must_be_immutable
class UserLoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  UserLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginErrorStates) {
            showToast(
              text: state.error,
              state: ToastState.ERROR,
            );
          }
          if (state is LoginSuccessStates) {
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
                    padding: const EdgeInsets.all(
                      20.0,
                    ),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'LOGIN',
                            style: TextStyle(
                              fontSize: 35.0,
                              fontWeight: FontWeight.w900,
                              color: defaultColor,
                            ),
                          ),
                          const SizedBox(
                            height: 7.0,
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
                                return 'Please enter your Password!';
                              }
                              return null;
                            },
                            onSubmit: (value) {},
                            label: 'Password',
                            prefix: IconBroken.Lock,
                            suffix: LoginCubit.get(context).suffix,
                            isPassword: LoginCubit.get(context).isPassword,
                            suffixPressed: () {
                              LoginCubit.get(context)
                                  .changePasswordVisibility();
                            },
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          defaultClickedButton(
                            contentWidget: state is LoginLoadingStates
                                ? const CupertinoActivityIndicator(
                                    color: Colors.white,
                                  )
                                : Text(
                                    "LOGIN".toUpperCase(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                            minWidth: double.infinity,
                            onTap: () async {
                              await LoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                              await WasteAppCubit.get(context).getUserData();
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
                          const SizedBox(
                            height: 15.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Don\'t have an account ? ',
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const RegisterScreen(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'REGISTER',
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
// usamaessam607@gmail.com
// 23114789

//himahima23@gmail.com
//23112311
