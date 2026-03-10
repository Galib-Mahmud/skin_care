// lib/feature/home/controller/home_controller.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/endpoint/api_client.dart';
import '../../../core/endpoint/api_endpoint.dart';

class HomeController extends GetxController {

  static HomeController get to => Get.find();
  final ApiClient _apiClient = ApiClient(baseUrl: ApiEndpoint.baseUrl);

  final RxBool isLoading  = false.obs;
  final RxBool isSaving   = false.obs;

  // ─── Bible Verse ──────────────────────────────────────────────────
  final RxString bibleVerse = ''.obs;

  // ─── Goals ────────────────────────────────────────────────────────
  final RxString skinStatus = 'Clear'.obs;
  final RxInt    waterGoal  = 8.obs;
  final RxString feeling    = 'Good'.obs;
  final RxInt    remainder  = 1.obs;
  final RxString skinGoal   = ''.obs;

  // ─── Water Intake ─────────────────────────────────────────────────
  final RxInt    waterAchieved    = 0.obs;
  final RxDouble waterPercentage  = 0.0.obs;

  // ─── Notes ────────────────────────────────────────────────────────
  final RxBool   isEditingNote    = false.obs;
  final RxString noteText         = RxString(
      'How is your skin feeling today? Any concerns or improvements?');
  final noteController            = TextEditingController();

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
      fetchBibleVerse(),
      fetchGoals(),
      fetchWaterIntake(),
    ]);
    isLoading.value = false;
  }

  // ──────────────────────────────────────────────────────────────────
  // GET /api/v1/services/bible-verses/
  // ──────────────────────────────────────────────────────────────────
  Future<void> fetchBibleVerse() async {
    try {
      final response = await _apiClient.get(
        '/api/v1/services/bible-verses/',
        requiresAuth: true,
      );
      if (response != null && response is List && response.isNotEmpty) {
        bibleVerse.value = response.first['contain'] ?? '';
      }
    } on HttpException catch (e) {
      print('❌ fetchBibleVerse error: ${e.message}');
    } catch (e) {
      print('❌ fetchBibleVerse error: $e');
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
        skinStatus.value = response['skin_status'] ?? 'Clear';
        waterGoal.value  = response['water_goal']  ?? 8;
        feeling.value    = response['feeling']     ?? 'Good';
        remainder.value  = response['remainder']   ?? 1;
        skinGoal.value   = response['skin_goal']   ?? '';
      }
    } on HttpException catch (e) {
      print('❌ fetchGoals error: ${e.message}');
    } catch (e) {
      print('❌ fetchGoals error: $e');
    }
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
        waterGoal.value       = response['water_goal']                    ?? 8;
        waterAchieved.value   = response['water_goal_achieved']           ?? 0;
        waterPercentage.value =
            (response['water_goal_achieved_percentage'] ?? 0).toDouble();
      }
    } on HttpException catch (e) {
      print('❌ fetchWaterIntake error: ${e.message}');
    } catch (e) {
      print('❌ fetchWaterIntake error: $e');
    }
  }

  // ──────────────────────────────────────────────────────────────────
  // PATCH water intake achieved  (+8 or -8 oz)
  // ──────────────────────────────────────────────────────────────────
  Future<void> updateWaterAchieved(int delta) async {
    final newVal = (waterAchieved.value + delta).clamp(0, waterGoal.value * 10);
    waterAchieved.value = newVal; // optimistic

    // recalc percentage locally
    if (waterGoal.value > 0) {
      waterPercentage.value =
          ((newVal / waterGoal.value) * 100).clamp(0, 100).toDouble();
    }

    try {
      await _apiClient.patch(
        '/api/v1/services/water-intake/',
        body: {'water_goal_achieved': newVal},
        requiresAuth: true,
      );
    } on HttpException catch (e) {
      // revert
      waterAchieved.value = (waterAchieved.value - delta)
          .clamp(0, waterGoal.value * 10);
      _showError(_extractMessage(_tryParseBody(e.body)) ?? e.message);
    } catch (e) {
      print('❌ updateWaterAchieved error: $e');
    }
  }

  // ──────────────────────────────────────────────────────────────────
  // PATCH mood + skin status  → /api/v1/user/profile/goal/update/
  // ──────────────────────────────────────────────────────────────────
  Future<void> patchGoals({String? newFeeling, String? newSkinStatus}) async {
    if (newFeeling    != null) feeling.value    = newFeeling;
    if (newSkinStatus != null) skinStatus.value = newSkinStatus;

    try {
      final body = <String, dynamic>{};
      if (newFeeling    != null) body['feeling']     = newFeeling;
      if (newSkinStatus != null) body['skin_status'] = newSkinStatus;

      await _apiClient.patch(
        '/api/v1/user/profile/goal/update/',
        body: body,
        requiresAuth: true,
      );
    } on HttpException catch (e) {
      _showError(_extractMessage(_tryParseBody(e.body)) ?? e.message);
    } catch (e) {
      print('❌ patchGoals error: $e');
    }
  }

  // ──────────────────────────────────────────────────────────────────
  // PUT full goal update  → /api/v1/user/profile/goal/update/
  // ──────────────────────────────────────────────────────────────────
  Future<void> putGoals() async {
    isSaving.value = true;
    try {
      await _apiClient.put(
        '/api/v1/user/profile/goal/update/',
        body: {
          'skin_status': skinStatus.value,
          'water_goal' : waterGoal.value,
          'feeling'    : feeling.value,
          'remainder'  : remainder.value,
          'skin_goal'  : skinGoal.value,
        },
        requiresAuth: true,
      );
      _showSuccess('Goals updated!');
    } on HttpException catch (e) {
      _showError(_extractMessage(_tryParseBody(e.body)) ?? e.message);
    } catch (e) {
      print('❌ putGoals error: $e');
    } finally {
      isSaving.value = false;
    }
  }

  // ─── Note helpers ──────────────────────────────────────────────────
  void toggleNote() {
    if (isEditingNote.value) {
      noteText.value = noteController.text;
    } else {
      noteController.text = noteText.value;
    }
    isEditingNote.value = !isEditingNote.value;
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

  @override
  void onClose() {
    noteController.dispose();
    super.onClose();
  }
}