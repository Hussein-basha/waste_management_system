// ignore_for_file: avoid_print
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:waste_app/controller/register_cubit/states.dart';
import '../../model/user_model.dart';
import 'package:waste_app/network/local/cache_helper.dart';
import '../../shared/constants.dart';

//ignore: must_be_immutable
class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialStates());

  static RegisterCubit get(context) => BlocProvider.of(context);

  File? userImageFile;
  final pickerImage = ImagePicker();

  Future<void> getUserImageFile() async {
    final pickedImage = await pickerImage.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage != null) {
      userImageFile = File(pickedImage.path);
      emit(ChosenUserImageSuccessfullyState());
    } else {
      emit(ChosenUserImageErrorState());
    }
  }

  Future<void> createUser({
    required String email,
    required String name,
    required String password,
    required String phone,
    required String location,
    required String image,
  }) async {
    emit(CreateUserLoadingState());
    // createUserWithEmailAndPassword return UserCredential (( Future type ))
    final user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    uId = user.user!.uid;
    await CacheHelper.saveData(key: 'uid', val: user.user!.uid).then((val) {
      emit(CreateUserSuccessStates());
      print("User created successfully with ID => ${user.user!.uid}");
      // CacheHelper.saveData(
      //   key: 'uid',
      //   val: user.user!.uid,
      // ); // to save User ID on Cache to go to home directly second time
      saveUserData(
        name: name,
        phone: phone,
        location: location,
        email: email,
        image: image,
        uid: user.user!.uid,
      ); // save UserData on Cloud FireStore
    }).catchError((e) {
      print(e.toString());
      emit(CreateUserErrorStates(e.toString()));
    });
  }

  UserModel? model1;

  Future<void> saveUserData({
    required String name,
    required String phone,
    required String location,
    required String email,
    required String uid,
    required String image,
  }) async {
    emit(SaveUserDataLoadingState());
    FirebaseStorage.instance
        .ref()
        .child("users/${Uri.file(userImageFile!.path).pathSegments.last}")
        .putFile(userImageFile!)
        .then((val) {
      val.ref.getDownloadURL().then((imageUrl) {
        print(imageUrl);
        UserModel model = UserModel(
          name: name,
          phone: phone,
          location: location,
          email: email,
          uId: uid,
          image: imageUrl,
        );
        FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .set(model.toJson())
            .then((value) {
          emit(SaveUserDataSuccessState());
        });
      });
    }).catchError((error) {
      emit(SaveUserDataErrorState(error));
    });
  }

  bool isPassword = true;
  IconData suffix = Icons.visibility_outlined;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(RegisterChangePasswordVisibilityStates());
  }
}
