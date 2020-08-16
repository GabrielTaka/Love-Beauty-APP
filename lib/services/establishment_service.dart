import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:Ubeleza/utils/constants.dart';

import 'package:shared_preferences/shared_preferences.dart';

class EstablishmentService {
  
  static String apiHost = Constants.SERVER_ONE;

  getEstablishments(bool homePage) async {
    Map<String, String> headers = {"Content-type": "application/x-www-form-urlencoded"};

    String urn = '';
    
    if (homePage) {
      urn = '/api/v1/establishments_random';
    } else {
      urn = '/api/v1/establishments';
    }

    String uri = '$apiHost$urn';

    final response = await http.get("$uri", headers: headers);

    if (response.statusCode == 200) {
      var resp = json.decode(response.body);
      return resp;

    } else {
      print( '----- GET ESTABLISHMENTS ERROR -----' );
      print( 'Status Code: ${response.statusCode}' );
      print( response.body );
    }
  }

  favoriteEstablishment(establishmentId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> headers = {"Content-type": "application/json"};
    var data = json.encode( 
      {
        "access_token": prefs.getString("access_token")
      }
    );
    final response = await http.post('$apiHost/api/v1/private/establishments/$establishmentId/favorite_establishment', headers: headers, body: data );

    return response.statusCode;
  }



}