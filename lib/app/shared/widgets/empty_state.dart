import 'package:delivery_agent_white_label/app/shared/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utilities.dart';

class EmptyState extends StatelessWidget {
  final String title;
  final double? top;
  final String? asset;
  final bool changeColor;
  final double? size;
  const EmptyState({
    Key? key,
    required this.title,
    this.asset,
    this.top,
    this.changeColor = true,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: top ?? 0),
      height: maxHeight(context),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment:
            top != null ? MainAxisAlignment.start : MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            asset ?? './assets/svg/notifications.svg',
            width: wXD(size ?? 117, context),
            height: wXD(size ?? 117, context),
            alignment: Alignment.center,
            color: changeColor ? veryDarkPurple : null,
          ),
          // Image.asset(
          //   asset ?? './assets/images/emptyState.png',
          //   width: wXD(200, context),
          //   height: wXD(160, context),
          //   alignment: Alignment.center,
          // ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: wXD(30, context), vertical: wXD(40, context)),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: textFamily(
                context,
                fontSize: 13,
                color: veryDarkPurple,
              ),
            ),
          )
        ],
      ),
    );
  }
}
