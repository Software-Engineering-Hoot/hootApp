import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:one_context/one_context.dart';

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
  final ImagePicker _picker = ImagePicker();
  List<XFile>? _imageFileList = [];
  String? _retrieveDataError;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> pickImage() async {
    _imageFileList = await _picker.pickMultiImage();
    print(_imageFileList);
    setState(() {});
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
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(30),
                    ],
                    textFieldType: TextFieldType.NAME,
                    decoration: rfInputDecoration(
                      lableText: 'Title',
                      showLableText: true,
                    ),
                    onChanged: (value) {
                      advert.title = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please type title';
                      }
                      return value.length < 3
                          ? 'Title must be greater than three characters'
                          : null;
                    },
                  ),
                  16.height,
                  DropdownButtonFormField(
                    isExpanded: true,
                    decoration: rfInputDecoration(
                      lableText: 'Pet Type',
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
                      advert.petType = value as String?;
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a type';
                      }
                      return null;
                    },
                  ),
                  16.height,
                  DropdownButtonFormField(
                    isExpanded: true,
                    decoration: rfInputDecoration(
                      lableText: 'City',
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
                      advert.address = value as String?;
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a city';
                      }
                      return null;
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
                      advert.startDate = value.toString();
                    },
                    readOnly: false,
                    validator: (DateTime? value) {
                      if (value == null) {
                        return "This Field Required";
                      } else if (advert.endDate != null &&
                          (DateTime.parse(advert.startDate!)
                                  .isAfter(DateTime.parse(advert.endDate!)) ||
                              DateTime.parse(advert.startDate!)
                                  .isAtSameMomentAs(
                                      DateTime.parse(advert.endDate!)))) {
                        return "Start Date can not be after or equal the End Date";
                      }
                      return null;
                    },
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
                      advert.endDate = value.toString();
                    },
                    readOnly: false,
                    validator: (DateTime? value) {
                      if (value == null) {
                        return "This Field Required";
                      } else if (advert.startDate != null &&
                          (DateTime.parse(advert.startDate!)
                                  .isAfter(DateTime.parse(advert.endDate!)) ||
                              DateTime.parse(advert.startDate!)
                                  .isAtSameMomentAs(
                                      DateTime.parse(advert.endDate!)))) {
                        return "Start Date can not be after or equal the End Date";
                      }
                      return null;
                    },
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
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                  16.height,
                  AppTextField(
                    maxLength: 100,
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
                  AppButton(
                    onTap: pickImage,
                    child: const Text('Pick Image'),
                  ),
                  16.height,
                  FutureBuilder<void>(
                    future: retrieveLostData(),
                    builder:
                        (BuildContext context, AsyncSnapshot<void> snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                          return const Text(
                            'You have not yet picked an image.',
                            textAlign: TextAlign.center,
                          );
                        case ConnectionState.done:
                          return _imageFileList?.length != 0
                              ? _handlePreview()
                              : Container();
                        // ignore: no_default_cases
                        default:
                          if (snapshot.hasError) {
                            return Text(
                              'Pick image/video error: ${snapshot.error}}',
                              textAlign: TextAlign.center,
                            );
                          } else {
                            return const Text(
                              'You have not yet picked an image.',
                              textAlign: TextAlign.center,
                            );
                          }
                      }
                    },
                  ),
                  16.height,
                  AppButton(
                    color: colorPrimary,
                    width: context.width(),
                    elevation: 0,
                    onTap: () async {
                      if (_formKey.currentState!.validate() &&
                          _imageFileList!.isNotEmpty) {
                        OneContext().showProgressIndicator();

                        await _advertService
                            .addAdvertWithBackEnd(advert, _imageFileList!)
                            .then((value) {
                          if (value) {
                            OneContext().hideProgressIndicator();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Dashboard()),
                            );
                          }
                        });
                      } else if (_imageFileList!.isEmpty) {
                        await Fluttertoast.showToast(
                          msg: "Images Can Not Be Empty",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 2,
                          backgroundColor: redColor,
                          textColor: Colors.white,
                          fontSize: 16,
                        );
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

  Widget _handlePreview() {
    return _previewImages();
  }

  Future<void> retrieveLostData() async {
    final response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        if (response.files == null) {
          _setImageFileListFromFile(response.file);
        } else {
          _imageFileList = response.files;
        }
      });
    } else {
      _retrieveDataError = response.exception!.code;
    }
  }

  void _setImageFileListFromFile(XFile? value) {
    _imageFileList = value == null ? null : <XFile>[value];
  }

  Widget _previewImages() {
    if (_imageFileList != null) {
      return CarouselSlider(
        options: CarouselOptions(height: 400.0),
        items: _imageFileList?.map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: const BoxDecoration(color: Colors.amber),
                child: Image.file(File(i.path), fit: BoxFit.cover),
              );
            },
          );
        }).toList(),
      );
    } else {
      return const Text(
        'You have not yet picked an image.',
        textAlign: TextAlign.center,
      );
    }
  }
}

class SnackBarPage extends StatelessWidget {
  const SnackBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          final snackBar = SnackBar(
            content: const Text('Yay! A SnackBar!'),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                // Some code to undo the change.
              },
            ),
          );

          // Find the ScaffoldMessenger in the widget tree
          // and use it to show a SnackBar.
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        child: const Text('Show SnackBar'),
      ),
    );
  }
}
