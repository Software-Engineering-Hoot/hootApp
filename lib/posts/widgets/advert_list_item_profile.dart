import 'package:flutter/material.dart';
import 'package:hoot/posts/models/advert_model.dart';
import 'package:hoot/posts/service/advert.dart';
import 'package:hoot/posts/utils/colors.dart';
import 'package:hoot/posts/view/dashboard.dart';
import 'package:hoot/posts/view/profile.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:one_context/one_context.dart';

class AdvertListItemProfile extends StatefulWidget {
  const AdvertListItemProfile({
    super.key,
    required this.advert,
    required this.isOwner,
  });

  final AdvertModel advert;
  final bool isOwner;

  @override
  State<AdvertListItemProfile> createState() => _AdvertListItemProfileState();
}

class _AdvertListItemProfileState extends State<AdvertListItemProfile> {
  final AdvertService _advertService = AdvertService();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      height: MediaQuery.of(context).size.width * 0.3,
      margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.00),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: colorBox,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: SizedBox(
          width: 200,
          height: 300,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.start, // main axis row için,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: SizedBox(
                      height: context.height() * 0.6,
                      width: context.width() * 0.30,
                      child: widget.advert.photos != null &&
                              widget.advert.photos?.length != 0
                          ? Image.network(
                              widget.advert.photos![0],
                              fit: BoxFit.cover,
                              height: 350,
                              width: context.width(),
                            )
                          : Icon(Icons.landscape),
                    ),
                  ),
                  8.width,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            SizedBox(
                              width: context.width() * 0.43,
                              child: Text(
                                widget.advert.title ?? '',
                                style: const TextStyle(fontSize: 17),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      10.height,
                      Text(
                        '${widget.advert.price} TL',
                        style: const TextStyle(
                            color: colorPrimary,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      2.height,
                      const Spacer(),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_pin,
                            color: colorPrimary,
                          ),
                          Text(widget.advert.address ?? ''),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (widget.isOwner)
                    IconButton(
                      onPressed: () {
                        showConfirmDialogCustom(
                          context,
                          cancelable: false,
                          title: 'Are you sure you want to delete?',
                          dialogType: DialogType.DELETE,
                          onCancel: (v) {
                            Navigator.of(context, rootNavigator: true).pop();
                          },
                          onAccept: (v) {
                            _advertService
                                .deleteAdvert(widget.advert)
                                .then((value) {
                              Navigator.of(context, rootNavigator: true).pop();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Dashboard()),
                              );
                            });
                          },
                        );
                      },
                      icon: Icon(Icons.close_sharp),
                      padding: EdgeInsets.only(bottom: 40, left: 10),
                    )
                  else
                    IconButton(
                      onPressed: () {
                        showConfirmDialogCustom(
                          context,
                          cancelable: false,
                          positiveText: 'Remove',
                          title:
                              'Are you sure you want to remove from favorite ?',
                          dialogType: DialogType.DELETE,
                          onCancel: (v) {
                            Navigator.of(context, rootNavigator: true).pop();
                          },
                          onAccept: (v) {
                            _advertService
                                .deleteAdvertFavorite(widget.advert)
                                .then((value) {
                              Navigator.of(context, rootNavigator: true).pop();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Dashboard()),
                              );
                            });
                          },
                        );
                      },
                      icon: const Icon(Icons.heart_broken, color: colorPrimary),
                      padding: EdgeInsets.only(bottom: 40, left: 10),
                    ),
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: filter_color),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 8),
                      decoration: boxDecorationWithRoundedCorners(
                          backgroundColor: colorPrimary_light),
                      child: Text(
                        widget.advert.petType ?? '',
                        style: boldTextStyle(color: colorPrimary, size: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
