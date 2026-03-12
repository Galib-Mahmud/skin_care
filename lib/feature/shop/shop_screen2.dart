// lib/feature/shop/screen/shop_screen2.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../routes/route_name.dart';
import 'controller/shop_controller.dart';


class ShopScreen2 extends StatelessWidget {
  const ShopScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(ShopController());

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56.h),
        child: SafeArea(
          bottom: false,
          child: Center(
            child: Text('Shop',
                style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w800,
                    color: Colors.black87)),
          ),
        ),
      ),
      body: Obx(() {
        if (c.isLoadingDetail.value) {
          return const Center(
              child: CircularProgressIndicator(color: Colors.black));
        }
        final p = c.selectedProduct.value;
        if (p == null) {
          return Center(
              child: Text('Product not found',
                  style: TextStyle(fontSize: 14.sp)));
        }
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.only(
              bottom: 24.h, left: 5.w, right: 5.w),
          child: Column(
            children: [
              // ── Product Image ─────────────────────────────────
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 16.w, vertical: 8.h),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16.r),
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: p.image.isNotEmpty
                            ? Image.network(p.image,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                                Container(color: Colors.grey[200]))
                            : Container(color: Colors.grey[200]),
                      ),
                    ),
                    Positioned(
                      top: 12.h,
                      left: 12.w,
                      child: _CircleBtn(
                        icon: Icons.arrow_back_ios_new_rounded,
                        onTap: () => Navigator.maybePop(context),
                      ),
                    ),
                    Positioned(
                      top: 12.h,
                      right: 12.w,
                      child: Obx(() => _CircleBtn(
                        icon: c.detailFav.value
                            ? Icons.favorite
                            : Icons.favorite_border,
                        onTap: c.toggleFav,
                      )),
                    ),
                  ],
                ),
              ),

              // ── Info Card ─────────────────────────────────────
              Padding(
                padding: EdgeInsets.fromLTRB(12.w, 4.h, 12.w, 0),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(255, 255, 255, 0.4),
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.12),
                        blurRadius: 14,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  padding:
                  EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 14.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title + qty stepper
                      Row(
                        children: [
                          Expanded(
                            child: Text(p.name,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w700)),
                          ),
                          SizedBox(width: 10.w),
                          Obx(() => _QtyStepper(
                            qty: c.detailQty.value,
                            onDecrease: c.decrementQty,
                            onIncrease: c.incrementQty,
                          )),
                        ],
                      ),
                      SizedBox(height: 10.h),

                      // Rating + stock
                      Row(
                        children: [
                          Icon(Icons.star,
                              size: 17.sp,
                              color: const Color(0xFFFFC107)),
                          SizedBox(width: 4.w),
                          Text(p.averageRating.toStringAsFixed(1),
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13.sp)),
                          SizedBox(width: 6.w),
                          Text('(${p.totalReviews} reviews)',
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.black54)),
                          const Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 3.h),
                            decoration: BoxDecoration(
                              color: p.stock > 0
                                  ? Colors.green.withOpacity(0.12)
                                  : Colors.red.withOpacity(0.12),
                              borderRadius:
                              BorderRadius.circular(20.r),
                            ),
                            child: Text(
                              p.stock > 0
                                  ? 'In Stock (${p.stock})'
                                  : 'Out of Stock',
                              style: TextStyle(
                                  fontSize: 11.sp,
                                  color: p.stock > 0
                                      ? Colors.green.shade700
                                      : Colors.red.shade700,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),

                      // Description
                      Text(p.description,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 13.sp,
                              color: Colors.black87,
                              height: 1.45)),
                      SizedBox(height: 16.h),

                      // Add to Cart button
                      Obx(() => SizedBox(
                        width: double.infinity,
                        height: 50.h,
                        child: c.isUpdatingCart.value
                            ? const Center(
                            child: CircularProgressIndicator(
                                color: Colors.black))
                            : OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                vertical: 12.h,
                                horizontal: 14.w),
                            side: const BorderSide(
                                color: Colors.black87,
                                width: 1.3),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(
                                    28.r)),
                            backgroundColor:
                            const Color.fromRGBO(
                                255, 255, 255, 0.4),
                            foregroundColor: Colors.black87,
                          ),
                          onPressed: p.stock > 0
                              ? () => c.addToCart(
                              p.id, c.detailQty.value)
                              : null,
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              Icon(
                                  Icons.shopping_bag_outlined,
                                  size: 18.sp),
                              SizedBox(width: 8.w),
                              Obx(() => Text(
                                'Add to Cart  |  \$${(p.price * c.detailQty.value).toStringAsFixed(2)}',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14.sp),
                              )),
                            ],
                          ),
                        ),
                      )),

                      SizedBox(height: 20.h),

                      // ── Reviews ────────────────────────────────
                      Row(
                        children: [
                          Text('Reviews',
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(width: 8.w),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 2.h),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius:
                              BorderRadius.circular(20.r),
                            ),
                            child: Text('${p.totalReviews}',
                                style: TextStyle(
                                    fontSize: 11.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),

                      if (p.reviews.isEmpty)
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          child: Text('No reviews yet.',
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  color: Colors.black54)),
                        )
                      else
                        ...p.reviews
                            .take(3)
                            .map((r) => _ReviewTile(review: r)),

                      SizedBox(height: 16.h),

                      // ── Write Review ───────────────────────────
                      Text('Write a Review',
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600)),
                      SizedBox(height: 10.h),

                      // Star selector
                      Obx(() => Row(
                        children: List.generate(5, (i) {
                          final star = i + 1;
                          return GestureDetector(
                            onTap: () =>
                            c.reviewRating.value = star,
                            child: Padding(
                              padding:
                              EdgeInsets.only(right: 4.w),
                              child: Icon(
                                star <= c.reviewRating.value
                                    ? Icons.star
                                    : Icons.star_border,
                                color: const Color(0xFFFFC107),
                                size: 30.sp,
                              ),
                            ),
                          );
                        }),
                      )),
                      SizedBox(height: 10.h),

                      TextField(
                        controller: c.reviewCommentCtrl,
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: 'Share your experience...',
                          hintStyle: TextStyle(
                              color: Colors.black45,
                              fontSize: 13.sp),
                          filled: true,
                          fillColor: const Color.fromRGBO(
                              255, 255, 255, 0.5),
                          border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(12.r),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.all(12.r),
                        ),
                      ),
                      SizedBox(height: 10.h),

                      Obx(() => SizedBox(
                        width: double.infinity,
                        height: 46.h,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black87,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(24.r)),
                            elevation: 0,
                          ),
                          onPressed: c.isSubmittingReview.value
                              ? null
                              : () => c.submitReview(p.id),
                          child: c.isSubmittingReview.value
                              ? const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2)
                              : Text('Submit Review',
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600)),
                        ),
                      )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class _ReviewTile extends StatelessWidget {
  const _ReviewTile({required this.review});
  final ReviewModel review;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 0.4),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: const Color(0xFFE5EDF2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ...List.generate(5, (i) => Icon(
                i < review.rating ? Icons.star : Icons.star_border,
                color: const Color(0xFFFFC107),
                size: 14.sp,
              )),
              const Spacer(),
              Text(
                review.createdAt.split('T').first,
                style: TextStyle(
                    fontSize: 11.sp, color: Colors.black45),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Text(review.comment,
              style: TextStyle(
                  fontSize: 13.sp, color: Colors.black87)),
        ],
      ),
    );
  }
}

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
                offset: const Offset(0, 3))
          ],
        ),
        alignment: Alignment.center,
        child: Icon(icon, size: 18.sp, color: Colors.black87),
      ),
    );
  }
}

class _QtyStepper extends StatelessWidget {
  const _QtyStepper(
      {required this.qty,
        required this.onDecrease,
        required this.onIncrease});
  final int qty;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;

  @override
  Widget build(BuildContext context) {
    Widget circle(IconData ic, VoidCallback onTap) => InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        width: 32.w,
        height: 32.w,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.black26)),
        alignment: Alignment.center,
        child: Icon(ic, size: 16.sp, color: Colors.black87),
      ),
    );
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        circle(Icons.remove, onDecrease),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Text('$qty',
              style: TextStyle(
                  fontWeight: FontWeight.w700, fontSize: 16.sp)),
        ),
        circle(Icons.add, onIncrease),
      ],
    );
  }
}