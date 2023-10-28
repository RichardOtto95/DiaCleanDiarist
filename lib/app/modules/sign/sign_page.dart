import 'package:delivery_agent_white_label/app/core/services/auth/auth_store.dart';
import 'package:delivery_agent_white_label/app/modules/sign/sign_store.dart';
import 'package:delivery_agent_white_label/app/shared/color_theme.dart';
import 'package:delivery_agent_white_label/app/shared/utilities.dart';
import 'package:delivery_agent_white_label/app/shared/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class SignPage extends StatefulWidget {
  const SignPage({Key? key}) : super(key: key);

  @override
  _SignPageState createState() => _SignPageState();
}

class _SignPageState extends State<SignPage> {
  final SignStore store = Modular.get();
  final AuthStore authStore = Modular.get();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneNumberController = TextEditingController();
  MaskTextInputFormatter maskFormatterPhone = MaskTextInputFormatter(
      mask: '(##) #####-####', filter: {"#": RegExp(r'[0-9]')});
  String text = '';
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: getOverlayStyleFromColor(getColors(context).secondary),
      child: Listener(
        onPointerDown: (a) => FocusScope.of(context).requestFocus(FocusNode()),
        child: WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Scaffold(
              backgroundColor: getColors(context).secondary,
              body: PageView(
                children: [
                  Observer(builder: (context) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Spacer(),
                        SvgPicture.asset(
                          "./assets/svg/logo-diaclean-dark.svg",
                          height: wXD(134, context),
                          width: wXD(223, context),
                        ),
                        // Image.asset(
                        //   brightness == Brightness.light
                        //       ? "./assets/images/logo.png"
                        //       : "./assets/svg/logo-diaclean-dark.svg",
                        //   width: wXD(173, context),
                        //   height: wXD(153, context),
                        // ),
                        // const Spacer(),
                        // Text(
                        //   'Entrar em sua conta',
                        //   textAlign: TextAlign.center,
                        //   style: textFamily(
                        //     context,
                        //     fontSize: 28,
                        //     color: getColors(context).onBackground,
                        //     fontWeight: FontWeight.w400,
                        //   ),
                        // ),
                        const Spacer(flex: 2),
                        Container(
                          // height: wXD(42, context),
                          width: wXD(224, context),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(23)),
                            color: getColors(context).primary,
                          ),

                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: wXD(20, context),
                                vertical: wXD(13, context)),
                            child: Form(
                              key: _formKey,
                              child: TextFormField(
                                inputFormatters: [maskFormatterPhone],
                                keyboardType: TextInputType.phone,
                                cursorColor: darkPurple,
                                decoration: InputDecoration.collapsed(
                                    hintText: 'Telefone',
                                    hintStyle: textFamily(
                                      context,
                                      fontSize: 16,
                                      color: getColors(context)
                                          .onPrimary
                                          .withOpacity(.6),
                                    )),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                style: textFamily(
                                  context,
                                  fontSize: 16,
                                  color: getColors(context).onPrimary,
                                ),
                                onChanged: (val) {
                                  print(
                                      'val: ${maskFormatterPhone.unmaskText(val)}');
                                  text = maskFormatterPhone.unmaskText(val);
                                  store.setPhone(text);
                                },
                                validator: (value) {
                                  if (value != null) {
                                    print(
                                        'value validator: $value ${value.length}');
                                  }
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor preenchar o número de telefone';
                                  }
                                  if (value.length < 15) {
                                    return 'Preencha com todos os números';
                                  }
                                },
                                onEditingComplete: () {
                                  if (text.length == 11) {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    store.phone ??= text;
                                    print(
                                        'store.start: ${store.resendingSMSSeconds}');
                                    if (store.resendingSMSSeconds != 0) {
                                      Fluttertoast.showToast(
                                        msg:
                                            "Aguarde ${store.resendingSMSSeconds} segundos para reenviar um novo código",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor:
                                            getColors(context).error,
                                        textColor: getColors(context).onError,
                                        fontSize: 16.0,
                                      );
                                    } else {
                                      store.verifyNumber(context);
                                    }
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: "Digite o número por completo!",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor:
                                            getColors(context).error,
                                        textColor: getColors(context).onError,
                                        fontSize: 16.0);
                                  }
                                },
                                controller: _phoneNumberController,
                              ),
                            ),
                          ),
                        ),
                        const Spacer(flex: 1),
                        Observer(
                          builder: (context) => store.resendingSMSSeconds != 0
                              ? Text(
                                  "Aguarde ${store.resendingSMSSeconds} segundos para reenviar um novo código",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white,
                                  ),
                                )
                              : Container(),
                        ),
                        const Spacer(flex: 1),

                        PrimaryButton(
                          color: darkPurple,
                          onTap: () {
                            if (text.length == 11) {
                              FocusScope.of(context).requestFocus(FocusNode());
                              store.phone ??= text;
                              print(
                                  'store.start: ${store.resendingSMSSeconds}');

                              if (store.resendingSMSSeconds != 0) {
                                showErrorToast(context,
                                    "Aguarde ${store.resendingSMSSeconds} segundos para reenviar um novo código");
                              } else {
                                store.verifyNumber(context);
                              }
                            } else {
                              showErrorToast(
                                  context, "Digite o número por completo!");
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
                    );
                  }),
                ],
              )),
        ),
      ),
    );
  }
}
