class MessageModel {
  String? message;
  String? messageSenderID;
  String? messageReceiverID;
  String? messageDateTime;

  MessageModel(
    this.message,
    this.messageDateTime,
    this.messageReceiverID,
    this.messageSenderID,
  );

  // Named Constructor to get message Data from FireStore
  MessageModel.fromJson({required Map<String, dynamic> json}) {
    message = json['message'];
    messageSenderID = json['messageSenderID'];
    messageDateTime = json['messageDateTime'];
    messageReceiverID = json['messageReceiverID'];
  }

  // TOJson used it when i will sent data to fireStore
  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'messageReceiverID': messageReceiverID,
      'messageSenderID': messageSenderID,
      'messageDateTime': messageDateTime,
    };
  }
}
