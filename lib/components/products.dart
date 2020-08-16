import 'package:Ubeleza/components/product_view.dart';
import 'package:Ubeleza/models/product.dart';
import 'package:flutter/material.dart';

class Products extends StatefulWidget {
  final AnimationController mainScreenAnimationController;
  final Animation<dynamic> mainScreenAnimation;
  final bool homePage;
  final int establishmentId;

  const Products(
    {
      Key key,
      this.mainScreenAnimationController,
      this.mainScreenAnimation,
      this.homePage = true,
      this.establishmentId = 0
    }
  ) : super(key: key);

  @override
  _ProductsState createState() => _ProductsState( );
}

class _ProductsState extends State<Products> with TickerProviderStateMixin {
  AnimationController animationController;
  Future<List<Product>> productsListData;

  @override
  void initState() {
    animationController = AnimationController( duration: const Duration(milliseconds: 2000), vsync: this );
    getProductList();
    super.initState();
  }

  getProductList() {
    productsListData = Product.getList( widget.homePage, widget.establishmentId );
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

    return FutureBuilder<List<Product>>(
      future: productsListData,
      builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
        Widget categoryWidget = Text('Nenhum produto encontrado');

        if (snapshot.hasData) {
          List<Product> productsListData = snapshot.data;
          print( productsListData.length );

          categoryWidget = buildProduct(productsListData);
        }

        return categoryWidget;
      }
    );
  }

  Widget buildProduct( List<Product> productsListData ) {
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
                itemCount: productsListData.length,
                scrollDirection: Axis.horizontal,

                itemBuilder: (BuildContext context, int index) {
                  final int count = productsListData.length > 10 ? 10 : productsListData.length;
                  final Animation<double> animation =
                      Tween<double>(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                              parent: animationController,
                              curve: Interval((1 / count) * index, 1.0,
                                  curve: Curves.fastOutSlowIn)));
                  animationController.forward();

                  print('===========================================================');
                  print(productsListData[index].avatar);

                  return ProductView(
                    animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                        parent: animationController,
                        curve: Interval((1 / count) * 1, 1.0, curve: Curves.fastOutSlowIn)
                    )),
                    animationController: animationController,
                    product: productsListData[index],
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
