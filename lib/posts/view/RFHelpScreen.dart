import 'package:flutter/material.dart';
import 'package:hoot/posts/models/settings_model.dart';
import 'package:hoot/posts/utils/constant.dart';
import 'package:hoot/posts/view/RFFAQComponent.dart';
import 'package:hoot/posts/widgets/custom_widgets.dart';
import 'package:nb_utils/nb_utils.dart';

class RFHelpScreen extends StatelessWidget {
  final List<SettingsModel> faqData = faqList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBarWidget(context,
          showLeadingIcon: false,
          title: 'Help',
          roundCornerShape: true,
          appBarHeight: 80),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Frequent Asked Questions', style: boldTextStyle(size: 18))
                .paddingOnly(left: 16, top: 24),
            ListView.builder(
              padding:
                  EdgeInsets.only(right: 16, left: 16, bottom: 16, top: 24),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: 9,
              itemBuilder: (BuildContext context, int index) {
                SettingsModel data = faqData[index % faqData.length];
                return RFFAQComponent(faqData: data);
              },
            ),
          ],
        ),
      ),
    );
  }
}
