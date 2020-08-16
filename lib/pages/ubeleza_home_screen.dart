import 'package:Ubeleza/models/tabIcon_data.dart';
import 'package:Ubeleza/pages/home_screem.dart';
import 'package:Ubeleza/components/bottom_bar_view.dart';
import 'package:Ubeleza/utils/ubeleza_theme.dart';
import 'package:flutter/material.dart';
import './profile_screen.dart';
import './establishments_favorites.dart';


class UbelezaHomeScreen extends StatefulWidget {
  @override
  _UbelezaHomeScreenState createState() => _UbelezaHomeScreenState();
}

class _UbelezaHomeScreenState extends State<UbelezaHomeScreen>
    with TickerProviderStateMixin {
  AnimationController animationController;

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: FintnessAppTheme.background,
  );

  @override
  void initState() {
    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    tabIconsList[0].isSelected = true;

    animationController = AnimationController( duration: const Duration(milliseconds: 600), vsync: this );
    tabBody = HomeScreen(animationController: animationController);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: FintnessAppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder<bool>(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            } else {
              return Stack(
                children: <Widget>[
                  tabBody,
                  bottomBar(),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  Widget bottomBar() {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),

        BottomBarView(
          tabIconsList: tabIconsList,
          addClick: () {},
          changeIndex: (int index) {

            if (index == 0 ) {
              animationController.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody = HomeScreen(animationController: animationController);
                });
              });

            } else if (index == 1) {
              animationController.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody = ProfileScreen(animationController: animationController);
                });
              });

            } else if (index == 2) {
              animationController.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody = EstablishmentsFavorites(animationController: animationController);
                });
              });

            } else if ( index == 3 ) {
              animationController.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody = ProfileScreen(animationController: animationController);
                });
              });
            }

          },
        ),
      ],
    );
  }
}
