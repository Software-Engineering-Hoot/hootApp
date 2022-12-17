import 'package:flutter/material.dart';
import 'package:hoot/posts/models/advert_model.dart';
import 'package:hoot/posts/service/advert.dart';
import 'package:hoot/posts/utils/colors.dart';
import 'package:hoot/posts/utils/constant.dart';
import 'package:hoot/posts/view/home.dart';
import 'package:hoot/posts/widgets/common_app_component.dart';
import 'package:hoot/posts/widgets/custom/date_picker_widget.dart';
import 'package:hoot/posts/widgets/custom_widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:intl/intl.dart';

class EditAdvert extends StatefulWidget {
  EditAdvert({
    super.key,
    this.showDialog = false,
    required this.advert,
  });

  bool showDialog;
  AdvertModel advert;

  @override
  EditAdvertState createState() => EditAdvertState();
}

class EditAdvertState extends State<EditAdvert> {
  final _formKey = GlobalKey<FormState>();
  final AdvertService _advertService = AdvertService();
  final ImagePicker _picker = ImagePicker();
  List<XFile>? images = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> pickImage() async {
    images = await _picker.pickMultiImage();
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
                    initialValue: widget.advert.title ?? "",
                    textFieldType: TextFieldType.NAME,
                    decoration: rfInputDecoration(
                      lableText: 'Title',
                      showLableText: true,
                    ),
                    onChanged: (value) {
                      widget.advert.title = value;
                    },
                    validator: (value) {
                      return value.isEmptyOrNull ? 'Please enter title' : null;
                    },
                  ),
                  16.height,
                  DropdownButtonFormField(
                    isExpanded: true,
                    decoration: rfInputDecoration(
                      lableText: widget.advert.petType,
                      showLableText: true,
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
                      widget.advert.petType = value as String?;
                    },
                  ),
                  16.height,
                  DropdownButtonFormField(
                    isExpanded: true,
                    decoration: rfInputDecoration(
                      lableText: widget.advert.address,
                      showLableText: true,
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
                      widget.advert.address = value as String?;
                    },
                  ),
                  16.height,
                  DatePickerWidget(
                    dateInput: DateTime.parse(widget.advert.startDate!),
                    labelText: 'Start Date',
                    initialValue: null,
                    decoration: rfInputDecoration(
                      lableText: DateFormat.yMMMd()
                          .format(DateTime.parse(widget.advert.startDate!)),
                      showLableText: true,
                    ),
                    validationText: 'Please enter start date',
                    isRequired: true,
                    onSaved: (value) {
                      widget.advert.startDate = value as String;
                    },
                    onChanged: (dynamic value) {
                      widget.advert.startDate = value.toString() as String;
                    },
                    readOnly: false,
                  ),
                  16.height,
                  DatePickerWidget(
                    dateInput: null,
                    labelText: 'End Date',
                    initialValue: null,
                    decoration: rfInputDecoration(
                      lableText: DateFormat.yMMMd()
                          .format(DateTime.parse(widget.advert.startDate!)),
                      showLableText: true,
                    ),
                    validationText: 'Please enter end date',
                    isRequired: true,
                    onSaved: (value) {
                      widget.advert.endDate = value as String;
                    },
                    onChanged: (dynamic value) {
                      widget.advert.endDate = value.toString() as String;
                    },
                    readOnly: false,
                  ),
                  16.height,
                  AppTextField(
                    initialValue: widget.advert.price.toString(),
                    textFieldType: TextFieldType.NUMBER,
                    decoration: rfInputDecoration(
                      lableText: 'Price',
                      showLableText: true,
                    ),
                    onChanged: (value) {
                      widget.advert.price = value.toDouble();
                    },
                    validator: (value) {
                      return value.isEmptyOrNull ? 'Please enter price' : null;
                    },
                  ),
                  16.height,
                  AppTextField(
                    initialValue: widget.advert.description,
                    maxLength: 60,
                    minLines: 4,
                    maxLines: 4,
                    textFieldType: TextFieldType.OTHER,
                    decoration: rfInputDecoration(
                      lableText: 'Description',
                      showLableText: true,
                    ),
                    onChanged: (value) {
                      widget.advert.description = value;
                    },
                    validator: (value) {
                      return value.isEmptyOrNull
                          ? 'Please enter description'
                          : null;
                    },
                  ),
                  AppButton(
                    onTap: pickImage,
                    child: Text("Pick Image"),
                  ),
                  16.height,
                  AppButton(
                    color: colorPrimary,
                    width: context.width(),
                    elevation: 0,
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        // await _advertService
                        //     .addAdvertWithBackEnd(widget.advert)
                        //     .then((value) {
                        //   if (value) {
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) => const Home()),
                        //     );
                        //   }
                        // });
                      }
                    },
                    child: Text('Edit', style: boldTextStyle(color: white)),
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
