
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
      appBar: AppBar(
        title: Text('Shop History'),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          return OrderCard(order: orders[index]);
        },
      ),
    );
  }
}

class Order {
  final String orderId;
  final String status;
  final double totalPrice;
  final int itemCount;

  Order({required this.orderId, required this.status, required this.totalPrice, required this.itemCount});
}

class OrderCard extends StatelessWidget {
  final Order order;

  const OrderCard({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 3,
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: [
              Image.asset('assets/images/shop/shopHistory.png', width: 60, height: 60), // Replace with your image asset
              SizedBox(width: 15.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(order.orderId, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp)),
                  Text('Standard Delivery', style: TextStyle(fontSize: 14.sp)),
                  SizedBox(height: 8.h),
                  Text('\$${order.totalPrice}', style: TextStyle(fontSize: 14.sp, color: Colors.grey)),
                ],
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('${order.itemCount} items', style: TextStyle(fontSize: 14.sp)),
                  SizedBox(height: 10.h),
                  _getStatusButton(order.status),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getStatusButton(String status) {
    Color buttonColor;
    String buttonText;

    switch (status) {
      case 'Packed':
        buttonColor = Colors.orange;
        buttonText = 'Complete';
        break;
      case 'Shipped':
        buttonColor = Colors.blue;
        buttonText = 'Shipped';
        break;
      case 'In Process':
        buttonColor = Colors.grey;
        buttonText = 'In Process';
        break;
      case 'Delivered':
        buttonColor = Colors.green;
        buttonText = 'Delivered';
        break;
      default:
        buttonColor = Colors.black;
        buttonText = 'Unknown';
    }

    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
      ),
      child: Text(buttonText, style: TextStyle(fontSize: 14.sp, color: Colors.white)),
    );
  }
}
