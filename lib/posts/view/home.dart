import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoot/posts/bloc/advert_bloc.dart';
import 'package:hoot/posts/models/advert_model.dart';
import 'package:hoot/posts/models/user_model.dart';
import 'package:hoot/posts/service/advert.dart';
import 'package:hoot/posts/utils/colors.dart';
import 'package:hoot/posts/utils/constant.dart';
import 'package:hoot/posts/widgets/advert_detail.dart';
import 'package:hoot/posts/widgets/advert_list_item.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AdvertService _advertService = AdvertService();
  UserModel user = UserModel();
  List<AdvertModel> adverts = [];
  final _scrollController = ScrollController();
  int selectedIndex = 0;

  @override
  void initState() {
    init();
    super.initState();
  }

  Future<bool> init() async {
    try {
      user = await _advertService.getUserDetails();
      adverts = await _advertService.getAdvert();
      print(adverts);
    } catch (e) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
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
      body: FutureBuilder<bool>(
        future: init(), // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            children = <Widget>[
              Container(
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
                        ).onTap(() async {
                          selectedIndex = index;
                          await refreshPage(petTypes[index])
                              .then((value) => setState(() {}));
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
                            child: AdvertListItem(post: adverts[index]),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AdvertDetail(advert: adverts[index])),
                              );
                            },
                          );
                        },
                        itemCount: adverts.length,
                        controller: _scrollController,
                      ),
                    ),
                  ],
                ),
              ),
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
        },
      ),
    );
  }

  Future<bool> refreshPage(String petType) async {
    adverts = await _advertService.filterByAll("", petType, 0);
    return true;
  }
}
