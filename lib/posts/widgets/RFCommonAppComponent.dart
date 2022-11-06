import 'package:flutter/material.dart';
import 'package:flutter_infinite_list/posts/utils/RFColors.dart';
import 'package:nb_utils/nb_utils.dart';

class RFCommonAppComponent extends StatefulWidget {
  final String? title;
  final String? subTitle;
  final Widget? cardWidget;
  final Widget? subWidget;
  final Widget? accountCircleWidget;
  final double? mainWidgetHeight;
  final double? subWidgetHeight;

  RFCommonAppComponent(
      {this.title,
      this.subTitle,
      this.cardWidget,
      this.subWidget,
      this.mainWidgetHeight,
      this.subWidgetHeight,
      this.accountCircleWidget});

  @override
  State<RFCommonAppComponent> createState() => _RFCommonAppComponentState();
}

class _RFCommonAppComponentState extends State<RFCommonAppComponent> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.only(bottom: 24),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: context.width(),
            height: widget.mainWidgetHeight ?? 300,
            decoration: boxDecorationWithRoundedCorners(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16)),
              backgroundColor: t1_colorPrimary,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(widget.title.validate(),
                    style: boldTextStyle(color: white, size: 22)),
                4.height,
                Text(widget.subTitle.validate(),
                    style: primaryTextStyle(color: white)),
              ],
            ),
          ),
          Column(
            children: [
              widget.accountCircleWidget ??
                  Container(
                    margin: EdgeInsets.only(
                        top: widget.subWidgetHeight ?? 400,
                        left: 24,
                        bottom: 24,
                        right: 24),
                    padding: EdgeInsets.all(24),
                    decoration: boxDecorationWithRoundedCorners(
                        backgroundColor: context.cardColor),
                    child: widget.cardWidget.validate(),
                  ),
              widget.subWidget.validate(),
            ],
          ),
        ],
      ),
    );
  }
}
