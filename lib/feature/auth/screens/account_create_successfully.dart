import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:skincare/routes/route_name.dart';
import '../../../widget/auth/custom_back_button.dart';
import '../../../widget/auth/custom_button.dart';
import '../../../widget/auth/custom_text_field.dart';

/// Reusable custom back button


class AccountCreateSuccessfully extends StatefulWidget {
  const AccountCreateSuccessfully({super.key});

  @override
  _AccountCreateSuccessfullyState createState() => _AccountCreateSuccessfullyState();
}

class _AccountCreateSuccessfullyState extends State<AccountCreateSuccessfully> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    print('Login attempted with email: ${_emailController.text}');
  }

  void _navigateToSignUp() {
    print('Navigate to Sign Up screen');
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
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 SizedBox(height: 50.h),
                CustomBackButton(), // Back button at top-left
                SizedBox(height: 16.h),
                Center(
                  child: Image.asset(
                    'assets/images/splash/signin.png',

                    fit: BoxFit.contain,
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      Text(
                        "Password Reset",
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 24.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.h),

                    ],
                  ),
                ),

                const SizedBox(height: 12),
                CustomTextField(
                  icon: Icons.lock,
                  labelText: 'Enter New Password',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                CustomTextField(
                  icon: Icons.lock,
                  labelText: 'Re-Enter New Password',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),

                ),
                const SizedBox(height: 16),
                CustomButton(
                  text: 'Update Password',
                  onPressed: () {

                    Get.toNamed(RouteName.mainScreen);


                  },
                ),
                const SizedBox(height: 16),

                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
