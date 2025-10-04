import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShopScreen1 extends StatefulWidget {
  const ShopScreen1({super.key});

  @override
  State<ShopScreen1> createState() => _ShopScreen1State();
}

class _ShopScreen1State extends State<ShopScreen1> {
  final TextEditingController _search = TextEditingController();

  final List<String> filters = ['All', 'Cleansers', 'Serums', 'Exfoliants', 'Moisturizers', 'SPF'];
  int selectedFilter = 0;

  final List<_Product> products = List.generate(
    8,
        (i) => _Product(
      title: 'Maroon Dark Top',
      subtitle: 'Skin',
      price: 194.99,
      rating: 5.0,
      image: 'assets/images/shop/product1.png', // replace with your asset
      isFav: i.isEven,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9D9D9),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(64.h),
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Container(
              height: 44.h,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.85),
                borderRadius: BorderRadius.circular(22.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.12),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.maybePop(context),
                    icon: Icon(Icons.arrow_back_ios_new, size: 18.sp, color: Colors.black87),
                  ),
                  Expanded(
                    child: Center(
                      child: Text('Shop',
                          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700)),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.shopping_cart_outlined, size: 20.sp, color: Colors.black87),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),

              // Search bar
              _SearchPill(controller: _search),

              SizedBox(height: 12.h),

              // Filters
              SizedBox(
                height: 36.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: filters.length,
                  separatorBuilder: (_, __) => SizedBox(width: 8.w),
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
                              color: Colors.black.withOpacity(0.10),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            )
                          ],
                        ),
                        child: Text(
                          filters[i],
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: selected ? Colors.white : Colors.black87,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: 12.h),

              // Grid
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
        ),
      ),

      // Rounded bottom nav (static)
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
        child: Container(
          height: 64.h,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.85),
            borderRadius: BorderRadius.circular(28.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _NavItem(icon: Icons.home_filled, label: 'Home', selected: true),
              _NavItem(icon: Icons.category_outlined, label: ''),
              _NavItem(icon: Icons.shopping_bag_outlined, label: ''),
              _NavItem(icon: Icons.star_border_rounded, label: ''),
              _NavItem(icon: Icons.person_outline, label: ''),
            ],
          ),
        ),
      ),
    );
  }
}

/// Widgets

class _SearchPill extends StatelessWidget {
  const _SearchPill({required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: TextStyle(fontSize: 14.sp),
      cursorColor: Colors.black87,
      decoration: InputDecoration(
        isCollapsed: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        hintText: 'Search Beauty Product',
        hintStyle: TextStyle(color: Colors.black38, fontSize: 14.sp),
        prefixIcon: Icon(Icons.search, color: Colors.black45, size: 20.sp),
        filled: true,
        fillColor: Colors.white.withOpacity(0.9),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22.r),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({required this.product, required this.onFavToggle});
  final _Product product;
  final VoidCallback onFavToggle;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
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

          // info
          Padding(
            padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14.sp)),
                SizedBox(height: 2.h),
                Text(product.subtitle,
                    style: TextStyle(color: Colors.black54, fontSize: 12.sp)),

                SizedBox(height: 8.h),
                Row(
                  children: [
                    Text('\$${product.price.toStringAsFixed(2)}',
                        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14.sp)),
                    const Spacer(),
                    Icon(Icons.star, size: 16.sp, color: const Color(0xFFFFC107)),
                    SizedBox(width: 4.w),
                    Text(product.rating.toStringAsFixed(1),
                        style: TextStyle(fontSize: 12.sp, color: Colors.black87)),
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

class _NavItem extends StatelessWidget {
  const _NavItem({required this.icon, required this.label, this.selected = false});
  final IconData icon;
  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final color = selected ? Colors.white : Colors.white70;
    return InkWell(
      borderRadius: BorderRadius.circular(18.r),
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 6.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 22.sp, color: color),
            if (label.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(top: 2.h),
                child: Text(label, style: TextStyle(fontSize: 11.sp, color: color)),
              ),
          ],
        ),
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
