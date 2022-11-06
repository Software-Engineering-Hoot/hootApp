import 'package:flutter/material.dart';
import 'package:flutter_infinite_list/posts/models/RoomFinderModel.dart';
import 'package:flutter_infinite_list/posts/utils/RFColors.dart';
import 'package:flutter_infinite_list/posts/utils/RFDataGenerator.dart';
import 'package:flutter_infinite_list/posts/widgets/RFCommonAppComponent.dart';
import 'package:flutter_infinite_list/posts/widgets/RFWidget.dart';
import 'package:nb_utils/nb_utils.dart';

class RFHomeFragment extends StatefulWidget {
  @override
  _RFHomeFragmentState createState() => _RFHomeFragmentState();
}

class _RFHomeFragmentState extends State<RFHomeFragment> {
  List<RoomFinderModel> categoryData = categoryList();
  List<RoomFinderModel> hotelListData = hotelList();
  List<RoomFinderModel> locationListData = locationList();
  //List<RoomFinderModel> recentUpdateData = recentUpdateList();

  int selectCategoryIndex = 0;

  bool locationWidth = true;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    setStatusBarColor(t1_colorPrimary,
        statusBarIconBrightness: Brightness.light);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RFCommonAppComponent(
        title: "SA APp",
        mainWidgetHeight: 200,
        subWidgetHeight: 130,
        cardWidget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Find a property anywhere', style: boldTextStyle(size: 18)),
            16.height,
            AppTextField(
              textFieldType: TextFieldType.EMAIL,
              decoration: rfInputDecoration(
                hintText: "Search address or near you",
                showPreFixIcon: true,
                showLableText: false,
                prefixIcon:
                    Icon(Icons.location_on, color: t1_colorPrimary, size: 18),
              ),
            ),
            16.height,
            AppButton(
              color: t1_colorPrimary,
              elevation: 0.0,
              child: Text('Search Now', style: boldTextStyle(color: white)),
              width: context.width(),
              onTap: () {
                //RFSearchDetailScreen().launch(context);
              },
            ),
            TextButton(
              onPressed: () {
                //
              },
              child: Align(
                alignment: Alignment.topRight,
                child: Text('Advance Search',
                    style: primaryTextStyle(), textAlign: TextAlign.end),
              ),
            )
          ],
        ),
        subWidget: Column(
          children: [
            HorizontalList(
              padding: EdgeInsets.only(right: 16, left: 16),
              wrapAlignment: WrapAlignment.spaceEvenly,
              itemCount: categoryData.length,
              itemBuilder: (BuildContext context, int index) {
                RoomFinderModel data = categoryData[index];

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectCategoryIndex = index;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 8),
                    decoration: boxDecorationWithRoundedCorners(
                        backgroundColor: t1_colorPrimary),
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Text(
                      data.roomCategoryName.validate(),
                      style: boldTextStyle(color: t1_colorPrimary),
                    ),
                  ),
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Recently Added Properties', style: boldTextStyle()),
                TextButton(
                  onPressed: () {
                    //RFViewAllHotelListScreen().launch(context);
                  },
                  child: Text('View All',
                      style: secondaryTextStyle(
                          decoration: TextDecoration.underline,
                          textBaseline: TextBaseline.alphabetic)),
                )
              ],
            ).paddingOnly(left: 16, right: 16, top: 16, bottom: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Locations', style: boldTextStyle()),
                TextButton(
                  onPressed: () {},
                  child: Text('View All',
                      style: secondaryTextStyle(
                          decoration: TextDecoration.underline)),
                )
              ],
            ).paddingOnly(left: 16, right: 16, bottom: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Recent Updates', style: boldTextStyle()),
                TextButton(
                  onPressed: () {},
                  child: Text('See All',
                      style: secondaryTextStyle(
                          decoration: TextDecoration.underline)),
                )
              ],
            ).paddingOnly(left: 16, right: 16, top: 16, bottom: 8),
          ],
        ),
      ),
    );
  }
}
