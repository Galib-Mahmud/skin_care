import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:skincare/feature/auth/screens/password_reset_screen.dart';
import 'package:skincare/feature/auth/screens/otp_screen.dart';
import 'package:skincare/feature/auth/screens/forget_password_screen.dart';
import 'package:skincare/feature/auth/screens/sign_in.dart';
import 'package:skincare/feature/auth/screens/signup.dart';
import 'package:skincare/feature/auth/screens/account_created_successfully.dart';
import 'package:skincare/feature/home/main_screen.dart';
import 'package:skincare/feature/home/ai_recipe_generator.dart';
import 'package:skincare/feature/home/resources.dart';
import 'package:skincare/feature/home/checkin_screen1.dart';
import 'package:skincare/feature/home/jurnal_prompts_screen.dart';
import 'package:skincare/feature/home/profile_screen.dart';
import 'package:skincare/feature/home/recipe_screen.dart';
import 'package:skincare/feature/home/water_goals_screen.dart';
import 'package:skincare/feature/profile/about_contact_screen.dart';
import 'package:skincare/feature/profile/encouragement_screen.dart';
import 'package:skincare/feature/profile/full_story.dart';
import 'package:skincare/feature/profile/privacy_screen.dart';
import 'package:skincare/feature/profile/profile_screen.dart';
import 'package:skincare/feature/shop/cart_screen.dart';
import 'package:skincare/feature/shop/community_screen.dart';
import 'package:skincare/feature/shop/order_failed_screen.dart';
import 'package:skincare/feature/shop/order_success_screen.dart';
import 'package:skincare/feature/shop/place_order_screen.dart';
import 'package:skincare/feature/shop/prayer_request_screen.dart';
import 'package:skincare/feature/shop/shop_screen1.dart';
import 'package:skincare/feature/shop/shop_screen2.dart';
import 'package:skincare/feature/splash/daily_faith_screen.dart';
import 'package:skincare/feature/splash/question1.dart';
import 'package:skincare/feature/splash/question2.dart';
import 'package:skincare/feature/splash/question3.dart';
import 'package:skincare/feature/splash/question4.dart';
import 'package:skincare/feature/splash/question5.dart';
import 'package:skincare/feature/splash/skincare_screen.dart';
import 'package:skincare/feature/splash/subscription_screen.dart';

import 'package:skincare/routes/route_name.dart';

import '../feature/home/daily_daviation.dart';
import '../feature/home/daily_daviation_chatbot_screen.dart';
import '../feature/home/edit_profile_screen.dart';
import '../feature/chat_bot/screens/jurnal_chatbot_screen.dart';
import '../feature/home/skincare_chatbot_screen.dart';
import '../feature/home/skincare_guide.dart';
import '../feature/profile/faith_wins_screen.dart';
import '../feature/profile/notification_screen.dart';
import '../feature/profile/shop_history_screen.dart';
import '../feature/shop/checkout_screen.dart';
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
    ),GetPage(
      name: RouteName.newPass,
      page: () =>PasswordResetScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),
    GetPage(
      name: RouteName.otpScreen,
      page: () =>OtpScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ), GetPage(
      name: RouteName.updatePass,
      page: () =>AccountCreateSuccessfully(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ), GetPage(
      name: RouteName.accountCreateSuccessfully,
      page: () =>AccountCreateSuccessfully(),
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
      page: () =>MainScreen(),
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
    ),GetPage(
      name: RouteName.question1,
      page: () =>Question1(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),GetPage(
      name: RouteName.question2,
      page: () =>Question2(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),GetPage(
      name: RouteName.question3,
      page: () =>Question3(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),GetPage(
      name: RouteName.question4,
      page: () =>Question4(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),GetPage(
      name: RouteName.question5,
      page: () =>Question5(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),GetPage(
      name: RouteName.subscription,
      page: () =>SubscriptionScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),GetPage(
      name: RouteName.dailycheckin1,
      page: () =>CheckinScreen1(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),GetPage(
      name: RouteName.dailycheckin2,
      page: () =>CheckinScreen2(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),GetPage(
      name: RouteName.skincareGuide,
      page: () =>ScreenCareGuide(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),GetPage(
      name: RouteName.dailyDaviation,
      page: () =>DailyDaviationScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),GetPage(
      name: RouteName.recipe,
      page: () =>RecipeScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),GetPage(
      name: RouteName.jurnalprompts,
      page: () =>JurnalPromptsScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),GetPage(
      name: RouteName.skincareChatbot,
      page: () =>SkincareChatBot(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),GetPage(
      name: RouteName.dailyDaviationchatbot,
      page: () =>DailyDaviationChatBot(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),GetPage(
      name: RouteName.airecipeGenerator,
      page: () =>AiRecipeGenerator(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),GetPage(
      name: RouteName.shopScreen1,
      page: () =>ShopScreen1(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),GetPage(
      name: RouteName.shopScreen2,
      page: () =>ShopScreen2(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),GetPage(
      name: RouteName.cart,
      page: () =>CartScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),GetPage(
      name: RouteName.placeOrder,
      page: () =>PlaceOrderScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),GetPage(
      name: RouteName.checkOut,
      page: () =>CheckoutScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),GetPage(
      name: RouteName.orderSuccess,
      page: () =>OrderSuccessScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),GetPage(
      name: RouteName.orderFaild,
      page: () =>OrderFailedScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),GetPage(
      name: RouteName.community,
      page: () =>CommunityScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),GetPage(
      name: RouteName.prayerRequest,
      page: () =>PrayerRequestsScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),GetPage(
      name: RouteName.faithWins,
      page: () =>FaithWinsTestimoniesScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),GetPage(
      name: RouteName.encouragement,
      page: () =>EncouragementBoardScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),GetPage(
      name: RouteName.notification,
      page: () =>NotificationScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),GetPage(
      name: RouteName.fullStory,
      page: () =>FullStoryScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),GetPage(
      name: RouteName.privacy,
      page: () =>PrivacyScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),GetPage(
      name: RouteName.contact,
      page: () =>AboutScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),GetPage(
      name: RouteName.shophistory,
      page: () =>ShopHistoryScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),GetPage(
      name: RouteName.profileScreen1,
      page: () =>ProfileScreen1(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),GetPage(
      name: RouteName.mainScreen,
      page: () =>MainScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),GetPage(
      name: RouteName.jurnalChatBot,
      page: () =>JurnalChatBot(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),GetPage(
      name: RouteName.watergoal,
      page: () =>WaterGoalsScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),GetPage(
      name: RouteName.editProfile,
      page: () =>EditProfileScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),
  ];

}