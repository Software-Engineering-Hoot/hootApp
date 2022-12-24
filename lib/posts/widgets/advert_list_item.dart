import 'package:flutter/material.dart';
import 'package:hoot/posts/models/advert_model.dart';
import 'package:hoot/posts/utils/colors.dart';
import 'package:nb_utils/nb_utils.dart';

class AdvertListItem extends StatelessWidget {
  AdvertListItem({super.key, required this.advert});

  final AdvertModel advert;
  final AdvertModel? newAdd = AdvertModel();

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
                        child:
                            advert.photos != null && advert.photos?.length != 0
                                ? Image.network(
                                    advert.photos![0],
                                    fit: BoxFit.cover,
                                    height: 350,
                                    width: context.width(),
                                  )
                                : Icon(Icons.landscape),
                      )),
                  8.width,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            SizedBox(
                              width: context.width() * 0.5,
                              child: Text(
                                advert.title ?? '',
                                style: const TextStyle(fontSize: 17),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      10.height,
                      Text(
                        '${advert.price} TL',
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
                          Text(advert.address ?? ''),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: filter_color),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  decoration: boxDecorationWithRoundedCorners(
                      backgroundColor: colorPrimary_light),
                  child: Text(
                    advert.petType ?? '',
                    style: boldTextStyle(color: colorPrimary, size: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
