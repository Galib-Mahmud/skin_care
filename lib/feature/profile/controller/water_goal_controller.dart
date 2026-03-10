// lib/feature/goals/controller/water_goal_controller.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skincare/feature/profile/controller/profile_controller.dart';
import '../../../core/endpoint/api_client.dart';
import '../../../core/endpoint/api_endpoint.dart';

class WaterGoalController extends GetxController {

  static WaterGoalController get to => Get.find();
  final ApiClient _apiClient = ApiClient(baseUrl: ApiEndpoint.baseUrl);

  final RxBool isLoading  = false.obs;
  final RxBool isSaving   = false.obs;

  // ─── Water Intake (from /services/water-intake/) ──────────────────
  final RxInt waterGoal             = 8.obs;
  final RxInt waterGoalAchieved     = 0.obs;
  final RxDouble achievedPercentage = 0.0.obs;
  int? _waterIntakeId;

  // ─── Goals (from /user/profile/goal/update/) ──────────────────────
  final RxString skinGoal   = 'Hydration'.obs;
  final RxInt prayerGoal    = 1.obs;

  // ─── Local slider/prayer state ────────────────────────────────────
  final RxDouble sliderValue = 8.0.obs;
  final RxInt prayerValue    = 1.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAll();
  }

  // ──────────────────────────────────────────────────────────────────
  // FETCH ALL
  // ──────────────────────────────────────────────────────────────────
  Future<void> fetchAll() async {
    isLoading.value = true;
    await Future.wait([
      fetchWaterIntake(),
      fetchGoals(),
    ]);
    isLoading.value = false;
  }

  // ──────────────────────────────────────────────────────────────────
  // GET /api/v1/services/water-intake/
  // ──────────────────────────────────────────────────────────────────
  Future<void> fetchWaterIntake() async {
    try {
      final response = await _apiClient.get(
        '/api/v1/services/water-intake/',
        requiresAuth: true,
      );
      if (response != null) {
        _waterIntakeId             = response['id'];
        waterGoal.value            = response['water_goal']                  ?? 8;
        waterGoalAchieved.value    = response['water_goal_achieved']         ?? 0;
        achievedPercentage.value   = (response['water_goal_achieved_percentage'] ?? 0).toDouble();
        sliderValue.value          = waterGoal.value.toDouble();
      }
    } on HttpException catch (e) {
      _showError(_extractMessage(_tryParseBody(e.body)) ?? e.message);
    } catch (e) {
      print('❌ fetchWaterIntake error: $e');
    }
  }

  // ──────────────────────────────────────────────────────────────────
  // GET /api/v1/user/profile/goal/update/
  // ──────────────────────────────────────────────────────────────────
  Future<void> fetchGoals() async {
    try {
      final response = await _apiClient.get(
        '/api/v1/user/profile/goal/update/',
        requiresAuth: true,
      );
      if (response != null) {
        skinGoal.value    = response['skin_goal'] ?? 'Hydration';
        prayerGoal.value  = response['remainder'] ?? 1;
        prayerValue.value = prayerGoal.value;
      }
    } on HttpException catch (e) {
      _showError(_extractMessage(_tryParseBody(e.body)) ?? e.message);
    } catch (e) {
      print('❌ fetchGoals error: $e');
    }
  }

  // ──────────────────────────────────────────────────────────────────
  // PUT /api/v1/services/water-intake/  (full update)
  // ──────────────────────────────────────────────────────────────────
  Future<void> updateWaterIntake() async {
    try {
      await _apiClient.put(
        '/api/v1/services/water-intake/',
        body: {
          'water_goal'         : sliderValue.value.toInt(),
          'water_goal_achieved': waterGoalAchieved.value,
        },
        requiresAuth: true,
      );
    } on HttpException catch (e) {
      _showError(_extractMessage(_tryParseBody(e.body)) ?? e.message);
      rethrow;
    }
  }

  // ──────────────────────────────────────────────────────────────────
  // PATCH /api/v1/services/water-intake/  (partial update)
  // ──────────────────────────────────────────────────────────────────
  Future<void> patchWaterIntake({int? waterGoalValue, int? achieved}) async {
    try {
      final body = <String, dynamic>{};
      if (waterGoalValue != null) body['water_goal']          = waterGoalValue;
      if (achieved != null)       body['water_goal_achieved'] = achieved;

      await _apiClient.patch(
        '/api/v1/services/water-intake/',
        body: body,
        requiresAuth: true,
      );
    } on HttpException catch (e) {
      _showError(_extractMessage(_tryParseBody(e.body)) ?? e.message);
      rethrow;
    }
  }

  // ──────────────────────────────────────────────────────────────────
  // PATCH /api/v1/user/profile/goal/update/  (skin goal + prayer)
  // ──────────────────────────────────────────────────────────────────
  Future<void> updateGoals() async {
    try {
      await _apiClient.patch(
        '/api/v1/user/profile/goal/update/',
        body: {
          'skin_goal': skinGoal.value,
          'remainder': prayerValue.value,
        },
        requiresAuth: true,
      );
    } on HttpException catch (e) {
      _showError(_extractMessage(_tryParseBody(e.body)) ?? e.message);
      rethrow;
    }
  }

  // ──────────────────────────────────────────────────────────────────
  // SAVE ALL — called on Save button tap
  // ──────────────────────────────────────────────────────────────────
  // lib/feature/goals/controller/water_goal_controller.dart

  Future<void> saveAll() async {
    isSaving.value = true;
    try {
      await Future.wait([
        updateWaterIntake(),
        updateGoals(),
      ]);
      await fetchAll();

      // ─── Refresh profile screen instantly ──────────────────────
      final profileController = Get.find<ProfileController>();
      await profileController.fetchGoals();  // ← add this

      _showSuccess('Goals saved successfully!');
      Get.back();
    } catch (_) {
      // errors already shown inside individual methods
    } finally {
      isSaving.value = false;
    }
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

  void _showSuccess(String message) {
    final context = Get.context;
    if (context == null) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message, style: const TextStyle(color: Colors.white)),
      backgroundColor: Colors.green.shade700,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ));
  }
}