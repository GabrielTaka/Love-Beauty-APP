import 'dart:convert';
import 'package:Ubeleza/utils/constants.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

class CategoryService {

  static String apiHost = Constants.SERVER_ONE;

  dynamic getCategories( BuildContext context ) async {
    final response = await http.get( '$apiHost/api/v1/categories' );
    print( response.statusCode );

    if (response.statusCode == 200) {
      var resp = json.decode(response.body);
      return resp;

    } else {
      Toast.show( 'Erro ao buscar categorias', context, duration: 10, gravity: Toast.BOTTOM );
    }
  }
}