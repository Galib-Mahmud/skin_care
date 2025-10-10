
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../routes/route_name.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final items = <_CartItem>[
    _CartItem('Citrus Fresh Facial Serum', 12.99, 'assets/images/shop/cart.png', qty: 2, showTrash: false),
    _CartItem('Citrus Fresh Facial Serum', 12.75, 'assets/images/shop/cart.png', qty: 1, showTrash: true),
    _CartItem('Citrus Fresh Facial Serum', 13.45, 'assets/images/shop/cart.png', qty: 1, showTrash: true),
    _CartItem('Citrus Fresh Facial Serum', 4.09,  'assets/images/shop/cart.png', qty: 1, showTrash: true),
  ];

  double get total =>
      items.fold<double>(0, (sum, it) => sum + it.price * it.qty);

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56.h),
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // left: "< Back"
                Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: () => Navigator.maybePop(context),
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 6.w),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.arrow_back_ios_new_rounded, size: 16.sp, color: Colors.black87),
                          SizedBox(width: 4.w),
                          Text('Back', style: TextStyle(fontSize: 14.sp, color: Colors.black87)),
                        ],
                      ),
                    ),
                  ),
                ),
                // center: "Cart"
                Text(
                  'Cart',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),

              ],
            ),
          ),
        ),
      ),

      body: Column(
        children: [
          SizedBox(height: 6.h),
          // list
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              itemCount: items.length,
              separatorBuilder: (_, __) => SizedBox(height: 8.h),
              itemBuilder: (context, i) {
                final item = items[i];
                return _CartCard(
                  item: item,
                  onMinus: () => setState(() {
                    if (item.qty > 1) item.qty--;
                  }),
                  onPlus: () => setState(() => item.qty++),
                  onRemove: item.showTrash
                      ? () => setState(() => items.removeAt(i))
                      : null,
                );
              },
            ),
          ),

          // bottom total + button
          Padding(
            padding: EdgeInsets.only(bottom: 140.h, left: 30.w, right: 30.w),
            child: Row(
              children: [
                Text(
                  '\$ ${total.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const Spacer(),
                SizedBox(
                  height: 44.h,
                  width: 230.w,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black87,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                      elevation: 0,
                    ),
                    onPressed: () {
                      Get.toNamed(RouteName.placeOrder);
                    },
                    child: Text('Continue', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// ===== Models =====
class _CartItem {
  _CartItem(this.title, this.price, this.image, {this.qty = 1, this.showTrash = true});
  final String title;
  final double price;
  final String image;
  int qty;
  final bool showTrash;
}

/// ===== UI Pieces =====
class _CartCard extends StatelessWidget {
  const _CartCard({
    required this.item,
    required this.onMinus,
    required this.onPlus,
    this.onRemove,
  });

  final _CartItem item;
  final VoidCallback onMinus;
  final VoidCallback onPlus;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255,255, 0.4),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFE5EDF2)), // gentle stroke
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.all(10.w),
      child: Row(
        children: [
          // thumbnail
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image.asset(
              item.image,
              width: 56.w, height: 56.w,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 10.w),

          // title + price
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  maxLines: 1, overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  '\$${item.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),

          // right controls: optional trash + stepper
          if (onRemove != null) ...[
            _IconRoundButton(
              icon: Icons.delete_outline,
              onTap: onRemove!,
              tooltip: 'Remove',
            ),
            SizedBox(width: 8.w),
          ],
          _QtyPill(
            qty: item.qty,
            onMinus: onMinus,
            onPlus: onPlus,
          ),
        ],
      ),
    );
  }
}

class _IconRoundButton extends StatelessWidget {
  const _IconRoundButton({required this.icon, required this.onTap, this.tooltip});
  final IconData icon;
  final VoidCallback onTap;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final child = Container(
      width: 32.w, height: 32.w,
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 0.4),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.black12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Icon(icon, size: 18.sp, color: Colors.black54),
    );
    return tooltip == null
        ? InkWell(onTap: onTap, borderRadius: BorderRadius.circular(8.r), child: child)
        : Tooltip(message: tooltip!, child: InkWell(onTap: onTap, borderRadius: BorderRadius.circular(8.r), child: child));
  }
}

/// qty stepper styled like the mock (rounded pill, subtle border, +/- circles)
class _QtyPill extends StatelessWidget {
  const _QtyPill({required this.qty, required this.onMinus, required this.onPlus});
  final int qty;
  final VoidCallback onMinus;
  final VoidCallback onPlus;

  @override
  Widget build(BuildContext context) {
    Widget roundSmall(IconData ic, VoidCallback onTap) => InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        width: 28.w, height: 28.w,
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 0.4),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.black12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Icon(ic, size: 16.sp, color: Colors.black87),
      ),
    );

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 0.4),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: const Color(0xFFE5EDF2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          roundSmall(Icons.remove, onMinus),
          SizedBox(width: 8.w),
          Text('$qty', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13.sp)),
          SizedBox(width: 8.w),
          roundSmall(Icons.add, onPlus),
        ],
      ),
    );
  }
}
