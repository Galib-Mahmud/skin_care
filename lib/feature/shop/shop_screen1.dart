// lib/feature/shop/screen/shop_screen1.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../routes/route_name.dart';
import 'controller/shop_controller.dart';


class ShopScreen1 extends StatelessWidget {
  const ShopScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(ShopController());
    final searchCtrl = TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // ── Header ──────────────────────────────────────────
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.maybePop(context),
                    icon: Icon(Icons.arrow_back_ios_new,
                        size: 18.sp, color: Colors.black87),
                  ),
                  Expanded(
                    child: Center(
                      child: Text('Shop',
                          style: TextStyle(
                              fontSize: 20.sp,
                              fontFamily: 'Playfair Display',
                              fontWeight: FontWeight.w800)),
                    ),
                  ),
                  Obx(() => Stack(
                    clipBehavior: Clip.none,
                    children: [
                      IconButton(
                        onPressed: () =>
                            Get.toNamed(RouteName.cart),
                        icon: Icon(Icons.shopping_cart_outlined,
                            size: 22.sp, color: Colors.black87),
                      ),
                      if (c.cartCount > 0)
                        Positioned(
                          right: 6.w,
                          top: 6.h,
                          child: Container(
                            width: 16.w,
                            height: 16.w,
                            decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle),
                            alignment: Alignment.center,
                            child: Text('${c.cartCount}',
                                style: TextStyle(
                                    fontSize: 9.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                    ],
                  )),
                ],
              ),
            ),

            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  c.selectedCategory.value = 'All';
                  searchCtrl.clear();
                  c.searchQuery.value = '';
                  await Future.wait(
                      [c.fetchCategories(), c.fetchProducts()]);
                },
                color: Colors.black,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.h),

                      // ── Search ──────────────────────────────────
                      _SearchPill(
                        controller: searchCtrl,
                        onChanged: c.onSearch,
                      ),
                      SizedBox(height: 15.h),

                      // ── Filter Chips ────────────────────────────
                      // FIXED: each chip has its own Obx
                      Obx(() {
                        final cats = [
                          CategoryModel(
                              id: 0, name: 'All', description: ''),
                          ...c.categories,
                        ];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 50.h,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: cats.length,
                              separatorBuilder: (_, __) =>
                                  SizedBox(width: 12.w),
                              itemBuilder: (_, i) {
                                final cat = cats[i];
                                // ← Obx INSIDE each chip item
                                return Obx(() {
                                  final selected =
                                      c.selectedCategory.value ==
                                          cat.name;
                                  return GestureDetector(
                                    onTap: () =>
                                        c.selectCategory(cat.name),
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: 8.h),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.w, vertical: 10.h),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: selected
                                            ? Colors.black
                                            : Colors.white
                                            .withOpacity(0.85),
                                        borderRadius:
                                        BorderRadius.circular(20.r),
                                        border: Border.all(
                                            color: selected
                                                ? Colors.black87
                                                : Colors.white,
                                            width: 1.5),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black
                                                .withOpacity(0.2),
                                            blurRadius: 8,
                                            offset: const Offset(0, 2),
                                          )
                                        ],
                                      ),
                                      child: Text(
                                        cat.name,
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          color: selected
                                              ? Colors.white
                                              : Colors.black87,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  );
                                });
                              },
                            ),
                          ),
                        );
                      }),

                      SizedBox(height: 20.h),

                      // ── AI Recommendations ──────────────────────
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Text('AI Recommendation Products',
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Playfair Display')),
                        ],
                      ),
                      SizedBox(height: 25.h),

                      Obx(() {
                        if (c.isLoadingProducts.value &&
                            c.products.isEmpty) {
                          return SizedBox(
                            height: 180.h,
                            child: const Center(
                                child: CircularProgressIndicator(
                                    color: Colors.black)),
                          );
                        }
                        final recs = c.products.take(4).toList();
                        if (recs.isEmpty) {
                          return SizedBox(
                            height: 100.h,
                            child: Center(
                                child: Text('No products',
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.black54))),
                          );
                        }
                        return SizedBox(
                          height: 260.h,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: recs.length,
                            separatorBuilder: (_, __) =>
                                SizedBox(width: 12.w),
                            itemBuilder: (_, i) => SizedBox(
                              width: 180.w,
                              child: _ProductCard(product: recs[i]),
                            ),
                          ),
                        );
                      }),

                      SizedBox(height: 25.h),

                      // ── Products Grid ───────────────────────────
                      Text('Products',
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Playfair Display')),
                      SizedBox(height: 16.h),

                      Obx(() {
                        if (c.isLoadingProducts.value &&
                            c.filteredProducts.isEmpty) {
                          return SizedBox(
                            height: 200.h,
                            child: const Center(
                                child: CircularProgressIndicator(
                                    color: Colors.black)),
                          );
                        }
                        if (c.filteredProducts.isEmpty) {
                          return SizedBox(
                            height: 120.h,
                            child: Center(
                                child: Text('No products found',
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.black54))),
                          );
                        }
                        return GridView.builder(
                          physics:
                          const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 12.h,
                            crossAxisSpacing: 12.w,
                            childAspectRatio: 0.72,
                          ),
                          itemCount: c.filteredProducts.length,
                          itemBuilder: (_, i) => _ProductCard(
                              product: c.filteredProducts[i]),
                        );
                      }),

                      Obx(() => c.hasMore.value
                          ? Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 16.h),
                        child: Center(
                          child: OutlinedButton(
                            onPressed: () => c.fetchProducts(
                                loadMore: true),
                            child: c.isLoadingProducts.value
                                ? SizedBox(
                                width: 20.w,
                                height: 20.w,
                                child:
                                const CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.black))
                                : Text('Load More',
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.black,
                                    fontWeight:
                                    FontWeight.bold)),
                          ),
                        ),
                      )
                          : SizedBox(height: 20.h)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Search bar ───────────────────────────────────────────────────────────────

class _SearchPill extends StatelessWidget {
  const _SearchPill(
      {required this.controller, required this.onChanged});
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 6,
      shadowColor: Colors.black.withOpacity(0.2),
      borderRadius: BorderRadius.circular(30.r),
      color: Colors.white.withOpacity(0.7),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: TextStyle(fontSize: 14.sp, color: Colors.black),
        cursorColor: Colors.black87,
        decoration: InputDecoration(
          contentPadding:
          EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          hintText: 'Search Beauty Product',
          hintStyle:
          TextStyle(color: Colors.black45, fontSize: 14.sp),
          prefixIcon:
          Icon(Icons.search, color: Colors.black54, size: 22.sp),
          filled: true,
          fillColor: Colors.white.withOpacity(0.7),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.r),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

// ── Product Card ─────────────────────────────────────────────────────────────

class _ProductCard extends StatelessWidget {
  const _ProductCard({required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.find<ShopController>().fetchProductDetail(product.id);
        Get.toNamed(RouteName.shopScreen2);
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromRGBO(255, 255, 255, 0.4),
          borderRadius: BorderRadius.circular(14.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.10),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: product.image.isNotEmpty
                        ? Image.network(product.image,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            Container(color: Colors.grey[200]))
                        : Container(color: Colors.grey[200]),
                  ),
                  Positioned(
                    top: 8.h,
                    right: 8.w,
                    child: Container(
                      width: 26.w,
                      height: 26.w,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.92),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.favorite_border,
                          size: 14.sp, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Playfair Display',
                          fontSize: 14.sp)),
                  SizedBox(height: 4.h),
                  Text(product.category,
                      style: TextStyle(
                          color: Colors.black54, fontSize: 12.sp, fontWeight: FontWeight.w500, fontFamily: 'Playfair Display')),
                  SizedBox(height: 6.h),
                  Row(
                    children: [
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontFamily: 'Playfair Display',
                            fontSize: 13.sp),
                      ),
                      const Spacer(),
                      Icon(Icons.star,
                          size: 12.sp,
                          color: const Color(0xFFFFC107)),
                      SizedBox(width: 2.w),
                      Text(
                        product.averageRating.toStringAsFixed(1),
                        style: TextStyle(
                            fontSize: 10.sp, color: Colors.black87),
                      ),
                    ],
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