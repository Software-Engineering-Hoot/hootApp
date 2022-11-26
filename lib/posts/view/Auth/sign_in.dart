import 'package:flutter/material.dart';
import 'package:flutter_infinite_list/posts/models/user_model.dart';
import 'package:flutter_infinite_list/posts/service/auth.dart';
import 'package:flutter_infinite_list/posts/utils/colors.dart';
import 'package:flutter_infinite_list/posts/view/auth/sign_up.dart';
import 'package:flutter_infinite_list/posts/view/home.dart';
import 'package:flutter_infinite_list/posts/widgets/common_app_component.dart';
import 'package:flutter_infinite_list/posts/widgets/custom_widgets.dart';
import 'package:nb_utils/nb_utils.dart';

// ignore: must_be_immutable
class SignIn extends StatefulWidget {
  SignIn({super.key, this.showDialog = false});

  bool showDialog;

  @override
  SignInState createState() => SignInState();
}

class SignInState extends State<SignIn> {
  UserModel user = UserModel();
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();

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
        cardWidget: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Sign In to Continue', style: boldTextStyle(size: 18)),
              16.height,
              AppTextField(
                textFieldType: TextFieldType.EMAIL,
                decoration: rfInputDecoration(
                  lableText: 'Email Address',
                  showLableText: true,
                  suffixIcon: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: boxDecorationWithRoundedCorners(
                        boxShape: BoxShape.circle,
                        backgroundColor: app_background),
                    child:
                        const Icon(Icons.done, color: Colors.white, size: 14),
                  ),
                ),
                onChanged: (value) {
                  user.email = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter email';
                  }
                  return null;
                },
              ),
              16.height,
              AppTextField(
                textFieldType: TextFieldType.PASSWORD,
                decoration: rfInputDecoration(
                  lableText: 'Password',
                  showLableText: true,
                ),
                onChanged: (value) {
                  user.password = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter password';
                  }
                  return null;
                },
              ),
              32.height,
              AppButton(
                color: colorPrimary,
                width: context.width(),
                elevation: 0,
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    await _authService
                        .signIn(user.email!, user.password!)
                        .then((value) {
                      if (value) {
                        const Home().launch(context);
                      }
                    });
                  }
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
            ],
          ),
        ),
        subWidget: socialLoginWidget(
          context,
          title1: 'New Member? ',
          title2: 'Sign up Here',
          callBack: () {
            SignUp().launch(context);
          },
        ),
      ),
    );
  }
}
