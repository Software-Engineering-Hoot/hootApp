import 'package:flutter/material.dart';
import 'package:hoot/posts/models/user_model.dart';
import 'package:hoot/posts/service/advert.dart';
import 'package:hoot/posts/utils/colors.dart';
import 'package:nb_utils/nb_utils.dart';

Future<void> editUserBottomSheet(
    BuildContext aContext, UserModel user, GlobalKey<FormState> formKey) async {
  final AdvertService _advertService = AdvertService();
  await showModalBottomSheet(
    backgroundColor: colorPrimary,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
    ),
    context: aContext,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            color: colorBox),
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Update user',
                style: boldTextStyle(color: textPrimaryColor),
              ),
              const Divider().paddingOnly(top: 10, bottom: 10),
              AppTextField(
                textFieldType: TextFieldType.NAME,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(18))),
                    labelText: 'Name'),
                initialValue: user.name,
                onChanged: (value) {
                  user.name = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some name';
                  }
                  return null;
                },
              ),
              16.height,
              AppTextField(
                textFieldType: TextFieldType.NAME,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(18))),
                    labelText: 'Surname'),
                initialValue: user.surname,
                onChanged: (value) {
                  user.surname = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter surname';
                  }
                  return null;
                },
              ),
              16.height,
              AppTextField(
                textFieldType: TextFieldType.EMAIL,
                enabled: false,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(18))),
                    labelText: 'Email'),
                initialValue: user.email,
                onChanged: (value) {
                  user.email = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter email address';
                  }
                  return null;
                },
              ),
              16.height,
              AppTextField(
                textFieldType: TextFieldType.NUMBER,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(18))),
                    labelText: 'Phone Number'),
                initialValue: user.phoneNumber,
                onChanged: (value) {
                  user.phoneNumber = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter phone number';
                  }
                  return null;
                },
              ),
              16.height,
              AppButton(
                color: colorPrimary,
                width: context.width(),
                child: Text('Update User',
                    style: boldTextStyle(color: Colors.white)),
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    _advertService
                        .editUser(user)
                        .then((value) => Navigator.pop(context));
                  }
                },
              ).cornerRadiusWithClipRRect(30).paddingOnly(
                    left: context.width() * 0.1,
                    right: context.width() * 0.1,
                    bottom: 10,
                  )
            ],
          ),
        ),
      );
    },
  );
}
