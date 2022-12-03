import 'package:flutter/material.dart';
import 'package:flutter_infinite_list/posts/models/advert_model.dart';
import 'package:flutter_infinite_list/posts/service/advert.dart';
import 'package:flutter_infinite_list/posts/utils/colors.dart';
import 'package:flutter_infinite_list/posts/view/home.dart';
import 'package:flutter_infinite_list/posts/widgets/common_app_component.dart';
import 'package:flutter_infinite_list/posts/widgets/custom/date_picker_widget.dart';
import 'package:flutter_infinite_list/posts/widgets/custom_widgets.dart';
import 'package:nb_utils/nb_utils.dart';

class AddAdvert extends StatefulWidget {
  AddAdvert({super.key, this.showDialog = false});

  bool showDialog;

  @override
  AddAdvertState createState() => AddAdvertState();
}

class AddAdvertState extends State<AddAdvert> {
  final _formKey = GlobalKey<FormState>();
  late AdvertModel advert = AdvertModel();
  final AdvertService _advertService = AdvertService();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    await setStatusBarColor(colorPrimary,
        statusBarIconBrightness: Brightness.light);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RFCommonAppComponent(
        title: 'Add Advert',
        mainWidgetHeight: 230,
        subWidgetHeight: 170,
        cardWidget: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            16.height,
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  AppTextField(
                    textFieldType: TextFieldType.NAME,
                    decoration: rfInputDecoration(
                      lableText: 'Title',
                      showLableText: true,
                    ),
                    onChanged: (value) {
                      advert.title = value;
                    },
                    validator: (value) {
                      return value.isEmptyOrNull ? 'Please enter title' : null;
                    },
                  ),
                  16.height,
                  AppTextField(
                    textFieldType: TextFieldType.NAME,
                    decoration: rfInputDecoration(
                      lableText: 'Pet Type',
                      showLableText: true,
                    ),
                    onChanged: (value) {
                      advert.petType = value;
                    },
                    validator: (value) {
                      return value.isEmptyOrNull
                          ? 'Please enter pet type'
                          : null;
                    },
                  ),
                  16.height,
                  AppTextField(
                    textFieldType: TextFieldType.NAME,
                    decoration: rfInputDecoration(
                      lableText: 'Address',
                      showLableText: true,
                    ),
                    onChanged: (value) {
                      advert.address = value;
                    },
                    validator: (value) {
                      return value.isEmptyOrNull
                          ? 'Please enter address'
                          : null;
                    },
                  ),
                  16.height,
                  DatePickerWidget(
                    dateInput: null,
                    labelText: 'Start Date',
                    initialValue: null,
                    decoration: rfInputDecoration(
                      lableText: 'Start Date',
                      showLableText: true,
                    ),
                    validationText: 'Please enter start date',
                    isRequired: true,
                    onSaved: (value) {
                      advert.startDate = value as String;
                    },
                    onChanged: (dynamic value) {
                      advert.startDate = value.toString() as String;
                    },
                    readOnly: false,
                  ),
                  16.height,
                  DatePickerWidget(
                    dateInput: null,
                    labelText: 'End Date',
                    initialValue: null,
                    decoration: rfInputDecoration(
                      lableText: 'End Date',
                      showLableText: true,
                    ),
                    validationText: 'Please enter end date',
                    isRequired: true,
                    onSaved: (value) {
                      advert.endDate = value as String;
                    },
                    onChanged: (dynamic value) {
                      advert.endDate = value.toString() as String;
                    },
                    readOnly: false,
                  ),
                  16.height,
                  AppTextField(
                    textFieldType: TextFieldType.NUMBER,
                    decoration: rfInputDecoration(
                      lableText: 'Price',
                      showLableText: true,
                    ),
                    onChanged: (value) {
                      advert.price = value.toDouble();
                    },
                    validator: (value) {
                      return value.isEmptyOrNull ? 'Please enter price' : null;
                    },
                  ),
                  16.height,
                  AppTextField(
                    maxLength: 60,
                    minLines: 4,
                    maxLines: 4,
                    textFieldType: TextFieldType.OTHER,
                    decoration: rfInputDecoration(
                      lableText: 'Description',
                      showLableText: true,
                    ),
                    onChanged: (value) {
                      advert.description = value;
                    },
                    validator: (value) {
                      return value.isEmptyOrNull
                          ? 'Please enter description'
                          : null;
                    },
                  ),
                  16.height,
                  AppButton(
                    color: colorPrimary,
                    width: context.width(),
                    elevation: 0,
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        await _advertService.addAdvert(advert).then((value) {
                          if (value) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Home()),
                            );
                          }
                        });
                      }
                    },
                    child: Text('Add', style: boldTextStyle(color: white)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
