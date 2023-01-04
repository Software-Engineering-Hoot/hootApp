import 'package:flutter/material.dart';
import 'package:hoot/posts/models/settings_model.dart';
import 'package:hoot/posts/models/user_model.dart';
import 'package:hoot/posts/service/advert.dart';
import 'package:hoot/posts/utils/colors.dart';
import 'package:hoot/posts/utils/constant.dart';
import 'package:hoot/posts/utils/images.dart';
import 'package:hoot/posts/view/Auth/sign_up.dart';
import 'package:hoot/posts/view/auth/sign_in.dart';
import 'package:hoot/posts/view/dashboard.dart';
import 'package:hoot/posts/widgets/common_app_component.dart';
import 'package:hoot/posts/widgets/custom_widgets.dart';
import 'package:hoot/posts/widgets/edit_user_bottom_sheet.dart';
import 'package:nb_utils/nb_utils.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final List<SettingsModel> settingData = settingList();
  final AdvertService _advertService = AdvertService();
  UserModel currentUser = UserModel();
  final _formKey = GlobalKey<FormState>();
  String imageUrl = '';

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<bool> init() async {
    try {
      currentUser = await _advertService.getUserDetails();
      imageUrl = currentUser.profilPic ?? user;
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
    return FutureBuilder<bool>(
        future: init(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              body: RFCommonAppComponent(
                title: "Settings",
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
                          border: Border.all(color: white, width: 4),
                        ),
                        child: CircleAvatar(
                          radius: 50.0,
                          backgroundImage: NetworkImage(imageUrl),
                          backgroundColor: Colors.transparent,
                        ),
                      ),
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
                          child: const Icon(Icons.add,
                              color: colorPrimary, size: 16),
                        ),
                      ),
                    ],
                  ),
                ),
                subWidget: Column(
                  children: [
                    16.height,
                    Text('${currentUser.name} ${currentUser.surname}',
                        style: boldTextStyle(size: 18)),
                    16.height,
                    InkWell(
                      onTap: () {
                        editUserBottomSheet(context, currentUser, _formKey)
                            .then(
                          (_) => setState(
                            () {},
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 24),
                        decoration: boxDecorationWithRoundedCorners(
                          backgroundColor: colorBox,
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            person
                                .iconImage(iconColor: colorPrimary)
                                .paddingOnly(top: 4),
                            16.width,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Edit Profile",
                                    style: boldTextStyle(color: colorPrimary)),
                                8.height,
                                Text(
                                  "Edit all the basic profile information associated with your profile",
                                  style: secondaryTextStyle(color: gray),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ).expand(),
                          ],
                        ),
                      ),
                    ),
                    ListView.builder(
                      padding: const EdgeInsets.only(left: 22),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: settingData.length,
                      itemBuilder: (BuildContext context, int index) {
                        SettingsModel data = settingData[index];
                        return Container(
                          margin: const EdgeInsets.only(right: 24),
                          child: SettingItemWidget(
                            title: data.roomCategoryName.validate(),
                            leading: data.img
                                .validate()
                                .iconImage(iconColor: colorPrimary, size: 18),
                            titleTextStyle: primaryTextStyle(),
                            onTap: () {
                              if (index == 3) {
                                showConfirmDialogCustom(
                                  context,
                                  cancelable: false,
                                  title: "Are you sure you want to logout?",
                                  primaryColor: colorPrimary,
                                  dialogType: DialogType.CONFIRMATION,
                                  onCancel: (v) {
                                    finish(context);
                                  },
                                  onAccept: (v) {
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) => SignIn()),
                                        (Route<dynamic> route) => false);
                                  },
                                );
                              } else {
                                data.newScreenWidget.validate().launch(context);
                              }
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('Error: ${snapshot.error}'),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text('Awaiting result...'),
                  ),
                ],
              ),
            );
          }
        });
  }
}
