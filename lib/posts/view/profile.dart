import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hoot/posts/models/advert_model.dart';
import 'package:hoot/posts/models/user_model.dart';
import 'package:hoot/posts/service/advert.dart';
import 'package:hoot/posts/service/auth.dart';
import 'package:hoot/posts/utils/colors.dart';
import 'package:hoot/posts/utils/images.dart';
import 'package:hoot/posts/view/auth/sign_in.dart';
import 'package:hoot/posts/widgets/advert_detail.dart';
import 'package:hoot/posts/widgets/advert_list_item_profile.dart';
import 'package:hoot/posts/widgets/common_app_component.dart';
import 'package:hoot/posts/widgets/custom_widgets.dart';
import 'package:nb_utils/nb_utils.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List<String> categotyData = ['Ilanlarım', 'Favorilerim'];
  List<AdvertModel> myAdverts = [];
  List<AdvertModel> favAdverts = [];
  UserModel user = UserModel();
  final AdvertService _advertService = AdvertService();
  UserModel userModel = UserModel();
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<bool> init() async {
    try {
      user = await _advertService.getUserDetails();
      myAdverts = await _advertService.getUserAdverts();
      favAdverts = await _advertService.getUserFavorites();
      print(favAdverts);
    } catch (e) {
      return false;
    }
    return true;
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RFCommonAppComponent(
        title: 'Account',
        mainWidgetHeight: 200,
        subWidgetHeight: 100,
        accountCircleWidget: Align(
          alignment: Alignment.bottomCenter,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                alignment: Alignment.bottomCenter,
                margin: const EdgeInsets.only(top: 150),
                width: 100,
                height: 100,
                decoration: boxDecorationWithRoundedCorners(
                    boxShape: BoxShape.circle,
                    border: Border.all(color: white, width: 4)),
                child: Container(),
              ),
              // AppButton(onTap: mFormBottomSheet(context, _formKey, user, _authService),child: const Icon(Icons.abc),),
              Positioned(
                bottom: 8,
                right: -4,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  padding: const EdgeInsets.all(6),
                  decoration: boxDecorationWithRoundedCorners(
                    backgroundColor: context.cardColor,
                    boxShape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 0.4,
                          blurRadius: 3,
                          color: gray.withOpacity(0.1),
                          offset: const Offset(1, 6)),
                    ],
                  ),
                  child: const Icon(Icons.add, color: colorPrimary, size: 16),
                ),
              ),
            ],
          ),
        ),
        subWidget: FutureBuilder<bool>(
          future: init(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            List<Widget> children;
            if (snapshot.hasData) {
              children = <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    16.height,
                    Text("${user.name} ${user.surname}",
                            style: boldTextStyle(size: 18))
                        .center(),
                    8.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${myAdverts.length.toString()} Advert',
                            style: secondaryTextStyle()),
                        8.width,
                        Container(
                            height: 10, width: 1, color: gray.withOpacity(0.4)),
                        8.width,
                        Text("${user.favAdvertIDs?.length.toString()} Favorite",
                            style: secondaryTextStyle()),
                      ],
                    ),
                    32.height,
                    Row(
                      children: [
                        OutlinedButton(
                          onPressed: () {
                            launchCall(user.phoneNumber);
                          },
                          style: OutlinedButton.styleFrom(
                            backgroundColor: context.scaffoldBackgroundColor,
                            side: BorderSide(
                                color: context.dividerColor, width: 1),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              call.iconImage(iconColor: colorPrimary),
                              8.width,
                              Text('Call',
                                  style: boldTextStyle(color: colorPrimary)),
                            ],
                          ),
                        ).expand(flex: 3),
                        8.width,
                        AppButton(
                          color: colorPrimary,
                          elevation: 0.0,
                          shapeBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          width: context.width(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              message.iconImage(iconColor: whiteColor),
                              8.width,
                              Text('Message',
                                  style: boldTextStyle(color: white)),
                            ],
                          ),
                          onTap: () {
                            launchMail(user.email);
                          },
                        ).expand(flex: 3),
                        8.width,
                        OutlinedButton(
                          onPressed: () {
                            showConfirmDialogCustom(
                              context,
                              cancelable: false,
                              title: "Are you sure you want to logout?",
                              dialogType: DialogType.CONFIRMATION,
                              onCancel: (v) {
                                finish(context);
                              },
                              onAccept: (v) {
                                SignIn().launch(v).then((value) {
                                  finish(context);
                                });
                              },
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            backgroundColor: context.scaffoldBackgroundColor,
                            side: BorderSide(
                                color: context.dividerColor, width: 1),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              sign_out.iconImage(iconColor: colorPrimary)
                            ],
                          ),
                        ).expand(flex: 1)
                      ],
                    ).paddingSymmetric(horizontal: 16),
                    Container(
                      decoration: boxDecorationWithRoundedCorners(
                        border: Border.all(color: app_background),
                        backgroundColor: context.cardColor,
                      ),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Email', style: boldTextStyle()),
                              Text("${user.email}",
                                  style: secondaryTextStyle()),
                            ],
                          ).paddingSymmetric(horizontal: 24, vertical: 16),
                          Divider(color: context.dividerColor, height: 0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Location', style: boldTextStyle()),
                              Text('Erzincan, Merkez',
                                  style: secondaryTextStyle()),
                            ],
                          ).paddingSymmetric(horizontal: 24, vertical: 16),
                          Divider(color: context.dividerColor, height: 0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Phone No', style: boldTextStyle()),
                              Text('${user.phoneNumber}',
                                  style: secondaryTextStyle()),
                            ],
                          ).paddingSymmetric(horizontal: 24, vertical: 16),
                        ],
                      ),
                    ),
                    HorizontalList(
                      wrapAlignment: WrapAlignment.spaceAround,
                      itemCount: categotyData.length,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      itemBuilder: (_, index) {
                        final data = categotyData[index];
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          decoration: boxDecorationWithRoundedCorners(
                            backgroundColor: selectedIndex == index
                                ? colorPrimary_light
                                : Colors.transparent,
                          ),
                          child: Text(
                            '$data',
                            style: boldTextStyle(
                                color: selectedIndex == index
                                    ? colorPrimary
                                    : gray.withOpacity(0.4)),
                          ),
                        ).onTap(() {
                          selectedIndex = index;
                          setState(() {});
                        },
                            splashColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent);
                      },
                    ),
                    ListView.builder(
                      padding:
                          const EdgeInsets.only(right: 16, left: 16, top: 16),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: selectedIndex == 0
                          ? myAdverts.length
                          : favAdverts.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AdvertDetail(
                                  advert: selectedIndex == 0
                                      ? myAdverts[index]
                                      : favAdverts[index],
                                ),
                              ),
                            );
                          },
                          child: AdvertListItemProfile(
                            advert: selectedIndex == 0
                                ? myAdverts[index]
                                : favAdverts[index],
                          ),
                        );
                      },
                    ),
                    16.height,
                  ],
                ),
              ];
            } else if (snapshot.hasError) {
              children = <Widget>[
                const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('Error: ${snapshot.error}'),
                ),
              ];
            } else {
              children = const <Widget>[
                SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text('Awaiting result...'),
                ),
              ];
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: children,
              ),
            );
          },
        ),
      ),
    );
  }
}

// ignore: inference_failure_on_function_return_type
mFormBottomSheet(BuildContext aContext, Key _formKey, UserModel userModel,
    AuthService _authService) {
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: aContext,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            color: colorPrimary),
        padding: const EdgeInsets.all(16),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                        // if (_formKey.currentState!.validate()) {
                        //   await _authService.signUp(userModel).then((value) {
                        //     if (value) {
                        //       SignIn().launch(context);
                        //     }
                        //   });
                        // }
                      },
                      child:
                          Text('Sign up', style: boldTextStyle(color: white)),
                    ),
                  ],
                ),
              ),
            ]),
      );
    },
  );
}
