import 'package:Ubeleza/models/establishment.dart';
import 'package:Ubeleza/pages/establishment_info_screen.dart';
import 'package:Ubeleza/utils/ubeleza_theme.dart';
import 'package:flutter/material.dart';
import 'package:Ubeleza/utils/HexColor.dart';

class EstablishmentView extends StatelessWidget {
  final AnimationController animationController;
  final Animation animation;
  final Establishment establishment;

  const EstablishmentView({Key key, this.animationController, this.animation, this.establishment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {

        return FadeTransition(
          opacity: animation,
          child: new Transform(
            transform: new Matrix4.translationValues( 0.0, 30 * (1.0 - animation.value), 0.0 ),
            child: Padding(
              padding: const EdgeInsets.only( left: 24, right: 24, top: 16, bottom: 18 ),
              child: Container(

                width: MediaQuery.of(context).size.width - 80,
                decoration: BoxDecoration(
                  color: FintnessAppTheme.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                      topRight: Radius.circular(68.0)
                  ),

                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: FintnessAppTheme.grey.withOpacity(0.2),
                        offset: Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                ),

                child: buildCardBody(context)
              ),
            ),
          ),
        );
      },
    );
  }


  Widget buildCardBody(context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only( left: 8, right: 8, top: 4 ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[

                          Container(
                            height: 48,
                            width: 2,
                            decoration: BoxDecoration(
                              color: HexColor('#87A0E5').withOpacity(0.5),
                              borderRadius: BorderRadius.all( Radius.circular(4.0) ),
                            ),
                          ),

                          Flexible(
                            child:
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  establishment.slogan,
                                  style: TextStyle(
                                    fontFamily: FintnessAppTheme.fontName,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    letterSpacing: -0.1,
                                    color: FintnessAppTheme.grey.withOpacity(0.5),
                                  )
                                )
                              )
                          ),

                        ],
                      ),

                    ],
                  ),
                ),
              ),

              Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 30),
                    child: Image.network( establishment.avatar, height: 40, ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only( top: 20, bottom: 0 ),
                    child: FlatButton(
                      onPressed: () {
                        Navigator.push<dynamic>(
                          context,
                          MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) => EstablishmentInfoScreen(animationController: animationController, establishment: establishment),
                          ),
                        );
                      },

                      child: Text(
                        "+ Detalhes",
                        style: TextStyle(
                          color: Colors.blue,
                        )

                    ),
                    )
                  )

                ],
              ),

            ],
          ),
        ),


        Padding(
          padding: const EdgeInsets.only( left: 24, right: 24, top: 8, bottom: 8 ),
          child: Container(
            height: 2,
            decoration: BoxDecoration(
              color: FintnessAppTheme.background,
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
            ),
          ),
        ),

        buildFooter()

      ],
    );
  }


  Widget buildFooter() {
    return Padding(
      padding: const EdgeInsets.only( left: 24, right: 24, top: 8, bottom: 16 ),
      child: Row(
        children: <Widget>[

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                Text(
                  'Avaliações',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: FintnessAppTheme.fontName,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    letterSpacing: -0.2,
                    color: FintnessAppTheme.darkText,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Container(
                    height: 4,
                    width: 70,
                    decoration: BoxDecoration(
                      color: HexColor('#87A0E5').withOpacity(0.2),
                      borderRadius: BorderRadius.all( Radius.circular(4.0) ),
                    ),

                    child: Row(
                      children: <Widget>[
                        Container(
                          width: ((70 / 1.2) * animation.value),
                          height: 4,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              HexColor('#87A0E5'),
                              HexColor('#87A0E5').withOpacity(0.5),
                            ]),
                            borderRadius: BorderRadius.all( Radius.circular(4.0) ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Row(
                    children: <Widget>[
                      Text(
                        '4',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: FintnessAppTheme.fontName,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: FintnessAppTheme.grey.withOpacity(0.5),
                        ),
                      ),

                      Icon(
                        Icons.star,
                        color: Colors.orangeAccent,
                        size: 15.0,
                      )
                    ]
                  )
                ),

              ],
            ),
          ),


          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Text(
                      'Serviços',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: FintnessAppTheme.fontName,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        letterSpacing: -0.2,
                        color: FintnessAppTheme.darkText,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Container(
                        height: 4,
                        width: 70,
                        decoration: BoxDecoration(
                          color: HexColor('#F56E98').withOpacity(0.2),
                          borderRadius: BorderRadius.all( Radius.circular(4.0) ),
                        ),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: ((70 / 2) * animationController.value),
                              height: 4,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  HexColor('#F56E98').withOpacity(0.1),
                                  HexColor('#F56E98'),
                                ]),
                                borderRadius: BorderRadius.all( Radius.circular(4.0) ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(
                        '7 serviços',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: FintnessAppTheme.fontName,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: FintnessAppTheme.grey.withOpacity(0.5),
                        ),
                      ),
                    ),

                  ],
                ),
              ],
            ),
          ),


          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Text(
                      'Distância',
                      style: TextStyle(
                        fontFamily: FintnessAppTheme.fontName,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        letterSpacing: -0.2,
                        color: FintnessAppTheme.darkText,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(right: 0, top: 4),
                      child: Container(
                        height: 4,
                        width: 70,
                        decoration: BoxDecoration(
                          color: HexColor('#F1B440').withOpacity(0.2),
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        ),

                        child: Row(
                          children: <Widget>[
                            Container(
                              width: ((70 / 2.5) * animationController.value),
                              height: 4,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  HexColor('#F1B440').withOpacity(0.1),
                                  HexColor('#F1B440'),
                                ]),
                                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(
                        '5 Km',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: FintnessAppTheme.fontName,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: FintnessAppTheme.grey.withOpacity(0.5),
                        ),
                      ),
                    ),

                  ],
                ),
              ],
            ),
          )


        ],
      ),
    );
  }
}
