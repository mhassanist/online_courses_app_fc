import 'package:flutter/material.dart';
import 'package:online_courses_app/data/course_model.dart';

class CourseDetails extends StatelessWidget {
  final Course course;

  CourseDetails(this.course);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Center(
          child: Text(course.title),
        ),
        ElevatedButton(onPressed: () {
          Navigator.pop(context, "sample-data");
        }, child: Text("Close"))
      ]),
    );
  }
}