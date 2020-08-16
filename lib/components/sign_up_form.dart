import 'package:Ubeleza/pages/sign_in_screen.dart';
import 'package:Ubeleza/pages/ubeleza_home_screen.dart';
import 'package:Ubeleza/utils/ubeleza_theme.dart';
import 'package:flutter/material.dart';
import 'package:Ubeleza/services/user_service.dart';

class SignUpForm extends StatelessWidget {
  final AnimationController animationController;
  final Animation animation;

  const SignUpForm({Key key, this.animationController, this.animation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final passwordConfirmationController = TextEditingController();

    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {

        return FadeTransition(
          opacity: animation,
          child: new Transform(
            transform: new Matrix4.translationValues( 0.0, 30 * (1.0 - animation.value), 0.0 ),
            child: Padding(
              padding: const EdgeInsets.only( left: 24, right: 24, top: 16, bottom: 18 ),
              child: Column(
                children: <Widget>[

                  Padding(
                    padding: EdgeInsets.only( bottom: 20 ),
                    child: Text(
                      'Cadastre-se',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: FintnessAppTheme.fontName,
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        letterSpacing: 1.2,
                        color: FintnessAppTheme.darkerText,
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only( bottom: 20 ),
                    child: Text('Faça parte do Ubeleza, seu salão delivery', textAlign: TextAlign.center,),
                  ),

                  Container(
                    decoration: BoxDecoration(
                      /*gradient: LinearGradient(colors: [
                        FintnessAppTheme.nearlyDarkBlue,
                        HexColor("#6F56E8")
                      ], begin: Alignment.topLeft, end: Alignment.bottomRight),*/
                      color: FintnessAppTheme.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          bottomLeft: Radius.circular(8.0),
                          bottomRight: Radius.circular(8.0),
                          topRight: Radius.circular(68.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: FintnessAppTheme.grey.withOpacity(0.6),
                            offset: Offset(1.1, 1.1),
                            blurRadius: 10.0),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          //Text('Welcome to Fryo!', style: h3),

                          TextFormField(
                            // autofocus: true,
                            controller: nameController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: "Nome Completo",
                              labelStyle: TextStyle(
                                color: Colors.black38,
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                              ),
                            ),
                            style: TextStyle(fontSize: 20),
                          ),

                          TextFormField(
                            // autofocus: true,
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: "E-mail",
                              labelStyle: TextStyle(
                                color: Colors.black38,
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                              ),
                            ),
                            style: TextStyle(fontSize: 20),
                          ),

                          TextFormField(
                            // autofocus: true,
                            controller: passwordController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: "Senha",
                              labelStyle: TextStyle(
                                color: Colors.black38,
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                              ),
                            ),
                            style: TextStyle(fontSize: 20),
                          ),

                          TextFormField(
                            // autofocus: true,
                            controller: passwordConfirmationController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: "Confirme Senha",
                              labelStyle: TextStyle(
                                color: Colors.black38,
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                              ),
                            ),
                            style: TextStyle(fontSize: 20),
                          ),

                          Padding(
                            padding: EdgeInsets.only( top: 10, bottom: 10 ),
                            child: ( Row(
                              children: <Widget>[

                                FlatButton(
                                  //color: Colors.blue,
                                  textColor: Colors.blue,
                                  //disabledColor: Colors.grey,
                                  disabledTextColor: Colors.grey,
                                  padding: EdgeInsets.all(10.0),
                                  splashColor: Colors.blueAccent,
                                  onPressed: () {
                                    Navigator.push<dynamic>(
                                      context,
                                      MaterialPageRoute<dynamic>(
                                        builder: (BuildContext context) => SignInScreen(animationController: animationController),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "Já possui cadastro? Faça login",
                                    style: TextStyle(fontSize: 15.0),
                                  ),
                                  //shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
                                ),
                              ]
                            )),
                          ),

                          FlatButton(
                            color: Colors.blue,
                            textColor: Colors.white,
                            disabledColor: Colors.grey,
                            disabledTextColor: Colors.black,
                            padding: EdgeInsets.all(10.0),
                            splashColor: Colors.blueAccent,
                            onPressed: () {
                              new UserService().sign_up(context, emailController.text, passwordController.text, passwordConfirmationController.text, nameController.text );

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UbelezaHomeScreen(),
                                ),
                              );
                            },
                            child: Text(
                              "Cadastrar",
                              style: TextStyle(fontSize: 20.0),
                            ),
                            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
                          ),

                        ],
                      ),
                    ),
                  ),
                ]
              )
            ),
          ),
        );
      },
    );
  }
}
