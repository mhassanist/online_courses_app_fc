import 'package:flutter/material.dart';
import 'package:online_courses_app/data/api/users_auth_api.dart';
import 'package:online_courses_app/ui/styles.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String errorString = "";

  @override
  Widget build(BuildContext context) {
    return _buildLoginScreen();
  }

  Widget _buildLoginScreen() {
    _emailController.text="admin@admin.com";
    _passwordController.text="123456";
    final logo          = _buildLogoImage();
    final emailField    = _buildEmailField();
    final passwordField = _buildPasswordField();
    final errorText     = _buildErrorTextField();
    final loginButton   = _buildLoginButton();

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(35.0, 20.0, 35.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  logo,
                  SizedBox(height: 25.0),
                  emailField,
                  SizedBox(height: 25.0),
                  passwordField,
                  errorText,
                  loginButton,
                  SizedBox(
                    height: 15.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogoImage() {
    return SizedBox(
      height: 135.0,
      child: Image.asset(
        "assets/images/logo.png",
        fit: BoxFit.contain,
      ),
    );
  }
  Widget _buildLoginButton() {
    return Material(
    elevation: 5.0,
    borderRadius: BorderRadius.circular(5.0),
    color: Theme.of(context).primaryColor,
    child: MaterialButton(
      minWidth: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      onPressed: () {
        String username = _emailController.text;
        String password = _passwordController.text;

        UsersAuthAPI().login(username,password);
        print(username +" -- " + password);
      },
      child: Text("Login",
          textAlign: TextAlign.center,
          style: Styles.mainTextStyle
              .copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
    ),
  );
  }

  Widget _buildErrorTextField() {
    return Text(
    errorString,
    style: Styles.mainTextStyleRed,
    textAlign: TextAlign.center,
  );
  }

  Widget _buildPasswordField() {
    return TextField(
    obscureText: true,
    style: Styles.mainTextStyle,
    controller: _passwordController,
    decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Password",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
  );
  }

  Widget _buildEmailField() {
    return TextField(
    controller: _emailController,
    obscureText: false,
    style: Styles.mainTextStyle,
    decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Email",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
  );
  }
}
