import 'package:flutter/material.dart';
import 'package:hoot/posts/widgets/custom_widgets.dart';
import 'package:nb_utils/nb_utils.dart';

class RFAboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBarWidget(context,
          showLeadingIcon: false,
          title: 'About Us',
          roundCornerShape: true,
          appBarHeight: 80),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            16.height,
            // rfCommonCachedNetworkImage(rf_aboutUs, fit: BoxFit.cover, height: 150, width: context.width()),
            Container(
              decoration: boxDecorationRoundedWithShadow(8,
                  backgroundColor: context.cardColor),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              margin: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Hello Hoot!', style: boldTextStyle()),
                  8.height,
                  Text(
                      'At Hoot, our mission is to make it easy for pet owners to find the best care for their lovely friends. If you need a sitter for a few hours or a few weeks, Hoot is here for you.',
                      style: secondaryTextStyle()),
                  16.height,
                  Text('About the Members', style: boldTextStyle()),
                  8.height,
                  Text(
                    "With Hoot, you can search and compare a wide range of caregivers that includes individuals, companies, and professional organisations. With our easy-to-use platform, you can contact a caregiver with just a few taps, so you can count on the care your pet will receive.",
                    style: secondaryTextStyle(),
                  ),
                  8.height,
                  Text(
                    "We understand that your pet is an important member of your family and we are dedicated to finding the best care for them. Thank you for choosing Hoot!",
                    style: secondaryTextStyle(),
                  ),
                  8.height,
                  Text(
                    "If you have any questions or need help, feel free to write to info.hootapp@gmail.com. We are always here to assist you.",
                    style: secondaryTextStyle(),
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
