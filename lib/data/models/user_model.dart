class User{
  String id;
  String username, fullName, email;
  String accessToken;

  User({this.id, this.username, this.fullName, this.email});

  factory User.fromJson(Map<String,dynamic> json){
    User c = User();
    c.id = json['id'].toString();
    c.username = json['username'];
    c.fullName = json['full_name'];
    c.email = json['email'];
    c.accessToken = json['access_token'];
    return c;
  }
}