import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoot/posts/bloc/advert_bloc.dart';
import 'package:hoot/posts/models/user_model.dart';
import 'package:hoot/posts/service/advert.dart';
import 'package:hoot/posts/utils/colors.dart';
import 'package:hoot/posts/utils/constant.dart';
import 'package:hoot/posts/widgets/advert_detail.dart';
import 'package:hoot/posts/widgets/advert_list_item.dart';
import 'package:nb_utils/nb_utils.dart';

class AdvertsList extends StatefulWidget {
  const AdvertsList({super.key});

  @override
  State<AdvertsList> createState() => _AdvertsListState();
}

class _AdvertsListState extends State<AdvertsList> {
  final AdvertService _advertService = AdvertService();
  UserModel user = UserModel();
  final _scrollController = ScrollController();
  bool isOwnTheAdvert = false;
  int selectedIndex = 0;

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
    return BlocBuilder<AdvertBloc, AdvertState>(
      builder: (context, state) {
        switch (state.status) {
          case AdvertStatus.failure:
            return const Center(child: Text('failed to fetch posts'));
          case AdvertStatus.success:
            if (state.adverts.isEmpty) {
              return const Center(child: Text('no posts'));
            }
            return Scaffold(
              appBar: AppBar(
                title: Text("Home"),
                backgroundColor: colorPrimary,
                automaticallyImplyLeading: false,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16)),
                ),
              ),
              body: Container(
                width: context.width(),
                height: context.height(),
                child: Column(
                  children: [
                    10.height,
                    HorizontalList(
                      wrapAlignment: WrapAlignment.start,
                      itemCount: petTypes.length,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 0,
                        vertical: 0,
                      ),
                      itemBuilder: (_, index) {
                        final data = petTypes[index];
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          decoration: boxDecorationWithRoundedCorners(
                            backgroundColor: selectedIndex == index
                                ? colorPrimary_light
                                : Colors.transparent,
                          ),
                          child: Text(
                            data,
                            style: boldTextStyle(
                                color: selectedIndex == index
                                    ? colorPrimary
                                    : gray.withOpacity(0.4)),
                          ),
                        ).onTap(() {
                          selectedIndex = index;
                          setState(() {});
                        },
                            splashColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent);
                      },
                    ),
                    10.height,
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            child: AdvertListItem(post: state.adverts[index]),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AdvertDetail(
                                    advert: state.adverts[index],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        itemCount: state.adverts.length,
                        controller: _scrollController,
                      ),
                    ),
                  ],
                ),
              ),
            );
          case AdvertStatus.initial:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
