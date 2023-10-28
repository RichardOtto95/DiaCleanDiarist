import 'package:delivery_agent_white_label/app/constants/properties.dart';
import 'package:delivery_agent_white_label/app/shared/color_theme.dart';
import 'package:delivery_agent_white_label/app/shared/utilities.dart';

import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final double? width;
  final double? height;
  final double? fontSize;
  final Widget? child;
  final bool isWhite;
  final void Function() onTap;
  final String title;
  final Color? color;

  const PrimaryButton({
    Key? key,
    this.width,
    required this.onTap,
    this.title = '',
    this.height,
    this.child,
    this.isWhite = false,
    this.fontSize,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          color: isWhite
              ? getColors(context).onSurface
              : color ?? getColors(context).primary,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(30),
            onTap: onTap,
            child: Container(
              width: width ?? wXD(274, context),
              height: height ?? wXD(59, context),
              alignment: Alignment.center,
              child: child ??
                  Text(
                    title,
                    style: textFamily(
                      context,
                      color: isWhite
                          ? getColors(context).primary
                          : getColors(context).onPrimary,
                      fontSize: fontSize ?? 18,
                    ),
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
