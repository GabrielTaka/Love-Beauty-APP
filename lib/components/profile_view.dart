import 'package:Ubeleza/pages/sign_in_screen.dart';
import 'package:Ubeleza/services/user_service.dart';
import 'package:Ubeleza/utils/constants.dart';
import 'package:Ubeleza/utils/ubeleza_theme.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  final AnimationController animationController;
  final Animation animation;
  bool logged;

  ProfileView({Key key, this.animationController, this.animation, this.logged}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    _logoff() {
      new UserService().logoff();
      logged = false;
    }

    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {

        return FadeTransition(
          opacity: animation,
          child: new Transform(
            transform: new Matrix4.translationValues( 0.0, 30 * (1.0 - animation.value), 0.0 ),
            child: Padding(
              padding: const EdgeInsets.only( left: 24, right: 24, top: 16, bottom: 18 ),

              child: Container(
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
                    children: <Widget>[

                      Text( Constants.WHERE_AM_I ),
                      Text( Constants.SERVER_ONE ),

                      Visibility(
                        visible: !logged,
                        child: FlatButton(
                          color: Colors.blue,
                          textColor: Colors.white,
                          disabledColor: Colors.grey,
                          disabledTextColor: Colors.black,
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
                            "Fazer login",
                            style: TextStyle(fontSize: 20.0),
                          ),
                          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
                        ),
                      ),

                      Visibility(
                        visible: logged,
                        child: FlatButton(
                          color: Colors.blue,
                          textColor: Colors.white,
                          disabledColor: Colors.grey,
                          disabledTextColor: Colors.black,
                          padding: EdgeInsets.all(10.0),
                          splashColor: Colors.blueAccent,
                          onPressed: () {
                            _logoff();
                          },
                          child: Text(
                            "Sair",
                            style: TextStyle(fontSize: 20.0),
                          ),
                          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
                        ),
                      ),

                    ]

                  )

                ),

              ),
            ),
          ),
        );
      },
    );
  }
}
