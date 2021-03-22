import 'dart:convert' as convert;
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:online_courses_app/data/app_constants.dart';
import 'package:online_courses_app/data/course_model.dart';
import 'package:online_courses_app/data/courses_response.dart';
import 'package:online_courses_app/data/meta_data.dart';

class Failure {
  int code;
  String message;

  Failure(this.code, this.message);
}

class APIResult {
  bool hasError;
  dynamic data;
  Failure failure;
}

class CoursesAPI {
  Future<APIResult> getCourses() async {
    var url =
        'https://raw.githubusercontent.com/mhassanist/courses-list-api/main/db.json';

    //url = 'https://raw.githubusercontent.com/mhassanist/courses-list-api/main/wrong.json';

    http.Response response;
    var jsonResponse;
    APIResult result = APIResult();
    CoursesResponse courseResponse;
    try {
      response = await http.get(url);

      if (response.statusCode == AppConstants.RESPONSE_CODE_SUCCESS) {
        jsonResponse = convert.jsonDecode(response.body);

        courseResponse = CoursesResponse.fromJson(jsonResponse);

        result.hasError = false;
        result.data = courseResponse.data;

      } else {
        courseResponse = CoursesResponse.fromJson(jsonResponse);
        MetaData responseMeta = courseResponse.metaData;

        result.hasError = true;
        result.failure = Failure(responseMeta.code, responseMeta.messages.message);
      }

    } on FormatException {
      result.hasError = true;

      result.failure = Failure(AppConstants.ERROR_NO_BODY_PARSING_CODE,
          "Problem parsing data from the server");
    } on SocketException {

      result.hasError = true;
      result.failure = Failure(AppConstants.ERROR_NO_CONNECTION_CODE,
          "Can't connect to internet");
    } catch (ex) {
      result.hasError = true;
      result.failure = Failure(AppConstants.ERROR_NO_CONNECTION_CODE,
          ex.toString());
    }

    return result;
  }

}
