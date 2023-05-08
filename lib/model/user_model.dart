class UserModel {
  String? name;
  String? email;
  String? phone;
  String? location;
  String? uId;
  String? image;
  String? comment;
  bool? subscribe;
  dynamic rate;

  UserModel({
    this.name,
    this.email,
    this.phone,
    this.location,
    this.uId,
    this.image,
    this.comment,
    this.subscribe,
    this.rate,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    location = json['location'];
    uId = json['uId'];
    image = json['image'];
    comment = json['comment'];
    subscribe = json['subscribe'];
    rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'location': location,
      'uId': uId,
      'image': image,
      'comment': comment,
      'subscribe': subscribe,
      'rate': rate,
    };
  }
}
