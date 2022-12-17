import 'package:flutter/material.dart';
import 'package:hoot/posts/models/advert_model.dart';
import 'package:hoot/posts/service/advert.dart';
import 'package:hoot/posts/utils/colors.dart';
import 'package:hoot/posts/view/edit_advert.dart';
import 'package:hoot/posts/widgets/advert_detail_info.dart';
import 'package:nb_utils/nb_utils.dart';

class AdvertDetail extends StatefulWidget {
  AdvertDetail({super.key, required this.advert});

  final AdvertModel advert;

  @override
  State<AdvertDetail> createState() => _AdvertDetailState();
}

class _AdvertDetailState extends State<AdvertDetail> {
  final AdvertService _advertService = AdvertService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AppButton(
        color: colorPrimary,
        elevation: 0,
        width: context.width(),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EditAdvert(advert: widget.advert)),
          );
        },
        child: Text('Edit Advert', style: boldTextStyle(color: white)),
      ).paddingSymmetric(horizontal: 16, vertical: 24),
      // bottomNavigationBar: AppButton(
      //   color: colorPrimary,
      //   elevation: 0,
      //   width: context.width(),
      //   onTap: () {
      //     _advertService.addAdvertFavorite(widget.advert);
      //   },
      //   child: Text('Add To Favorites', style: boldTextStyle(color: white)),
      // ).paddingSymmetric(horizontal: 16, vertical: 24),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new,
                    color: colorPrimary, size: 18),
                onPressed: () {
                  finish(context);
                },
              ),
              shape: const RoundedRectangleBorder(
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
                titlePadding: const EdgeInsets.all(10),
                centerTitle: true,
                background: Stack(
                  children: [
                    // Image.asset(
                    //   widget.advert.photos![0].hashCode,
                    //   fit: BoxFit.cover,
                    //   height: 350,
                    //   width: context.width(),
                    // ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 32),
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
              AdvertDetailIfo(advert: widget.advert),
            ],
          ),
        ),
      ),
    );
  }
}
