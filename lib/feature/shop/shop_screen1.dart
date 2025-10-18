import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../routes/route_name.dart';

class ShopScreen1 extends StatefulWidget {
  const ShopScreen1({super.key});

  @override
  State<ShopScreen1> createState() => _ShopScreen1State();
}

class _ShopScreen1State extends State<ShopScreen1> {
  final TextEditingController _search = TextEditingController();

  final List<String> filters = ['All', 'Cleansers', 'Serums', 'Exfoliants'];
  int selectedFilter = 0;

  final List<_Product> products = List.generate(
    8,
        (i) => _Product(
      title: 'Maroon Dark Top',
      subtitle: 'Skin',
      price: 194.99,
      rating: 5.0,
      image: 'assets/images/shop/product1.png',
      isFav: i.isEven,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.maybePop(context),
                    icon: Icon(Icons.arrow_back_ios_new, size: 18.sp, color: Colors.black87),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Shop',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontFamily: 'Playfair Display',
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.shopping_cart_outlined, size: 20.sp, color: Colors.black87),
                  ),
                ],
              ),
              SizedBox(height: 10.h),

              // ✅ Search bar with proper black elevation
              _SearchPill(controller: _search),


              SizedBox(height: 30.h),

              // Filters
              SizedBox(
                height: 36.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: filters.length,
                  separatorBuilder: (_, __) => SizedBox(width: 30.w),
                  itemBuilder: (_, i) {
                    final selected = i == selectedFilter;
                    return GestureDetector(
                      onTap: () => setState(() => selectedFilter = i),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 14.w),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: selected ? Colors.black : Colors.white.withOpacity(0.85),
                          borderRadius: BorderRadius.circular(20.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 9,
                              offset: const Offset(0, 2),
                            )
                          ],
                        ),
                        child: Text(
                          filters[i],
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: selected ? Colors.white : Colors.black87,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20.h),

              // Product Section
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8.h),
                  Text(
                    'AI Recommendation Products',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'See More',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  // Product Grid
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12.h,
                      crossAxisSpacing: 12.w,
                      childAspectRatio: 0.72,
                    ),
                    itemCount: products.length,
                    itemBuilder: (_, i) => _ProductCard(
                      product: products[i],
                      onFavToggle: () => setState(() => products[i].isFav = !products[i].isFav),
                    ),
                  ),
                  SizedBox(height: 90.h),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// ✅ Search Pill with realistic elevation shadow and rounded style
class _SearchPill extends StatelessWidget {
  const _SearchPill({required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h), // Padding around the search bar
      child: Material(
        elevation: 8, // Elevation for shadow effect
        shadowColor: Colors.black.withOpacity(0.9), // Slight shadow for a subtle elevation
        borderRadius: BorderRadius.circular(30.r), // Rounded edges
        color: Color.fromRGBO(255, 255, 255, 0.4),
        child: TextField(
          controller: controller,
          style: TextStyle(fontSize: 14.sp, color: Colors.black), // Styling the text
          cursorColor: Colors.black87,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h), // Padding inside the TextField
            hintText: 'Search Beauty Product',
            hintStyle: TextStyle(color: Colors.black45, fontSize: 14.sp), // Lighter color for hint
            prefixIcon: Icon(Icons.search, color: Colors.black54, size: 22.sp), // Search icon
            filled: true,
            fillColor: Colors.white.withOpacity(0.7), // Background color with subtle opacity
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.r), // Rounded border
              borderSide: BorderSide.none, // Remove the default border
            ),
          ),
        ),
      ),
    );
  }
}


/// Product Card
class _ProductCard extends StatelessWidget {
  const _ProductCard({required this.product, required this.onFavToggle});
  final _Product product;
  final VoidCallback onFavToggle;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 0.4),
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
          // image + heart
          Expanded(
            child: InkWell(
              onTap: () {
                Get.toNamed(RouteName.shopScreen2);
              },
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(product.image, fit: BoxFit.cover),
                  ),
                  Positioned(
                    top: 8.h,
                    right: 8.w,
                    child: InkWell(
                      onTap: onFavToggle,
                      child: Container(
                        width: 26.w,
                        height: 26.w,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.92),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(
                          product.isFav ? Icons.favorite : Icons.favorite_border,
                          size: 16.sp,
                          color: product.isFav ? Colors.redAccent : Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // info
          Padding(
            padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.sp),
                ),
                SizedBox(height: 2.h),
                Text(
                  product.subtitle,
                  style: TextStyle(color: Colors.black54, fontSize: 14.sp),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14.sp),
                    ),
                    const Spacer(),
                    Icon(Icons.star, size: 16.sp, color: const Color(0xFFFFC107)),
                    SizedBox(width: 4.w),
                    Text(
                      product.rating.toStringAsFixed(1),
                      style: TextStyle(fontSize: 12.sp, color: Colors.black87),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Model
class _Product {
  final String title;
  final String subtitle;
  final double price;
  final double rating;
  final String image;
  bool isFav;
  _Product({
    required this.title,
    required this.subtitle,
    required this.price,
    required this.rating,
    required this.image,
    this.isFav = false,
  });
}
