import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_infinite_list/posts/utils/colors.dart';
import 'package:flutter_infinite_list/posts/utils/constant.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher.dart';

InputDecoration rfInputDecoration(
    {Widget? suffixIcon,
    String? hintText,
    Widget? prefixIcon,
    bool? showPreFixIcon,
    String? lableText,
    bool showLableText = false}) {
  return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: gray.withOpacity(0.4)),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      hintText: hintText,
      hintStyle: secondaryTextStyle(),
      labelStyle: secondaryTextStyle(),
      labelText: showLableText.validate() ? lableText! : null,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: colorPrimary),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: gray.withOpacity(0.4)),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: redColor.withOpacity(0.4)),
      ),
      filled: true,
      fillColor: colorWhite,
      suffix: suffixIcon.validate(),
      prefixIcon: showPreFixIcon.validate() ? prefixIcon.validate() : null);
}

Widget rfCommonRichText(
    {String? title,
    String? subTitle,
    int? textSize,
    double? textHeight,
    Color? titleTextColor,
    Color? subTitleTextColor,
    TextStyle? titleTextStyle,
    TextStyle? subTitleTextStyle}) {
  return RichText(
    //textAlign: TextAlign.center,
    text: TextSpan(
      text: title.validate(),
      style: titleTextStyle ??
          primaryTextStyle(
              size: textSize ?? 14,
              height: textHeight ?? 0,
              letterSpacing: 1.5),
      children: [
        TextSpan(
          text: subTitle.validate(),
          style: subTitleTextStyle ??
              primaryTextStyle(
                  color: subTitleTextColor ?? colorPrimary,
                  size: textSize ?? 14,
                  letterSpacing: 1.5),
        ),
      ],
    ),
  );
}

Future<void> commonLaunchUrl(String address,
    {LaunchMode launchMode = LaunchMode.inAppWebView}) async {
  await launchUrl(Uri.parse(address), mode: launchMode).catchError((e) {
    toast('Invalid URL: $address');
  });
}

void launchMail(String? url) {
  if (url.validate().isNotEmpty) {
    commonLaunchUrl('mailto:' + url!,
        launchMode: LaunchMode.externalApplication);
  }
}

void launchCall(String? url) {
  if (url.validate().isNotEmpty) {
    if (isIOS)
      commonLaunchUrl('tel://' + url!,
          launchMode: LaunchMode.externalApplication);
    else
      commonLaunchUrl('tel:' + url!,
          launchMode: LaunchMode.externalApplication);
  }
}

extension strExt on String {
  Widget iconImage({Color? iconColor, double size = bottomNavigationIconSize}) {
    return Image.asset(
      this,
      width: size,
      height: size,
      color: iconColor ?? gray,
      errorBuilder: (_, __, ___) =>
          placeHolderWidget(width: size, height: size),
    );
  }
}

Decoration shadowWidget(BuildContext context) {
  return boxDecorationWithRoundedCorners(
    backgroundColor: context.cardColor,
    boxShadow: [
      BoxShadow(
          spreadRadius: 0.4,
          blurRadius: 3,
          color: gray.withOpacity(0.1),
          offset: const Offset(1, 6)),
    ],
  );
}

Widget socialLoginWidget(BuildContext context,
    {Function? callBack, String? title1, String? title2}) {
  return Column(
    children: [
      Column(
        children: [
          24.height,
          rfCommonRichText(title: title1, subTitle: title2)
              .paddingAll(8)
              .onTap(() {
            callBack!.call();
          })
        ],
      )
    ],
  );
}

Widget placeHolderWidget(
    {double? height,
    double? width,
    BoxFit? fit,
    AlignmentGeometry? alignment,
    double? radius}) {
  return Image.asset('images/app/placeholder.jpg',
          height: height,
          width: width,
          fit: fit ?? BoxFit.cover,
          alignment: alignment ?? Alignment.center)
      .cornerRadiusWithClipRRect(radius ?? defaultRadius);
}

PreferredSizeWidget commonAppBarWidget(BuildContext context,
    {String? title,
    double? appBarHeight,
    bool? showLeadingIcon,
    bool? bottomSheet,
    bool? roundCornerShape}) {
  return PreferredSize(
    preferredSize: Size.fromHeight(appBarHeight ?? 100.0),
    child: AppBar(
      title: Text(title!, style: boldTextStyle(color: whiteColor, size: 20)),
      systemOverlayStyle:
          const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
      backgroundColor: colorPrimary,
      centerTitle: true,
      leading: showLeadingIcon.validate()
          ? const SizedBox()
          : IconButton(
              onPressed: () {
                finish(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new,
                  color: whiteColor, size: 18),
              color: colorPrimary,
            ),
      elevation: 0,
      shape: roundCornerShape.validate()
          ? const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)))
          : const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.zero),
            ),
    ),
  );
}

// extension strExt on String {
//   Widget iconImage({Color? iconColor, double size = bottomNavigationIconSize}) {
//     return Image.asset(
//       this,
//       width: size,
//       height: size,
//       color: iconColor ?? gray,
//       errorBuilder: (_, __, ___) =>
//           placeHolderWidget(width: size, height: size),
//     );
//   }
// }
