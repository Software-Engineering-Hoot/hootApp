import 'package:flutter/material.dart';
import 'package:flutter_infinite_list/posts/service/advert.dart';
import 'package:flutter_infinite_list/posts/utils/colors.dart';
import 'package:flutter_infinite_list/posts/utils/constant.dart';
import 'package:flutter_infinite_list/posts/widgets/common_app_component.dart';
import 'package:flutter_infinite_list/posts/widgets/custom_widgets.dart';
import 'package:nb_utils/nb_utils.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String city = "";
  String petType = "";
  double amount = 0;
  final AdvertService _advertService = AdvertService();

  FocusNode addressFocusNode = FocusNode();
  FocusNode priceFocusNode = FocusNode();
  FocusNode residentFocusNode = FocusNode();

  // List<RoomFinderModel> locationListData = locationList();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RFCommonAppComponent(
        title: "Search",
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
                lableText: "Enter an address or city",
                showLableText: true,
                showPreFixIcon: true,
                prefixIcon:
                    Icon(Icons.location_on, color: colorPrimary, size: 16),
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
                prefixIcon: Icon(Icons.pets, color: colorPrimary, size: 16),
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
              focus: residentFocusNode,
              textFieldType: TextFieldType.NUMBER,
              decoration: rfInputDecoration(
                lableText: 'Enter Amount',
                showLableText: true,
                showPreFixIcon: true,
                prefixIcon:
                    Icon(Icons.attach_money, color: colorPrimary, size: 16),
              ),
            ),
            16.height,
            AppButton(
              color: colorPrimary,
              child: Text('Search Now', style: boldTextStyle(color: white)),
              width: context.width(),
              elevation: 0,
              onTap: () {
                _advertService.filterByAll(city, petType, amount);
              },
            ),
          ],
        ),
      ),
    );
  }
}
