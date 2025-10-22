import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skincare/routes/route_name.dart';

class PlaceOrderScreen extends StatefulWidget {
  const PlaceOrderScreen({super.key});

  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  final items = <_CartItem>[
    _CartItem('Citrus Fresh Facial Serum', 12.99, 'assets/images/shop/order.png', qty: 2),
    _CartItem('Citrus Fresh Facial Serum', 12.75, 'assets/images/shop/order.png', qty: 1),
    _CartItem('Citrus Fresh Facial Serum', 13.45, 'assets/images/shop/order.png', qty: 1),
    _CartItem('Citrus Fresh Facial Serum', 4.09, 'assets/images/shop/order.png', qty: 1),
  ];

  final double deliveryCharge = 3.99;

  double get subtotal => items.take(3).fold(0.0, (s, it) => s + it.price * it.qty);
  double get total => subtotal + deliveryCharge;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(217, 217, 217, 1),

      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56.h),
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Stack(
              alignment: Alignment.center,
              children: [
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
                Text(
                  'Place order',
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

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 6.h),

            /// --- Item List ---
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Column(
                children: List.generate(3, (i) {
                  final item = items[i];
                  return Padding(
                    padding: EdgeInsets.only(bottom: 8.h),
                    child: _CartCard(
                      item: item,
                      onMinus: () {
                        setState(() {
                          if (item.qty > 1) {
                            item.qty--;
                          } else {
                            items.removeAt(i);
                          }
                        });
                      },
                      onPlus: () {
                        setState(() {
                          item.qty++;
                        });
                      },
                    ),
                  );
                }),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 2.h, bottom: 10.h),
              child: Text(
                '+1 more',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            /// --- Summary ---
            Container(
              margin: EdgeInsets.symmetric(horizontal: 12.w),
              padding: EdgeInsets.fromLTRB(12.w, 8.h, 12.w, 8.h),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                children: [
                  _SummaryRow(label: 'Subtotal', value: subtotal.toStringAsFixed(2)),
                  SizedBox(height: 8.h),
                  Container(height: 1, color: const Color(0xFFE5EDF2)),
                  SizedBox(height: 8.h),
                  _SummaryRow(
                    label: 'Delivery Charges',
                    value: '+${deliveryCharge.toStringAsFixed(2)}',
                  ),
                  SizedBox(height: 14.h),
                  Row(
                    children: [
                      Text(
                        'Total',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        total.toStringAsFixed(2),
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const Spacer(),

            /// --- Bottom Checkout Bar ---
            SafeArea(
              top: false,
              minimum: EdgeInsets.only(bottom: 130.h, left: 25.w, right: 15.w),
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
                    height: 50.h,
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
                        Get.toNamed(RouteName.checkOut);
                      },
                      child: Text(
                        'Check Out',
                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
                      ),
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

/// --- Helpers ---
class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label, style: TextStyle(fontSize: 16.sp, color: Colors.black87)),
        const Spacer(),
        Text(value, style: TextStyle(fontSize: 16.sp, color: Colors.black87)),
      ],
    );
  }
}

/// --- Cart Item Model ---
class _CartItem {
  _CartItem(this.title, this.price, this.image, {this.qty = 1});
  final String title;
  final double price;
  final String image;
  int qty;
}

/// --- Cart Card ---
class _CartCard extends StatelessWidget {
  const _CartCard({
    required this.item,
    required this.onMinus,
    required this.onPlus,
  });

  final _CartItem item;
  final VoidCallback onMinus;
  final VoidCallback onPlus;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 0.4),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFE5EDF2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.all(10.w),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image.asset(item.image, width: 90.w, height: 82.w, fit: BoxFit.cover),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.black87),
                ),
                SizedBox(height: 4.h),
                Text('\$${item.price.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 13.sp, color: Colors.black87)),
              ],
            ),
          ),
          _QtyPill(qty: item.qty, onMinus: onMinus, onPlus: onPlus),
        ],
      ),
    );
  }
}

/// --- Qty Pill (minus becomes trash when qty == 1) ---
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
        width: 28.w,
        height: 28.w,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(255, 255, 255, 0.4),
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
        color: const Color.fromRGBO(255, 255, 255, 0.4),
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
          // 👇 dynamic: minus or trash
          roundSmall(qty == 1 ? Icons.delete_outline : Icons.remove, onMinus),
          SizedBox(width: 8.w),
          Text('$qty', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13.sp)),
          SizedBox(width: 8.w),
          roundSmall(Icons.add, onPlus),
        ],
      ),
    );
  }
}
