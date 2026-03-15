import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skincare/routes/route_name.dart';
import '../../../widget/auth/custom_back_button.dart';

class AccountCreateSuccessfully extends StatefulWidget {
  const AccountCreateSuccessfully({super.key});

  @override
  State<AccountCreateSuccessfully> createState() =>
      _AccountCreateSuccessfullyState();
}

class _AccountCreateSuccessfullyState extends State<AccountCreateSuccessfully> {

  @override
  void initState() {
    super.initState();
    _delayedNavigation();
  }

  Future<void> _delayedNavigation() async {
    await Future.delayed(const Duration(seconds: 3));
    Get.offNamed(RouteName.signin);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: screenHeight,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),

                /// Back Button
                const CustomBackButton(),

                const SizedBox(height: 30),

                /// Image
                Center(
                  child: Image.asset(
                    'assets/images/splash/signin.png',
                    height: 220.h,
                    fit: BoxFit.contain,
                  ),
                ),

                const SizedBox(height: 30),

                /// Title + Description
                Center(
                  child: Column(
                    children: [
                      Text(
                        "Account Created Successfully",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),

                      SizedBox(height: 12.h),

                      Text(
                        "Your account has been created. You can now start exploring your account.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 16.sp,
                          color: const Color(0x9901031D),
                        ),
                      ),

                      SizedBox(height: 20.h),
                      const CircularProgressIndicator(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}