import '../domain/user.dart';
import 'dashboard.dart';
import 'login_screen.dart';
import '../services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerPage extends StatefulWidget {
  DrawerPage({Key key}) : super(key: key);

  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  String uid, phoneNumber;
  void initState() {
    this.uid = "";
    this.phoneNumber = "";
    FirebaseAuth.instance.currentUser().then((val) {
      setState(() {
        this.uid = val.uid;
        this.phoneNumber = val.phoneNumber;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context);
    final bool isLoggedIn = user != null;

    return isLoggedIn
        ? Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Container(
                    child: Center(
                      child: Text(
                        "ЗАРЕГАН!\n$phoneNumber",
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green,
                  ),
                ),
                ListTile(
                    leading: Icon(Icons.person_outline),
                    title: Text('Войти'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PhoneVerification()),
                      );
                    }),
                ListTile(
                  leading: Icon(Icons.clear_all),
                  title: Text('Выход'),
                  onTap: () {
                    AuthService().logOut();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.error_outline),
                  title: Text('DashBoard'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DashBoard()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.chat_bubble_outline),
                  title: Text('Связаться с нами'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          )
        : Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Container(
                    child: Center(
                      child: Text(
                        "Привет Гость!",
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                  ),
                ),
                ListTile(
                    leading: Icon(Icons.person_outline),
                    title: Text('Войти'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PhoneVerification()),
                      );
                    }),
                ListTile(
                  leading: Icon(Icons.clear_all),
                  title: Text('Уйти'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                // ListTile(
                //   leading: Icon(Icons.error_outline),
                //   title: Text('DashBoard'),
                //   onTap: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => PhoneVerification()),
                //     );
                //   },
                // ),
                ListTile(
                  leading: Icon(Icons.chat_bubble_outline),
                  title: Text('Связаться с нами'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
  }
}
