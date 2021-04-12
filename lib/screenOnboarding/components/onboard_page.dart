import 'package:flutter/material.dart';
import 'package:food_recommendation/botttomNavigation/bottomBar2.dart';
import 'package:food_recommendation/providers/color_providers.dart';
import 'package:food_recommendation/screenOnboarding/model/onboard_page_model.dart';
import 'package:provider/provider.dart';

import 'drawer_paint.dart';

class onBoardPage extends StatefulWidget {
  final PageController pageController;
  final OnboardPageModel pageModel;

  const onBoardPage(
      {Key key, @required this.pageModel, @required this.pageController})
      : super(key: key);

  @override
  _onBoardPageState createState() => _onBoardPageState();
}

class _onBoardPageState extends State<onBoardPage>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> heroAnimation;
  Animation<double> borderAnimation;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 750));

    heroAnimation = Tween<double>(begin: -200, end: 0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.bounceOut));
    borderAnimation = Tween<double>(begin: 200, end: 50).animate(
        CurvedAnimation(parent: animationController, curve: Curves.bounceOut));

    animationController.forward(from: 0);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  _nextButtonPressed() {
    Provider.of<ColorProvider>(context).color =
        widget.pageModel.nextAccentColor;
    widget.pageController.nextPage(
      duration: Duration(
        milliseconds: 100,
      ),
      curve: Curves.fastLinearToSlowEaseIn,
    );
  }

  _closeButtonPressed() {
    Provider.of<ColorProvider>(context).color =
        widget.pageModel.nextAccentColor;
    setState(() {
      color = Colors.amber[100];
    });
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => bottomBar2()), (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          color: widget.pageModel.primeColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AnimatedBuilder(
                animation: heroAnimation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(heroAnimation.value, 0),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 32.0),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: Icon(
                          widget.pageModel.imagePath,
                          color: widget.pageModel.accentColor,
                          size: MediaQuery.of(context).size.width / 6,
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width / 6,
              ),
              AnimatedBuilder(
                animation: heroAnimation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(heroAnimation.value, 0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: Container(
                        height: 250,
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                widget.pageModel.subhead,
                                style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: widget.pageModel.accentColor,
                                    letterSpacing: 1,
                                    fontStyle: FontStyle.normal),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                widget.pageModel.description,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: widget.pageModel.accentColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: AnimatedBuilder(
            animation: borderAnimation,
            builder: (context, child) {
              return CustomPaint(
                painter: DrawerPaint(
                  curveColor: widget.pageModel.accentColor,
                ),
                child: Container(
                  width: borderAnimation.value,
                  height: double.infinity,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 24.0),
                      child: IconButton(
                        icon: widget.pageModel.pageNumber != 4
                            ? Icon(
                                Icons.arrow_forward_ios,
                                color: widget.pageModel.primeColor,
                                size: 32,
                              )
                            : Icon(
                                Icons.close,
                                color: widget.pageModel.primeColor,
                                size: 32,
                              ),
                        onPressed: widget.pageModel.pageNumber != 4
                            ? _nextButtonPressed
                            : _closeButtonPressed,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
