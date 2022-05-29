import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:mockito/mockito.dart';
import 'package:parental_control/services/auth.dart';
import 'package:parental_control/services/database.dart';

///we don't want to use the real firebase authentication multiple times
///so we create a mock sign-in class. Mock is taken from the Mokito package

class MockAuth extends Mock implements AuthBase {}

class MockDatabase extends Mock implements Database {}

class MockUser extends Mock implements User {
  MockUser();

  factory MockUser.uid(String uid) {
    final user = MockUser();
    when(user.uid).thenReturn(uid);
    return user;
  }
}

class MockNavigatorObvserver extends Mock implements NavigatorObserver {}
