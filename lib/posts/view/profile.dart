import 'package:flutter/material.dart';
import 'package:hoot/posts/models/advert_model.dart';
import 'package:hoot/posts/models/user_model.dart';
import 'package:hoot/posts/service/advert.dart';
import 'package:hoot/posts/service/auth.dart';
import 'package:hoot/posts/utils/colors.dart';
import 'package:hoot/posts/utils/images.dart';
import 'package:hoot/posts/widgets/advert_detail.dart';
import 'package:hoot/posts/widgets/advert_list_item_profile.dart';
import 'package:hoot/posts/widgets/common_app_component.dart';
import 'package:hoot/posts/widgets/custom_widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hoot/posts/models/advert_model.dart';
import 'package:hoot/posts/service/advert.dart';
import 'package:hoot/posts/utils/colors.dart';
import 'package:hoot/posts/utils/constant.dart';
import 'package:hoot/posts/view/dashboard.dart';
import 'package:hoot/posts/widgets/common_app_component.dart';
import 'package:hoot/posts/widgets/custom/date_picker_widget.dart';
import 'package:hoot/posts/widgets/custom_widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List<String> categotyData = ['Ilanlarım', 'Favorilerim'];
  List<AdvertModel> myAdverts = [];
  List<AdvertModel> favAdverts = [];
  UserModel currenctUser = UserModel();
  final AdvertService _advertService = AdvertService();
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  XFile? _image;
  final ImagePicker _picker = ImagePicker();

  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<bool> init() async {
    try {
      currenctUser = await _advertService.getUserDetails();
      myAdverts = await _advertService.getUserAdverts();
      favAdverts = await _advertService.getUserFavorites();
    } catch (e) {
      return false;
    }
    return true;
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Future<void> pickImage() async {
    _image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl =
        currenctUser.profilPic == null ? user : currenctUser.profilPic;
    return FutureBuilder<bool>(
        future: init(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            children = <Widget>[
              Scaffold(
                body: RFCommonAppComponent(
                  title: 'Account',
                  mainWidgetHeight: 200,
                  subWidgetHeight: 100,
                  accountCircleWidget: Align(
                    alignment: Alignment.bottomCenter,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          alignment: Alignment.bottomCenter,
                          margin: const EdgeInsets.only(top: 150),
                          width: 100,
                          height: 100,
                          decoration: boxDecorationWithRoundedCorners(
                            boxShape: BoxShape.circle,
                            border: Border.all(color: white, width: 4),
                          ),
                          child: commonCachedNetworkImage(
                            imageUrl,
                            fit: BoxFit.cover,
                            width: 100,
                            height: 100,
                            radius: 150,
                          ),
                        ),
                        Positioned(
                            bottom: 8,
                            right: -4,
                            child: Container(
                              alignment: Alignment.bottomCenter,
                              padding: const EdgeInsets.all(6),
                              decoration: boxDecorationWithRoundedCorners(
                                backgroundColor: context.cardColor,
                                boxShape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    spreadRadius: 0.4,
                                    blurRadius: 3,
                                    color: gray.withOpacity(0.1),
                                    offset: const Offset(1, 6),
                                  ),
                                ],
                              ),
                              child: InkWell(
                                onTap: () async {
                                  await pickImage();
                                  _advertService.updateAccountWithBackEnd(
                                      currenctUser, _image!);
                                },
                                child: Icon(Icons.add,
                                    color: colorPrimary, size: 16),
                              ),
                            ))
                      ],
                    ),
                  ),
                  subWidget: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      16.height,
                      Text(
                        "${currenctUser.name} ${currenctUser.surname}",
                        style: boldTextStyle(size: 18),
                      ).center(),
                      8.height,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${myAdverts.length.toString()} Advert',
                            style: secondaryTextStyle(),
                          ),
                          8.width,
                          Container(
                            height: 10,
                            width: 1,
                            color: gray.withOpacity(0.4),
                          ),
                          8.width,
                          Text(
                            '${favAdverts.length.toString()} Favorite',
                            style: secondaryTextStyle(),
                          ),
                        ],
                      ),
                      32.height,
                      Container(
                        decoration: boxDecorationWithRoundedCorners(
                          border: Border.all(color: app_background),
                          backgroundColor: context.cardColor,
                        ),
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Email', style: boldTextStyle()),
                                Text(
                                  "${currenctUser.email}",
                                  style: secondaryTextStyle(),
                                ),
                              ],
                            ).paddingSymmetric(horizontal: 24, vertical: 16),
                            Divider(color: context.dividerColor, height: 0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Location', style: boldTextStyle()),
                                Text(
                                  "${currenctUser.location}",
                                  style: secondaryTextStyle(),
                                ),
                              ],
                            ).paddingSymmetric(horizontal: 24, vertical: 16),
                            Divider(color: context.dividerColor, height: 0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Phone No', style: boldTextStyle()),
                                Text(
                                  '${currenctUser.phoneNumber}',
                                  style: secondaryTextStyle(),
                                ),
                              ],
                            ).paddingSymmetric(horizontal: 24, vertical: 16),
                          ],
                        ),
                      ),
                      HorizontalList(
                        wrapAlignment: WrapAlignment.spaceAround,
                        itemCount: categotyData.length,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        itemBuilder: (_, index) {
                          final data = categotyData[index];
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 16,
                            ),
                            decoration: boxDecorationWithRoundedCorners(
                              backgroundColor: selectedIndex == index
                                  ? colorPrimary_light
                                  : Colors.transparent,
                            ),
                            child: Text(
                              '$data',
                              style: boldTextStyle(
                                color: selectedIndex == index
                                    ? colorPrimary
                                    : gray.withOpacity(0.4),
                              ),
                            ),
                          ).onTap(
                            () {
                              selectedIndex = index;
                              setState(() {});
                            },
                            splashColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                          );
                        },
                      ),
                      ListView.builder(
                        padding:
                            const EdgeInsets.only(right: 16, left: 16, top: 16),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: selectedIndex == 0
                            ? myAdverts.length
                            : favAdverts.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => selectedIndex == 0
                                        ? AdvertDetail(
                                            advert: myAdverts[index],
                                            isEditable: true,
                                          )
                                        : AdvertDetail(
                                            advert: favAdverts[index],
                                            isEditable: false,
                                          )),
                              );
                            },
                            child: selectedIndex == 0
                                ? AdvertListItemProfile(
                                    advert: myAdverts[index],
                                    isOwner: true,
                                  )
                                : AdvertListItemProfile(
                                    advert: favAdverts[index],
                                    isOwner: false,
                                  ),
                          );
                        },
                      ),
                      16.height,
                    ],
                  ),
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
        });
  }
}
