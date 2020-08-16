import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:Ubeleza/utils/constants.dart';

class ProductService {

  static String apiHost = Constants.SERVER_ONE;

  getProducts( bool homePage ) async {
    Map<String, String> headers = {"Content-type": "application/x-www-form-urlencoded"};

    String urn = '';

    if (homePage) {
      urn = '/api/v1/products_random';
    } else {
      urn = '/api/v1/products';
    }

    String uri = '$apiHost$urn';

    final response = await http.get( uri, headers: headers );

    if (response.statusCode == 200) {
      var resp = json.decode(response.body);
      print( resp );
      return resp;

    } else {
      print('======== GET PRODUCTS ERROR ========');
      print( response.statusCode );
      print( response );
    }
  }


  getProductsByEstablishment( int establishmentId ) async {
    Map<String, String> headers = {"Content-type": "application/x-www-form-urlencoded"};

    String urn = '/api/v1/establishments/$establishmentId/products';

    String uri = '$apiHost$urn';

    final response = await http.get( uri, headers: headers );

    if (response.statusCode == 200) {
      var resp = json.decode(response.body);
      print( resp );
      return resp;

    } else {
      print('======== GET PRODUCTS ERROR ========');
      print( response.statusCode );
      print( response );
    }
  }

}