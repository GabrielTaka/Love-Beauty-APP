import 'package:Ubeleza/models/product.dart';
import 'package:Ubeleza/pages/scheduler.dart';
import 'package:Ubeleza/pages/scheduler_screen.dart';
import 'package:Ubeleza/utils/ubeleza_theme.dart';
import 'package:flutter/material.dart';

class ProductInfoScreen extends StatefulWidget {
  const ProductInfoScreen({Key key, this.animationController, this.product}) : super(key: key);

  final AnimationController animationController;
  final Product product;

  @override
  _ProductInfoScreenState createState() => _ProductInfoScreenState();
}

class _ProductInfoScreenState extends State<ProductInfoScreen> with TickerProviderStateMixin {
  Animation<double> topBarAnimation;

  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;

  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;
  final double infoHeight = 100.0;

  @override
  void initState() {
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: widget.animationController,
        curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)
      )
    );

    addAllListData();

    scrollController.addListener(() {
      if (scrollController.offset >= 24) {
        if (topBarOpacity != 1.0) {
          setState(() {
            topBarOpacity = 1.0;
          });
        }

      } else if (scrollController.offset <= 24 &&
          scrollController.offset >= 0) {
        if (topBarOpacity != scrollController.offset / 24) {
          setState(() {
            topBarOpacity = scrollController.offset / 24;
          });
        }

      } else if (scrollController.offset <= 0) {
        if (topBarOpacity != 0.0) {
          setState(() {
            topBarOpacity = 0.0;
          });
        }
      }
    });

    super.initState();
  }

  void addAllListData() {
    const int count = 9;
    final double tempHeight = 280;

    listViews.add(
      Padding(
        padding: EdgeInsets.only(top: 25),
        child: AspectRatio(
          aspectRatio: 1.5,
          child: Image.network( widget.product.avatar ),
        ),
      ),
    );

    listViews.add(
      Container(
        decoration: BoxDecoration(
          color: FintnessAppTheme.nearlyWhite,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(32.0),
              topRight: Radius.circular(32.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: FintnessAppTheme.grey.withOpacity(0.2),
                offset: const Offset(1.1, 1.1),
                blurRadius: 10.0),
          ],
        ),

        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: SingleChildScrollView(
            child: Container(

              constraints: BoxConstraints(
                  minHeight: infoHeight,
                  maxHeight: tempHeight > infoHeight ? tempHeight : infoHeight
              ),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  Padding(
                    padding: const EdgeInsets.only( top: 10.0, left: 18, right: 16 ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            widget.product.title,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 30,
                              letterSpacing: 0.27,
                              color: FintnessAppTheme.darkerText,
                            ),
                          ),
                        ),

                        Container(
                          width: 50,
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: FintnessAppTheme.nearlyDarkBlue,
                            gradient: LinearGradient(
                                colors: [
                                  FintnessAppTheme.nearlyDarkBlue,
                                  Colors.indigo[300] // HexColor('#6A88E5'),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight
                            ),
                            shape: BoxShape.circle,

                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: FintnessAppTheme.nearlyDarkBlue.withOpacity(0.4),
                                  offset: const Offset(3.0, 10.0),
                                  blurRadius: 16.0
                              ),
                            ],
                          ),

                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              splashColor: Colors.white.withOpacity(0.1),
                              highlightColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              onTap: () {
                                //widget.addClick();
                              },
                              child: Icon(
                                Icons.favorite,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                          ),
                        ),

                      ]
                    )
                  ),

                  Padding(
                    padding: const EdgeInsets.only( left: 16, right: 16, bottom: 8, top: 16 ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            widget.product.description,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight.w200,
                              fontSize: 22,
                              letterSpacing: 0.27,
                              color: FintnessAppTheme.nearlyDarkBlue,
                            ),
                          ),
                        ),

                        Container(
                          child: Row(
                            children: <Widget>[
                              Text(
                                '4.1',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontWeight: FontWeight.w200,
                                  fontSize: 22,
                                  letterSpacing: 0.27,
                                  color: FintnessAppTheme.grey,
                                ),
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.orangeAccent,
                                size: 24,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),

                  Row(
                    children: <Widget>[
                      getTimeBoxUI('Preço', 'R\$ ${widget.product.price}'),
                      getTimeBoxUI('Duração', '${widget.product.duraction} minutos'),
                    ],
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );

    listViews.add(
      Container(
        padding: const EdgeInsets.only( left: 16, right: 16, bottom: 8, top: 16 ),
        color: FintnessAppTheme.nearlyWhite,
        child: FlatButton(
          color: FintnessAppTheme.nearlyDarkBlue,
          textColor: Colors.white,
          disabledColor: Colors.grey,
          disabledTextColor: Colors.black,
          padding: EdgeInsets.all(16.0),
          splashColor: Colors.blueAccent,
          onPressed: () {
            Navigator.push<dynamic>(
              context,
              MaterialPageRoute<dynamic>(
                builder: (BuildContext context) => Scheduler( title: widget.product.subcategory.name )
                //builder: (BuildContext context) => SchedulerScreen (animationController: widget.animationController),
              ),
            );
          },
          child: Text(
            "Agendar",
            style: TextStyle(fontSize: 20.0),
          ),
          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
        ),
      )
    );

  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: FintnessAppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[

            getMainListViewUI(),
            //getAppBarUI(),

            Padding(
              padding: EdgeInsets.only(top: 5),
              child: SizedBox(
                width: AppBar().preferredSize.height,
                height: AppBar().preferredSize.height,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell( borderRadius: BorderRadius.circular(AppBar().preferredSize.height ),
                    child: Icon( Icons.arrow_back, color: FintnessAppTheme.nearlyBlack, ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ),


            SizedBox(
              height: 10,
            )
          ],
        ),

      ),
    );
  }

  Widget getMainListViewUI() {
    return FutureBuilder<bool>(
      future: getData(),

      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();

        } else {
          return ListView.builder(
            controller: scrollController,
            padding: EdgeInsets.only(
              top: 20,
              bottom: 5,
            ),
            itemCount: listViews.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              widget.animationController.forward();
              return listViews[index];
            },
          );
        }
      },
    );
  }

  Widget getAppBarUI() {
    return Column(
      children: <Widget>[
        AnimatedBuilder(
          animation: widget.animationController,
          builder: (BuildContext context, Widget child) {
            return FadeTransition(
              opacity: topBarAnimation,
              child: Transform(
                transform: Matrix4.translationValues(
                    0.0, 30 * (1.0 - topBarAnimation.value), 0.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: FintnessAppTheme.white.withOpacity(topBarOpacity),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(32.0),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: FintnessAppTheme.grey.withOpacity(0.4 * topBarOpacity),
                          offset: const Offset(1.1, 1.1),
                          blurRadius: 10.0),
                    ],
                  ),

                  child: Column(
                    children: <Widget>[

                      SizedBox(
                        height: 15,
                      ),

                      Padding(
                        padding: EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 16 - 8.0 * topBarOpacity,
                            bottom: 12 - 8.0 * topBarOpacity),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Ubeleza',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: FintnessAppTheme.fontName,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 22 + 6 - 6 * topBarOpacity,
                                    letterSpacing: 1.2,
                                    color: FintnessAppTheme.darkerText,
                                  ),
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(
                                left: 8,
                                right: 8,
                              ),
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: Icon(
                                      Icons.notifications,
                                      color: FintnessAppTheme.grey,
                                      size: 35,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                      )

                    ],
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }

  Widget getTimeBoxUI(String title, String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: FintnessAppTheme.nearlyWhite,
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: FintnessAppTheme.grey.withOpacity(0.2),
                offset: const Offset(1.1, 1.1),
                blurRadius: 8.0),
          ],
        ),

        child: Padding(
          padding: const EdgeInsets.only( left: 18.0, right: 18.0, top: 12.0, bottom: 12.0 ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: FintnessAppTheme.grey,
                ),
              ),

              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: FintnessAppTheme.nearlyBlue,
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
