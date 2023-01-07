import 'package:flutter/material.dart';
import 'package:hoot/posts/view/auth/sign_in.dart';
import 'package:one_context/one_context.dart';

class App extends MaterialApp {
  App({super.key})
      : super(
            builder: OneContext().builder,
            navigatorKey: OneContext().key,
            home: SignIn());
}
