// lib/feature/shop/controller/shop_controller.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/endpoint/api_client.dart';
import '../../../core/endpoint/api_endpoint.dart';
import '../../../routes/route_name.dart';

// ─── Models ───────────────────────────────────────────────────────────────────

class CategoryModel {
  final int id;
  final String name;
  final String description;

  CategoryModel({
    required this.id,
    required this.name,
    required this.description,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> j) => CategoryModel(
    id: j['id'],
    name: j['name'] ?? '',
    description: j['description'] ?? '',
  );
}

class ReviewModel {
  final int id;
  final int rating;
  final String comment;
  final String createdAt;

  ReviewModel({
    required this.id,
    required this.rating,
    required this.comment,
    required this.createdAt,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> j) => ReviewModel(
    id: j['id'] ?? 0,
    rating: j['rating'] ?? 0,
    comment: j['comment'] ?? '',
    createdAt: j['created_at'] ?? '',
  );
}

class ProductModel {
  final int id;
  final String category;
  final String name;
  final String description;
  final String productType;
  final double price;
  final int stock;
  final String image;
  final bool isActive;
  final int totalReviews;
  final double averageRating;
  final List<ReviewModel> reviews;

  ProductModel({
    required this.id,
    required this.category,
    required this.name,
    required this.description,
    required this.productType,
    required this.price,
    required this.stock,
    required this.image,
    required this.isActive,
    required this.totalReviews,
    required this.averageRating,
    required this.reviews,
  });

  factory ProductModel.fromJson(Map<String, dynamic> j) => ProductModel(
    id: j['id'] ?? 0,
    category: j['category'] ?? '',
    name: j['name'] ?? '',
    description: j['description'] ?? '',
    productType: j['product_type'] ?? '',
    price: double.tryParse(j['price']?.toString() ?? '0') ?? 0,
    stock: j['stock'] ?? 0,
    image: j['image'] ?? '',
    isActive: j['is_active'] ?? false,
    totalReviews: j['total_reviews'] ?? 0,
    averageRating: (j['average_rating'] ?? 0).toDouble(),
    reviews: (j['reviews'] as List? ?? [])
        .map((r) => ReviewModel.fromJson(r))
        .toList(),
  );
}

class CartItemModel {
  final int id;
  final int productId;
  final String productName;
  final String productImage;
  final double productPrice;
  int quantity;
  final double totalPrice;

  CartItemModel({
    required this.id,
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.productPrice,
    required this.quantity,
    required this.totalPrice,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> j) {
    final product = j['product'];
    final isMap = product is Map<String, dynamic>;

    return CartItemModel(
      id: j['id'] ?? 0,

      // API returns product as String (name), not Map — so no productId available
      productId: isMap ? (product['id'] ?? 0) : 0,

      // product is a plain String → use it directly as name
      productName: isMap
          ? (product['name'] ?? '')
          : (product?.toString() ?? ''),

      // image & price are top-level fields in this API response
      productImage: isMap
          ? (product['image'] ?? '')
          : (j['image'] ?? ''),

      productPrice: isMap
          ? (double.tryParse(product['price']?.toString() ?? '0') ?? 0)
          : (double.tryParse(j['price']?.toString() ?? '0') ?? 0),

      quantity: j['quantity'] ?? 1,
      totalPrice:
      double.tryParse(j['total_price']?.toString() ?? '0') ?? 0,
    );
  }

  double get lineTotal => productPrice * quantity;
}

// ─── Controller ───────────────────────────────────────────────────────────────

class ShopController extends GetxController {
  static ShopController get to => Get.put(ShopController());
  final ApiClient _api = ApiClient(baseUrl: ApiEndpoint.baseUrl);

  // ── Loading states ─────────────────────────────────────────────────
  final RxBool isLoadingCategories = false.obs;
  final RxBool isLoadingProducts   = false.obs;
  final RxBool isLoadingCart       = false.obs;
  final RxBool isLoadingDetail     = false.obs;
  final RxBool isSubmittingReview  = false.obs;
  final RxBool isUpdatingCart      = false.obs;
  final RxBool isPlacingOrder      = false.obs;

  // ── Data ───────────────────────────────────────────────────────────
  final RxList<CategoryModel> categories       = <CategoryModel>[].obs;
  final RxList<ProductModel>  products         = <ProductModel>[].obs;
  final RxList<ProductModel>  filteredProducts = <ProductModel>[].obs;
  final Rx<ProductModel?>     selectedProduct  = Rx<ProductModel?>(null);
  final RxList<CartItemModel> cartItems        = <CartItemModel>[].obs;

  // ── Pagination ─────────────────────────────────────────────────────
  final RxString nextPageUrl = ''.obs;
  final RxBool   hasMore     = false.obs;
  final RxInt    totalCount  = 0.obs;

  // ── UI State ───────────────────────────────────────────────────────
  final RxString selectedCategory = 'All'.obs;
  final RxString searchQuery      = ''.obs;
  final RxInt    detailQty        = 1.obs;
  final RxBool   detailFav        = false.obs;

  // ── Review form ────────────────────────────────────────────────────
  final RxInt          reviewRating     = 5.obs;
  final TextEditingController reviewCommentCtrl = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
    fetchProducts();
    fetchCart();
    debounce(
      searchQuery,
          (_) => _applyFilter(),
      time: const Duration(milliseconds: 400),
    );
  }

  // ──────────────────────────────────────────────────────────────────
  // GET /api/v1/shop/categories/active/
  // ──────────────────────────────────────────────────────────────────
  Future<void> fetchCategories() async {
    isLoadingCategories.value = true;
    try {
      final res = await _api.get(
        '/api/v1/shop/categories/active/',
        requiresAuth: false,
      );
      if (res is List) {
        categories.value =
            res.map((j) => CategoryModel.fromJson(j)).toList();
      }
    } on HttpException catch (e) {
      print('❌ fetchCategories: ${e.message}');
    } catch (e) {
      print('❌ fetchCategories: $e');
    } finally {
      isLoadingCategories.value = false;
    }
  }

  // ──────────────────────────────────────────────────────────────────
  // GET /api/v1/shop/products/active/?page=N
  // ──────────────────────────────────────────────────────────────────
  Future<void> fetchProducts({bool loadMore = false}) async {
    if (isLoadingProducts.value) return;
    isLoadingProducts.value = true;
    try {
      final url = loadMore && nextPageUrl.value.isEmpty
          ? nextPageUrl.value
          : '/api/v1/shop/products/active/';

      final res = await _api.get(url, requiresAuth: false);
      if (res is Map<String, dynamic>) {
        totalCount.value  = res['count'] ?? 0;
        nextPageUrl.value = res['next'] ?? '';
        hasMore.value     = nextPageUrl.value.isNotEmpty;

        final list = (res['results'] as List? ?? [])
            .map((j) => ProductModel.fromJson(j))
            .toList();

        if (loadMore) {
          products.addAll(list);
        } else {
          products.value = list;
        }
        _applyFilter();
      }
    } on HttpException catch (e) {
      print('❌ fetchProducts: ${e.message}');
    } catch (e) {
      print('❌ fetchProducts: $e');
    } finally {
      isLoadingProducts.value = false;
    }
  }

  // ──────────────────────────────────────────────────────────────────
  // GET /api/v1/shop/products/active/{id}/
  // ──────────────────────────────────────────────────────────────────
  Future<void> fetchProductDetail(int id) async {
    isLoadingDetail.value  = true;
    detailQty.value        = 1;
    detailFav.value        = false;
    selectedProduct.value  = null;
    try {
      final res = await _api.get(
        '/api/v1/shop/products/active/$id/',
        requiresAuth: false,
      );
      if (res != null) {
        selectedProduct.value = ProductModel.fromJson(res);
      }
    } on HttpException catch (e) {
      print('❌ fetchProductDetail: ${e.message}');
    } catch (e) {
      print('❌ fetchProductDetail: $e');
    } finally {
      isLoadingDetail.value = false;
    }
  }

  // ──────────────────────────────────────────────────────────────────
  // CART — GET /api/v1/shop/cart/
  // ──────────────────────────────────────────────────────────────────
  Future<void> fetchCart() async {
    isLoadingCart.value = true;
    try {
      final res =
      await _api.get('/api/v1/shop/cart/', requiresAuth: true);
      if (res is List) {
        cartItems.value =
            res.map((j) => CartItemModel.fromJson(j)).toList();
      }
    } on HttpException catch (e) {
      print('❌ fetchCart: ${e.message}');
    } catch (e) {
      print('❌ fetchCart: $e');
    } finally {
      isLoadingCart.value = false;
    }
  }

  // ──────────────────────────────────────────────────────────────────
  // CART — POST /api/v1/shop/cart/
  // ──────────────────────────────────────────────────────────────────
  Future<void> addToCart(int productId, int quantity) async {
    isUpdatingCart.value = true;
    try {
      print('🛒 addToCart CALLED → productId: $productId, qty: $quantity');

      final res = await _api.post(
        '/api/v1/shop/cart/',
        body: {'product': productId, 'quantity': quantity},
        requiresAuth: true,
      );

      print('✅ addToCart SUCCESS → $res');
      await fetchCart();
      print('🛒 cartItems after fetch: ${cartItems.length}');
      _showSuccess('Added to cart!');
    } on HttpException catch (e) {
      print('❌ HttpException → status: ${e.statusCode}, msg: ${e.message}, body: ${e.body}');
      _showError(_extractMessage(_tryParseBody(e.body)) ?? e.message);
    } catch (e, st) {
      print('❌ Unknown error → $e');
      print('📍 StackTrace → $st');
    } finally {
      isUpdatingCart.value = false;
    }
  }

  // ──────────────────────────────────────────────────────────────────
  // CART — PUT /api/v1/shop/cart/{id}/
  // ──────────────────────────────────────────────────────────────────
  Future<void> updateCartItem(int cartItemId, int quantity) async {
    isUpdatingCart.value = true;
    try {
      final idx = cartItems.indexWhere((c) => c.id == cartItemId);
      if (idx != -1) cartItems[idx].quantity = quantity;
      cartItems.refresh();

      await _api.put(
        '/api/v1/shop/cart/$cartItemId/',
        body: {'quantity': quantity},
        requiresAuth: true,
      );
    } on HttpException catch (e) {
      await fetchCart();
      _showError(_extractMessage(_tryParseBody(e.body)) ?? e.message);
    } catch (e) {
      print('❌ updateCartItem: $e');
    } finally {
      isUpdatingCart.value = false;
    }
  }

  // ──────────────────────────────────────────────────────────────────
  // CART — PATCH /api/v1/shop/cart/{id}/
  // ──────────────────────────────────────────────────────────────────
  Future<void> patchCartItem(int cartItemId, int quantity) async {
    isUpdatingCart.value = true;
    try {
      final idx = cartItems.indexWhere((c) => c.id == cartItemId);
      if (idx != -1) cartItems[idx].quantity = quantity;
      cartItems.refresh();

      await _api.patch(
        '/api/v1/shop/cart/$cartItemId/',
        body: {'quantity': quantity},
        requiresAuth: true,
      );
    } on HttpException catch (e) {
      await fetchCart();
      _showError(_extractMessage(_tryParseBody(e.body)) ?? e.message);
    } catch (e) {
      print('❌ patchCartItem: $e');
    } finally {
      isUpdatingCart.value = false;
    }
  }

  // ──────────────────────────────────────────────────────────────────
  // CART — DELETE /api/v1/shop/cart/{id}/
  // ──────────────────────────────────────────────────────────────────
  Future<void> removeCartItem(int cartItemId) async {
    isUpdatingCart.value = true;
    try {
      cartItems.removeWhere((c) => c.id == cartItemId);

      await _api.delete(
        '/api/v1/shop/cart/$cartItemId/',
        requiresAuth: true,
      );
    } on HttpException catch (e) {
      await fetchCart();
      _showError(_extractMessage(_tryParseBody(e.body)) ?? e.message);
    } catch (e) {
      print('❌ removeCartItem: $e');
    } finally {
      isUpdatingCart.value = false;
    }
  }

  // ──────────────────────────────────────────────────────────────────
  // ORDER — POST /api/v1/shop/orders/
  // ──────────────────────────────────────────────────────────────────
  Future<void> placeOrder({
    required String shippingAddress,
    String paymentMethod = 'Cash on Delivery',
  }) async {
    if (cartItems.isEmpty) return;
    isPlacingOrder.value = true;
    try {
      final orderItems = cartItems
          .map((i) => {
        'product' : i.productId,
        'quantity': i.quantity,
      })
          .toList();

      await _api.post(
        '/api/v1/shop/orders/',
        body: {
          'shipping_address': shippingAddress,
          'payment_method'  : paymentMethod,
          'is_paid'         : false,
          'delivery_charges': '3.99',
          'order_items'     : orderItems,
        },
        requiresAuth: true,
      );

      cartItems.clear();
      Get.offAllNamed(RouteName.orderSuccess);
    } on HttpException catch (e) {
      _showError(_extractMessage(_tryParseBody(e.body)) ?? e.message);
      Get.toNamed(RouteName.orderFaild);
    } catch (e) {
      print('❌ placeOrder: $e');
      Get.toNamed(RouteName.orderFaild);
    } finally {
      isPlacingOrder.value = false;
    }
  }

  // ──────────────────────────────────────────────────────────────────
  // REVIEW — POST /api/v1/shop/reviews/create/
  // ──────────────────────────────────────────────────────────────────
  Future<void> submitReview(int productId) async {
    final comment = reviewCommentCtrl.text.trim();
    if (comment.isEmpty) {
      _showError('Please write a comment.');
      return;
    }
    isSubmittingReview.value = true;
    try {
      await _api.post(
        '/api/v1/shop/reviews/create/',
        body: {
          'product': productId,
          'rating' : reviewRating.value,
          'comment': comment,
        },
        requiresAuth: true,
      );
      reviewCommentCtrl.clear();
      reviewRating.value = 5;
      await fetchProductDetail(productId);
      _showSuccess('Review submitted!');
    } on HttpException catch (e) {
      _showError(_extractMessage(_tryParseBody(e.body)) ?? e.message);
    } catch (e) {
      print('❌ submitReview: $e');
    } finally {
      isSubmittingReview.value = false;
    }
  }

  // ── Derived getters ────────────────────────────────────────────────
  double get cartSubtotal =>
      cartItems.fold(0, (s, i) => s + i.lineTotal);

  double get cartTotal => cartSubtotal + 3.99;

  int get cartCount =>
      cartItems.fold(0, (s, i) => s + i.quantity);

  // ── Filter / Search ────────────────────────────────────────────────
  void selectCategory(String cat) {
    selectedCategory.value = cat;
    _applyFilter();
  }

  void onSearch(String q) {
    searchQuery.value = q;
  }

  void _applyFilter() {
    var list = [...products];

    if (selectedCategory.value != 'All') {
      list = list
          .where((p) =>
      p.category.toLowerCase() ==
          selectedCategory.value.toLowerCase())
          .toList();
    }

    final q = searchQuery.value.trim().toLowerCase();
    if (q.isNotEmpty) {
      list = list
          .where((p) =>
      p.name.toLowerCase().contains(q) ||
          p.category.toLowerCase().contains(q))
          .toList();
    }

    filteredProducts.value = list;
  }

  // ── Qty / Fav helpers ──────────────────────────────────────────────
  void incrementQty() => detailQty.value++;

  void decrementQty() {
    if (detailQty.value > 1) detailQty.value--;
  }

  void toggleFav() => detailFav.value = !detailFav.value;

  // ── Private helpers ────────────────────────────────────────────────
  Map<String, dynamic>? _tryParseBody(String? body) {
    if (body == null || body.trim().isEmpty) return null;
    try {
      final d = jsonDecode(body);
      if (d is Map<String, dynamic>) return d;
    } catch (_) {}
    return null;
  }

  String? _extractMessage(Map<String, dynamic>? body) {
    if (body == null) return null;
    if (body.containsKey('detail')) return body['detail'].toString();
    for (final e in body.entries) {
      final v = e.value;
      if (v is List && v.isNotEmpty) return v.first.toString();
      if (v is String) return v;
    }
    return null;
  }

  void _showError(String msg) {
    final ctx = Get.context;
    if (ctx == null) return;
    ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
      content:
      Text(msg, style: const TextStyle(color: Colors.white)),
      backgroundColor: Colors.red.shade700,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)),
    ));
  }

  void _showSuccess(String msg) {
    final ctx = Get.context;
    if (ctx == null) return;
    ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
      content:
      Text(msg, style: const TextStyle(color: Colors.white)),
      backgroundColor: Colors.green.shade700,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)),
    ));
  }

  @override
  void onClose() {
    reviewCommentCtrl.dispose();
    super.onClose();
  }
}