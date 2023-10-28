import 'package:delivery_agent_white_label/app/shared/utilities.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DefaultAppBar extends StatelessWidget {
  final String title;
  final bool noPop;
  final Color? color;
  final Color? textColor;
  final void Function()? onPop;

  DefaultAppBar(
    this.title, {
    this.onPop,
    this.noPop = false,
    this.color,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: getOverlayStyleFromColor(color ?? getColors(context).surface),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: maxWidth(context),
            height: MediaQuery.of(context).viewPadding.top + wXD(50, context),
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
            margin: EdgeInsets.only(bottom: wXD(10, context)),
            decoration: BoxDecoration(
              // borderRadius:
              //     const BorderRadius.only(bottomLeft: Radius.circular(3)),
              color: color ?? getColors(context).surface,
              boxShadow: [
                BoxShadow(
                  blurRadius: 3,
                  color: getColors(context).shadow,
                  offset: Offset(0, 3),
                ),
              ],
            ),
          ),
          Visibility(
            visible: !noPop,
            child: Positioned(
              top: viewPaddingTop(context) + wXD(2, context),
              left: wXD(10, context),
              child: IconButton(
                onPressed: () {
                  if (!noPop) {
                    if (onPop != null) {
                      onPop!();
                    } else {
                      Modular.to.pop();
                    }
                  }
                },
                icon: Icon(
                  Icons.arrow_back_rounded,
                  size: wXD(28, context),
                  color: textColor ??
                      getColors(context).onBackground.withOpacity(.8),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: wXD(19, context),
            child: Text(
              title,
              style: TextStyle(
                color: textColor ?? getColors(context).onBackground,
                fontSize: 20,
                fontWeight: FontWeight.w500,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
