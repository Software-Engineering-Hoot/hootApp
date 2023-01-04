import 'package:flutter/material.dart';
import 'package:hoot/posts/models/user_model.dart';
import 'package:hoot/posts/service/auth.dart';
import 'package:hoot/posts/utils/colors.dart';
import 'package:hoot/posts/view/auth/sign_in.dart';
import 'package:hoot/posts/widgets/common_app_component.dart';
import 'package:hoot/posts/widgets/custom_widgets.dart';
import 'package:nb_utils/nb_utils.dart';

class ResetPassword extends StatefulWidget {
  ResetPassword({super.key, this.showDialog = false});

  bool showDialog;

  @override
  ResetPasswordState createState() => ResetPasswordState();
}

class ResetPasswordState extends State<ResetPassword> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  final email = TextEditingController();

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
        title: 'Reset Password',
        mainWidgetHeight: 230,
        subWidgetHeight: 170,
        cardWidget: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            16.height,
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
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
                      email.text = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter email';
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
                            .resetPassword(email.text)
                            .then((value) {
                          if (value) {
                            SignIn().launch(context);
                          }
                        });
                      }
                    },
                    child: Text('Reset', style: boldTextStyle(color: white)),
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
