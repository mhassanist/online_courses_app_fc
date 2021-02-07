import 'package:flutter/material.dart';
import 'package:online_courses_app/data/course_model.dart';
import 'package:online_courses_app/ui/widgets/course_card.dart';

class CoursesList extends StatelessWidget {
  List<Course> coursesList;

  @override
  Widget build(BuildContext context) {
    coursesList = _buildDummyCoursesList();
    return _buildCoursesScreen();
  }

  _buildCoursesScreen() {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [_buildCourseListHeader(), _buildCoursesList()],
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

  _buildDummyCoursesList() {
    coursesList = [];
    coursesList.add(new Course(
        100,
        'https://cdn3.f-cdn.com/contestentries/1112912/26228964/599ac11baba88_thumb900.jpg',
        'Youtube Marketing | التسويق الرقمي',
        'Learn the best practices in Youtube Marketing'));

    coursesList.add(new Course(
        200,
        'https://hackr.io/blog/best-java-courses/thumbnail/large',
        'Introduction to Java | مقدمة فى الجافا',
        'Description Introduction to Java Description Introduction to Java Description Introduction to Java'));

    coursesList.add(new Course(
        300,
        'https://5.imimg.com/data5/QD/VX/MY-61372866/flutter-application-development-500x500.png',
        'Mobile Development With Flutter | تطوير التطبيقات باستخدام فلاتر',
        'This course is a mobile development With Flutter'));

    return coursesList;
  }
}
