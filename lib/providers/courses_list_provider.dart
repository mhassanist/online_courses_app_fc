import 'package:flutter/material.dart';
import 'package:online_courses_app/data/course_model.dart';
import 'package:online_courses_app/data/courses_api.dart';

enum ListScreenState{initial, loading, loaded}
class CoursesListProvider with ChangeNotifier{

  ListScreenState state = ListScreenState.initial;
  List<Course> coursesList;

  getCourses()async{
    coursesList = await CoursesAPI().getCourses();

    state = ListScreenState.loaded;
    notifyListeners();
  }

}