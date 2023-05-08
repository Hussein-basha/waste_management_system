// ignore_for_file: avoid_print
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waste_app/controller/login_cubit/states.dart';
import 'package:waste_app/shared/constants.dart';
import 'package:waste_app/network/local/cache_helper.dart';

//ignore: must_be_immutable
class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialStates());

  static LoginCubit get(context) => BlocProvider.of(context);

  Future<void> userLogin({
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingStates());
    try {
      final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // save uid in global var and cache
      uId = user.user!.uid;
      await CacheHelper.saveData(key: 'uid', val: user.user!.uid);
      print('HI');
      emit(LoginSuccessStates(user.user!.uid));
    } catch (e) {
      emit(LoginErrorStates(e.toString()));
    }
  }

  bool isPassword = true;
  IconData suffix = Icons.visibility_outlined;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ChangePasswordVisibilityStates());
  }
}
