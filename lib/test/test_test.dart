import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hoot/posts/service/auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class MockUserRepository extends Mock implements AuthService {
  final MockFirebaseAuth auth;
  MockUserRepository({required this.auth});
}

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

void main() {
  MockFirebaseAuth _auth = MockFirebaseAuth();
  MockUserRepository _repo;
  _repo = MockUserRepository(auth: _auth);

  var emailField = find.byKey(Key("email-field"));
  var passwordField = find.byKey(Key("password-field"));
  var signInButton = find.text("Sign In");

  group("login page test", () {
    when(_repo.signIn("test@testmail.com", "password")).thenAnswer((_) async {
      return true;
    });
    //       var status = authService.signIn("cafyufatra@gufum.com ", "123456");
    //   //Listenin içerisinde eklediğimiz sayıyı kontrol ediyoruz
    //   //expect metodu ile beklediğimiz sonucu kontrol ediyoruz
    //   expect(status, true);
    // });
    // testWidgets('email, password and button are found',
    //     (WidgetTester tester) async {
    //   // await tester.pumpWidget(_makeTestable(LoginPage()));
    //   expect(emailField, findsOneWidget);
    //   expect(passwordField, findsOneWidget);
    //   expect(signInButton, findsOneWidget);
    // });
    // testWidgets("validates empty email and password",
    //     (WidgetTester tester) async {
    //   await tester.tap(signInButton);
    //   await tester.pump();
    //   expect(find.text("Please Enter Email"), findsOneWidget);
    //   expect(find.text("Please Enter Password"), findsOneWidget);
    // });

    // testWidgets("calls sign in method when email and password is entered",
    //     (WidgetTester tester) async {
    //   await tester.enterText(emailField, "test@testmail.com");
    //   await tester.enterText(passwordField, "password");
    //   await tester.tap(signInButton);
    //   await tester.pump();
    //   verify(_repo.signIn("test@testmail.com", "password")).called(1);
    // });
  });
}
