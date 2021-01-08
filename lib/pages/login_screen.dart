// keyboardType: TextInputType.phone,

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodex/domain/user.dart';
import 'package:foodex/pages/drawer.dart';
import 'package:foodex/services/auth.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';
import 'dashboard.dart';

class PhoneVerification extends StatefulWidget {
  @override
  _PhoneVerificationState createState() => _PhoneVerificationState();
}

// your_async_method () async {

//      final documents = await db.collection('users').where("email", isEqualTo: "jtent@mail.com").getDocuments();
//      final userObject = documents.documents.first.data;
//      print(userObject);
//  }

class _PhoneVerificationState extends State<PhoneVerification> {
  String smsCode;
  String verificationCode;
  String number;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 3,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.sort, color: Colors.green[700]),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        title: Text(
          'Авторизация',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.notifications, color: Colors.green[800]),
              onPressed: null)
        ],
      ),
      drawer: StreamProvider<User>.value(
        value: AuthService().currentUser,
        child: DrawerPage(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: Text(
                "Введите номер телефона",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 20,
                ),
              ),
            ),
            TextField(
              // PhoneNumberTextInputFormatter
              keyboardType: TextInputType.phone,
              obscureText: false,
              onChanged: (val) {
                number = val;
              },
              cursorColor: Colors.grey,
              style: TextStyle(
                height: 2,
                fontSize: 14,
              ),
              decoration: InputDecoration(
                  fillColor: Colors.blueGrey[50],
                  filled: true,
                  prefixIcon: Icon(
                    Icons.phone_android_outlined,
                    color: Colors.green[900],
                  ),
                  hintText: "Введите номер телефона",
                  hintStyle: TextStyle(
                    color: Colors.red,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: ButtonTheme(
                height: 50,
                minWidth: width,
                child: RaisedButton.icon(
                  onPressed: () {
                    _submit();
                  },
                  icon: Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                  label: Text("Получить код"),
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  splashColor: Colors.green[800],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _submit() async {
    final PhoneVerificationCompleted verificationSuccess =
        (AuthCredential credential) {
      setState(() {
        print("Verification");
        print(credential);
      });
    };

    final PhoneVerificationFailed phoneVerificationFailed =
        (AuthException exception) {
      print("${exception.message}");
    };
    final PhoneCodeSent phoneCodeSent = (String verId, [int forceCodeResend]) {
      this.verificationCode = verId;
      smsCodeDialog(context).then((value) => print("Signed In"));
    };

    final PhoneCodeAutoRetrievalTimeout autoRetrievalTimeout = (String verId) {
      this.verificationCode = verId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: this.number,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verificationSuccess,
        verificationFailed: phoneVerificationFailed,
        codeSent: phoneCodeSent,
        codeAutoRetrievalTimeout: autoRetrievalTimeout);
  }

  Future<bool> smsCodeDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Enter Code",
              style: TextStyle(
                color: Colors.green[900],
              ),
            ),
            content: TextField(
              keyboardType: TextInputType.phone,
              onChanged: (Value) {
                smsCode = Value;
              },
            ),
            contentPadding: EdgeInsets.all(10),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  "Verify",
                  style: TextStyle(
                    color: Colors.green[900],
                  ),
                ),
                onPressed: () {
                  FirebaseAuth.instance.currentUser().then((user) {
                    if (user != null) {
                      Navigator.of(context).pop();
                      Navigator.pop(context);
                    } else {
                      Navigator.of(context).pop();
                      signIn();
                    }
                  });
                },
              )
            ],
          );
        });
  }

  signIn() {
    AuthCredential phoneAuthCredential = PhoneAuthProvider.getCredential(
        verificationId: verificationCode, smsCode: smsCode);
    FirebaseAuth.instance
        .signInWithCredential(phoneAuthCredential)
        .then((user) => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DashBoard()),
            ))
        .catchError((e) => print(e));
  }
}
