import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_recommendation/screenOnboarding/model/onboard_page_model.dart';

List<OnboardPageModel> onboardData = [
  OnboardPageModel(
    Colors.amber[300],
    Colors.white,
    Colors.amber[300],
    2,
    FontAwesomeIcons.utensils,
    'Food Recipes',
    'When it comes to food, you should not say “Live to eat” instead say “Eat to live”. '
        'So dive in to choose your recipe and delight your tastebuds.',
  ),
  OnboardPageModel(
    Colors.white,
    Colors.amber[300],
    Colors.white,
    2,
    FontAwesomeIcons.glassMartini,
    'Don\'t just limit to food!',
    'Do not limit yourself to just food! Fodaffy also provides you with a whole range of beverages and desserts, '
        'so that you can have a luxurious meal right at your home.',
  ),
  OnboardPageModel(
    Colors.amber[300],
    Colors.white,
    Colors.amber[300],
    3,
    FontAwesomeIcons.list,
    'Inventory Tracking',
    'Tired of running out of products and checking the best before dates? From not on, let Fodaffy take '
        'care of that for you.',
  ),
  OnboardPageModel(
    Colors.white,
    Colors.amber[300],
    Colors.amber[300],
    4,
    FontAwesomeIcons.checkSquare,
    'Automatic Shopping List',
    ' Keep forgetting what to buy when in-store? Do you always check if a product has finished in your '
        'kitchen? Fodaffy will help you solve these problems with ease.',
  ),
];
