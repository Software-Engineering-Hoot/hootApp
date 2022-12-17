import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoot/firebase_options.dart';
import 'package:hoot/posts/service/auth.dart';
import 'package:hoot/simple_bloc_observer.dart';
import 'package:test/test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoot/app.dart';
import 'package:hoot/simple_bloc_observer.dart';

/*added libs @emircand*/
import 'package:firebase_core/firebase_core.dart';
import 'package:hoot/firebase_options.dart';

bool USE_FIRESTORE_EMULATOR = false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  if (USE_FIRESTORE_EMULATOR) {
    FirebaseFirestore.instance.settings = const Settings(
        host: '192.168.1.21:8080',
        sslEnabled: false,
        persistenceEnabled: false);
  }
  group('Auth Tests', () {
    var authService = AuthService();
    test('Login', () {
      var status = authService.signIn("cafyufatra@gufum.com ", "123456");
      //Listenin içerisinde eklediğimiz sayıyı kontrol ediyoruz
      //expect metodu ile beklediğimiz sonucu kontrol ediyoruz
      expect(status, true);
    });

    // test('Favorilerden çıkarma', () {
    //   //Önce 2'rakamını ekleyip sonra çıkarıyoruz
    //   var number = 2;
    //   favorites.add(number);
    //   expect(favorites.items.contains(number), true);
    //   favorites.remove(number);
    //   expect(favorites.items.contains(number), false);
    // });
  });
}
