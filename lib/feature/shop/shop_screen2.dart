import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../routes/route_name.dart';

class ShopScreen2 extends StatefulWidget {
  const ShopScreen2({super.key});

  @override
  State<ShopScreen2> createState() => _ShopScreen2State();
}

class _ShopScreen2State extends State<ShopScreen2> {
  int qty = 1;
  bool fav = false;

  // Data to match the design text
  final String title = 'Light Dress Bless';
  final String image = 'assets/images/shop/product1.png'; // <- your asset here
  final double price = 162.99;
  final double oldPrice = 209.99;
  final double rating = 5.0;
  final int reviews = 7932;

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56.h),
        child: SafeArea(
          bottom: false,
          child: Center(
            child: Text(
              'Shop',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w800,
                color: Colors.black87,
              ),
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.only(bottom: 18.h),
        child: Column(
          children: [
            // ======= IMAGE + FLOATING CIRCLE BUTTONS =======
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: AspectRatio(
                      aspectRatio: 1, // square like the mock
                      child: Image.asset(image, fit: BoxFit.cover),
                    ),
                  ),
                  // left button
                  Positioned(
                    top: 12.h,
                    left: 12.w,
                    child: _CircleBtn(
                      icon: Icons.arrow_back_ios_new_rounded,
                      onTap: () => Navigator.maybePop(context),
                    ),
                  ),
                  // right button (favorite)
                  Positioned(
                    top: 12.h,
                    right: 12.w,
                    child: _CircleBtn(
                      icon: fav ? Icons.favorite : Icons.favorite_border,
                      onTap: () => setState(() => fav = !fav),
                    ),
                  ),
                ],
              ),
            ),

            // ======= FLOATING CARD (looks like it sits right below image) =======
            Padding(
              padding: EdgeInsets.fromLTRB(12.w, 6.h, 12.w, 0),
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 0.4),
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 14,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 12.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // ---- title + tiny info dot + qty stepper ----
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                        SizedBox(width: 10.w),
                        _QtyStepper(
                          qty: qty,
                          onDecrease: () => setState(() {
                            if (qty > 1) qty--;
                          }),
                          onIncrease: () => setState(() => qty++),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),

                    // ---- rating row ----
                    Row(
                      children: [
                        Icon(Icons.star, size: 16.sp, color: const Color(0xFFFFC107)),
                        SizedBox(width: 6.w),
                        Text(
                          rating.toStringAsFixed(1),
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 12.sp,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          '(${_formatReviews(reviews)} reviews)',
                          style: TextStyle(fontSize: 12.sp, color: Colors.black54),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),

                    // ---- description line ----
                    Align(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 12.5.sp,
                            color: Colors.black87,
                            height: 1.35,
                          ),
                          children: const [
                            TextSpan(
                              text:
                              "Its simple and elegant shape makes it perfect for those of you who like you who want minimalist \n clothes ",
                            ),
                            TextSpan(
                              text: "Read More . . .",
                              style: TextStyle(color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 14.h),

                    // ---- Add to cart pill (outlined) ----
                    SizedBox(
                      width: double.infinity,
                      child: _AddToCartPill(
                        price: price,
                        oldPrice: oldPrice,
                        onPressed: () {
                       Get.toNamed(RouteName.placeOrder);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatReviews(int n) {
    final s = n.toString();
    final re = RegExp(r'\B(?=(\d{3})+(?!\d))');
    return s.replaceAllMapped(re, (m) => ',');
  }
}

// ======= Widgets =======

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
    Widget circle(IconData ic, VoidCallback onTap) => InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        width: 30.w,
        height: 30.w,
        decoration: BoxDecoration(

          shape: BoxShape.circle,
          border: Border.all(color: Colors.black12),

        ),
        alignment: Alignment.center,
        child: Icon(ic, size: 16.sp, color: Colors.black87),
      ),
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        circle(Icons.remove, onDecrease),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Text(
            '$qty',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14.sp),
          ),
        ),
        circle(Icons.add, onIncrease),
      ],
    );
  }
}

class _AddToCartPill extends StatelessWidget {
  const _AddToCartPill({
    required this.price,
    required this.oldPrice,
    this.onPressed,
  });

  final double price;
  final double oldPrice;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 14.w),
        side: const BorderSide(color: Colors.black87, width: 1.3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28.r)),
        backgroundColor: Color.fromRGBO(255, 255, 255, 0.4),
        foregroundColor: Colors.black87,
      ),
      onPressed: onPressed,
      child: Stack(
        alignment: Alignment.center,

        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.shopping_bag_outlined, size: 18.sp),
              SizedBox(width: 8.w),
              Text(
                'Add to Cart |  \$${price.toStringAsFixed(2)}',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15.sp),
              ),
            ],
          ),
          Positioned(
            right: 6.w,
            child: Text(
              '\$${oldPrice.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.black45,
                decoration: TextDecoration.lineThrough,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
