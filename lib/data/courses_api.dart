import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:online_courses_app/data/course_model.dart';
import 'package:online_courses_app/data/courses_response.dart';

class CoursesAPI{

  Future<List<Course>> getCourses()async{
    var url = 'https://raw.githubusercontent.com/mhassanist/courses-list-api/main/db.json';

    http.Response response = await http.get(url);
    //throw "EXCEPTION ....";

    CoursesResponse coursesResponse;
    if (response.statusCode == 200) {

      var jsonResponse = convert.jsonDecode(response.body);

      coursesResponse = CoursesResponse.fromJson(jsonResponse);

    } else {
      print('Request failed with status: ${response.statusCode}.');
    }

    return coursesResponse.data;
  }

}