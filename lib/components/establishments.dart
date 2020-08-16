import 'package:Ubeleza/components/establishment_view.dart';
import 'package:Ubeleza/models/establishment.dart';
import 'package:flutter/material.dart';

class Establishments extends StatefulWidget {
  const Establishments(
      {Key key, this.mainScreenAnimationController, this.mainScreenAnimation})
      : super(key: key);

  final AnimationController mainScreenAnimationController;
  final Animation<dynamic> mainScreenAnimation;

  @override
  _EstablishmentsState createState() => _EstablishmentsState();
}

class _EstablishmentsState extends State<Establishments> with TickerProviderStateMixin {
  AnimationController animationController;
  Future<List<Establishment>> establishmentsListData = Establishment.getList();

  @override
  void initState() {
    animationController = AnimationController( duration: const Duration(milliseconds: 2000), vsync: this );
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<List<Establishment>>(
      future: establishmentsListData,
      builder: (BuildContext context, AsyncSnapshot<List<Establishment>> snapshot) {
        Widget categoryWidget = Text('Nenhum estabelecimento encontrado');

        if (snapshot.hasData) {
          List<Establishment> establishmentsListData = snapshot.data;
          print( establishmentsListData.length );

          categoryWidget = buildCategory(establishmentsListData);
        }

        return categoryWidget;
      }
    );
  }

  Widget buildCategory( List<Establishment> establishmentsListData ) {
    return AnimatedBuilder(
      animation: widget.mainScreenAnimationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: widget.mainScreenAnimation,
          child: Transform(
            transform: Matrix4.translationValues(0.0, 30 * (1.0 - widget.mainScreenAnimation.value), 0.0),
            child: Container(
              height: 280,
              width: double.infinity,
              child: ListView.builder(
                padding: const EdgeInsets.only( top: 0, bottom: 0, right: 16, left: 16),
                itemCount: establishmentsListData.length,
                scrollDirection: Axis.horizontal,

                itemBuilder: (BuildContext context, int index) {
                  final int count = establishmentsListData.length > 10 ? 10 : establishmentsListData.length;
                  final Animation<double> animation =
                      Tween<double>(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                              parent: animationController,
                              curve: Interval((1 / count) * index, 1.0,
                                  curve: Curves.fastOutSlowIn)));
                  animationController.forward();

                  return EstablishmentView(
                    animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                        parent: animationController,
                        curve: Interval((1 / count) * 1, 1.0, curve: Curves.fastOutSlowIn)
                    )),
                    animationController: animationController,
                    establishment: establishmentsListData[index],
                  );

                },

              ),
            ),
          ),
        );
      },
    );
  }
}
