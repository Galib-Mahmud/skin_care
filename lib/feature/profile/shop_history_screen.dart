import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShopHistoryScreen extends StatelessWidget {
  final List<Order> orders = [
    Order(orderId: '#92287157', status: 'Packed', totalPrice: 1000, itemCount: 3),
    Order(orderId: '#92287157', status: 'Shipped', totalPrice: 1000, itemCount: 3),
    Order(orderId: '#92287157', status: 'In Process', totalPrice: 1000, itemCount: 3),
    Order(orderId: '#92287157', status: 'Delivered', totalPrice: 1000, itemCount: 3),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Column(
          children: [
            // Custom Header
            Container(

              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
              child: Row(
                children: [
                  // Back Button
                  InkWell(
                    onTap: () => Navigator.maybePop(context),
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 6.w),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.arrow_back_ios_new_rounded,
                              size: 16.sp, color: Colors.black87),
                          SizedBox(width: 4.w),
                          Text('Back',
                              style: TextStyle(
                                  fontSize: 14.sp, color: Colors.black87)),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  // Title
                  Text(
                    'Shop History',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  Spacer(),
                  SizedBox(width: 80.w), // Balance the back button width
                ],
              ),
            ),
            // Orders List
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(16.w),
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: OrderCard(order: orders[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Order {
  final String orderId;
  final String status;
  final double totalPrice;
  final int itemCount;

  Order({
    required this.orderId,
    required this.status,
    required this.totalPrice,
    required this.itemCount,
  });

  // Helper methods to get UI-specific values
  String get deliveryStatus {
    if (status == 'Packed') return 'Packed';
    if (status == 'Shipped') return 'Delivered';
    if (status == 'In Process') return 'Delivered';
    if (status == 'Delivered') return 'Delivered';
    return status;
  }

  String get statusButton {
    if (status == 'Packed') return 'Complete';
    if (status == 'Shipped') return 'Shipped';
    if (status == 'In Process') return 'In Process';
    if (status == 'Delivered') return 'Complete';
    return status;
  }

  bool get showCheckmark {
    return status == 'Delivered' || status == 'Shipped' || status == 'In Process';
  }
}

class OrderCard extends StatelessWidget {
  final Order order;

  const OrderCard({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFE8E8E8),
        borderRadius: BorderRadius.circular(16.r),
      ),
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          // Product Image
          Container(
            width: 92.w,
            height: 92.h,
            decoration: BoxDecoration(
              color: Color(0xFFF5E6E0),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.asset(
                'assets/images/shop/shopHistory.png',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Color(0xFFF5E6E0),
                    child: Icon(Icons.shopping_bag, color: Colors.grey, size: 32.sp),
                  );
                },
              ),
            ),
          ),
          SizedBox(width: 12.w),

          // Order Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order ${order.orderId}',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Standard Delivery',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  '\${order.totalPrice}',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    Text(
                      order.deliveryStatus,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    if (order.showCheckmark) ...[
                      SizedBox(width: 6.w),
                      Container(
                        width: 20.w,
                        height: 20.h,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 14.sp,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),

          // Right Side - Item Count and Status Button
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${order.itemCount} items',
                style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 32.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  order.statusButton,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}