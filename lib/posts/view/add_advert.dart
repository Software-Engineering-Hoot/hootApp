import 'package:flutter/material.dart';
import 'package:flutter_infinite_list/posts/models/user_model.dart';
import 'package:flutter_infinite_list/posts/service/auth.dart';
import 'package:flutter_infinite_list/posts/utils/colors.dart';
import 'package:flutter_infinite_list/posts/view/auth/sign_in.dart';
import 'package:flutter_infinite_list/posts/widgets/common_app_component.dart';
import 'package:flutter_infinite_list/posts/widgets/custom_widgets.dart';
import 'package:nb_utils/nb_utils.dart';

class AddAdvert extends StatefulWidget {
  AddAdvert({super.key, this.showDialog = false});

  bool showDialog;

  @override
  AddAdvertState createState() => AddAdvertState();
}

class AddAdvertState extends State<AddAdvert> {
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
        title: 'Add Advert',
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
                    controller: email,
                    textFieldType: TextFieldType.NAME,
                    decoration: rfInputDecoration(
                      lableText: 'Title',
                      showLableText: true,
                    ),
                    onChanged: (value) {
                      email.text = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter title';
                      }
                      return null;
                    },
                  ),
                  16.height,
                  AppTextField(
                    controller: email,
                    textFieldType: TextFieldType.NAME,
                    decoration: rfInputDecoration(
                      lableText: 'Pet Type',
                      showLableText: true,
                    ),
                    onChanged: (value) {
                      email.text = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter pet type';
                      }
                      return null;
                    },
                  ),
                  16.height,
                  AppTextField(
                    controller: email,
                    textFieldType: TextFieldType.NAME,
                    decoration: rfInputDecoration(
                      lableText: 'Address',
                      showLableText: true,
                    ),
                    onChanged: (value) {
                      email.text = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter address';
                      }
                      return null;
                    },
                  ),
                  16.height,
                  AppTextField(
                    controller: email,
                    textFieldType: TextFieldType.NAME,
                    decoration: rfInputDecoration(
                      lableText: 'Start Date',
                      showLableText: true,
                    ),
                    onChanged: (value) {
                      email.text = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter start date';
                      }
                      return null;
                    },
                  ),
                  16.height,
                  AppTextField(
                    controller: email,
                    textFieldType: TextFieldType.NAME,
                    decoration: rfInputDecoration(
                      lableText: 'End Date',
                      showLableText: true,
                    ),
                    onChanged: (value) {
                      email.text = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter end date';
                      }
                      return null;
                    },
                  ),
                  16.height,
                  AppTextField(
                    controller: email,
                    textFieldType: TextFieldType.NAME,
                    decoration: rfInputDecoration(
                      lableText: 'Price',
                      showLableText: true,
                    ),
                    onChanged: (value) {
                      email.text = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter price';
                      }
                      return null;
                    },
                  ),
                  16.height,
                  AppTextField(
                    controller: email,
                    textFieldType: TextFieldType.NAME,
                    decoration: rfInputDecoration(
                      lableText: 'Description',
                      showLableText: true,
                    ),
                    onChanged: (value) {
                      email.text = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter description';
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
                      // if (_formKey.currentState!.validate()) {
                      //   await _authService
                      //       .AddAdvert(email.text)
                      //       .then((value) {
                      //     if (value) {
                      //       SignIn().launch(context);
                      //     }
                      //   });
                      // }
                    },
                    child: Text('Add', style: boldTextStyle(color: white)),
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
