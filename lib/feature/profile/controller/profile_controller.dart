// lib/feature/profile/controller/profile_controller.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/endpoint/api_client.dart';
import '../../../core/endpoint/api_endpoint.dart';
import '../../../routes/route_name.dart';

class ProfileController extends GetxController {

  static ProfileController get to => Get.find();
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
      middleText: 'Are you sure you want to logout?',
      textConfirm: 'Logout',
      textCancel: 'Cancel',
      confirmTextColor: Colors.white,
      buttonColor: Colors.black,
      onConfirm: () async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.clear();
        Get.offAllNamed(RouteName.signin);
      },
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