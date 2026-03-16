// lib/feature/goals/controller/water_goal_controller.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skincare/core/snackbar/app_snackbar.dart';
import 'package:skincare/feature/profile/controller/profile_controller.dart';
import '../../../core/endpoint/api_client.dart';
import '../../../core/endpoint/api_endpoint.dart';

class WaterGoalController extends GetxController {
  final ApiClient _apiClient = ApiClient(baseUrl: ApiEndpoint.baseUrl);

  // Status flags
  final RxBool isLoading = false.obs;
  final RxBool isSaving = false.obs;

  // Observable Values (Reflecting API structure)
  final RxDouble waterSliderValue = 8.0.obs; // Maps to water_goal
  final RxString skinGoal = 'Hydration'.obs;
  final RxInt prayerValue = 1.obs; // Maps to remainder

  @override
  void onInit() {
    super.onInit();
    fetchAll();
  }

  Future<void> fetchAll() async {
    isLoading.value = true;
    try {
      // Parallel execution for efficiency
      await Future.wait([fetchWaterIntake(), fetchGoals()]);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchWaterIntake() async {
    try {
      final response = await _apiClient.get('/api/v1/services/water-intake/', requiresAuth: true);
      if (response != null) {
        waterSliderValue.value = (response['water_goal'] ?? 8).toDouble();
      }
    } catch (e) {
      debugPrint('Error fetching water intake: $e');
    }
  }

  Future<void> fetchGoals() async {
    try {
      final response = await _apiClient.get('/api/v1/user/profile/goal/update/', requiresAuth: true);
      if (response != null) {
        skinGoal.value = response['skin_goal'] ?? 'Hydration';
        prayerValue.value = response['remainder'] ?? 1;
        // Sync water goal if the profile goal endpoint is more authoritative
        waterSliderValue.value = (response['water_goal'] ?? 8).toDouble();
      }
    } catch (e) {
      debugPrint('Error fetching goals: $e');
    }
  }

  Future<void> saveAll() async {
    isSaving.value = true;
    try {
      final waterIntakeBody = {'water_goal': waterSliderValue.value.toInt()};
      final profileGoalBody = {
        'skin_goal': skinGoal.value,
        'remainder': prayerValue.value,
        'water_goal': waterSliderValue.value.toInt(),
      };

      await Future.wait([
        _apiClient.put('/api/v1/services/water-intake/', body: waterIntakeBody, requiresAuth: true),
        _apiClient.patch('/api/v1/user/profile/goal/update/', body: profileGoalBody, requiresAuth: true),
      ]);

      // Refresh Profile
      if (Get.isRegistered<ProfileController>()) {
        await Get.find<ProfileController>().fetchGoals();
      }
      AppSnackbar.success('Goals updated successfully!');
    } catch (e) {
      debugPrint('Error saving goals: $e');
      AppSnackbar.error('Failed to update goals. Please try again.');
    } finally {
      isSaving.value = false;
    }
  }
}