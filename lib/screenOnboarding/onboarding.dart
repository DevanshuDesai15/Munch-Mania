import 'package:flutter/material.dart';
import 'package:food_recommendation/botttomNavigation/bottomBar2.dart';
import 'package:food_recommendation/providers/color_providers.dart';
import 'package:food_recommendation/screenOnboarding/components/onboard_page.dart';
import 'package:food_recommendation/screenOnboarding/components/page_view_indicator.dart';
import 'package:food_recommendation/screenOnboarding/data/onboard_page_data.dart';
import 'package:provider/provider.dart';

class Onboarding extends StatelessWidget {
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    ColorProvider colorProvider = Provider.of<ColorProvider>(context);
    return Stack(
      children: <Widget>[
        PageView.builder(
          controller: pageController,
          physics: NeverScrollableScrollPhysics(),
          itemCount: onboardData.length,
          itemBuilder: (context, index) {
            return onBoardPage(
              pageController: pageController,
              pageModel: onboardData[index],
            );
          },
        ),
        Container(
          width: double.infinity,
          height: 70,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(left: 32.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: MediaQuery.of(context).size.width / 10,
                          width: MediaQuery.of(context).size.width / 10,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              image: DecorationImage(
                                  image: AssetImage("assets/logoTop.png"))),
                        ),
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.only(right: 32.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => bottomBar2()),
                          (_) => false);
                    },
                    child: Text(
                      'Skip',
                      style: TextStyle(
                          color: colorProvider.color,
                          fontSize: MediaQuery.of(context).size.width / 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 80.0, left: 40),
            child: PageViewIndicator(
              controller: pageController,
              itemCount: onboardData.length,
              color: colorProvider.color,
            ),
          ),
        )
      ],
    );
  }
}
