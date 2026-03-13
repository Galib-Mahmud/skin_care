import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Rounded "pill" app bar exactly like the mockup.
/// - Blurred, semi-transparent light surface
/// - Rounded corners
/// - Back chevron on the left
/// - Center title
/// - Chat bubble with smiley on the right
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBack;
  final VoidCallback? onRightTap;

  const CustomAppBar({
    super.key,
    required this.title,
    this.onBack,
    this.onRightTap,
  });

  @override
  Size get preferredSize => Size.fromHeight(64.h);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        height: 60.h,
        // transparent scaffold area
        color: Colors.transparent,
        padding: EdgeInsets.only(top: 8.h,left: 14.w,right: 14.w),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(22.r),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8), // subtle frosted effect
            child: Container(
              height: 58.h,
              decoration: BoxDecoration(
                color: const Color(0xFFE5E7EA).withOpacity(0.82), // light grey like screenshot
                borderRadius: BorderRadius.circular(22.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.12),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: onBack ?? () => Navigator.of(context).maybePop(),
                    borderRadius: BorderRadius.circular(22.r),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                      child: Icon(Icons.arrow_back_ios_new_rounded,
                          size: 24.sp, color: Colors.black87),
                    ),
                  ),

                  // Title centered
                  Expanded(
                    child: Center(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w900,
                          color: Colors.black87,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ),
                  ),

                  // Right icon: chat bubble with smiley face overlay
                  InkWell(
                    onTap: onRightTap,
                    borderRadius: BorderRadius.circular(22.r),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Icon(Icons.chat_bubble_rounded,
                              size: 24.sp, color: Colors.white),
                          // tiny smiley inside
                          Positioned(
                            top: 0,
                            child: Image.asset(
                                'assets/images/home/chatbot.png'),

                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
