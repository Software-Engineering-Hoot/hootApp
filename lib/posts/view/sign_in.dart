import 'package:flutter/material.dart';
import 'package:flutter_infinite_list/posts/utils/RFColors.dart';
import 'package:flutter_infinite_list/posts/view/home.dart';
import 'package:flutter_infinite_list/posts/widgets/RFCommonAppComponent.dart';
import 'package:flutter_infinite_list/posts/widgets/RFWidget.dart';
import 'package:nb_utils/nb_utils.dart';

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

  FocusNode emailFocusNode = FocusNode();
  FocusNode passWordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    await setStatusBarColor(t1_colorPrimary,
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
        title: 'Sa App',
        mainWidgetHeight: 230,
        subWidgetHeight: 170,
        cardWidget: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Sign In to Continue', style: boldTextStyle(size: 18)),
            16.height,
            AppTextField(
              controller: emailController,
              focus: emailFocusNode,
              nextFocus: passWordFocusNode,
              textFieldType: TextFieldType.EMAIL,
              decoration: rfInputDecoration(
                lableText: 'Email Address',
                showLableText: true,
                suffixIcon: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: boxDecorationWithRoundedCorners(
                      boxShape: BoxShape.circle,
                      backgroundColor: t1_app_background),
                  child: const Icon(Icons.done, color: Colors.white, size: 14),
                ),
              ),
            ),
            16.height,
            AppTextField(
              controller: passwordController,
              focus: passWordFocusNode,
              textFieldType: TextFieldType.PASSWORD,
              decoration: rfInputDecoration(
                lableText: 'Password',
                showLableText: true,
              ),
            ),
            32.height,
            AppButton(
              color: t1_colorPrimary,
              width: context.width(),
              elevation: 0,
              onTap: () {
                const Home().launch(context);
              },
              child: Text('Log In', style: boldTextStyle(color: white)),
            ),
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                  child: Text('Reset Password?', style: primaryTextStyle()),
                  onPressed: () {
                    //RFResetPasswordScreen().launch(context);
                  }),
            ),
          ],
        ),
        subWidget: socialLoginWidget(context,
            title1: 'New Member? ', title2: 'Sign up Here', callBack: () {
          ;
        }),
      ),
    );
  }
}
