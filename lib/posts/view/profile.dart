import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_infinite_list/posts/models/advert_model.dart';
import 'package:flutter_infinite_list/posts/models/user_model.dart';
import 'package:flutter_infinite_list/posts/service/advert.dart';
import 'package:flutter_infinite_list/posts/utils/colors.dart';
import 'package:flutter_infinite_list/posts/utils/images.dart';
import 'package:flutter_infinite_list/posts/widgets/common_app_component.dart';
import 'package:flutter_infinite_list/posts/widgets/advert_list_item.dart';
import 'package:flutter_infinite_list/posts/widgets/custom_widgets.dart';
import 'package:nb_utils/nb_utils.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // final List<RoomFinderModel> settingData = settingList();
  // final List<RoomFinderModel> appliedHotelData = appliedHotelList();
  // final List<RoomFinderModel> applyHotelData = applyHotelList();
  List<String> categotyData = ['Ilanlarım', 'Favorilerim'];
  List<AdvertModel> myAdverts = [];
  List<AdvertModel> favAdverts = [];
  UserModel user = UserModel();
  final AdvertService _advertService = AdvertService();

  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<bool> init() async {
    try {
      myAdverts = await _advertService.getUserAdvers();
      favAdverts = await _advertService.getAdvert();
      user = await _advertService.getUserDetails();
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
                  child: Container()),
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
                              Text('Call Me',
                                  style: boldTextStyle(color: colorPrimary)),
                            ],
                          ),
                        ).expand(),
                        16.width,
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
                              Text('Message Me',
                                  style: boldTextStyle(color: white)),
                            ],
                          ),
                          onTap: () {
                            launchMail(user.email);
                          },
                        ).expand()
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
                            '$data (${selectedIndex == 0 ? myAdverts.length : favAdverts.length})',
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
                        return AdvertListItem(
                            post: selectedIndex == 0
                                ? myAdverts[index]
                                : favAdverts[index]);
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
