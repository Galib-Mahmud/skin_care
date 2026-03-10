// lib/feature/home/controller/home_controller.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/endpoint/api_client.dart';
import '../../../core/endpoint/api_endpoint.dart';

class HomeController extends GetxController {

  static HomeController get to => Get.find();
  final ApiClient _apiClient = ApiClient(baseUrl: ApiEndpoint.baseUrl);

  final RxBool isLoading = false.obs;
  final RxBool isSaving  = false.obs;

  // ─── Bible Verse ──────────────────────────────────────────────────
  final RxString bibleVerse = ''.obs;

  // ─── Goals ────────────────────────────────────────────────────────
  final RxString skinStatus = 'Clear'.obs;
  final RxInt    waterGoal  = 8.obs;
  final RxString feeling    = 'Good'.obs;
  final RxInt    remainder  = 1.obs;
  final RxString skinGoal   = ''.obs;

  // ─── Water Intake ─────────────────────────────────────────────────
  final RxInt    waterAchieved   = 0.obs;
  final RxDouble waterPercentage = 0.0.obs;

  // ─── Notes ────────────────────────────────────────────────────────
  final RxBool   isEditingNote = false.obs;
  final RxBool   isSavingNote  = false.obs;
  final RxString noteText      = RxString(
      'How is your skin feeling today? Any concerns or improvements?');
  final RxInt    noteId        = 0.obs;
  final RxString noteDate      = ''.obs;
  final noteController         = TextEditingController();

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
      fetchTodaysNote(),
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
        waterGoal.value       = response['water_goal']                   ?? 8;
        waterAchieved.value   = response['water_goal_achieved']          ?? 0;
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
  // GET /api/v1/services/todays-notes/detail/
  // ──────────────────────────────────────────────────────────────────
  Future<void> fetchTodaysNote() async {
    try {
      final response = await _apiClient.get(
        '/api/v1/services/todays-notes/detail/',
        requiresAuth: true,
      );
      if (response != null) {
        noteId.value        = response['id']    ?? 0;
        noteDate.value      = response['date']  ?? '';
        noteText.value      = response['notes'] ?? '';
        noteController.text = noteText.value;
      }
    } on HttpException catch (e) {
      // 404 = no note yet today — silently ignore
      if (e.statusCode != 404) {
        print('❌ fetchTodaysNote error: ${e.message}');
      }
    } catch (e) {
      print('❌ fetchTodaysNote error: $e');
    }
  }

  // ──────────────────────────────────────────────────────────────────
  // POST /api/v1/services/todays-notes/
  // ──────────────────────────────────────────────────────────────────
  Future<void> saveTodaysNote() async {
    final text = noteController.text.trim();
    if (text.isEmpty) return;

    isSavingNote.value = true;
    try {
      final today = DateTime.now();
      final date  =
          '${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';

      final response = await _apiClient.post(
        '/api/v1/services/todays-notes/',
        body: {
          'date' : date,
          'notes': text,
        },
        requiresAuth: true,
      );

      if (response != null) {
        noteId.value   = response['id']    ?? 0;
        noteDate.value = response['date']  ?? date;
        noteText.value = response['notes'] ?? text;
      }

      _showSuccess('Note saved!');
    } on HttpException catch (e) {
      _showError(_extractMessage(_tryParseBody(e.body)) ?? e.message);
    } catch (e) {
      print('❌ saveTodaysNote error: $e');
      _showError('Something went wrong. Please try again.');
    } finally {
      isSavingNote.value = false;
    }
  }

  // ──────────────────────────────────────────────────────────────────
  // PATCH water intake (+8 or -8 oz)
  // ──────────────────────────────────────────────────────────────────
  Future<void> updateWaterAchieved(int delta) async {
    final newVal =
    (waterAchieved.value + delta).clamp(0, waterGoal.value * 10);
    waterAchieved.value = newVal;

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
      waterAchieved.value =
          (waterAchieved.value - delta).clamp(0, waterGoal.value * 10);
      _showError(_extractMessage(_tryParseBody(e.body)) ?? e.message);
    } catch (e) {
      print('❌ updateWaterAchieved error: $e');
    }
  }

  // ──────────────────────────────────────────────────────────────────
  // PATCH mood + skin status
  // ──────────────────────────────────────────────────────────────────
  Future<void> patchGoals({
    String? newFeeling,
    String? newSkinStatus,
  }) async {
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
  // NOTE TOGGLE — edit ↔ save
  // ──────────────────────────────────────────────────────────────────
  void toggleNote() {
    if (isEditingNote.value) {
      noteText.value = noteController.text;
      saveTodaysNote();        // ← POST on checkmark
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