import 'dart:ui';

import '../domain/user.dart';
import '../services/auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthPage extends StatefulWidget {
  AuthPage({Key key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String _phone;
  String _password;
  bool showlogin = true;

  AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    Widget _logo() {
      return Padding(
          padding: EdgeInsets.only(top: 100),
          child: Container(
            child: Align(
              child: Text(
                'FOODEX',
                style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ));
    }

    Widget _input(Icon icon, String hint, TextEditingController controller,
        bool obscure) {
      return Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          controller: controller,
          obscureText: obscure,
          style: TextStyle(fontSize: 20, color: Colors.white),
          decoration: InputDecoration(
              hintStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white30),
              hintText: hint,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 3),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white54, width: 1),
              ),
              prefixIcon: Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: IconTheme(
                    data: IconThemeData(color: Colors.white), child: icon),
              )),
        ),
      );
    }

    Widget _button(String text, void func()) {
      return RaisedButton(
        splashColor: Theme.of(context).primaryColor,
        // elevation: 2,
        // highlightColor: Theme.of(context).primaryColor,
        child: Text(text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
              fontSize: 20,
            )),
        onPressed: () {
          func();
        },
      );
    }

    Widget _form(String label, void func()) {
      return Container(
          child: Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(bottom: 20, top: 20),
              child: _input(
                  Icon(Icons.phone), "Phone number", phoneController, false)),
          Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: _input(
                  Icon(Icons.lock), "Password", passwordController, true)),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: _button(label, func)),
          ),
        ],
      ));
    }

    void _loginButtonAction() async {
      _phone = phoneController.text;
      _password = passwordController.text;

      if (_phone.isEmpty || _password.isEmpty) return;

      User user = await _authService.signInWithEmailAndPassword(
          _phone.trim(), _password.trim());
      if (user == null) {
        Fluttertoast.showToast(
            msg: "Ничего не вышло(",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        phoneController.clear();
        passwordController.clear();
      }

      phoneController.clear();
      passwordController.clear();
    }

    void _registerButtonAction() async {
      _phone = phoneController.text;
      _password = passwordController.text;

      if (_phone.isEmpty || _password.isEmpty) return;

      User user = await _authService.registerWithEmailAndPassword(
          _phone.trim(), _password.trim());
      if (user == null) {
        Fluttertoast.showToast(
            msg: "Ошибка с регистрацией",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        phoneController.clear();
        passwordController.clear();
      }

      phoneController.clear();
      passwordController.clear();
    }

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(children: <Widget>[
        _logo(),
        SizedBox(height: 50),
        showlogin
            ? Column(
                children: <Widget>[
                  _form('LOGIN', _loginButtonAction),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Text(
                          'Регистрация',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          showlogin = false;
                        });
                      },
                    ),
                  )
                ],
              )
            : Column(
                children: <Widget>[
                  _form('REGISTER', _registerButtonAction),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Text(
                          'Вход',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          showlogin = true;
                        });
                      },
                    ),
                  )
                ],
              )
      ]),
    );
  }
}
