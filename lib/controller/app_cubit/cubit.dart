// ignore_for_file: avoid_print
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:waste_app/controller/app_cubit/states.dart';
import 'package:waste_app/network/local/cache_helper.dart';
import '../../map/map_user.dart';
import '../../model/message_model.dart';
import '../../model/post_model.dart';
import '../../model/user_model.dart';
import '../../screens/cateogries_screen.dart';
import '../../screens/chat_screen.dart';
import '../../screens/feeds_screen.dart';
import 'package:image_picker/image_picker.dart';
import '../../screens/home_screen.dart';
import '../../screens/post_screen.dart';
import '../../shared/componentes.dart';
import '../../shared/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

//ignore: must_be_immutable
class WasteAppCubit extends Cubit<WasteAppState> {
  WasteAppCubit() : super(WasteAppInitialState());

  static WasteAppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  void changeBottomScreen(int index) {
    currentIndex = index;
    emit(WasteAppChangeBottomNavState());
  }

  List<Widget> screens = [
    const FeedsScreens(),
    const CateogriesScreen(),
    NewPostScreen(),
    const ChatScreen(),
    const MapUserWasteManagementSystem(),
  ];

  List<String> titles = [
    'Home',
    'Category',
    'Create Post',
    'ChatS',
    'Map',
  ];

  UserModel? userModel;

  Future<void> getUserData() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uId ?? CacheHelper.getData(key: 'uid'))
        .get()
        .then((value) {
      userModel = UserModel.fromJson(value.data()!);
      emit(WasteAppGetUserSuccessState());
    });
  }

  dynamic clearUserData() {
    // clear user data in cubit
    usersData.clear();
    usersID.clear();
    userModel = null;
    // clear user data in local cache
    CacheHelper.deleteCacheData(key: 'uid');
    // clear global uid var
    uId = null;
  }

  List<UserModel> usersData = [];
  List<String> usersID = [];

  Future<void> getUsersData() async {
    usersData.clear();
    usersID.clear();
    FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        if (userModel!.uId != element.data()['userID']) {
          usersID.add(element.id);
          usersData.add(UserModel.fromJson(element.data()));
        }
        emit(GetUsersDataSuccessState());
      });
    });
  }

  Future<void> navToHomeScreen(context) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const WestAppLayout(),
      ),
    );
  }

  File? profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    emit(GetProfileImageLoadingState());
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(WasteAppProfileImageSuccessState());
    } else {
      print('No Image Selected!');
      emit(WasteAppProfileImageErrorState());
    }
  }

  Future<void> uploadProfileImage({
    required String name,
    required String phone,
    required String location,
    required String comment,
  }) async {
    emit(WasteAppUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(
          name: name,
          phone: phone,
          location: location,
          comment: comment,
          profile: value,
        );
      }).catchError((error) {
        emit(WasteAppUploadProfileImageSuccessState());
      });
    }).catchError((error) {
      emit(WasteAppUploadProfileImageErrorState());
    });
  }

  Future<void> updateUser({
    required String name,
    required String phone,
    required String location,
    required String comment,
    String? profile,
  }) async {
    UserModel model1 = UserModel(
      name: name,
      phone: phone,
      location: location,
      comment: comment,
      image: profile ?? userModel!.image,
      email: userModel!.email,
      uId: userModel!.uId,
      subscribe: userModel!.subscribe,
      rate: userModel!.rate,
    );

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .update(model1.toJson())
        .then((value) {
      userModel = model1;
      emit(WasteAppUserUpdateSuccessState());
    }).catchError((error) {
      emit(WasteAppUserUpdateErrorState());
    });
  }

  File? postImage;

  Future<void> getPostImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(WasteAppPostImageSuccessState());
    } else {
      print('No Image Selected!');
      emit(WasteAppPostImageErrorState());
    }
  }

  Future<void> uploadPostImage({
    required String dateTime,
    required String text,
  }) async {
    var now = DateTime.now();
    emit(WasteAppCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(
          dateTime: DateFormat('MMMM dd, yyyy - hh:mm aa')
              .format(now)
              .replaceAll('-', 'at'),
          text: text,
          postImage: value,
        );
      }).catchError((error) {
        emit(WasteAppCreatePostErrorState());
      });
    }).catchError((error) {
      emit(WasteAppCreatePostErrorState());
    });
  }

  Future<void> createPost({
    required String? dateTime,
    required String text,
    String? postImage,
  }) async {
    var now = DateTime.now();
    PostModel model2 = PostModel(
      name: userModel!.name,
      uId: userModel!.uId,
      image: userModel!.image,
      dateTime: DateFormat('MMMM dd, yyyy - hh:mm aa')
          .format(now)
          .replaceAll('-', 'at'),
      text: text,
      postImage: postImage,
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(model2.toMap())
        .then((value) {
      emit(WasteAppCreatePostSuccessState());
    }).catchError((error) {
      emit(WasteAppCreatePostErrorState());
    });
  }

  Future<void> removePostImage() async {
    postImage = null;
    emit(WasteAppRemovePostImageState());
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];

  Future<void> getPosts() async {
    posts.clear();
    postsId.clear();
    emit(GetUsersPostsLoadingState());
    FirebaseFirestore.instance.collection('posts').get().then((value) async {
      for (var element in value.docs) {
        await element.reference.collection('likes').get().then((value) {
          posts.add(PostModel.fromJson(element.data()));
          likes.add(value.docs.length);
          postsId.add(element.id);
        }).catchError((error) {});
      }
    });
    emit(WasteAppGetPostsSuccessState());
  }

  Future<void> deletePost(
      {required String postMakerID, required String postID}) async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(postMakerID)
        .collection('posts')
        .doc(postID)
        .delete()
        .then((value) {
      getPosts();
      emit(DeletePostSuccessfullyState());
    });
  }

  Future<void> sendMessage(
      {required String message, required String messageReceiverID}) async {
    final model = MessageModel(
        message, DateTime.now().toString(), messageReceiverID, userModel!.uId);
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(messageReceiverID)
        .collection('messages')
        .add(model.toJson())
        .then((value) {
      emit(SendMessageSuccessState());
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(messageReceiverID)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(model.toJson())
        .then((value) {
      emit(SendMessageSuccessState());
    });
  }

  List<MessageModel> messages = [];

  Future<void> getMessages({required String messageReceiverID}) async {
    emit(GetMessageLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(messageReceiverID)
        .collection('messages')
        .orderBy('messageDateTime')
        .snapshots()
        .listen((val) {
      messages.clear();
      val.docs.forEach((element) {
        messages.add(MessageModel.fromJson(json: element.data()));
      });
      emit(GetMessageSuccessState());
    });
  }

  bool isDark = false;

  Future<void> changeThem() async {
    isDark = !isDark;
    emit(AppChangeModeState());
  }

  subscribe() async {
    getUserData();
    getUsersData();
    await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: userModel?.email!)
        .get()
        .then((value) async {
      if (value.docs.isNotEmpty) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(value.docs.first.id)
            .update({
          'subscribe': true,
          'paid': true,
          'start': DateTime.now().toLocal().toString(),
          'end':
              DateTime.now().add(const Duration(days: 30)).toLocal().toString(),
        });
        showToast(
          text: 'your are now subscribe as a user...',
          state: ToastState.SUCCESS,
        );
      }
    });
    userModel!.subscribe = true;
  }

  Future<void> subscribing() async {
    getUserData();
    getUsersData();
    userModel!.subscribe = true;
    await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: userModel?.email!)
        .get()
        .then((value) async {
      if (value.docs.isNotEmpty) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(value.docs.first.id)
            .update({
          'subscribe': true,
          'paid': true,
          'start': DateTime.now().toLocal().toString(),
          'end':
              DateTime.now().add(const Duration(days: 30)).toLocal().toString(),
        });
      }
    });
    userModel!.subscribe = true;
  }

  unsubscribe({required String title, required ToastState toast}) async {
    getUserData();
    getUsersData();
    await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: userModel?.email!)
        .get()
        .then((value) async {
      if (value.docs.isNotEmpty) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(value.docs.first.id)
            .update({
          'subscribe': false,
          'paid': false,
          'start': '',
          'end': '',
        });
        showToast(
          // text: 'Scan QR Code to subscribe as a worker...',
          text: title,
          state: toast,
        );
      }
    });
    userModel!.subscribe = false;
  }

  bool openCommentsThrowPostDetailsScreen = false;
}
