import 'package:flutter/material.dart';
import 'package:hoot/posts/utils/colors.dart';
import 'package:hoot/posts/utils/images.dart';
import 'package:hoot/posts/widgets/custom_widgets.dart';
import 'package:nb_utils/nb_utils.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget(
      {super.key, this.title, this.start, this.advert, this.end});
  final String? title;
  final String? start;
  final String? advert;
  final String? end;

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
          Container(
            width: context.width() * 0.70,
            child: RichText(
              maxLines: 4,
              overflow: TextOverflow.clip,
              text: TextSpan(
                text: title,
                style: boldTextStyle(),
                children: <TextSpan>[
                  TextSpan(text: start, style: primaryTextStyle()),
                  TextSpan(text: advert, style: TextStyle(color: colorPrimary)),
                  TextSpan(text: end, style: primaryTextStyle()),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
