import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:skincare/routes/app_route.dart';
import 'package:skincare/routes/route_name.dart';
import 'core/theme/color_theme.dart';
import 'feature/auth/controller/auth_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
          initialRoute: RouteName.splashloading,
          getPages: AppRoute.pages,
          initialBinding: AppBinding(),
          defaultTransition: Transition.fade,
        );
      },
    );
  }
}

// ─── App Bindings ──────────────────────────────────────────────────
class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController(), permanent: true);
  }
}