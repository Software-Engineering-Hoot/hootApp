import 'package:flutter/material.dart';
import 'package:flutter_infinite_list/posts/utils/colors.dart';
import 'package:flutter_infinite_list/posts/widgets/common_app_component.dart';
import 'package:nb_utils/nb_utils.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // final List<RoomFinderModel> settingData = settingList();
  // final List<RoomFinderModel> appliedHotelData = appliedHotelList();
  // final List<RoomFinderModel> applyHotelData = applyHotelList();

  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RFCommonAppComponent(
        title: "Account",
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
        subWidget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            16.height,
            Text('Sefa Cahyir', style: boldTextStyle(size: 18)).center(),
            8.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('2 Advert', style: secondaryTextStyle()),
                8.width,
                Container(height: 10, width: 1, color: gray.withOpacity(0.4)),
                8.width,
                Text('Erzincan', style: secondaryTextStyle()),
              ],
            ),
            32.height,
            Row(
              children: [
                OutlinedButton(
                  onPressed: () {
                    //launchCall("1234567890");
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: context.scaffoldBackgroundColor,
                    side: BorderSide(color: context.dividerColor, width: 1),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // rf_call.iconImage(iconColor: appStore.isDarkModeOn ? white : rf_primaryColor),
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
                      //rf_message.iconImage(iconColor: whiteColor),
                      // rfCommonCachedNetworkImage(rf_message, color: white, height: 16, width: 16),
                      8.width,
                      Text('Message Me', style: boldTextStyle(color: white)),
                    ],
                  ),
                  onTap: () {
                    //launchMail("demo@gmail.com");
                  },
                ).expand()
              ],
            ).paddingSymmetric(horizontal: 16),
            Container(
              decoration: boxDecorationWithRoundedCorners(
                border: Border.all(color: app_background),
                backgroundColor: context.cardColor,
              ),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Email', style: boldTextStyle()),
                      Text('sefacahyir@gmail.com', style: secondaryTextStyle()),
                    ],
                  ).paddingSymmetric(horizontal: 24, vertical: 16),
                  Divider(color: context.dividerColor, height: 0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Location', style: boldTextStyle()),
                      Text('Erzincan, Merkez', style: secondaryTextStyle()),
                    ],
                  ).paddingSymmetric(horizontal: 24, vertical: 16),
                  Divider(color: context.dividerColor, height: 0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Phone No', style: boldTextStyle()),
                      Text('(+90) 5527862400', style: secondaryTextStyle()),
                    ],
                  ).paddingSymmetric(horizontal: 24, vertical: 16),
                ],
              ),
            ),
            16.height,
          ],
        ),
      ),
    );
  }
}