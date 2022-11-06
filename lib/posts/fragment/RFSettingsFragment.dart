import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:flutter_infinite_list/posts/models/RoomFinderModel.dart';
import 'package:flutter_infinite_list/posts/utils/RFColors.dart';
import 'package:flutter_infinite_list/posts/utils/RFDataGenerator.dart';
import 'package:flutter_infinite_list/posts/widgets/RFCommonAppComponent.dart';
import 'package:flutter_infinite_list/posts/utils/RFImages.dart';
import 'package:flutter_infinite_list/posts/widgets/RFWidget.dart';

class RFSettingsFragment extends StatelessWidget {
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
          children: [
            16.height,
            Text('Courtney Henry', style: boldTextStyle(size: 18)),
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
            16.height,
            Container(
              margin: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              decoration: boxDecorationWithRoundedCorners(
                backgroundColor: t1_colorPrimary,
              ),
              padding: EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  rf_person
                      .iconImage(iconColor: t1_colorPrimary)
                      .paddingOnly(top: 4),
                  16.width,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Edit Profile",
                          style: boldTextStyle(color: t1_colorPrimary)),
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
          ],
        ),
      ),
    );
  }
}
