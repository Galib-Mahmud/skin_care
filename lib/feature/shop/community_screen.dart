import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skincare/feature/home/encouragement_screen.dart';
import 'package:skincare/feature/home/faith_wins_screen.dart';
import 'package:skincare/feature/shop/prayer_request_screen.dart';
import 'package:skincare/widget/home/custom_navbar.dart';
// import your navbar

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  // tell the navbar which tab is active (example: 0 = Home)
  int currentIndex = 0;

  // cards data
  final List<_CommunityItem> items = [
    _CommunityItem(
      icon: Image.asset('assets/images/shop/prayers.png'),
      // replace with your asset if you have one
      title: 'Prayer Requests',
      subtitle: 'Faith-based beauty tips',
    ),
    _CommunityItem(
      icon: Image.asset('assets/images/shop/encouragement.png'),
      title: 'Encouragement Board',
      subtitle: 'Spiritual nourishment',
    ),
    _CommunityItem(
      icon: Image.asset('assets/images/shop/faith.png'),
      title: 'Faith Wins',
      subtitle: 'Healthy meals for glow',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56.h),
        child: SafeArea(
          bottom: false,
          child: Center(
            child: Text(
              'Community',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
          ),
        ),
      ),

      body: ListView.separated(
        padding: EdgeInsets.only(top: 50.h, left: 15.w, right: 15.w),
        itemCount: items.length,
        separatorBuilder: (_, __) => SizedBox(height: 10.h),
        itemBuilder: (context, i) => _CommunityCard(
          item: items[i],
          onTap: () {
            if (i == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PrayerRequestsScreen()),
              );
            } else if (i == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const EncouragementBoardScreen(),
                ),
              );
            } else if (i == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const FaithWinsTestimoniesScreen(),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

/// --- Models/UI ---

class _CommunityItem {
  final Widget icon; // use your own asset if needed
  final String title;
  final String subtitle;

  const _CommunityItem({
    required this.icon,
    required this.title,
    required this.subtitle,
  });
}

class _CommunityCard extends StatelessWidget {
  const _CommunityCard({required this.item, this.onTap});

  final _CommunityItem item;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 0.4),
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        child: Row(
          children: [
            // left icon container (subtle, like mock)
            Container(
              width: 46.w,
              height: 48.h,

              decoration: BoxDecoration(

                borderRadius: BorderRadius.circular(10.r),
              ),
              alignment: Alignment.center,
              child: SizedBox(width: 39.w, height: 40.w, child: item.icon),
            ),
            SizedBox(width: 12.w),

            // title + subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Text(
                    item.subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                    ),
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
