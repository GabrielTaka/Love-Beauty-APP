import 'package:Ubeleza/models/category.dart';
import 'package:Ubeleza/utils/HexColor.dart';
import 'package:Ubeleza/utils/ubeleza_theme.dart';
import 'package:flutter/material.dart';

class VerticalCategories extends StatefulWidget {
  const VerticalCategories(
      {Key key, this.mainScreenAnimationController, this.mainScreenAnimation})
      : super(key: key);

  final AnimationController mainScreenAnimationController;
  final Animation<dynamic> mainScreenAnimation;

  @override
  _VerticalCategories createState() => _VerticalCategories();
}

class _VerticalCategories extends State<VerticalCategories> with TickerProviderStateMixin {
  AnimationController animationController;
  Future<List<Category>> categoriesListData;

  @override
  void initState() {
    animationController = AnimationController( duration: const Duration(milliseconds: 2000), vsync: this );
    super.initState();
    getCategories();
  }

  getCategories() {
    categoriesListData = Category.getList( context );
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

    return FutureBuilder<List<Category>>(
      future: categoriesListData,
      builder: (BuildContext context, AsyncSnapshot<List<Category>> snapshot) {
        Widget categoryWidget = Text('Sem categoria');

        if (snapshot.hasData) {
          List<Category> categoriesListData = snapshot.data;
          print( categoriesListData.length );
          print( categoriesListData[0].titleTxt );

          categoryWidget = buildCategory(categoriesListData);
        }

        return categoryWidget;
      }
    );
  }

  Widget buildCategory( List<Category> categoriesListData ) {
    return AnimatedBuilder(
      animation: widget.mainScreenAnimationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: widget.mainScreenAnimation,
          child: Transform(
            transform: Matrix4.translationValues(0.0, 30 * (1.0 - widget.mainScreenAnimation.value), 0.0),
            child: Container(
              height: 650,
              width: double.infinity,
              child: ListView.builder(
                padding: const EdgeInsets.only( top: 0, bottom: 0, right: 16, left: 16),
                itemCount: categoriesListData.length,
                scrollDirection: Axis.vertical,

                itemBuilder: (BuildContext context, int index) {
                  final int count = categoriesListData.length > 10 ? 10 : categoriesListData.length;
                  final Animation<double> animation =
                      Tween<double>(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                              parent: animationController,
                              curve: Interval((1 / count) * index, 1.0,
                                  curve: Curves.fastOutSlowIn)));
                  animationController.forward();

                  print("==============;;;;");
                  print(categoriesListData[index]);
                  print("==============");

                  return MealsView(
                    categoriesListData: categoriesListData[index],
                    animation: animation,
                    animationController: animationController,
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

class MealsView extends StatelessWidget {
  const MealsView( {Key key, this.categoriesListData, this.animationController, this.animation} ) : super(key: key);

  final Category categoriesListData;
  final AnimationController animationController;
  final Animation<dynamic> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(
                100 * (1.0 - animation.value), 0.0, 0.0),
            child: SizedBox(
              width: 500,
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 16, left: 8, right: 8, bottom: 0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: HexColor(categoriesListData.endColor)
                                  .withOpacity(0.6),
                              offset: const Offset(1.1, 4.0),
                              blurRadius: 8.0),
                        ],
                        gradient: LinearGradient(
                          colors: <HexColor>[
                            HexColor(categoriesListData.startColor),
                            HexColor(categoriesListData.endColor),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(8.0),
                          bottomLeft: Radius.circular(8.0),
                          topLeft: Radius.circular(8.0),
                          topRight: Radius.circular(54.0),
                        ),
                      ),

                      child: Padding(
                        padding: const EdgeInsets.only( top: 10, left: 16, right: 100, bottom: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                
                                  
                                Container(
                                  margin: const EdgeInsets.only( right: 30.0),
                                  child: Image.network( categoriesListData.imagePath, height: 70 ),
                                ),
                                
                                Text(
                                  categoriesListData.titleTxt,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: FintnessAppTheme.fontName,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    letterSpacing: 0.2,
                                    color: FintnessAppTheme.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
