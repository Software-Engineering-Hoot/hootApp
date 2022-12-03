import 'package:flutter/material.dart';
import 'package:flutter_infinite_list/posts/models/advert_model.dart';
import 'package:flutter_infinite_list/posts/models/post.dart';
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
        padding: EdgeInsets.all(8.0),
        child: Container(
          width: 200,
          height: 400,
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween, // main axis row için,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Container(
                    // width: context.height() * 0.17,
                    // height: context.width() * 0.17,
                    child: Image.network(post.photos ?? ''),
                    height: context.height() * 0.45,
                    width: context.width() * 0.25,
                  )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(post.title ?? ''),
                  Text(
                    post.price.toString() + " TL",
                    style: TextStyle(color: colorPrimary),
                  ),
                  Spacer(),
                  //20.height,
                  Container(
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
                                  borderRadius: BorderRadius.circular(15.0),
                                  color: filter_color),
                              child: Padding(
                                padding: EdgeInsets.all(5),
                                child: SizedBox(
                                    child: Text(
                                  post.petType ?? '',
                                  style: TextStyle(
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
