import 'dart:async';
import 'package:delivery_agent_white_label/app/core/services/auth/auth_store.dart';
import 'package:delivery_agent_white_label/app/modules/sign/sign_store.dart';
import 'package:delivery_agent_white_label/app/modules/sign/widgets/custom_pincode_textfield.dart';
import 'package:delivery_agent_white_label/app/shared/utilities.dart';
import 'package:delivery_agent_white_label/app/shared/widgets/default_app_bar.dart';
import 'package:delivery_agent_white_label/app/shared/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../shared/color_theme.dart';

class Verify extends StatefulWidget {
  final String phoneNumber;
  const Verify({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  _VerifyState createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  final SignStore store = Modular.get();
  final AuthStore authStore = Modular.get();
  final TextEditingController _pinCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print('onWillPo verify');
        if (store.loadOverlay != null) {
          if (store.loadOverlay!.mounted) {
            return false;
          }
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: getColors(context).secondary,
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(flex: 2),
                SvgPicture.asset(
                  "./assets/svg/logo-diaclean-dark.svg",
                  height: wXD(134, context),
                  width: wXD(223, context),
                ),
                const Spacer(flex: 2),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: wXD(30, context)),
                  width: maxWidth(context),
                  child: CustomPinCodeTextField(controller: _pinCodeController),
                ),
                const Spacer(flex: 1),
                Observer(
                  builder: (context) => store.resendingSMSSeconds != 0
                      ? Text(
                          "Aguarde ${store.resendingSMSSeconds} segundos para reenviar um novo código",
                          style: textFamily(
                            context,
                            fontSize: 13,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        )
                      : TextButton(
                          child: Text(
                            'Reenviar o código',
                            style: textFamily(
                              context,
                              color: Colors.white.withOpacity(.75),
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                            ),
                          ),
                          onPressed: () {
                            store.resendingSMS(context);
                          },
                        ),
                ),
                const Spacer(flex: 1),
                PrimaryButton(
                  color: darkPurple,
                  onTap: () async {
                    print(
                        '_pinCodeController.text: ${_pinCodeController.text.isNotEmpty} - ${_pinCodeController.text.length}');
                    if (_pinCodeController.text.length == 6 &&
                        _pinCodeController.text.isNotEmpty) {
                      await store.signinPhone(
                        _pinCodeController.text,
                        context,
                      );
                    } else {
                      showErrorToast(context, "Código incompleto!");
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Entrar",
                        style: textFamily(
                          context,
                          color: getColors(context).onPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: wXD(2, context)),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: wXD(18, context),
                        color: getColors(context).onPrimary,
                      )
                    ],
                  ),
                ),
                const Spacer(),
              ],
            ),
            Positioned(
              top: viewPaddingTop(context) + wXD(10, context),
              left: wXD(10, context),
              child: IconButton(
                onPressed: () {
                  Modular.to.pop();
                },
                icon: Icon(
                  Icons.arrow_back_ios_rounded,
                  size: wXD(23, context),
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // showToast(message, Color color) {
  //   Fluttertoast.showToast(
  //     msg: message,
  //     backgroundColor: color,
  //   );
  // }
}
