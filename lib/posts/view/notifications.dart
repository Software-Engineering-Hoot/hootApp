import 'package:flutter/material.dart';
import 'package:hoot/posts/service/advert.dart';
import 'package:hoot/posts/widgets/custom_widgets.dart';
import 'package:hoot/posts/widgets/notificaition_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final AdvertService _advertService = AdvertService();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<bool> init() async {
    try {
      // user = await _advertService();
      // myAdverts = await _advertService.getUserAdverts();
      // favAdverts = await _advertService.getAdvert();
      // print(favAdverts);
    } catch (e) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBarWidget(context,
          showLeadingIcon: false,
          title: 'Notifications',
          roundCornerShape: true,
          appBarHeight: 80),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Today', style: boldTextStyle(size: 18)),
                TextButton(
                    onPressed: () {},
                    child: Text('', style: secondaryTextStyle())),
              ],
            ).paddingOnly(left: 16, right: 16, top: 16),
            ListView.builder(
              padding: const EdgeInsets.only(right: 16, left: 16, bottom: 4),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 2,
              itemBuilder: (BuildContext context, int index) {
                return const NotificationWidget(
                  title: "11.02.2022",
                  subTitle: "Notfiiiss",
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
