import 'dart:convert' as convert;
import 'dart:io';
import 'package:http/io_client.dart';
import 'package:online_courses_app/data/api/api_constants.dart';
import 'package:online_courses_app/data/api/api_response_handler.dart';
import 'package:online_courses_app/data/api/api_result.dart';
import 'package:online_courses_app/data/api/failure.dart';
import 'package:online_courses_app/data/app_constants.dart';
import 'package:http/http.dart' as http;
import 'package:online_courses_app/data/models/meta_data.dart';
import 'package:online_courses_app/data/models/user_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UsersAuthAPI {
  Future<APIResult> login(String userName, String password) async {
    var url = APIConstants.BASE_URL+'/login';

    http.Response response;
    var jsonResponse;

    APIResult result = APIResult();

    UserResponse userResponse;

    Map<String, dynamic> bodyData = {
      'username': userName,
      'password': password,
      "grant_type": "password",
      "client_id": 2,
      "client_secret": "J2bgaVwasTc7ER0aZrY0rfMFVI9xSkSncFskpK3F",
      "notification_id":
          "740f4707bebcf74f9b7c25d48e3358945f6aa01da5ddb387462c7eaf61bb78ad",
      "device_os": "android"
    };

    try {
      HttpClient client = new HttpClient();
      client.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);

      IOClient ioClient = IOClient(client);

      response = await ioClient.post(url,
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
          body: convert.jsonEncode(bodyData));

      if (response.statusCode == AppConstants.RESPONSE_CODE_SUCCESS) {
        jsonResponse = convert.jsonDecode(response.body);

        userResponse = UserResponse.fromJson(jsonResponse);

        //print("Token: " + userResponse.metaData.accessToken);

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString(AppConstants.KEY_ACCESS_TOKEN, userResponse.metaData.accessToken);

        result.hasError = false;
        result.data = userResponse.data;
      } else {
        jsonResponse = convert.jsonDecode(response.body);
        userResponse = UserResponse.fromJson(jsonResponse);
        MetaData responseMeta = userResponse.metaData;

        result.hasError = true;
        result.failure =
            Failure(responseMeta.code, responseMeta.messages.message);
      }
    } catch (ex) {
      result = APIResponseErrorHandler.parseError(ex);
    }

    print(result.data);
    return result;
  }
}
