import 'package:flutter/material.dart';
import 'package:online_courses_app/data/course_model.dart';
import 'package:online_courses_app/data/courses_api.dart';

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