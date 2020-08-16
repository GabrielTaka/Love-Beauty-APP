import 'package:Ubeleza/services/category_service.dart';
import 'package:flutter/widgets.dart';

class Category {
  Category({
    this.imagePath = '',
    this.titleTxt = '',
    this.startColor = '',
    this.endColor = '',
    this.meals,
    this.kacl = 0,
  });

  static Future<List<Category>> getList( BuildContext context ) async {
    dynamic categories = await new CategoryService().getCategories( context );

    List<Category> tabIconsList = new List<Category>();

    categories.forEach( (category) => 
      //print( category['icon'] )
      tabIconsList.add(
        Category(
          imagePath: category["icon"],
          titleTxt: category["name"],
          kacl: 0,
          meals: <String>[],
          startColor: '#FA7D82',
          endColor: '#FFB295',
        ),
      )
    );
    
    return tabIconsList;
  }

  String imagePath;
  String titleTxt;
  String startColor;
  String endColor;
  List<String> meals;
  int kacl;

}
