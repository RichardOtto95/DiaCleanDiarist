import 'package:delivery_agent_white_label/app/shared/color_theme.dart';
import 'package:delivery_agent_white_label/app/shared/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  int page = 0;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: getOverlayStyleFromColor(getColors(context).secondary),
      child: Scaffold(
        backgroundColor: Color(0xff412E6E),
        body: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: maxHeight(context),
              width: maxWidth(context),
              child: PageView(
                onPageChanged: (val) {
                  setState(() {
                    page = val;
                  });
                },
                children: [
                  SvgPicture.asset(
                    "./assets/svg/telaonboarding-diarista-1.svg",
                    height: maxHeight(context),
                    width: maxWidth(context),
                  ),
                  SvgPicture.asset(
                    "./assets/svg/telaonboarding-diarista-2.svg",
                    height: maxHeight(context),
                    width: maxWidth(context),
                  ),
                  SvgPicture.asset(
                    "./assets/svg/telaonboarding-diarista-3.svg",
                    height: maxHeight(context),
                    width: maxWidth(context),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: wXD(40, context),
              child: SizedBox(
                width: wXD(65, context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OnBoardingBall(active: page == 0),
                    OnBoardingBall(active: page == 1),
                    OnBoardingBall(active: page == 2),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: page == 0 || page == 1,
              child: Positioned(
                bottom: maxHeight(context) / 2,
                right: wXD(8, context),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: wXD(23, context),
                  color: Colors.white,
                ),
              ),
            ),
            Visibility(
              visible: page == 1 || page == 2,
              child: Positioned(
                bottom: maxHeight(context) / 2,
                left: wXD(8, context),
                child: Icon(
                  Icons.arrow_back_ios_rounded,
                  size: wXD(23, context),
                  color: Colors.white,
                ),
              ),
            ),
            Visibility(
              visible: page == 2,
              child: Positioned(
                top: viewPaddingTop(context) + wXD(27, context),
                right: wXD(18, context),
                child: IconButton(
                  onPressed: () => Modular.to.pushNamed("/waiting"),
                  icon: Container(
                    height: wXD(50, context),
                    width: wXD(50, context),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: lightPurple,
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: wXD(22, context),
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnBoardingBall extends StatelessWidget {
  final bool active;

  const OnBoardingBall({Key? key, required this.active}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: wXD(15, context),
      width: wXD(15, context),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: active ? darkPurple : Colors.white,
          border: Border.all(color: Colors.white)),
    );
  }
}
