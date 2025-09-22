import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:skincare/feature/auth/screens/otp_screen.dart';
import 'package:skincare/feature/auth/screens/reset_password.dart';
import 'package:skincare/feature/auth/screens/sign_in.dart';
import 'package:skincare/feature/auth/screens/signup.dart';
import 'package:skincare/feature/home/HomeScreen.dart';
import 'package:skincare/feature/home/check_in_screen2.dart';
import 'package:skincare/feature/home/checkin_screen1.dart';
import 'package:skincare/feature/home/profile_screen.dart';
import 'package:skincare/feature/splash/daily_faith_screen.dart';
import 'package:skincare/feature/splash/skincare_screen.dart';

import 'package:skincare/routes/route_name.dart';

import '../feature/splash/loading_splash_screen.dart';
import '../feature/splash/willness_screen.dart';

class AppRoute {
  static final List<GetPage> pages = [
    GetPage(
      name: RouteName.splashloading,
      page: () => LoadingSplashScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),


     GetPage(
      name: RouteName.signup,
      page: () => SignUpScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),


    GetPage(
      name: RouteName.signin,
      page: () =>SignInScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),
    GetPage(
      name: RouteName.resetPass,
      page: () =>ResetPassword(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),
    GetPage(
      name: RouteName.otpScreen,
      page: () =>OtpScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),GetPage(
      name: RouteName.dailyFaith,
      page: () =>DailyFaithScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),GetPage(
      name: RouteName.skinCare,
      page: () =>SkincareScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),GetPage(
      name: RouteName.wellNess,
      page: () =>WellnessScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),GetPage(
      name: RouteName.homeScreen,
      page: () =>HomeScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),GetPage(
      name: RouteName.checkinScreen1,
      page: () =>CheckinScreen1(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),GetPage(
      name: RouteName.checkinScreen2,
      page: () =>CheckinScreen2(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),GetPage(
      name: RouteName.profileScreen,
      page: () =>ProfileScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),
  ];

}