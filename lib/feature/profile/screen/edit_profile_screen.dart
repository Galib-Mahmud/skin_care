// lib/feature/profile/screen/edit_profile_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controller/edit_profile_controller.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditProfileController());

    return Scaffold(
      backgroundColor: const Color(0xFFD9D9D9),
      body: SafeArea(
        child: Obx(() => controller.isLoading.value
            ? const Center(
            child: CircularProgressIndicator(color: Colors.black))
            : Column(
          children: [
            // ─── Top bar ───────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 14, vertical: 8),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  const Spacer(),
                  Obx(() => controller.isSaving.value
                      ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.black87),
                  )
                      : GestureDetector(
                    onTap: controller.saveProfile,
                    child: const Text(
                      'Save',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black87,
                          fontWeight: FontWeight.w600),
                    ),
                  )),
                ],
              ),
            ),

            SizedBox(height: 10.h),

            // ─── Avatar ────────────────────────────────────
            GestureDetector(
              onTap: controller.pickImage,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Obx(() {
                    // priority: newly picked > existing URL > placeholder
                    ImageProvider imageProvider;
                    if (controller.selectedImage.value != null) {
                      imageProvider = FileImage(
                          controller.selectedImage.value!);
                    } else if (controller
                        .currentImageUrl.value.isNotEmpty) {
                      imageProvider = NetworkImage(
                          controller.currentImageUrl.value);
                    } else {
                      imageProvider = const AssetImage(
                          'assets/images/home/img.png');
                    }
                    return CircleAvatar(
                      radius: 48.r,
                      backgroundImage: imageProvider,
                      backgroundColor: Colors.grey.shade300,
                    );
                  }),
                  Positioned(
                    right: 6,
                    bottom: 6,
                    child: Material(
                      color: Colors.transparent,
                      elevation: 2,
                      shape: const CircleBorder(),
                      child: InkWell(
                        customBorder: const CircleBorder(),
                        onTap: controller.pickImage,
                        child: Container(
                          width: 38.w,
                          height: 38.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFFE5E5E5),
                            border: Border.all(
                                color: const Color(0xFFBFBFBF),
                                width: 1),
                          ),
                          child: Center(
                            child: Container(
                              width: 26.w,
                              height: 26.h,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFF6D6D6D),
                              ),
                              child: const Icon(
                                  Icons.camera_alt_rounded,
                                  color: Colors.white,
                                  size: 14),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 18.h),

            // ─── Form fields ───────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  // Name
                  TextField(
                    controller: controller.nameController,
                    textInputAction: TextInputAction.next,
                    decoration: _fieldDecoration('Full Name'),
                  ),
                  SizedBox(height: 12.h),

                  // Area code + Phone
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: TextField(
                          controller: controller.areaController,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          decoration: _fieldDecoration('Area'),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        flex: 7,
                        child: TextField(
                          controller: controller.phoneController,
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.next,
                          decoration: _fieldDecoration('Phone Number'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),

                  // Email
                  TextField(
                    enabled: false,
                    controller: controller.emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: _fieldDecoration('Email'),
                  ),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }

  InputDecoration _fieldDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      isDense: true,
      contentPadding:
      const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      filled: true,
      fillColor: const Color.fromRGBO(255, 255, 255, 0.4),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: const BorderSide(color: Colors.grey, width: 0.9),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.black87, width: 1.2),
      ),
    );
  }
}