import 'package:flutter/material.dart';
import 'package:flutter_infinite_list/posts/models/RoomFinderModel.dart';
import 'package:flutter_infinite_list/posts/utils/colors.dart';
import 'package:flutter_infinite_list/posts/utils/data_generator.dart';
import 'package:flutter_infinite_list/posts/widgets/common_app_component.dart';
import 'package:flutter_infinite_list/posts/widgets/custom_widgets.dart';
import 'package:nb_utils/nb_utils.dart';

class RFSearchFragment extends StatefulWidget {
  const RFSearchFragment({super.key});

  @override
  _RFSearchFragmentState createState() => _RFSearchFragmentState();
}

class _RFSearchFragmentState extends State<RFSearchFragment> {
  TextEditingController addressController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController residentController = TextEditingController();

  FocusNode addressFocusNode = FocusNode();
  FocusNode priceFocusNode = FocusNode();
  FocusNode residentFocusNode = FocusNode();

  List<RoomFinderModel> locationListData = locationList();

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
            AppTextField(
              controller: addressController,
              focus: addressFocusNode,
              nextFocus: priceFocusNode,
              textFieldType: TextFieldType.EMAIL,
              decoration: rfInputDecoration(
                lableText: "Enter an address or city",
                showLableText: true,
                showPreFixIcon: true,
                prefixIcon:
                    Icon(Icons.location_on, color: colorPrimary, size: 16),
              ),
            ),
            8.height,
            AppTextField(
              controller: priceController,
              focus: priceFocusNode,
              nextFocus: residentFocusNode,
              textFieldType: TextFieldType.PHONE,
              decoration: rfInputDecoration(
                lableText: 'Enter Pet Type',
                showLableText: true,
                showPreFixIcon: true,
                prefixIcon: Icon(Icons.pets, color: colorPrimary, size: 16),
              ),
            ),
            8.height,
            AppTextField(
              controller: residentController,
              focus: residentFocusNode,
              textFieldType: TextFieldType.OTHER,
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
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
