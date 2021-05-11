import 'dart:convert' as convert;
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:online_courses_app/data/api/api_constants.dart';
import 'package:online_courses_app/data/api/api_response_handler.dart';
import 'package:online_courses_app/data/api/api_result.dart';
import 'package:online_courses_app/data/api/failure.dart';
import 'package:online_courses_app/data/app_constants.dart';
import 'package:online_courses_app/data/models/courses_response.dart';
import 'package:online_courses_app/data/models/meta_data.dart';

class CoursesAPI {
  Future<APIResult> getCourses() async {
    var url = APIConstants.BASE_URL+'/v1/course';

    http.Response response;
    var jsonResponse;
    APIResult result = APIResult();
    CoursesResponse courseResponse;
    try {
      response = await http.get(url, headers: {
        HttpHeaders.authorizationHeader: APIConstants.clientToken,
        "": ""
      });

      if (response.statusCode == AppConstants.RESPONSE_CODE_SUCCESS) {
        jsonResponse = convert.jsonDecode(response.body);

        courseResponse = CoursesResponse.fromJson(jsonResponse);

        result.hasError = false;
        result.data = courseResponse.data;
      } else {
        courseResponse = CoursesResponse.fromJson(jsonResponse);
        MetaData responseMeta = courseResponse.metaData;

        result.hasError = true;
        result.failure =
            Failure(responseMeta.code, responseMeta.messages.message);
      }
    } catch (ex) {
      result = APIResponseErrorHandler.parseError(ex);
    }

    return result;
  }
}
