import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';

import '../utilities.dart';

class Waiting extends StatefulWidget {
  const Waiting({Key? key}) : super(key: key);

  @override
  State<Waiting> createState() => _WaitingState();
}

class _WaitingState extends State<Waiting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getColors(context).secondary,
      body: GestureDetector(
        onTap: () => Modular.to.pushNamed("/main"),
        child: SizedBox(
          width: maxWidth(context),
          child: Column(
            children: [
              Spacer(flex: 8),
              SvgPicture.asset(
                "./assets/svg/logo-diaclean-dark.svg",
                height: wXD(134, context),
                width: wXD(223, context),
              ),
              Spacer(flex: 10),
              Text(
                "Aguardando aprovação!",
                style: textFamily(
                  context,
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: getColors(context).onSecondary,
                ),
              ),
              Spacer(flex: 5),
              SizedBox(
                width: wXD(296, context),
                child: Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit,\nsed do eiusmod",
                  style: textFamily(
                    context,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.italic,
                    color: getColors(context).onSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Spacer(flex: 20),
            ],
          ),
        ),
      ),
    );
  }
}
