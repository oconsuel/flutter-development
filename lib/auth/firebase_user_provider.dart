import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class TestProjectFirebaseUser {
  TestProjectFirebaseUser(this.user);
  final User user;
  bool get loggedIn => user != null;
}

TestProjectFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<TestProjectFirebaseUser> testProjectFirebaseUserStream() => FirebaseAuth
    .instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<TestProjectFirebaseUser>(
        (user) => currentUser = TestProjectFirebaseUser(user));
