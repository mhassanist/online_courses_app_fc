class MetaData{
  int code;
  String developerMessage;
  UserMessages messages;
  MetaData();

  factory MetaData.fromJson(Map<String, dynamic>json){
    MetaData d = MetaData();
    d.code = json['code'];
    d.developerMessage = json['developer_message'];
    d.messages = UserMessages.fromJson(json['user_messages']);

    return d;
  }

}
class UserMessages{
  String message;
  UserMessages();
  factory UserMessages.fromJson(Map<String, dynamic>json){
    UserMessages userMessages = UserMessages();

    userMessages.message = json['en'];

    return userMessages;
  }

  }