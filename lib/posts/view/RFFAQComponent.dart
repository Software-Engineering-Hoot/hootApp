import 'package:flutter/material.dart';
import 'package:hoot/posts/models/settings_model.dart';
import 'package:hoot/posts/utils/colors.dart';
import 'package:hoot/posts/widgets/custom_widgets.dart';
import 'package:nb_utils/nb_utils.dart';

class RFFAQComponent extends StatelessWidget {
  final SettingsModel faqData;

  RFFAQComponent({required this.faqData});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      width: context.width(),
      margin: EdgeInsets.only(bottom: 16),
      decoration:
          boxDecorationRoundedWithShadow(8, backgroundColor: context.cardColor),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              decoration: boxDecorationWithRoundedCorners(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                backgroundColor: faqBgColor,
              ),
              padding: EdgeInsets.all(8),
              child: faqData.img.validate().iconImage(iconColor: colorPrimary)),
          16.width,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(faqData.price.validate(), style: boldTextStyle()),
              12.height,
              Text(faqData.description.validate(),
                  style: secondaryTextStyle(),
                  maxLines: 10,
                  overflow: TextOverflow.ellipsis),
            ],
          ).expand(),
        ],
      ),
    );
  }
}
