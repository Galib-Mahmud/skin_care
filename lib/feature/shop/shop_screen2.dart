import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShopScreen2 extends StatefulWidget {
  const ShopScreen2({super.key});

  @override
  State<ShopScreen2> createState() => _ShopScreen2State();
}

class _ShopScreen2State extends State<ShopScreen2> {
  int qty = 1;
  bool fav = false;

  // demo data
  final String title = 'Light Dress Bless';
  final String image = 'assets/images/shop/product1.png'; // replace
  final double price = 162.99;
  final double oldPrice = 209.99;
  final double rating = 5.0;
  final int reviews = 7932;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9D9D9),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56.h),
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 8.h),
            child: Center(
              child: Text('Shop',
                  style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700)),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          // hero image
          Positioned.fill(
            top: 0,
            bottom: 220.h,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.asset(image, fit: BoxFit.cover),
            ),
          ),

          // top overlay buttons
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _CircleBtn(
                    icon: Icons.arrow_back_ios_new,
                    onTap: () => Navigator.maybePop(context),
                  ),
                  _CircleBtn(
                    icon: fav ? Icons.favorite : Icons.favorite_border,
                    onTap: () => setState(() => fav = !fav),
                  ),
                ],
              ),
            ),
          ),

          // floating card
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(12.w),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 14,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                padding: EdgeInsets.fromLTRB(14.w, 12.h, 14.w, 14.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // title + qty
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(title,
                              style: TextStyle(
                                  fontSize: 16.sp, fontWeight: FontWeight.w700)),
                        ),
                        _QtyStepper(
                          qty: qty,
                          onDecrease: () => setState(() {
                            if (qty > 1) qty--;
                          }),
                          onIncrease: () => setState(() => qty++),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),

                    // rating
                    Row(
                      children: [
                        Icon(Icons.star, size: 16.sp, color: const Color(0xFFFFC107)),
                        SizedBox(width: 6.w),
                        Text(
                          '$rating ',
                          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12.sp),
                        ),
                        Text(
                          '(${_formatReviews(reviews)} reviews)',
                          style: TextStyle(color: Colors.black54, fontSize: 12.sp),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),

                    // description
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Its simple and elegant shape makes it perfect for those of you who like you who want minimalist clothes Read More . . .",
                        style: TextStyle(fontSize: 12.5.sp, color: Colors.black87, height: 1.35),
                      ),
                    ),
                    SizedBox(height: 14.h),

                    // add to cart button
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          side: BorderSide(color: Colors.black87, width: 1.2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28.r),
                          ),
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black87,
                        ),
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.shopping_bag_outlined, size: 18.sp),
                            SizedBox(width: 8.w),
                            Text(
                              'Add to Cart | \$${price.toStringAsFixed(2)}',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 13.5.sp),
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              '\$${oldPrice.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.black45,
                                decoration: TextDecoration.lineThrough,
                              ),
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
        ],
      ),
    );
  }

  String _formatReviews(int n) {
    // 7,932 -> "7,932"
    final s = n.toString();
    final re = RegExp(r'\B(?=(\d{3})+(?!\d))');
    return s.replaceAllMapped(re, (m) => ',');
  }
}

/// small round icon button
class _CircleBtn extends StatelessWidget {
  const _CircleBtn({required this.icon, this.onTap});
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        width: 36.w,
        height: 36.w,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.95),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Icon(icon, size: 18.sp, color: Colors.black87),
      ),
    );
  }
}

/// qty stepper like the mock (circle - number + circle +)
class _QtyStepper extends StatelessWidget {
  const _QtyStepper({
    required this.qty,
    required this.onDecrease,
    required this.onIncrease,
  });

  final int qty;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;

  @override
  Widget build(BuildContext context) {
    Widget circleBtn(IconData icon, VoidCallback onTap) => InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        width: 28.w,
        height: 28.w,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.black12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, size: 16.sp, color: Colors.black87),
      ),
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        circleBtn(Icons.remove, onDecrease),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Text('$qty',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14.sp)),
        ),
        circleBtn(Icons.add, onIncrease),
      ],
    );
  }
}
