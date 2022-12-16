import 'package:flutter/material.dart';
import 'package:flutter_infinite_list/posts/models/advert_model.dart';
import 'package:flutter_infinite_list/posts/models/user_model.dart';
import 'package:flutter_infinite_list/posts/service/advert.dart';
import 'package:flutter_infinite_list/posts/utils/colors.dart';
import 'package:flutter_infinite_list/posts/utils/images.dart';
import 'package:flutter_infinite_list/posts/widgets/custom_widgets.dart';
import 'package:nb_utils/nb_utils.dart';

class AdvertDetailIfo extends StatefulWidget {
  const AdvertDetailIfo({super.key, required this.hotelData});
  // final List<RoomFinderModel> hotelImageData = hotelImageList();

  final AdvertModel hotelData;

  @override
  State<AdvertDetailIfo> createState() => _AdvertDetailIfoState();
}

class _AdvertDetailIfoState extends State<AdvertDetailIfo> {
  final AdvertService _advertService = AdvertService();
  UserModel user = UserModel();

  @override
  void initState() {
    init();
    super.initState();
  }

  Future<bool> init() async {
    try {
      user = await _advertService.getUserDetails();
    } catch (e) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: init(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            children = <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Image.network(
                                  "https://i.pinimg.com/474x/82/a1/88/82a188d47fed928f11e994eb448dfe74.jpg",
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover)
                              .cornerRadiusWithClipRRect(30),
                          16.width,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(user.name ?? '', style: boldTextStyle()),
                              4.height,
                              Text(user.surname ?? '',
                                  style: secondaryTextStyle()),
                            ],
                          ).expand(),
                          AppButton(
                            onTap: () {
                              launchCall(user.phoneNumber ?? '');
                            },
                            color: colorPrimary,
                            width: 15,
                            height: 15,
                            elevation: 0,
                            child: call.iconImage(iconColor: white, size: 14),
                          ),
                          8.width,
                          AppButton(
                            onTap: () {
                              launchMail(user.email);
                            },
                            color: colorPrimary,
                            width: 15,
                            height: 15,
                            elevation: 0,
                            child:
                                message.iconImage(iconColor: white, size: 14),
                          ),
                        ],
                      ),
                      24.height,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.location_on, color: colorPrimary)
                              .paddingOnly(top: 2),
                          16.width,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.hotelData.address ?? '',
                                  style: boldTextStyle()),
                              8.height,
                              Text(widget.hotelData.title ?? '',
                                  style: primaryTextStyle()),
                              8.height,
                            ],
                          ).expand(),
                          16.width,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(4),
                                    decoration: boxDecorationWithRoundedCorners(
                                        backgroundColor: colorPrimary,
                                        boxShape: BoxShape.circle),
                                  ),
                                  6.width,
                                  Text(widget.hotelData.petType ?? '',
                                      style: secondaryTextStyle()),
                                ],
                              ),
                              8.height,
                              Text(
                                '${widget.hotelData.price} TL',
                                style: primaryTextStyle(),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ).paddingOnly(left: 2),
                              8.height,
                            ],
                          ).expand()
                        ],
                      ),
                    ],
                  ).paddingAll(24),
                  HorizontalList(
                    padding: EdgeInsets.only(right: 24, left: 24),
                    wrapAlignment: WrapAlignment.spaceEvenly,
                    itemCount: 2,
                    itemBuilder: (_, int index) => Stack(
                      alignment: Alignment.center,
                      children: [
                        // rfCommonCachedNetworkImage(hotelImageData[index].img.validate(),
                        //     height: 70, width: 70, fit: BoxFit.cover),
                        Container(
                          height: 70,
                          width: 70,
                          decoration: boxDecorationWithRoundedCorners(
                            borderRadius: BorderRadius.circular(8),
                            backgroundColor: black.withOpacity(0.5),
                          ),
                        ),
                        Text('+ 5',
                                style: boldTextStyle(color: white, size: 20),
                                textAlign: TextAlign.center)
                            .visible(index == 3),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Description', style: boldTextStyle()),
                      8.height,
                      Text(
                        widget.hotelData.description ?? '',
                        style: secondaryTextStyle(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                      ),
                    ],
                  ).paddingOnly(left: 24, right: 24, top: 24, bottom: 8),
                ],
              )
            ];
          } else if (snapshot.hasError) {
            children = <Widget>[
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              ),
            ];
          } else {
            children = const <Widget>[
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Awaiting result...'),
              ),
            ];
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            ),
          );
        });
  }
}
