import 'package:flutter/material.dart';
import 'package:hoot/posts/models/advert_model.dart';
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
  List<AdvertModel> adverts = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<bool> init() async {
    try {
      adverts = await _advertService.getUserNotificaitons();
      print(adverts);
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
      body: FutureBuilder<bool>(
        future: init(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData && adverts.isNotEmpty) {
            return SingleChildScrollView(
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
                    padding:
                        const EdgeInsets.only(right: 16, left: 16, bottom: 4),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: adverts.length,
                    itemBuilder: (BuildContext context, int index) {
                      return NotificationWidget(
                        title: "Favoriye Eklendi \n",
                        start: "Bir kullanıcı ",
                        advert: "${adverts[index].title}",
                        end: " ilanını favoriye ekledi ",
                      );
                    },
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            Column(
              children: [
                const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('Error: ${snapshot.error}'),
                ),
              ],
            );
          } else {
            Column(
              children: const [
                SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text('Awaiting result...'),
                ),
              ],
            );
          }
          return Center(
              child: Column(
            children: const [
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Awaiting result...'),
              ),
            ],
          ));
        },
      ),
    );
  }
}
