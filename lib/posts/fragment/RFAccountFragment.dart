import 'package:flutter/material.dart';
import 'package:flutter_infinite_list/posts/utils/RFColors.dart';
import 'package:flutter_infinite_list/posts/widgets/RFCommonAppComponent.dart';
import 'package:nb_utils/nb_utils.dart';

class RFAccountFragment extends StatefulWidget {
  @override
  State<RFAccountFragment> createState() => _RFAccountFragmentState();
}

class _RFAccountFragmentState extends State<RFAccountFragment> {
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
                  margin: EdgeInsets.only(top: 150),
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
                  padding: EdgeInsets.all(6),
                  decoration: boxDecorationWithRoundedCorners(
                    backgroundColor: context.cardColor,
                    boxShape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 0.4,
                          blurRadius: 3,
                          color: gray.withOpacity(0.1),
                          offset: Offset(1, 6)),
                    ],
                  ),
                  child: Icon(Icons.add, color: t1_colorPrimary, size: 16),
                ),
              ),
            ],
          ),
        ),
        subWidget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            16.height,
            Text('Courtney Henry', style: boldTextStyle(size: 18)).center(),
            8.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('10 Applied', style: secondaryTextStyle()),
                8.width,
                Container(height: 10, width: 1, color: gray.withOpacity(0.4)),
                8.width,
                Text('Kathmandu', style: secondaryTextStyle()),
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
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // rf_call.iconImage(iconColor: appStore.isDarkModeOn ? white : rf_primaryColor),
                      8.width,
                      Text('Call Me',
                          style: boldTextStyle(color: t1_colorPrimary)),
                    ],
                  ),
                ).expand(),
                16.width,
                AppButton(
                  color: t1_colorPrimary,
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
                border: Border.all(color: t1_app_background),
                backgroundColor: context.cardColor,
              ),
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Email', style: boldTextStyle()),
                      Text('henry11@gmail.com', style: secondaryTextStyle()),
                    ],
                  ).paddingSymmetric(horizontal: 24, vertical: 16),
                  Divider(color: context.dividerColor, height: 0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Location', style: boldTextStyle()),
                      Text('Kathmandu, Nepal', style: secondaryTextStyle()),
                    ],
                  ).paddingSymmetric(horizontal: 24, vertical: 16),
                  Divider(color: context.dividerColor, height: 0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Phone No', style: boldTextStyle()),
                      Text('(+977) 9125331510', style: secondaryTextStyle()),
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
