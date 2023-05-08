import 'package:waste_app/model/user_model.dart';

class PostModel extends UserModel {
  @override
  String? name;
  @override
  String? uId;
  @override
  String? image;
  String? dateTime;
  String? text;
  String? postImage;
  String? postId;
  dynamic likes;

  PostModel({
    this.name,
    this.uId,
    this.image,
    this.dateTime,
    this.text,
    this.postImage,
    this.postId,
    this.likes,
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uId = json['uId'];
    image = json['image'];
    dateTime = json['dateTime'];
    text = json['text'];
    postImage = json['postImage'];
    postId = json['postId'];
    likes = json['likes'];
  }

  // List<String> likes = [];
  // String? get postId => null;
  // final String? postId;
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uId': uId,
      'image': image,
      'dateTime': dateTime,
      'text': text,
      'postImage': postImage,
    };
  }
}

class GetPostModel extends PostModel {
  @override
  String? postId;

  /// contains uIds of users who liked the post
  @override
  dynamic likes;

  GetPostModel({
    required String name,
    required String uId,
    required String image,
    required String text,
    required String postImage,
    required String dateTime,
    required int milSecEpoch,
    required this.postId,
    required this.likes,
  }) : super(
          name: name,
          uId: uId,
          image: image,
          text: text,
          postImage: postImage,
          dateTime: dateTime,
        );

  GetPostModel.fromJson({
    required Map<String, dynamic> json,
    required this.postId,
    required this.likes,
  }) : super.fromJson(json);
}
