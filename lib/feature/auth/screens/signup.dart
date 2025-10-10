import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skincare/routes/route_name.dart';

import '../../../widget/auth/custom_back_button.dart';
import '../../../widget/auth/custom_button.dart';
import '../../../widget/auth/custom_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _passwordController = TextEditingController();
  final _rePasswordController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _passwordController.dispose();
    _rePasswordController.dispose();
    super.dispose();
  }

  void _signUp() {
    if (_passwordController.text == _rePasswordController.text) {
      print('Sign up successful');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 10.r, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomBackButton(),
              SizedBox(height: 20.h),

              // Logo
              Center(
                child: SizedBox(
                  width: 150.w,
                  height: 150.h,
                  child: Image.asset(
                    'assets/images/splash/signin.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(height: 10.h),

              // Full Name
              CustomTextField(
                icon: Icons.person,
                labelText: 'Enter Full Name',
                controller: _fullNameController,
              ),
              SizedBox(height: 10.h),

              // Email
              CustomTextField(
                icon: Icons.email,
                labelText: 'Enter Email Address',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 10.h),

              // Mobile
              CustomTextField(
                icon: Icons.phone,
                labelText: 'Enter Mobile Number',
                controller: _mobileController,
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 10.h),

              // Password
              CustomTextField(
                icon: Icons.lock,
                labelText: 'Enter Password',
                controller: _passwordController,
                obscureText: true,
              ),
              SizedBox(height: 10.h),

              // Re-enter Password
              CustomTextField(
                icon: Icons.lock,
                labelText: 'Re-enter Password',
                controller: _rePasswordController,
                obscureText: true,
              ),
              SizedBox(height: 30.h),

              // Sign Up Button
              CustomButton(
                text: 'Sign Up',
                onPressed: _signUp,
              ),

              CustomButton(
                text: 'Sign In',
                onPressed: () {
                  Get.toNamed(RouteName.signin);
                },
              ),


              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}
