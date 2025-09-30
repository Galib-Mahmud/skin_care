import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:skincare/routes/route_name.dart';
import '../../../widget/auth/custom_back_button.dart';
import '../../../widget/auth/custom_button.dart';
import '../../../widget/auth/custom_text_field.dart';

/// Reusable custom back button


class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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

    return SafeArea(
      child: Scaffold(

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
                  const SizedBox(height: 16),
                  CustomBackButton(), // Back button at top-left
                  const SizedBox(height: 16),
                  Center(
                    child: Image.asset(
                      'assets/images/splash/beauty.jpg',
                      width: 200.w,
                      height: 200.h,


                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 32),
                  CustomTextField(
                    icon: Icons.email,
                    labelText: 'Enter Email Address',
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    icon: Icons.lock,
                    labelText: 'Enter Password',
                    controller: _passwordController,
                    obscureText: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Get.toNamed(RouteName.resetPass);
                        },
                        child: const Text('Forgot Password?'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  CustomButton(
                    text: 'Sign In',
                    onPressed: () {

                      Get.toNamed(RouteName.homeScreen);

                    },
                  ),
                  const SizedBox(height: 16),
                  CustomButton(
                    text: 'Sign Up',
                    onPressed: () {
                      Get.toNamed(RouteName.signup);
                    },
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
