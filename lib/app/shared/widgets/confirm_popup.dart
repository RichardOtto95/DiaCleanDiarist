import 'dart:ui';

import 'package:delivery_agent_white_label/app/constants/properties.dart';
import 'package:delivery_agent_white_label/app/shared/utilities.dart';

import 'package:flutter/material.dart';

class ConfirmPopup extends StatelessWidget {
  final String text;
  final void Function() onConfirm, onCancel;
  final double? height;
  const ConfirmPopup({
    Key? key,
    required this.text,
    required this.onConfirm,
    required this.onCancel,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool loadCircular = false;
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
      child: GestureDetector(
        onTap: onCancel,
        child: Container(
          height: maxHeight(context),
          width: maxWidth(context),
          color: getColors(context).shadow,
          alignment: Alignment.center,
          child: Material(
            borderRadius: defBorderRadius(context),
            // borderRadius: BorderRadius.only(
            //   bottomLeft: defBorderRadius(context),
            //   topRight: defBorderRadius(context),
            // ),
            child: Container(
              height: height ?? wXD(145, context),
              width: wXD(327, context),
              padding: EdgeInsets.all(wXD(25, context)),
              decoration: BoxDecoration(
                color: getColors(context).surface,
                borderRadius: defBorderRadius(context),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 18,
                    color: getColors(context).shadow,
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    text,
                    style: textFamily(context,
                        fontSize: 17,
                        color: getColors(context).onSurface.withOpacity(.9)),
                  ),
                  Spacer(),
                  StatefulBuilder(
                    builder: (context, setState) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: loadCircular
                            ? [
                                CircularProgressIndicator(
                                  color: getColors(context).primary,
                                )
                              ]
                            : [
                                PopupButton(text: 'Não', onTap: onCancel),
                                SizedBox(width: wXD(0, context)),
                                PopupButton(
                                  text: 'Sim',
                                  inverse: true,
                                  onTap: () {
                                    setState(() {
                                      loadCircular = true;
                                      onConfirm();
                                    });
                                  },
                                ),
                              ],
                      );
                    },
                  ),
                  SizedBox(height: wXD(5, context)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PopupButton extends StatelessWidget {
  final String text;
  final double? width;
  final double? fontSize;
  final bool inverse;
  final void Function() onTap;
  const PopupButton(
      {Key? key,
      required this.text,
      required this.onTap,
      this.width,
      this.fontSize,
      this.inverse = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: wXD(41, context),
        width: width ?? wXD(78, context),
        decoration: BoxDecoration(
          borderRadius: defBorderRadius(context),
          boxShadow: const [
            BoxShadow(
                blurRadius: 8, offset: Offset(0, 3), color: Color(0x30000000))
          ],
          color:
              inverse ? getColors(context).primary : getColors(context).surface,
          // border: Border.all(
          //   color: brightness == Brightness.light
          //       ? getColors(context).onBackground
          //       : getColors(context).surface,
          // ),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: textFamily(
            context,
            color: inverse
                ? getColors(context).onPrimary
                : getColors(context).primary,
            fontSize: fontSize ?? 17,
          ),
        ),
      ),
    );
  }
}
