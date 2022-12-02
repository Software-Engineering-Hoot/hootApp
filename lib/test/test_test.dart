import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_infinite_list/posts/service/auth.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {
  @override
  Stream<User> authStateChanges() {
    return Stream.fromIterable([
      _mockUser,
    ]);
  }
}

class MockUser extends Mock implements User {}

final MockUser _mockUser = MockUser();

class MockUserCredential extends Mock implements Future<UserCredential> {}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final MockFirebaseAuth mockFirebaseAuth = MockFirebaseAuth();
  final authManager = AuthService();
  final MockUserCredential mockUserCredential = MockUserCredential();
  setUp(() {});
  test('emit occurs', () async {
    expectLater(authManager, emitsInOrder([_mockUser]));
  });

  test('create account', () async {
    // when(mockFirebaseAuth.createUserWithEmailAndPassword(
    //         email: 'tadas@gmail.com', password: '123456'))
    //     .thenAnswer((realInvocation) => false);

    expect(
        await authManager.signIn(
          'tadas@gmail.com',
          '123456',
        ),
        'Success');
  });
}
