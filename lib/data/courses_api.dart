import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class CoursesAPI{
  var baseUrl = 'https://raw.githubusercontent.com/mhassanist/courses-list-api/main';
  getCourses()async{
    var url = baseUrl + '/db.json';

    var response = await http.get(url);

    if (response.statusCode == 200) {

      var jsonResponse = convert.jsonDecode(response.body);

      var data = jsonResponse['data'];
      print('Number of books about http: $data.');
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    //parse response

  }

}