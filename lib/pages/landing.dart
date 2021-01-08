import 'auth.dart';
import 'home_page.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isLoggedIn = false;

    return isLoggedIn ? HomePage() : AuthPage();
  }
}
