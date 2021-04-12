import 'package:flutter/material.dart';
import 'package:food_recommendation/providers/color_providers.dart';
import 'package:food_recommendation/screenOnboarding/onboarding.dart';
import 'package:provider/provider.dart';

class home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        builder: (context) => ColorProvider(),
        child: Onboarding(),
      ),
    );
  }
}
