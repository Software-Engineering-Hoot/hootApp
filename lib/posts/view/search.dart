import 'package:flutter/material.dart';
import 'package:hoot/posts/models/advert_model.dart';
import 'package:hoot/posts/service/advert.dart';
import 'package:hoot/posts/utils/colors.dart';
import 'package:hoot/posts/utils/constant.dart';
import 'package:hoot/posts/widgets/common_app_component.dart';
import 'package:hoot/posts/widgets/custom_widgets.dart';
import 'package:hoot/posts/widgets/advert_list_item.dart';
import 'package:nb_utils/nb_utils.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String city = '';
  String petType = '';
  double amount = 0;
  bool isSearched = false;
  List<AdvertModel> searchedAdvert = [];
  final AdvertService _advertService = AdvertService();

  @override
  void initState() {
    super.initState();
  }

  Future<bool> getSearchedAdvert(
      String city, String petType, double amount) async {
    try {
      searchedAdvert = await _advertService.getAdvert();
    } catch (e) {
      return false;
    }
    return true;
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RFCommonAppComponent(
        title: 'Search',
        mainWidgetHeight: 230,
        subWidgetHeight: 160,
        cardWidget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Advance Search', style: boldTextStyle(size: 18)),
            16.height,
            DropdownButtonFormField(
              isExpanded: true,
              decoration: rfInputDecoration(
                lableText: 'Enter an address or city',
                showLableText: true,
                showPreFixIcon: true,
                prefixIcon: const Icon(Icons.location_on,
                    color: colorPrimary, size: 16),
              ),
              items: cities.map((taxGroup) {
                return DropdownMenuItem<String>(
                  value: taxGroup,
                  child: Text(
                    taxGroup,
                  ),
                );
              }).toList(),
              onChanged: (value) {
                city = (value as String?)!;
              },
            ),
            8.height,
            DropdownButtonFormField(
              isExpanded: true,
              decoration: rfInputDecoration(
                lableText: 'Enter Pet Type',
                showLableText: true,
                showPreFixIcon: true,
                prefixIcon:
                    const Icon(Icons.pets, color: colorPrimary, size: 16),
              ),
              items: petTypes.map((taxGroup) {
                return DropdownMenuItem<String>(
                  value: taxGroup,
                  child: Text(
                    taxGroup,
                  ),
                );
              }).toList(),
              onChanged: (value) {
                petType = (value as String?)!;
              },
            ),
            8.height,
            AppTextField(
              onChanged: (p0) {
                amount = double.parse(p0);
              },
              textFieldType: TextFieldType.NUMBER,
              decoration: rfInputDecoration(
                lableText: 'Enter Amount',
                showLableText: true,
                showPreFixIcon: true,
                prefixIcon: const Icon(Icons.attach_money,
                    color: colorPrimary, size: 16),
              ),
            ),
            16.height,
            AppButton(
              color: colorPrimary,
              width: context.width(),
              elevation: 0,
              onTap: () async {
                await getSearchedAdvert(city, petType, amount).then((value) {
                  return isSearched = true;
                }).then((value) => setState(() {}));
              },
              child: Text('Search Now', style: boldTextStyle(color: white)),
            ),
          ],
        ),
        subWidget: FutureBuilder<bool>(
          future: getSearchedAdvert(
            city,
            petType,
            amount,
          ), // a previously-obtained Future<String> or null
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            List<Widget> children;
            if (snapshot.hasData) {
              children = <Widget>[
                if (isSearched == true)
                  ListView.builder(
                    padding:
                        const EdgeInsets.only(right: 16, left: 16, top: 16),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: searchedAdvert.length,
                    itemBuilder: (BuildContext context, int index) {
                      return AdvertListItem(post: searchedAdvert[index]);
                    },
                  )
                else
                  Container(),
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
              children = <Widget>[];
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: children,
              ),
            );
          },
        ),
      ),
    );
  }
}
