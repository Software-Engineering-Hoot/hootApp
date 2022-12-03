import 'package:flutter/material.dart';
import 'package:flutter_infinite_list/posts/models/advert_model.dart';
import 'package:flutter_infinite_list/posts/service/auth.dart';
import 'package:flutter_infinite_list/posts/utils/colors.dart';
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
  late AdvertModel advert = AdvertModel();

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
                    textFieldType: TextFieldType.NAME,
                    decoration: rfInputDecoration(
                      lableText: 'Title',
                      showLableText: true,
                    ),
                    onChanged: (value) {
                      advert.title = value;
                    },
                    validator: (value) {
                      return value.isEmptyOrNull ? null : 'Please enter title';
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
                      return value.isEmptyOrNull
                          ? null
                          : 'Please enter pet type';
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
                      return value.isEmptyOrNull
                          ? null
                          : 'Please enter address';
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
                      return value.isEmptyOrNull
                          ? null
                          : 'Please enter start date';
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
                      return value.isEmptyOrNull
                          ? null
                          : 'Please enter end date';
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
                      return value.isEmptyOrNull ? null : 'Please enter price';
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
                      return value.isEmptyOrNull
                          ? null
                          : 'Please enter description';
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
