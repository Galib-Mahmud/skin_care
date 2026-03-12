import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:skincare/core/local_storage/user_info.dart';
import 'package:skincare/routes/app_route.dart';
import 'package:skincare/routes/route_name.dart';
import 'core/theme/color_theme.dart';
import 'feature/auth/controller/auth_controller.dart';
import 'feature/profile/controller/edit_profile_controller.dart';
import 'feature/profile/controller/notification_controller.dart';
import 'feature/profile/controller/history_order_controller.dart';
import 'feature/profile/controller/profile_controller.dart';
import 'feature/profile/controller/water_goal_controller.dart';
import 'feature/home/controller/home_controller.dart';
import 'feature/shop/controller/shop_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool isAuthenticated = await UserInfo.isLoggedIn();
  runApp(MyApp(
    isAuthenticated: isAuthenticated,
  ));
}

class MyApp extends StatelessWidget {
  bool isAuthenticated = false;
  MyApp({super.key, this.isAuthenticated = false});

  // Get the initial route based on authentication status
  String get initialRoute {
    if (isAuthenticated) {
      return RouteName.homeScreen;
    } else {
      return RouteName.splashloading;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {

        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          initialRoute: initialRoute,
          getPages: AppRoute.pages,
          defaultTransition: Transition.fade,
        );
      },
    );
  }
}

