import 'package:online_courses_app/data/models/meta_data.dart';
import 'package:online_courses_app/data/models/user_model.dart';

class UserResponse{
  MetaData metaData;
  User data ;

  UserResponse();
  factory UserResponse.fromJson(Map<String, dynamic>json){
    UserResponse userResponse = UserResponse();

    userResponse.metaData = MetaData.fromJson(json['meta_data']);
    userResponse.data=User.fromJson(json['data']);

        return userResponse;
  }

  }