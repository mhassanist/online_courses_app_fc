import 'package:flutter/material.dart';
import 'package:online_courses_app/data/app_constants.dart';
import 'package:online_courses_app/ui/list_courses.dart';
import 'package:online_courses_app/ui/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthContainer extends StatefulWidget {
  @override
  _AuthContainerState createState() => _AuthContainerState();

}

class _AuthContainerState extends State<AuthContainer> {
  String token;
  bool initial = true;

  @override
  Widget build(BuildContext context) {
    if (initial) {
      SharedPreferences.getInstance().then((sharedPrefValue) {
        setState(() {
          initial = false;
          token = sharedPrefValue.getString(AppConstants.KEY_ACCESS_TOKEN);

        });
      });
      return CircularProgressIndicator();
    } else {
      if (token == null) {
        return LoginScreen();
      } else {
        return CoursesList();
      }
    }
  }
}