import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_agent_white_label/app/core/models/time_model.dart';
import 'package:delivery_agent_white_label/app/modules/profile/widgets/type_evaluation.dart';

import 'package:delivery_agent_white_label/app/shared/utilities.dart';
import 'package:delivery_agent_white_label/app/shared/widgets/default_app_bar.dart';
import 'package:delivery_agent_white_label/app/shared/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class AnswerRating extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(
                    wXD(16, context),
                    wXD(95, context),
                    wXD(12, context),
                    wXD(12, context),
                  ),
                  width: maxWidth(context),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          color: getColors(context)
                              .onBackground
                              .withOpacity(.9)
                              .withOpacity(.2)),
                    ),
                  ),
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Avalie seu atendimento',
                        style: textFamily(
                          context,
                          color: getColors(context).onBackground,
                          fontSize: 17,
                        ),
                      ),
                      Text(
                        TimeModel().date(Timestamp.now()),
                        style: textFamily(
                          context,
                          color: getColors(context)
                              .onBackground
                              .withOpacity(.9)
                              .withOpacity(.5),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                TypeEvaluation(
                  title: 'Opinião referente ao produto',
                  opinion:
                      'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos',
                  rating: 3,
                  text: '',
                  onChanged: (String value) {},
                ),
                TypeEvaluation(
                  title: 'Opinião referente ao atendimento',
                  opinion:
                      'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos',
                  rating: 3,
                  text: '',
                  onChanged: (String value) {},
                ),
                TypeEvaluation(
                  title: 'Opinião referente a entrega',
                  opinion:
                      'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos',
                  rating: 3,
                  text: '',
                  onChanged: (String value) {},
                ),
                // Padding(
                //   padding: EdgeInsets.fromLTRB(
                //     wXD(19, context),
                //     wXD(12, context),
                //     wXD(17, context),
                //     wXD(17, context),
                //   ),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text(
                //         'Avalie a Scorefy também.',
                //         style: textFamily(context,
                //           color: getColors(context).onBackground,
                //           fontSize: 14,
                //         ),
                //       ),
                //       Text(
                //         'Em uma escala de 0 a 10, qual é a chance de você indicar a Scorefy para um amigo?',
                //         style: textFamily(context,
                //           color: getColors(context).onBackground.withOpacity(.9).withOpacity(.8),
                //           fontSize: 13,
                //           fontWeight: FontWeight.w400,
                //           height: 1.5,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: wXD(15, context)),
                //   child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: getBalls()),
                // ),
                SizedBox(height: wXD(35, context)),
                PrimaryButton(
                  onTap: () {},
                  // height: wXD(52, context),
                  // width: wXD(150, context),
                  title: 'Responder',
                ),
                SizedBox(height: wXD(25, context)),
              ],
            ),
          ),
          DefaultAppBar('Avaliação'),
        ],
      ),
    );
  }

  List<Ball> getBalls() {
    List<Ball> balls = [];
    for (var i = 1; i <= 10; i++) {
      balls.add(Ball(i));
    }
    return balls;
  }
}

class Ball extends StatelessWidget {
  final int number;

  Ball(this.number);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: wXD(26, context),
      width: wXD(26, context),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: getColors(context).primary.withOpacity(.15)),
      alignment: Alignment.center,
      child: Text(
        number.toString(),
        style: textFamily(
          context,
          fontSize: 16,
          color: getColors(context).onBackground.withOpacity(.9),
        ),
      ),
    );
  }
}
