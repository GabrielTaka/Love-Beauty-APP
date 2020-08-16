import 'package:Ubeleza/models/product.dart';
import 'package:Ubeleza/pages/product_info_screen.dart';
import 'package:Ubeleza/utils/ubeleza_theme.dart';
import 'package:flutter/material.dart';

class ProductView extends StatelessWidget {
  final AnimationController animationController;
  final Animation animation;
  final Product product;

  const ProductView({Key key, this.animationController, this.animation, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {

        return FadeTransition(
          opacity: animation,
          child: new Transform(
            transform: new Matrix4.translationValues(0.0, 30 * (1.0 - animation.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only( left: 24, right: 24, top: 16, bottom: 18 ),
              child: Container(
                width: MediaQuery.of(context).size.width - 80,
                height: 282,
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

                child: buildCardBody( context )
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
          padding: const EdgeInsets.only(top: 7, left: 16, right: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              /* Card title */
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[

                      Padding(
                        padding: const EdgeInsets.only( left: 4 ),
                        child: Text(
                          product.subcategory.name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: FintnessAppTheme.fontName,
                              fontWeight: FontWeight.w500,
                              fontSize: 25,
                              letterSpacing: -0.1,
                              color: FintnessAppTheme.darkText
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

                                Transform(
                        transform: new Matrix4.identity()..scale(0.8),
                        child: new Chip(
                          label: new Text(
                            product.category.name,
                            overflow: TextOverflow.ellipsis,
                            style: new TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.lightBlue,
                        ),
                      ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[

                      Padding(
                        padding: const EdgeInsets.only( left: 4, bottom: 3 ),
                        child: Text(
                          'R\$ ${product.price}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: FintnessAppTheme.fontName,
                            fontWeight: FontWeight.w600,
                            fontSize: 25,
                            color: FintnessAppTheme.nearlyDarkBlue,
                          ),
                        ),
                      ),

                    ],
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.network( product.avatar, width: 80 ),
                        ],
                      ),

                    ],
                  )
                ],
              )
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

        buildFooter( context )

      ],
    );
  }


  Widget buildFooter( context ) {
    return Padding(
      padding: const EdgeInsets.only( left: 24, right: 24, top: 8, bottom: 8 ),
      child: Row(
        children: <Widget>[

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                Text(
                  '5 Km',
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
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    'Distância',
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
          ),

          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[

                    FlatButton(
                      onPressed: () {
                        Navigator.push<dynamic>(
                          context,
                          MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) => ProductInfoScreen( animationController: animationController, product: product ),
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
