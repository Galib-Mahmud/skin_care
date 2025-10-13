import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrayerRequestsScreen extends StatefulWidget {
  const PrayerRequestsScreen({super.key});

  @override
  State<PrayerRequestsScreen> createState() => _PrayerRequestsScreenState();
}

class _PrayerRequestsScreenState extends State<PrayerRequestsScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<_PrayerRequest> _requests = [
    _PrayerRequest(
      'Sarah M.',
      '2 hours ago',
      'Please pray for my confidence as I start my new skincare journey. I have struggled with acne for years.',
      12,
    ),
    _PrayerRequest(
      'Lisa K.',
      '5 hours ago',
      'Grateful for clear skin this week! Please pray for continued healing and self-love.',
      12,
    ),
    _PrayerRequest(
      'Sarah M.',
      '2 hours ago',
      'Please pray for my confidence as I start my new skincare journey. I have struggled with acne for years.',
      12,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 100.h, left: 15.w, right: 12.w,bottom: 150.h),
        child: Container(
          height: MediaQuery.of(context).size.height - 120,  // Adjusting height for screen size
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 0.4),
            borderRadius: BorderRadius.circular(24.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.10),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10.w, left: 12.w, right: 12.w),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('🙏', style: TextStyle(fontSize: 18.sp)),
                    SizedBox(width: 6.w),
                    Text(
                      'Prayer Requests',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              // Input field to share a new prayer request
              Padding(
                padding: EdgeInsets.all(12.w),
                child: TextField(
                  controller: _controller, // Binding the controller
                  decoration: InputDecoration(
                    hintText: 'Share a prayer request with the community...',
                    hintStyle: TextStyle(color: Colors.black26, fontSize: 14.sp),
                    filled: true,
                    fillColor: Color.fromRGBO(255, 255, 255, 0.4),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.r),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 18.h, // Adjust this for the TextField height
                      horizontal: 16.w,
                    ),
                  ),
                ),
              ),
              // Share Prayer Request Button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: ElevatedButton(
                  onPressed: () {
                    // Share prayer request logic
                    if (_controller.text.isNotEmpty) {
                      setState(() {
                        _requests.insert(
                          0,
                          _PrayerRequest('You', 'Just Now', _controller.text, 0),
                        );
                        _controller.clear();
                      });
                      FocusScope.of(context).unfocus(); // Dismiss keyboard
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28.r),
                    ),
                    backgroundColor: Colors.black87,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                  ),
                  child: Text(
                    'Share Prayer Request',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              // Prayer Requests List
              Flexible(
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  itemCount: _requests.length,
                  separatorBuilder: (_, __) => SizedBox(height: 12.h),
                  itemBuilder: (context, i) => _PrayerRequestCard(
                    request: _requests[i],
                    onPrayingChanged: (isPraying) {
                      setState(() {
                        _requests[i].isPraying = isPraying;
                        if (isPraying) {
                          _requests[i].prayingCount++;
                        } else {
                          _requests[i].prayingCount--;
                        }
                      });
                    },
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

/// --- Model for Prayer Request ---
class _PrayerRequest {
  final String name;
  final String timestamp;
  final String message;
  int prayingCount;
  bool isPraying;

  _PrayerRequest(
      this.name,
      this.timestamp,
      this.message,
      this.prayingCount, {
        this.isPraying = false,
      });
}

/// --- Prayer Request Card ---
class _PrayerRequestCard extends StatelessWidget {
  const _PrayerRequestCard({
    required this.request,
    required this.onPrayingChanged,
  });

  final _PrayerRequest request;
  final Function(bool) onPrayingChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 0.4),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            blurRadius: 10,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Name + Timestamp header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                request.name,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              Text(
                request.timestamp,
                style: TextStyle(fontSize: 12.sp, color: Colors.black54),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          // Prayer request message
          Text(
            request.message,
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.black87,
              height: 1.4,
            ),
          ),
          SizedBox(height: 12.h),
          // Praying button
          OutlinedButton.icon(
            onPressed: () {
              onPrayingChanged(!request.isPraying);
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.black26, width: 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              backgroundColor: Colors.white,
            ),
            icon: Icon(
              request.isPraying ? Icons.favorite : Icons.favorite_border,
              size: 16.sp,
              color: Colors.black87,
            ),
            label: Text(
              'Praying (${request.prayingCount})',
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
