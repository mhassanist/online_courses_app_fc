import 'file:///D:/code/online_courses_app/lib/data/models/course_model.dart';
import 'package:online_courses_app/data/models/meta_data.dart';

class CoursesResponse{
  MetaData metaData;
  List<Course> data ;

  CoursesResponse();
  factory CoursesResponse.fromJson(Map<String, dynamic>json){
    CoursesResponse coursesResponse = CoursesResponse();

    coursesResponse.metaData = MetaData.fromJson(json['meta_data']);
    coursesResponse.data=[];
    for(var c in json['data'] ){
      Course temp = Course.fromJson(c);
      coursesResponse.data.add(temp);
    }

    return coursesResponse;
  }

  }