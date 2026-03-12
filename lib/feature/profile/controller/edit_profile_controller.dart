// lib/feature/profile/controller/edit_profile_controller.dart

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/endpoint/api_client.dart';
import '../../../core/endpoint/api_endpoint.dart';
import 'profile_controller.dart';

class EditProfileController extends GetxController {

  static EditProfileController get to => Get.put(EditProfileController());
  final ApiClient _apiClient = ApiClient(baseUrl: ApiEndpoint.baseUrl);

  final RxBool isLoading  = false.obs;
  final RxBool isSaving   = false.obs;

  // ─── Controllers ──────────────────────────────────────────────────
  final nameController  = TextEditingController();
  final areaController  = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();

  // ─── Image ────────────────────────────────────────────────────────
  final Rx<File?> selectedImage      = Rx<File?>(null);
  final RxString  currentImageUrl    = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  // ──────────────────────────────────────────────────────────────────
  // FETCH
  // ──────────────────────────────────────────────────────────────────
  Future<void> fetchProfile() async {
    isLoading.value = true;
    try {
      final response = await _apiClient.get(
        '/api/v1/user/profile/update/',
        requiresAuth: true,
      );
      if (response != null) {
        final fullPhone = response['phone_number'] ?? '';
        // split area code (first 3 digits) and rest
        if (fullPhone.length > 3) {
          areaController.text  = fullPhone.substring(0, 3);
          phoneController.text = fullPhone.substring(3);
        } else {
          phoneController.text = fullPhone;
        }
        nameController.text       = response['full_name']     ?? '';
        emailController.text      = response['email']         ?? '';
        currentImageUrl.value     = response['profile_image'] ?? '';
      }
    } on HttpException catch (e) {
      _showError(_extractMessage(_tryParseBody(e.body)) ?? e.message);
    } catch (e) {
      print('❌ EditProfile fetchProfile error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // ──────────────────────────────────────────────────────────────────
  // PICK IMAGE
  // ──────────────────────────────────────────────────────────────────
  Future<void> pickImage() async {
    final picker = ImagePicker();
    final XFile? picked = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    if (picked != null) {
      selectedImage.value = File(picked.path);
    }
  }

  // ──────────────────────────────────────────────────────────────────
  // SAVE (PUT if full, PATCH if partial)
  // ──────────────────────────────────────────────────────────────────
  Future<void> saveProfile() async {
    if (nameController.text.trim().isEmpty) {
      _showError('Name cannot be empty');
      return;
    }
    if (emailController.text.trim().isEmpty) {
      _showError('Email cannot be empty');
      return;
    }

    isSaving.value = true;
    try {
      final fullPhone =
          '${areaController.text.trim()}${phoneController.text.trim()}';

      if (selectedImage.value != null) {
        // ── multipart (with image) ─────────────────────────────
        await _apiClient.multipart(
          '/api/v1/user/profile/update/',
          method: 'PATCH',
          fields: {
            'full_name'   : nameController.text.trim(),
            'email'       : emailController.text.trim(),
            'phone_number': fullPhone,
          },
          files: {'profile_image': selectedImage.value!},
          requiresAuth: true,
        );
      } else {
        // ── json PATCH (no image change) ───────────────────────
        await _apiClient.patch(
          '/api/v1/user/profile/update/',
          body: {
            'full_name'   : nameController.text.trim(),
            'email'       : emailController.text.trim(),
            'phone_number': fullPhone,
          },
          requiresAuth: true,
        );
      }

      // ── Refresh ProfileController instantly ───────────────────
      final profileController = Get.find<ProfileController>();
      await profileController.fetchProfile();

      _showSuccess('Profile updated successfully!');
      Get.back();

    } on HttpException catch (e) {
      _showError(_extractMessage(_tryParseBody(e.body)) ?? e.message);
    } catch (e) {
      print('❌ saveProfile error: $e');
      _showError('Something went wrong. Please try again.');
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

  @override
  void onClose() {
    nameController.dispose();
    areaController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.onClose();
  }
}