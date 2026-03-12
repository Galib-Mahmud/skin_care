// lib/feature/profile/controller/notification_controller.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/endpoint/api_client.dart';
import '../../../core/endpoint/api_endpoint.dart';

class NotificationController extends GetxController {

  static NotificationController get to => Get.put(NotificationController());
  final ApiClient _apiClient = ApiClient(baseUrl: ApiEndpoint.baseUrl);

  final RxBool isLoading              = false.obs;
  final RxBool isSaving               = false.obs;

  // ─── Notification Settings ────────────────────────────────────────
  final RxBool dailyCheckIn           = false.obs;
  final RxBool waterIntake            = false.obs;
  final RxBool dailyDevotional        = false.obs;
  final RxBool productRecommendations = false.obs;
  final RxBool communityUpdates       = false.obs;

  int? _notificationId;

  @override
  void onInit() {
    super.onInit();
    fetchNotificationSettings();
  }

  // ──────────────────────────────────────────────────────────────────
  // FETCH
  // ──────────────────────────────────────────────────────────────────
  Future<void> fetchNotificationSettings() async {
    isLoading.value = true;
    try {
      final response = await _apiClient.get(
        '/api/v1/user/profile/notifications/',
        requiresAuth: true,
      );
      if (response != null) {
        _notificationId             = response['id'];
        dailyCheckIn.value          = response['daily_check_in_reminder']  ?? false;
        waterIntake.value           = response['water_intake_reminder']    ?? false;
        dailyDevotional.value       = response['daily_devotional']         ?? false;
        productRecommendations.value = response['product_recommendations'] ?? false;
        communityUpdates.value      = response['community_updates']        ?? false;
      }
    } on HttpException catch (e) {
      _showError(_extractMessage(_tryParseBody(e.body)) ?? e.message);
    } catch (e) {
      print('❌ fetchNotificationSettings error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // ──────────────────────────────────────────────────────────────────
  // UPDATE
  // ──────────────────────────────────────────────────────────────────
  Future<void> updateNotificationSettings() async {
    isSaving.value = true;
    try {
      await _apiClient.put(
        '/api/v1/user/profile/notifications/',
        body: {
          'daily_check_in_reminder' : dailyCheckIn.value,
          'water_intake_reminder'   : waterIntake.value,
          'daily_devotional'        : dailyDevotional.value,
          'product_recommendations' : productRecommendations.value,
          'community_updates'       : communityUpdates.value,
        },
        requiresAuth: true,
      );
      _showSuccess('Notification settings saved!');
    } on HttpException catch (e) {
      _showError(_extractMessage(_tryParseBody(e.body)) ?? e.message);
    } catch (e) {
      print('❌ updateNotificationSettings error: $e');
      _showError('Something went wrong. Please try again.');
    } finally {
      isSaving.value = false;
    }
  }

  // ── toggle + auto-save ────────────────────────────────────────────
  void toggle(RxBool field) {
    field.value = !field.value;
    updateNotificationSettings();
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