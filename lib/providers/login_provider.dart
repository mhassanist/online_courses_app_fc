import 'package:flutter/material.dart';
import 'package:online_courses_app/data/api/api_result.dart';
import 'package:online_courses_app/data/api/courses_api.dart';
import 'package:online_courses_app/data/api/users_auth_api.dart';
import 'package:online_courses_app/data/models/course_model.dart';
import 'package:online_courses_app/data/models/user_model.dart';

enum LoginScreenState{initial, loading, loaded, error}
class LoginProvider with ChangeNotifier{

  LoginScreenState state = LoginScreenState.initial;
  User user;
  APIResult apiResult;
  String errorMessage;

  login(userName, password)async{
    setState(LoginScreenState.loading);
    apiResult = await UsersAuthAPI().login(userName, password);

    if(!apiResult.hasError){
      user = apiResult.data;
      setState( LoginScreenState.loaded);

    }else{
      errorMessage = apiResult.failure.message;
      setState( LoginScreenState.error);

    }
  }

  setState(state){
    this.state = state;
    notifyListeners();
  }

}