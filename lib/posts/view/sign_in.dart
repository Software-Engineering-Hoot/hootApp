import 'package:flutter/material.dart';
import 'package:flutter_infinite_list/posts/models/user_model.dart';
import 'package:flutter_infinite_list/posts/service/auth.dart';
import 'package:flutter_infinite_list/posts/utils/RFColors.dart';
import 'package:flutter_infinite_list/posts/view/home.dart';
import 'package:flutter_infinite_list/posts/widgets/RFCommonAppComponent.dart';
import 'package:flutter_infinite_list/posts/widgets/RFWidget.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ignore: must_be_immutable
class SignIn extends StatefulWidget {
  SignIn({super.key, this.showDialog = false});

  bool showDialog;

  @override
  SignInState createState() => SignInState();
}

class SignInState extends State<SignIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailCreateController = TextEditingController();
  TextEditingController passwordCreateController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  UserModel user = UserModel();
  AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    await setStatusBarColor(colorPrimary,
        statusBarIconBrightness: Brightness.light);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RFCommonAppComponent(
        title: 'Hoot App',
        mainWidgetHeight: 230,
        subWidgetHeight: 170,
        cardWidget: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Sign In to Continue', style: boldTextStyle(size: 18)),
            16.height,
            AppTextField(
              controller: emailController,
              textFieldType: TextFieldType.EMAIL,
              decoration: rfInputDecoration(
                lableText: 'Email Address',
                showLableText: true,
                suffixIcon: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: boxDecorationWithRoundedCorners(
                      boxShape: BoxShape.circle,
                      backgroundColor: app_background),
                  child: const Icon(Icons.done, color: Colors.white, size: 14),
                ),
              ),
            ),
            16.height,
            AppTextField(
              controller: passwordController,
              textFieldType: TextFieldType.PASSWORD,
              decoration: rfInputDecoration(
                lableText: 'Password',
                showLableText: true,
              ),
            ),
            32.height,
            AppButton(
              color: colorPrimary,
              width: context.width(),
              elevation: 0,
              onTap: () async {
                await _authService
                    .signIn(emailController.text, passwordController.text)
                    .then((value) {
                  if (value != null) {
                    const Home().launch(context);
                  }
                });
              },
              child: Text('Log In', style: boldTextStyle(color: white)),
            ),
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                child: Text('Reset Password?', style: primaryTextStyle()),
                onPressed: () {
                  //RFResetPasswordScreen().launch(context);
                },
              ),
            ),
            AppTextField(
              controller: nameController,
              textFieldType: TextFieldType.NAME,
              decoration: rfInputDecoration(
                lableText: 'name',
                showLableText: true,
              ),
            ),
            AppTextField(
              controller: surnameController,
              textFieldType: TextFieldType.NAME,
              decoration: rfInputDecoration(
                lableText: 'surname',
                showLableText: true,
              ),
            ),
            AppTextField(
              controller: emailCreateController,
              textFieldType: TextFieldType.EMAIL,
              decoration: rfInputDecoration(
                lableText: 'email',
                showLableText: true,
              ),
            ),
            AppTextField(
              controller: passwordCreateController,
              textFieldType: TextFieldType.PASSWORD,
              decoration: rfInputDecoration(
                lableText: 'password',
                showLableText: true,
              ),
            ),
            AppButton(
              color: colorPrimary,
              width: context.width(),
              elevation: 0,
              onTap: () {
                _authService
                    .signUp(
                  nameController.text,
                  surnameController.text,
                  emailCreateController.text,
                  passwordCreateController.text,
                )
                    .then((value) {
                  User? user = FirebaseAuth.instance.currentUser;
                  print(user);
                  user?.sendEmailVerification();
                });
              },
              child: Text('Sign up', style: boldTextStyle(color: white)),
            ),
          ],
        ),
        subWidget: socialLoginWidget(
          context,
          title1: 'New Member? ',
          title2: 'Sign up Here',
          callBack: () {},
        ),
      ),
    );
  }
}
