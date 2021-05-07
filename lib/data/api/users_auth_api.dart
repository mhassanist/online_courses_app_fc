import 'dart:convert' as convert;
import 'dart:io';
import 'package:http/io_client.dart';
import 'package:online_courses_app/data/app_constants.dart';
import 'package:http/http.dart' as http;
import 'package:online_courses_app/data/models/meta_data.dart';
import 'package:online_courses_app/data/models/user_response.dart';

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

class UsersAuthAPI {
  Future<APIResult> login(String userName, String password) async {
    var url =
        'https://ocourses-api.bymsaudi.com/public/login';

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
      client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);

      IOClient ioClient = IOClient(client);

      response = await ioClient.post(url,
          headers: {
            HttpHeaders.contentTypeHeader :"application/json",

          },
          body: convert.jsonEncode(bodyData));

      if (response.statusCode == AppConstants.RESPONSE_CODE_SUCCESS) {
        jsonResponse = convert.jsonDecode(response.body);

        userResponse = UserResponse.fromJson(jsonResponse);

        result.hasError = false;
        result.data = userResponse.data;
      } else {
        userResponse = UserResponse.fromJson(jsonResponse);
        MetaData responseMeta = userResponse.metaData;

        result.hasError = true;
        result.failure =
            Failure(responseMeta.code, responseMeta.messages.message);
      }
    } on FormatException {
      result.hasError = true;

      result.failure = Failure(AppConstants.ERROR_NO_BODY_PARSING_CODE,
          "Problem parsing data from the server");
    } on SocketException {
      result.hasError = true;
      result.failure = Failure(
          AppConstants.ERROR_NO_CONNECTION_CODE, "Can't connect to internet");
    } catch (ex) {
      result.hasError = true;
      result.failure =
          Failure(AppConstants.ERROR_NO_CONNECTION_CODE, ex.toString());
    }

    print(result.data);
    return result;
  }
}
