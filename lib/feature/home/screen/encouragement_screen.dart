import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EncouragementBoardScreen extends StatefulWidget {
  const EncouragementBoardScreen({super.key});

  @override
  State<EncouragementBoardScreen> createState() => _EncouragementBoardScreenState();
}

class _EncouragementBoardScreenState extends State<EncouragementBoardScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<_Encouragement> _encouragements = [
    _Encouragement(
      'Rachel P.',
      '1 day ago',
      'Remember: You are fearfully and wonderfully made! Your skin doesn\'t define your worth.',
      15,
    ),
    _Encouragement(
      'Grace L.',
      '3 days ago',
      'Started using natural oils and praying over my skincare routine. God is so faithful! 🙏',
      16,
    ),
    _Encouragement(
      'Grace L.',
      '3 days ago',
      'Started using natural oils and praying over my skincare routine. God is so faithful! 🙏',
      16,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 80.0, bottom: 10.0),
        child: Card(
          elevation: 5,
          color: Color.fromRGBO(217, 217, 217, 1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 16.h),

              Center(
                child: Text(
                  'Encouragement Board',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
              // Input field to share encouragement
              Padding(
                padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 8.h),
                child: TextField(
                  controller: _controller,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Share words of encouragement...',
                    hintStyle: TextStyle(
                      color: Colors.black26,
                      fontSize: 13.sp,
                    ),
                    filled: true,
                    fillColor: Color.fromRGBO(255, 255, 255, 0.4),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
                  ),
                ),
              ),

              // Share Encouragement Button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: ElevatedButton(
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      setState(() {
                        _encouragements.insert(0, _Encouragement(
                          'You',
                          'Just Now',
                          _controller.text,
                          0,
                        ));
                        _controller.clear();
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.r),
                    ),
                    backgroundColor: Colors.black87,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    elevation: 0,
                  ),
                  child: Text(
                    'Share Encouragement',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 16.h),

              // Encouragements List
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  itemCount: _encouragements.length,
                  separatorBuilder: (_, __) => SizedBox(height: 12.h),
                  itemBuilder: (context, i) => _EncouragementCard(
                    encouragement: _encouragements[i],
                    onLikeChanged: (isLiked) {
                      setState(() {
                        _encouragements[i].isLiked = isLiked;
                        if (isLiked) {
                          _encouragements[i].likeCount++;
                        } else {
                          _encouragements[i].likeCount--;
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

/// --- Model for Encouragement ---
class _Encouragement {
  final String name;
  final String timestamp;
  final String message;
  int likeCount;
  bool isLiked;

  _Encouragement(
      this.name,
      this.timestamp,
      this.message,
      this.likeCount, {
        this.isLiked = false,
      });
}

/// --- Encouragement Card ---
class _EncouragementCard extends StatelessWidget {
  const _EncouragementCard({
    required this.encouragement,
    required this.onLikeChanged,
  });

  final _Encouragement encouragement;
  final Function(bool) onLikeChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 0.4),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
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
                encouragement.name,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              Text(
                encouragement.timestamp,
                style: TextStyle(
                  fontSize: 11.sp,
                  color: Colors.black45,
                ),
              ),
            ],
          ),

          SizedBox(height: 10.h),

          // Message
          Text(
            encouragement.message,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.black87,
              height: 1.4,
            ),
          ),

          SizedBox(height: 12.h),

          // Like button
          InkWell(
            onTap: () {
              onLikeChanged(!encouragement.isLiked);
            },
            borderRadius: BorderRadius.circular(20.r),
            child: Padding(
              padding: EdgeInsets.all(4.w),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    encouragement.isLiked ? Icons.favorite : Icons.favorite_border,
                    size: 16.sp,
                    color: Colors.black87,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    '${encouragement.likeCount}',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}