import 'package:flutter/material.dart';
import 'package:todo_app/features/landing_page/landing_page_main.dart';

const String routeLandingPage = '/';

Route<dynamic> generatePageRoute(RouteSettings settings) {
  switch (settings.name) {
    case routeLandingPage:
      return MaterialPageRoute(builder: (context) => const LandingPageMain());
    default:
      return MaterialPageRoute(builder: (context) => const LandingPageMain());
      ;
  }
}

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static GlobalKey<NavigatorState> dashBoardNavigatorKey =
      GlobalKey<NavigatorState>();
  static GlobalKey<NavigatorState> accountNavigatorKey =
      GlobalKey<NavigatorState>();
  static GlobalKey<NavigatorState> billPayNavigatorKey =
      GlobalKey<NavigatorState>();
  static GlobalKey<NavigatorState> rewardsNavigatorKey =
      GlobalKey<NavigatorState>();
  static GlobalKey<NavigatorState> secureHomeNavigatorKey =
      GlobalKey<NavigatorState>();
  static GlobalKey<NavigatorState> termsAndConditionsNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'termsandconditionsnavigator');
}
