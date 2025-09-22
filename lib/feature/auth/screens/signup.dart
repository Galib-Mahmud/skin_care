import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:skincare/routes/route_name.dart';

import '../../../widget/auth/custom_back_button.dart';
import '../../../widget/auth/custom_button.dart';
import '../../../widget/auth/custom_text_field.dart';

class SignUpScreen extends StatefulWidget {
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
    // Add sign-up logic here
    if (_passwordController.text == _rePasswordController.text) {
      // Proceed with sign-up
      print('Sign up successful');
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Passwords do not match')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                CustomBackButton(),
                Center(child: Image.asset('assets/images/auth/logo.png',

                  fit: BoxFit.contain,
                ),
                ),
                // Ensure logo.png is in assets
                CustomTextField(
                  icon: Icons.person,
                  labelText: 'Enter Full Name',
                  controller: _fullNameController,
                  keyboardType: null,
                ),
                CustomTextField(
                  icon: Icons.email,
                  labelText: 'Enter Email Address',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                CustomTextField(
                  icon: Icons.phone,
                  labelText: 'Enter Mobile Number',
                  controller: _mobileController,
                  keyboardType: TextInputType.phone,
                ),
                CustomTextField(
                  icon: Icons.lock,
                  labelText: 'Enter Password',
                  controller: _passwordController,
                  obscureText: true,
                  keyboardType: null,
                ),
                CustomTextField(
                  icon: Icons.lock,
                  labelText: 'Re-enter Password',
                  controller: _rePasswordController,
                  obscureText: true,
                  keyboardType: null,
                ),
                CustomButton(
                  text: 'Sign Up',
                  onPressed: () {
                    Get.toNamed(RouteName.signin);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
