import 'package:flutter/material.dart';
import 'package:flutter_infinite_list/posts/models/advert_model.dart';
import 'package:flutter_infinite_list/posts/utils/colors.dart';
import 'package:nb_utils/nb_utils.dart';

class PostListItem extends StatelessWidget {
  PostListItem({super.key, required this.post});

  final AdvertModel post;
  final AdvertModel? newAdd = AdvertModel();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      height: MediaQuery.of(context).size.width * 0.37,
      margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
      // ignore: prefer_const_constructors
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        color: colorBox,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: SizedBox(
          width: 200,
          height: 400,
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween, // main axis row için,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SizedBox(
                    height: context.height() * 2.7,
                    width: context.width() * 0.35,
                    child: Image.network(post.photos ?? ''),
                  )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.title ?? '',
                    style: const TextStyle(fontSize: 20),
                  ),
                  10.height,
                  Text(
                    '${post.price} TL',
                    style: const TextStyle(
                        color: colorPrimary,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  2.height,
                  const Spacer(),
                  SizedBox(
                    width: 200,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceAround, // main axis row için,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Icon(
                            Icons.location_pin,
                            color: colorPrimary,
                          ),
                          Text(post.address ?? ''),
                          const Spacer(),
                          Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: filter_color),
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: SizedBox(
                                    child: Text(
                                  post.petType ?? '',
                                  style: const TextStyle(
                                    fontFamily: 'Halvetica',
                                    fontSize: 12,
                                  ),
                                )),
                              ))
                        ]),
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
