import 'package:firebase_auth/firebase_auth.dart';

class User {
  String id;
  String phoneNumber;

  User.fromFirebase(FirebaseUser user) {
    id = user.uid;
    phoneNumber = user.phoneNumber;
  }
}
