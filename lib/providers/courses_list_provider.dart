import 'package:flutter/material.dart';
import 'package:online_courses_app/data/api/courses_api.dart';
import 'package:online_courses_app/data/models/course_model.dart';

enum ListScreenState{initial, loading, loaded, error}
class CoursesListProvider with ChangeNotifier{

  ListScreenState state = ListScreenState.initial;
  List<Course> coursesList;
  APIResult apiResult;
  String errorMessage;

  getCourses()async{
    apiResult = await CoursesAPI().getCourses();

    if(!apiResult.hasError){
      coursesList = apiResult.data;
      setState( ListScreenState.loaded);

    }else{
      errorMessage = apiResult.failure.message;
      setState( ListScreenState.error);

    }
  }

  setState(state){
    this.state = state;
    notifyListeners();
  }

}