import 'package:flutter/material.dart';
import 'package:hoot/posts/models/user_model.dart';
import 'package:hoot/posts/service/auth.dart';
import 'package:hoot/posts/utils/colors.dart';
import 'package:hoot/posts/view/auth/sign_in.dart';
import 'package:hoot/posts/widgets/common_app_component.dart';
import 'package:hoot/posts/widgets/custom_widgets.dart';
import 'package:nb_utils/nb_utils.dart';

class SignUp extends StatefulWidget {
  SignUp({super.key, this.showDialog = false});

  bool showDialog;

  @override
  SignUpState createState() => SignUpState();
}

class SignUpState extends State<SignUp> {
  UserModel userModel = UserModel();
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
                    textFieldType: TextFieldType.NAME,
                    decoration: rfInputDecoration(
                      lableText: 'Name',
                      showLableText: true,
                    ),
                    onChanged: (value) {
                      userModel.name = value;
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
                    textFieldType: TextFieldType.NAME,
                    decoration: rfInputDecoration(
                      lableText: 'Surname',
                      showLableText: true,
                    ),
                    onChanged: (value) {
                      userModel.surname = value;
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
                    textFieldType: TextFieldType.NAME,
                    decoration: rfInputDecoration(
                      lableText: 'Location: ',
                      showLableText: true,
                    ),
                    onChanged: (value) {
                      userModel.location = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter location';
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
                      userModel.email = value;
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
                    textFieldType: TextFieldType.PASSWORD,
                    decoration: rfInputDecoration(
                      lableText: 'Password',
                      showLableText: true,
                    ),
                    onChanged: (value) {
                      userModel.password = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      }
                      if (userModel.password != userModel.passwordAgain) {
                        return 'Please enter same password';
                      }
                      return null;
                    },
                  ),
                  16.height,
                  AppTextField(
                    textFieldType: TextFieldType.PASSWORD,
                    decoration: rfInputDecoration(
                      lableText: 'Password Again',
                      showLableText: true,
                    ),
                    onChanged: (value) {
                      userModel.passwordAgain = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password again';
                      }
                      if (userModel.password != userModel.passwordAgain) {
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
                        await _authService.signUp(userModel).then((value) {
                          if (value) {
                            SignIn().launch(context);
                          }
                        });
                      }
                    },
                    child: Text('Sign up', style: boldTextStyle(color: white)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
