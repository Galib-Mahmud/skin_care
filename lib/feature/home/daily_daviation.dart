import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DailyDaviationScreen extends StatelessWidget {
  const DailyDaviationScreen({super.key, this.onConfirm});

  final VoidCallback? onConfirm;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 60.h),

              // Headline
              Text(
                "Hello! How can I assist you\ntoday?",
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                  height: 1.25,
                ),
              ),
              SizedBox(height: 10.h),

              // Subtext
              Text(
                "Instant answers at your fingertips!",
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black,
                ),
              ),

              // Illustration + avatars chip
              Expanded(
                child: Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Illustration (replace with your asset)
                      Image.asset(
                        'assets/images/home/dailydaviation.png',
                        width: 270.w,
                        fit: BoxFit.cover,
                      ),



                    ],
                  ),
                ),
              ),

              // Big outlined circular confirm button
              Padding(
                padding: EdgeInsets.only(bottom: 100.h),
                child: Center(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(1000.r),
                    onTap: onConfirm ?? () {},
                    child: Container(
                      width: 70.w,
                      height: 70.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black, // inner dark circle
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // white ring outline
                          Container(
                            width: 70.w,
                            height: 70.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 3),
                            ),
                          ),
                          Icon(Icons.check, color: Colors.white, size: 28.sp),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AvatarOverlap extends StatelessWidget {
  const _AvatarOverlap({required this.images, required this.size});
  final List<String> images;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size + (images.length - 1) * (size * 0.6),
      height: size,
      child: Stack(
        children: List.generate(images.length, (i) {
          return Positioned(
            left: i * (size * 0.6),
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
                image: DecorationImage(
                  image: AssetImage(images[i]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
