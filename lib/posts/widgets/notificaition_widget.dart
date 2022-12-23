import 'package:flutter/material.dart';
import 'package:hoot/posts/utils/colors.dart';
import 'package:hoot/posts/utils/images.dart';
import 'package:hoot/posts/widgets/custom_widgets.dart';
import 'package:nb_utils/nb_utils.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({super.key, this.title, this.subTitle});
  final String? title;
  final String? subTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: boxDecorationWithRoundedCorners(
        border: Border.all(color: gray.withOpacity(0.3)),
        backgroundColor: context.cardColor,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: boxDecorationWithRoundedCorners(
              backgroundColor: notificationBgColor,
              borderRadius: const BorderRadius.all(Radius.circular(4)),
            ),
            child: Stack(
              children: [
                notification.iconImage(iconColor: black),
                Positioned(
                  top: 1,
                  right: 1,
                  child: Container(
                    width: 6,
                    height: 6,
                    decoration: boxDecorationWithRoundedCorners(
                      boxShape: BoxShape.circle,
                      backgroundColor: redColor,
                    ),
                  ),
                )
              ],
            ),
          ),
          16.width,
          rfCommonRichText(
            title: title.validate(),
            subTitle: subTitle.validate(),
            titleTextStyle: primaryTextStyle(),
            subTitleTextStyle: boldTextStyle(),
          ).flexible()
        ],
      ),
    );
  }
}
