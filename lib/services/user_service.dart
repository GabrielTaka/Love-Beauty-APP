import 'dart:convert';
import 'package:Ubeleza/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {

  static String apiHost = Constants.SERVER_ONE; // "https://u-beleza-api.herokuapp.com/";

  sign_in(BuildContext context, String username, String password) async {
    print( 'vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv' );

    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, String> headers = {"Content-type": "application/json"};
    var data = json.encode( {"username": username, "password": password, "grant_type": 'password', "origin": 'app'} );
    
    final response = await http.post("$apiHost/oauth/token", headers: headers, body: data);
    
    print( response.statusCode );
    print( response.body );

    if (response.statusCode == 200) {
      print('33333333333333333333333333333333333333333333');
      var resp = json.decode(response.body);

      prefs.setString( 'access_token', resp['access_token'] );
      prefs.setString( 'token_type', resp['token_type'] );
      prefs.setInt( 'created_at', resp['created_at'] );
      prefs.setInt( 'expires_in', resp['expires_in'] );

      await getCurrentUser();

    } else {
      print('44444444444444444444444444444444444444444444444444444');
      Toast.show( 'Erro ao logar, verifique usuário e senha', context, duration: 10, gravity: Toast.BOTTOM );
      //showAlertDialog1( context, json.decode(response.body) );
    }
  }


  sign_up(BuildContext context, String username, String password, String passwordConfirmation, String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, String> headers = {"Content-type": "application/json"};
    var data = json.encode( 
      {
        "email": username,
        "password": password,
        "password_confirmation": passwordConfirmation,
        "name": name,
        "role": 'user'
      }
    );
    
    final response = await http.post('$apiHost/api/v1/users', headers: headers, body: data);
    
    print( '=========================================' );
    print( response.statusCode );
    print( response.body );
    print( response );

    if (response.statusCode == 201) {
      print('11111111111111111111111111111111111111111');
      await sign_in(context, username, password);

    } else {
      print('2222222222222222222222222222222222222222222222');
      Toast.show( 'Erro ao cadastrar, verifique seus dados', context, duration: 10, gravity: Toast.BOTTOM );
      //showAlertDialog1( context, json.decode(response.body) );
    }
  }


  logoff() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString( 'access_token', '' );
    prefs.setString( 'token_type', '' );
    prefs.setInt( 'created_at', 0 );
    prefs.setInt( 'expires_in', 0 );
    prefs.setString( 'user_name', '' );
    prefs.setString( 'user_email', '' );
  }

  Future<bool> isLogged() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('access_token');
    return ![null, ''].contains(accessToken);
  }


  getCurrentUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, String> headers = {"Content-type": "application/x-www-form-urlencoded"};
    
    final response = await http.get("$apiHost/api/v1/private/current/user?access_token=${prefs.getString('access_token')}", headers: headers);
    
    print( response.statusCode );
    print( response.body );

    if (response.statusCode == 200) {
      print('33333333333333333333333333333333333333333333');
      var resp = json.decode(response.body);

      prefs.setInt( 'user_id', resp['id'] );
      prefs.setString( 'user_email', resp['email'] );
      prefs.setString( 'user_name', resp['name'] );

    } else {
      print('44444444444444444444444444444444444444444444444444444');
    }
  }


  showAlertDialog1(BuildContext context, var resp) {
      // configura o button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () { },
    );

    // configura o  AlertDialog
    AlertDialog alerta = AlertDialog(
      title: Text( resp['access_token'] ),
      content: Text( resp['expires_in'].toString() ),
      actions: [
        okButton,
      ],
    );

    // exibe o dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }

  showAlertDialog(BuildContext context, String resp) {
      // configura o button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () { },
    );
    // configura o  AlertDialog
    AlertDialog alerta = AlertDialog(
      title: Text( 'Access Token' ),
      content: Text( resp ),
      actions: [
        okButton,
      ],
    );
    // exibe o dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }

}