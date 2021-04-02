import 'package:flutter/material.dart';
import 'package:online_courses_app/data/course_model.dart';
import 'package:online_courses_app/data/courses_api.dart';
import 'package:online_courses_app/providers/courses_list_provider.dart';
import 'package:online_courses_app/ui/course_details.dart';
import 'package:online_courses_app/ui/list_courses.dart';
import 'package:provider/provider.dart';

void main(){

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<CoursesListProvider>(create: (_) => CoursesListProvider()),
    ],
    child: MyApp(),
  ));

}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Course> courses = [];
  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: CoursesList.routeName,
      routes: {
        CoursesList.routeName: (context) => CoursesList(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        CourseDetails.routeName : (context) => CourseDetails(),
      },
      debugShowCheckedModeBanner: false,
      title: 'Dev School',
      theme: ThemeData(
        fontFamily: 'Cairo',
           primarySwatch: Colors.blue,
      ),
      //home: CoursesList()
    );
  }
}