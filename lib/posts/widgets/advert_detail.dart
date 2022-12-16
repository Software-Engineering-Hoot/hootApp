import 'package:flutter/material.dart';
import 'package:flutter_infinite_list/posts/models/advert_model.dart';
import 'package:flutter_infinite_list/posts/utils/colors.dart';
import 'package:flutter_infinite_list/posts/widgets/advert_detail_info.dart';
import 'package:nb_utils/nb_utils.dart';

class AdvertDetail extends StatelessWidget {
  AdvertDetail({super.key, required this.post});

  final AdvertModel post;
  final AdvertModel? newAdd = AdvertModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: AppButton(
      //   color: colorPrimary,
      //   elevation: 0,
      //   child: Text('Book Now', style: boldTextStyle(color: white)),
      //   width: context.width(),
      //   onTap: () {
      //     showInDialog(context, barrierDismissible: true, builder: (context) {
      //       return RFCongratulatedDialog();
      //     });
      //   },
      // ).paddingSymmetric(horizontal: 16, vertical: 24),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios_new,
                    color: colorPrimary, size: 18),
                onPressed: () {
                  finish(context);
                },
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16)),
              ),
              backgroundColor: colorPrimary,
              pinned: true,
              elevation: 2,
              expandedHeight: 300,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                titlePadding: EdgeInsets.all(10),
                centerTitle: true,
                background: Stack(
                  children: [
                    Image.network(
                      post.photos!.first,
                      fit: BoxFit.cover,
                      height: 350,
                      width: context.width(),
                    ),
                    // rfCommonCachedNetworkImage(
                    //   widget.hotelData!.img.validate(),
                    //   fit: BoxFit.cover,
                    //   width: context.width(),
                    //   height: 350,
                    // ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("widget.hotelData",
                              style: boldTextStyle(color: white, size: 18)),
                          8.height,
                          Row(
                            children: [
                              Text("widget.hotelData ",
                                  style: boldTextStyle(color: white)),
                              Text("widget.hotelData!.",
                                  style: secondaryTextStyle(color: white)),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            children: [
              AdvertDetailIfo(hotelData: post),
            ],
          ),
        ),
      ),
    );
  }
}
