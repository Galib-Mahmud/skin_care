// lib/feature/profile/controller/profile_controller.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/endpoint/api_client.dart';
import '../../../core/endpoint/api_endpoint.dart';
import '../../../routes/route_name.dart';

class ProfileController extends GetxController {

  static ProfileController get to => Get.put(ProfileController());
  final ApiClient _apiClient = ApiClient(baseUrl: ApiEndpoint.baseUrl);

  final RxBool isLoading     = false.obs;
  final RxString fullName    = ''.obs;
  final RxString email       = ''.obs;
  final RxString phoneNumber = ''.obs;
  final RxString profileImage = ''.obs;

  // ─── Goals ────────────────────────────────────────────────────────
  final RxString skinStatus  = ''.obs;
  final RxInt waterGoal      = 0.obs;
  final RxString feeling     = ''.obs;
  final RxInt remainder      = 0.obs;
  final RxString skinGoal    = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
    fetchGoals();
  }

  Future<void> fetchProfile() async {
    isLoading.value = true;
    try {
      final response = await _apiClient.get(
        '/api/v1/user/profile/details/',
        requiresAuth: true,
      );
      if (response != null) {
        fullName.value     = response['full_name']     ?? '';
        email.value        = response['email']         ?? '';
        phoneNumber.value  = response['phone_number']  ?? '';
        profileImage.value = response['profile_image'] ?? '';
      }
    } on HttpException catch (e) {
      _showError(_extractMessage(_tryParseBody(e.body)) ?? e.message);
    } catch (e) {
      print('❌ fetchProfile error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchGoals() async {
    try {
      final response = await _apiClient.get(
        '/api/v1/user/profile/goal/update/',
        requiresAuth: true,
      );
      if (response != null) {
        skinStatus.value = response['skin_status'] ?? '';
        waterGoal.value  = response['water_goal']  ?? 0;
        feeling.value    = response['feeling']     ?? '';
        remainder.value  = response['remainder']   ?? 0;
        skinGoal.value   = response['skin_goal']   ?? '';
      }
    } on HttpException catch (e) {
      _showError(_extractMessage(_tryParseBody(e.body)) ?? e.message);
    } catch (e) {
      print('❌ fetchGoals error: $e');
    }
  }

  void logout() {
    Get.defaultDialog(
      title: 'Logout',
      titleStyle: Get.textTheme.titleLarge!.copyWith(
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
      middleText: 'Are you sure you want to logout?',
      middleTextStyle: Get.textTheme.bodyMedium!.copyWith(
        color: Colors.black54,
        fontSize: 16,
      ),
      backgroundColor: Colors.white,
      radius: 16,
      barrierDismissible: true,
      textCancel: 'Cancel',
      cancelTextColor: Colors.black87,
      onCancel: () {
        Get.back();
      },
      textConfirm: 'Logout',
      confirmTextColor: Colors.white,
      buttonColor: Get.theme.colorScheme.secondary, // theme color
      onConfirm: () async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.clear();
        Get.offAllNamed(RouteName.signin);
      },
      // Optional: content padding
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    );
  }

  // ─── Helpers ──────────────────────────────────────────────────────
  Map<String, dynamic>? _tryParseBody(String? body) {
    if (body == null || body.trim().isEmpty) return null;
    try {
      final decoded = jsonDecode(body);
      if (decoded is Map<String, dynamic>) return decoded;
    } catch (_) {}
    return null;
  }

  String? _extractMessage(Map<String, dynamic>? body) {
    if (body == null) return null;
    if (body.containsKey('detail')) return body['detail'].toString();
    for (final entry in body.entries) {
      final val = entry.value;
      if (val is List && val.isNotEmpty) return val.first.toString();
      if (val is String) return val;
    }
    return null;
  }

  void _showError(String message) {
    final context = Get.context;
    if (context == null) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message, style: const TextStyle(color: Colors.white)),
      backgroundColor: Colors.red.shade700,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ));
  }
}