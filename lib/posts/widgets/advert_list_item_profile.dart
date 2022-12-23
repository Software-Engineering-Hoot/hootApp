import 'package:flutter/material.dart';
import 'package:hoot/posts/models/advert_model.dart';
import 'package:hoot/posts/service/advert.dart';
import 'package:hoot/posts/utils/colors.dart';
import 'package:nb_utils/nb_utils.dart';

class AdvertListItemProfile extends StatefulWidget {
  AdvertListItemProfile({super.key, required this.advert});

  final AdvertModel advert;

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
                      Text(
                        widget.advert.title ?? '',
                        style: const TextStyle(fontSize: 20),
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
                  IconButton(
                    onPressed: () {
                      showConfirmDialogCustom(
                        context,
                        cancelable: false,
                        title: 'Are you sure you want to delete?',
                        dialogType: DialogType.DELETE,
                        onCancel: (v) {
                          finish(context);
                        },
                        onAccept: (v) {
                          _advertService
                              .deleteAdvert(widget.advert)
                              .then((value) {
                            setState(() {
                              finish(context);
                            });
                          });
                        },
                      );
                    },
                    icon: Icon(Icons.close_sharp),
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
