import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  final List<_CommunityItem> items = const [
    _CommunityItem(
      icon: Icons.self_improvement, // replace with your asset if you have one
      title: 'Prayer Requests',
      subtitle: 'Faith-based beauty tips',
    ),
    _CommunityItem(
      icon: Icons.emoji_people_outlined,
      title: 'Encouragement Board',
      subtitle: 'Spiritual nourishment',
    ),
    _CommunityItem(
      icon: Icons.workspace_premium_outlined,
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
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
          ),
        ),
      ),

      body: ListView.separated(
        padding: EdgeInsets.fromLTRB(12.w, 8.h, 12.w, 100.h),
        itemCount: items.length,
        separatorBuilder: (_, __) => SizedBox(height: 10.h),
        itemBuilder: (context, i) => _CommunityCard(
          item: items[i],
          onTap: () {
            // TODO: route to respective pages
            // Navigator.push(context, MaterialPageRoute(builder: (_) => SomePage()));
          },
        ),
      ),


    );
  }
}

/// --- Models/UI ---

class _CommunityItem {
  final IconData icon; // use your own asset if needed
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
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
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
              height: 46.w,
              decoration: BoxDecoration(
                color: const Color(0xFFF3F3F3),
                borderRadius: BorderRadius.circular(10.r),
              ),
              alignment: Alignment.center,
              child: Icon(item.icon, color: Colors.black87, size: 24.sp),
            ),
            SizedBox(width: 12.w),

            // title + subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    maxLines: 1, overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15.5.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    item.subtitle,
                    maxLines: 1, overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12.5.sp,
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
