import 'package:flutter/material.dart';
import 'package:flutter_infinite_list/posts/models/advert_model.dart';
import 'package:flutter_infinite_list/posts/models/user_model.dart';
import 'package:flutter_infinite_list/posts/service/advert.dart';
import 'package:flutter_infinite_list/posts/utils/colors.dart';
import 'package:flutter_infinite_list/posts/widgets/advert_detail_info.dart';
import 'package:nb_utils/nb_utils.dart';

class AdvertDetail extends StatefulWidget {
  AdvertDetail({super.key, required this.advert});

  final AdvertModel advert;

  @override
  State<AdvertDetail> createState() => _AdvertDetailState();
}

class _AdvertDetailState extends State<AdvertDetail> {
  final AdvertModel? newAdd = AdvertModel();
  final AdvertService _advertService = AdvertService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AppButton(
        color: colorPrimary,
        elevation: 0,
        child: Text('Add To Favorites', style: boldTextStyle(color: white)),
        width: context.width(),
        onTap: () {
          _advertService.addAdvertFavorite(widget.advert);
        },
      ).paddingSymmetric(horizontal: 16, vertical: 24),
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
                      widget.advert.photos!.first,
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
              AdvertDetailIfo(hotelData: widget.advert),
            ],
          ),
        ),
      ),
    );
  }
}
