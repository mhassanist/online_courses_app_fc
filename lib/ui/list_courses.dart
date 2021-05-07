import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_courses_app/data/models/course_model.dart';
import 'package:online_courses_app/providers/courses_list_provider.dart';
import 'package:online_courses_app/ui/widgets/course_card.dart';
import 'package:online_courses_app/ui/widgets/error_widget.dart';
import 'package:provider/provider.dart';

class CoursesList extends StatelessWidget {

  static const String routeName = "/";


  List<Course> coursesList;

  CoursesListProvider provider;

  CoursesList();

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<CoursesListProvider>(context);

    if(provider.state == ListScreenState.initial){
      provider.getCourses();
      return Container(color:Colors.white ,child: Center(child: CircularProgressIndicator(),));
    }else if(provider.state == ListScreenState.error) {
       String message = provider.errorMessage;
       return OCErrorWidget(message);
    }else {
      coursesList = provider.coursesList;
    }

    return _buildCoursesScreen();
  }

  _buildCoursesScreen() {
    return Scaffold(
      body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [_buildCourseListHeader(),
              _buildCoursesList()],
          ),

      ),
    );
  }

  _buildCourseListHeader() {
    return Container(
        child: Center(
          child: Text(
            "الدورات الحالية",
            style: TextStyle(fontSize: 38, fontFamily: 'Cairo'),
          ),
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(
              "assets/images/header_bg.jpg",
            ),
          ),
        ));
  }

  _buildCoursesList() {
    return Expanded(
      child: ListView.builder(
        itemCount: coursesList.length,
        padding: EdgeInsets.symmetric(horizontal: 15),
        itemBuilder: (context, index) {
          return CourseCard(
            course: coursesList[index],
          );
        },
      ),
    );
  }

}
