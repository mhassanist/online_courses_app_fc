import 'package:flutter/material.dart';
import 'package:online_courses_app/data/course_model.dart';

class CourseCard extends StatelessWidget {
  final Course _course;

  CourseCard({Course course}) : _course = course;

  @override
  Widget build(BuildContext context) {
    Widget courseCard = _buildCourseCard();

    return GestureDetector(
        onTap: () {
          //when we click on the card
        },
        child: courseCard);
  }

  Widget _buildCourseCard() {
    Widget cardContent = _buildCourseCardContent(_course);

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: cardContent,
      ),
    );
  }

  Widget _buildCourseCardContent(Course course) {
    Widget courseImage = _buildCourseImage(_course.image);
    Widget courseTitle = _buildCourseTitle(_course.title);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        courseImage,
        courseTitle,
      ],
    );
  }

  Widget _buildCourseImage(String image) {
    if (image == null) {
      //default image
      image = 'https://static.thenounproject.com/png/583402-200.png';
    }
    return Image.network(
      image,
      fit: BoxFit.fitWidth,
      height: 150,
    );
  }

  Widget _buildCourseTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
          child: Text(
        title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      )),
    );
  }
}
