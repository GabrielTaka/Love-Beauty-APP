
import 'package:Ubeleza/services/product_service.dart';

class Product {
  int id;
  String title;
  String price;
  String description;
  String duraction;
  String avatar;
  int establishmentId;
  Category category;
  Subcategory subcategory;

  Product({
    this.id,
    this.title,
    this.price,
    this.description,
    this.duraction,
    this.avatar,
    this.establishmentId,
    this.category,
    this.subcategory
  });

  static Future<List<Product>> getList( bool homePage, int establishmentId ) async {
    dynamic products;

    if ( establishmentId != 0 ) {
      products = await new ProductService().getProductsByEstablishment( establishmentId );
    } else {
      products = await new ProductService().getProducts( homePage );
    }

    List<Product> productsList = new List<Product>();

    products.forEach( (product) =>
      productsList.add(
        Product(
          id: product['id'],
          title: product['title'],
          price: product['price'],
          description: product['description'],
          duraction: product['details']['duraction'],
          avatar: product['images'][0]['url'],
          establishmentId: product['establishmentId'],
          category: new Category( product['category_types'] ),
          subcategory: new Subcategory( product['subcategory'] )
        ),
      )
    );

    return productsList;
  }
}


class Category {
  int id;
  String name;

  Category( categoryHash ) {
    if (categoryHash.length > 0) {
      this.id = categoryHash[0]['id'];
      this.name = categoryHash[0]['name'];
    }
  }
}

class Subcategory {
  int id;
  String name;

  Subcategory( subcategoryHash ) {
    if ( subcategoryHash != null ) {
      this.id = subcategoryHash['id'];
      this.name = subcategoryHash['name'];
    }
  }
}