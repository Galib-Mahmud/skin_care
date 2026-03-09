// lib/feature/auth/controller/auth_controller.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/endpoint/api_client.dart';
import '../../../core/endpoint/api_endpoint.dart';
import '../../../core/local_storage/user_info.dart';
import '../../../routes/route_name.dart';

class AuthController extends GetxController {

  static AuthController get to => Get.find();

  final ApiClient _apiClient = ApiClient(baseUrl: ApiEndpoint.baseUrl);

  final RxBool isLoading = false.obs;
  final RxString otpFlowType = 'register'.obs;

  // ─── SignUp Controllers ────────────────────────────────────────────
  final fullNameController      = TextEditingController();
  final emailController         = TextEditingController();
  final mobileController        = TextEditingController();
  final passwordController      = TextEditingController();
  final rePasswordController    = TextEditingController();

  // ─── SignIn Controllers ────────────────────────────────────────────
  final signInEmailController    = TextEditingController();
  final signInPasswordController = TextEditingController();

  // ─── Forgot Password Controllers ──────────────────────────────────
  final forgotEmailController           = TextEditingController();
  final newPasswordController           = TextEditingController();
  final confirmNewPasswordController    = TextEditingController();

  // ─── OTP Controllers ──────────────────────────────────────────────
  final List<TextEditingController> otpControllers =
  List.generate(6, (_) => TextEditingController());

  // ─── Onboarding Answers ───────────────────────────────────────────
  final RxString skinStatus = 'Dry'.obs;
  final RxString waterGoal  = '64 oz'.obs;
  final RxString feeling    = 'Tired 😴'.obs;
  final RxString remainder  = '3 time'.obs;
  final RxString skinGoal   = 'Anti-aging & wrinkle care'.obs;

  // ──────────────────────────────────────────────────────────────────
  // REGISTER
  // ──────────────────────────────────────────────────────────────────
  Future<void> register() async {
    if (fullNameController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        passwordController.text.isEmpty) {
      _showError('Please fill all required fields');
      return;
    }
    if (passwordController.text != rePasswordController.text) {
      _showError('Passwords do not match');
      return;
    }

    isLoading.value = true;
    try {
      final body = {
        'email'        : emailController.text.trim(),
        'full_name'    : fullNameController.text.trim(),
        'phone_number' : mobileController.text.trim(),
        'password'     : passwordController.text,
        'skin_status'  : skinStatus.value,
        'water_goal'   : _parseWaterGoal(waterGoal.value),
        'feeling'      : feeling.value,
        'remainder'    : _parseRemainder(remainder.value),
        'skin_goal'    : skinGoal.value,
      };

      await _apiClient.post(
        '/api/v1/auth/register/',
        body: body,
        requiresAuth: false,
      );

      await UserInfo.setUserEmail(emailController.text.trim());
      otpFlowType.value = 'register';
      _clearOtpFields();
      Get.toNamed(RouteName.otpScreen);

    } on HttpException catch (e) {
      final parsed = _tryParseBody(e.body);
      if (_isResendActivation(parsed)) {
        await UserInfo.setUserEmail(emailController.text.trim());
        otpFlowType.value = 'register';
        _clearOtpFields();
        _showInfo('Account not activated. A new code has been sent to your email.');
        Get.toNamed(RouteName.otpScreen);
        return;
      }
      _showError(_extractMessage(parsed) ?? e.message);
    } catch (e) {
      print('❌ Register error: $e');
      _showError('Something went wrong. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

  // ──────────────────────────────────────────────────────────────────
  // VERIFY OTP
  // ──────────────────────────────────────────────────────────────────
  Future<void> verifyOtp() async {
    if (otpFlowType.value == 'register') {
      await _verifyRegistrationOtp();
    } else if (otpFlowType.value == 'forgot_password') {
      await _verifyForgotPasswordOtp();
    }
  }

  Future<void> _verifyRegistrationOtp() async {
    final code = _getOtpCode();
    if (code.length < 6) {
      _showError('Please enter the complete 6-digit code');
      return;
    }
    isLoading.value = true;
    try {
      final email = await UserInfo.getUserEmail();
      await _apiClient.post(
        '/api/v1/auth/register/activate/',
        body: {'email': email, 'code': code},
        requiresAuth: false,
      );
      Get.toNamed(RouteName.accountCreateSuccessfully);
    } on HttpException catch (e) {
      final parsed = _tryParseBody(e.body);
      _showError(_extractMessage(parsed) ?? e.message);
    } catch (e) {
      print('❌ VerifyOTP error: $e');
      _showError('Something went wrong. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resendRegistrationOtp() async {
    final email = await UserInfo.getUserEmail();
    if (email == null) return;
    isLoading.value = true;
    try {
      await _apiClient.post(
        '/api/v1/auth/resend-otp/',
        body: {'email': email},
        requiresAuth: false,
      );
      _showSuccess('A new code has been sent to your email');
    } on HttpException catch (e) {
      final parsed = _tryParseBody(e.body);
      _showError(_extractMessage(parsed) ?? e.message);
    } catch (e) {
      print('❌ ResendOTP error: $e');
      _showError('Something went wrong. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

  // ──────────────────────────────────────────────────────────────────
  // LOGIN
  // ──────────────────────────────────────────────────────────────────
  Future<void> login() async {
    if (signInEmailController.text.trim().isEmpty ||
        signInPasswordController.text.isEmpty) {
      _showError('Please enter email and password');
      return;
    }
    isLoading.value = true;
    try {
      final response = await _apiClient.post(
        '/api/v1/auth/login/',
        body: {
          'email'   : signInEmailController.text.trim(),
          'password': signInPasswordController.text,
        },
        requiresAuth: false,
      );
      if (response != null) {
        await UserInfo.setAccessToken(response['access'] ?? '');
        await UserInfo.setRefreshToken(response['refresh'] ?? '');
      }
      Get.offAllNamed(RouteName.homeScreen);
    } on UnauthorizedException catch (e) {
      final parsed = _tryParseBody(e.body);
      _showError(_extractMessage(parsed) ?? 'Invalid email or password');
    } on HttpException catch (e) {
      final parsed = _tryParseBody(e.body);
      _showError(_extractMessage(parsed) ?? e.message);
    } catch (e) {
      print('❌ Login error: $e');
      _showError('Something went wrong. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

  // ──────────────────────────────────────────────────────────────────
  // FORGOT PASSWORD
  // ──────────────────────────────────────────────────────────────────
  Future<void> forgotPassword() async {
    if (forgotEmailController.text.trim().isEmpty) {
      _showError('Please enter your email address');
      return;
    }
    isLoading.value = true;
    try {
      await _apiClient.post(
        '/api/v1/auth/forgot-password/',
        body: {'email': forgotEmailController.text.trim()},
        requiresAuth: false,
      );
      await UserInfo.setForgotPasswordEmail(forgotEmailController.text.trim());
      otpFlowType.value = 'forgot_password';
      _clearOtpFields();
      Get.toNamed(RouteName.otpScreen);
    } on HttpException catch (e) {
      final parsed = _tryParseBody(e.body);
      _showError(_extractMessage(parsed) ?? e.message);
    } catch (e) {
      print('❌ ForgotPassword error: $e');
      _showError('Something went wrong. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _verifyForgotPasswordOtp() async {
    final code = _getOtpCode();
    if (code.length < 6) {
      _showError('Please enter the complete 6-digit code');
      return;
    }
    isLoading.value = true;
    try {
      final email = await UserInfo.getForgotPasswordEmail();
      await _apiClient.post(
        '/api/v1/auth/forgot-password/verify/',
        body: {'email': email, 'code': code},
        requiresAuth: false,
      );
      Get.toNamed(RouteName.newPass);
    } on HttpException catch (e) {
      final parsed = _tryParseBody(e.body);
      _showError(_extractMessage(parsed) ?? e.message);
    } catch (e) {
      print('❌ VerifyForgotOTP error: $e');
      _showError('Something went wrong. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resendForgotPasswordOtp() async {
    final email = await UserInfo.getForgotPasswordEmail();
    if (email == null) return;
    isLoading.value = true;
    try {
      await _apiClient.post(
        '/api/v1/auth/forgot-password/resend-otp/',
        body: {'email': email},
        requiresAuth: false,
      );
      _showSuccess('A new code has been sent to your email');
    } on HttpException catch (e) {
      final parsed = _tryParseBody(e.body);
      _showError(_extractMessage(parsed) ?? e.message);
    } catch (e) {
      print('❌ ResendForgotOTP error: $e');
      _showError('Something went wrong. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> setNewPassword() async {
    if (newPasswordController.text.isEmpty ||
        confirmNewPasswordController.text.isEmpty) {
      _showError('Please fill in all fields');
      return;
    }
    if (newPasswordController.text != confirmNewPasswordController.text) {
      _showError('Passwords do not match');
      return;
    }
    if (newPasswordController.text.length < 8) {
      _showError('Password must be at least 8 characters');
      return;
    }
    isLoading.value = true;
    try {
      final email = await UserInfo.getForgotPasswordEmail();
      await _apiClient.post(
        '/api/v1/auth/forgot-password/set/password/',
        body: {
          'email'           : email,
          'password'        : newPasswordController.text,
          'confirm_password': confirmNewPasswordController.text,
        },
        requiresAuth: false,
      );
      await UserInfo.clearForgotPasswordEmail();
      _showSuccess('Password updated successfully');
      Get.offAllNamed(RouteName.updatePass);
    } on HttpException catch (e) {
      final parsed = _tryParseBody(e.body);
      _showError(_extractMessage(parsed) ?? e.message);
    } catch (e) {
      print('❌ SetNewPassword error: $e');
      _showError('Something went wrong. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

  // ──────────────────────────────────────────────────────────────────
  // PARSERS
  // ──────────────────────────────────────────────────────────────────
  Map<String, dynamic>? _tryParseBody(String? body) {
    if (body == null || body.trim().isEmpty) return null;
    try {
      final decoded = jsonDecode(body);
      if (decoded is Map<String, dynamic>) return decoded;
    } catch (_) {}
    return null;
  }

  bool _isResendActivation(Map<String, dynamic>? body) {
    if (body == null) return false;
    final emailField = body['email'];
    if (emailField is Map) return emailField['status'] == 'resend_activation';
    return false;
  }

  String? _extractMessage(Map<String, dynamic>? body) {
    if (body == null) return null;
    if (body.containsKey('detail')) return body['detail'].toString();
    for (final entry in body.entries) {
      final val = entry.value;
      if (val is Map && val.containsKey('message')) return val['message'].toString();
      if (val is List && val.isNotEmpty) return val.first.toString();
      if (val is String) return val;
    }
    return null;
  }

  // ──────────────────────────────────────────────────────────────────
  // HELPERS
  // ──────────────────────────────────────────────────────────────────
  String _getOtpCode() => otpControllers.map((c) => c.text).join('');

  void _clearOtpFields() {
    for (var c in otpControllers) c.clear();
  }

  int _parseWaterGoal(String label) {
    final oz = int.tryParse(label.replaceAll(RegExp(r'[^0-9]'), '')) ?? 64;
    final glasses = (oz / 8).round();
    return glasses < 8 ? 8 : glasses;
  }

  int _parseRemainder(String label) {
    return int.tryParse(label.replaceAll(RegExp(r'[^0-9]'), '')) ?? 1;
  }

  // ──────────────────────────────────────────────────────────────────
  // SNACKBARS — using ScaffoldMessenger (no overlay issue)
  // ──────────────────────────────────────────────────────────────────
  void _showError(String message) {
    final context = Get.context;
    if (context == null) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.red.shade700,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  void _showSuccess(String message) {
    final context = Get.context;
    if (context == null) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_outline, color: Colors.white),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.green.shade700,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  void _showInfo(String message) {
    final context = Get.context;
    if (context == null) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.info_outline, color: Colors.white),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.blue.shade700,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
    signInEmailController.dispose();
    signInPasswordController.dispose();
    forgotEmailController.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    for (var c in otpControllers) c.dispose();
    super.onClose();
  }
}