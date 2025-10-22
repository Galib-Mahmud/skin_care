import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _nameCtrl = TextEditingController(text: 'Jocelyn Nicole');
  final _areaCtrl = TextEditingController(text: '405');
  final _phoneCtrl = TextEditingController(text: '555-0128');
  final _emailCtrl = TextEditingController(text: 'jocelynnicole@gmail.com');

  @override
  void dispose() {
    _nameCtrl.dispose();
    _areaCtrl.dispose();
    _phoneCtrl.dispose();
    _emailCtrl.dispose();
    super.dispose();
  }

  InputDecoration _fieldDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      filled: true,
      fillColor: Color.fromRGBO(255, 255,255, 0.4),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9D9D9),
      body: SafeArea(
        child: Column(
          children: [
            // Top bar: Cancel | Save
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.maybePop(context),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

         SizedBox(height: 10.h),

            // Avatar with camera badge
            Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                  radius: 48.r,
                  backgroundImage: const NetworkImage(
                    'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=512&q=80',
                  ),
                  backgroundColor: Colors.grey.shade300,
                ),
                Positioned(
                  right: 6,
                  bottom: 6,
                  child: Material(
                    color: Colors.transparent,
                    elevation: 2,
                    shape: const CircleBorder(),
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () {},
                      child: Container(
                        width: 38.w,
                        height: 38.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFFE5E5E5),
                          border: Border.all(color: const Color(0xFFBFBFBF), width: 1),
                        ),
                        child: Center(
                          child: Container(
                            width: 26.w,
                            height: 26.h,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF6D6D6D),
                            ),
                            child: Icon(Icons.camera_alt_rounded,
                                color: Colors.white, size: 14),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

          SizedBox(height: 18.h),

            // Form fields
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  TextField(
                    controller: _nameCtrl,
                    textInputAction: TextInputAction.next,
                    decoration: _fieldDecoration('Jocelyn Nicole'),
                  ),
             SizedBox(height: 12.h),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: TextField(
                          controller: _areaCtrl,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          decoration: _fieldDecoration('405'),
                        ),
                      ),
                    SizedBox(width: 12.h),
                      Expanded(
                        flex: 7,
                        child: TextField(
                          controller: _phoneCtrl,
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.next,
                          decoration: _fieldDecoration('555-0128'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  TextField(
                    controller: _emailCtrl,
                    keyboardType: TextInputType.emailAddress,
                    decoration: _fieldDecoration('jocelynnicole@gmail.com'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
