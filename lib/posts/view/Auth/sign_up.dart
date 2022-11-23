import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_infinite_list/posts/models/user_model.dart';
import 'package:flutter_infinite_list/posts/service/auth.dart';
import 'package:flutter_infinite_list/posts/utils/RFColors.dart';
import 'package:flutter_infinite_list/posts/view/Auth/sign_in.dart';
import 'package:flutter_infinite_list/posts/widgets/RFCommonAppComponent.dart';
import 'package:flutter_infinite_list/posts/widgets/RFWidget.dart';
import 'package:nb_utils/nb_utils.dart';

// ignore: must_be_immutable
class SignUp extends StatefulWidget {
  SignUp({super.key, this.showDialog = false});

  bool showDialog;

  @override
  SignUpState createState() => SignUpState();
}

class SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordCreateController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
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
        title: 'Sign Up',
        mainWidgetHeight: 230,
        subWidgetHeight: 170,
        cardWidget: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Sign Up to Continue', style: boldTextStyle(size: 18)),
            16.height,
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  AppTextField(
                    controller: nameController,
                    textFieldType: TextFieldType.NAME,
                    decoration: rfInputDecoration(
                      lableText: 'Name',
                      showLableText: true,
                    ),
                    onChanged: (value) {
                      user.name = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some name';
                      }
                      return null;
                    },
                  ),
                  16.height,
                  AppTextField(
                    controller: surnameController,
                    textFieldType: TextFieldType.NAME,
                    decoration: rfInputDecoration(
                      lableText: 'Surname',
                      showLableText: true,
                    ),
                    onChanged: (value) {
                      user.surname = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter surname';
                      }
                      return null;
                    },
                  ),
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
                        child: const Icon(Icons.done,
                            color: Colors.white, size: 14),
                      ),
                    ),
                    onChanged: (value) {
                      user.email = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter email address';
                      }
                      return null;
                    },
                  ),
                  16.height,
                  AppTextField(
                    controller: passwordController,
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
                      if (user.password == user.passwordAgain) {
                        return 'Please enter same password';
                      }
                      return null;
                    },
                  ),
                  16.height,
                  AppTextField(
                    controller: passwordController,
                    textFieldType: TextFieldType.PASSWORD,
                    decoration: rfInputDecoration(
                      lableText: 'Password Again',
                      showLableText: true,
                    ),
                    onChanged: (value) {
                      user.passwordAgain = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password again';
                      }
                      if (user.password == user.passwordAgain) {
                        return 'Please enter same password';
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
                            .signUp(nameController.text, surnameController.text,
                                emailController.text, passwordController.text)
                            .then((value) {
                          final user = FirebaseAuth.instance.currentUser;
                          user?.sendEmailVerification().then((value) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Sending Message"),
                            ));
                            SignIn().launch(context);
                          });
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                      }
                    },
                    child: Text('Sign up', style: boldTextStyle(color: white)),
                  ),
                ],
              ),
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
            // AppButton(
            //   color: colorPrimary,
            //   width: context.width(),
            //   elevation: 0,
            //   onTap: () {
            //     _authService
            //         .signUp(
            //       nameController.text,
            //       surnameController.text,
            //       emailCreateController.text,
            //       passwordCreateController.text,
            //     )
            //         .then((value) {
            //       User? user = FirebaseAuth.instance.currentUser;
            //       print(user);
            //       user?.sendEmailVerification();
            //     });
            //   },
            //   child: Text('Sign up', style: boldTextStyle(color: white)),
            // ),
          ],
        ),
      ),
    );
  }
}
