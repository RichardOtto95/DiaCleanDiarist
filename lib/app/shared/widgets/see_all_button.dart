import 'package:flutter/material.dart';

import '../../constants/properties.dart';
import '../color_theme.dart';
import '../utilities.dart';

class SeeAllButton extends StatelessWidget {
  final String title;
  final void Function() onTap;
  const SeeAllButton({Key? key, required this.title, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: onTap,
        borderRadius: defBorderRadius(context),
        child: Container(
          height: wXD(44, context),
          width: wXD(349, context),
          padding:
              EdgeInsets.only(left: wXD(12, context), right: wXD(19, context)),
          decoration: BoxDecoration(
            border: Border.all(
                color: getColors(context)
                    .onBackground
                    .withOpacity(.7)
                    .withOpacity(.4)),
            borderRadius: defBorderRadius(context),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: textFamily(
                  context,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: getColors(context).primary,
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: getColors(context).primary,
                size: wXD(20, context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
