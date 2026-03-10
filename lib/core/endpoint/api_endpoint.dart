class ApiEndpoint {
  static const String baseUrl = "http://10.10.7.76:14070";

  // ─── Auth - Registration ───────────────────────────────────────────
  static const String register         = "$baseUrl/api/v1/auth/register/";
  static const String registerActivate = "$baseUrl/api/v1/auth/register/activate/";
  static const String resendOtp        = "$baseUrl/api/v1/auth/resend-otp/";

  // ─── Auth - Login ──────────────────────────────────────────────────
  static const String login            = "$baseUrl/api/v1/auth/login/";

  // ─── Auth - Forgot Password ────────────────────────────────────────
  static const String forgotPassword        = "$baseUrl/api/v1/auth/forgot-password/";
  static const String forgotPasswordVerify  = "$baseUrl/api/v1/auth/forgot-password/verify/";
  static const String forgotPasswordResendOtp = "$baseUrl/api/v1/auth/forgot-password/resend-otp/";
  static const String forgotPasswordSetPassword = "$baseUrl/api/v1/auth/forgot-password/set/password/";

  // ─── User - Profile ────────────────────────────────────────────────
  static const String userProfileDetails        = "$baseUrl/api/v1/user/profile/details/";
  static const String userProfileUpdate         = "$baseUrl/api/v1/user/profile/update/";
  static const String userProfileGoalUpdate     = "$baseUrl/api/v1/user/profile/goal/update/";
  static const String userProfileChangePassword = "$baseUrl/api/v1/user/profile/change-password/";
  static const String userProfileDelete         = "$baseUrl/api/v1/user/profile/delete/";

  // ─── Billing & Subscriptions ───────────────────────────────────────
  static const String activePaymentPlans = "$baseUrl/api/v1/payment/active-payment-plans/";

  // ─── Service - Skin Status ─────────────────────────────────────────
  static const String skinStatus = "$baseUrl/api/v1/services/skin-status/";

  // ─── Service - Water Intake ────────────────────────────────────────
  static const String waterIntake = "$baseUrl/api/v1/services/water-intake/";

  // ─── Service - Today's Notes ───────────────────────────────────────
  static const String todaysNotes       = "$baseUrl/api/v1/services/todays-notes/";
  static const String todaysNotesDetail = "$baseUrl/api/v1/services/todays-notes/detail/";

  // ─── Service - Posts ───────────────────────────────────────────────
  static const String createPost = "$baseUrl/api/v1/services/posts/";
  static const String listPosts  = "$baseUrl/api/v1/services/posts/list/";

  // ─── Service - Likes ───────────────────────────────────────────────
  static const String likes = "$baseUrl/api/v1/services/likes/";

  // ─── Service - Comments ────────────────────────────────────────────
  static const String comments = "$baseUrl/api/v1/services/comments/";

  // ─── AI Section ────────────────────────────────────────────────────
  static const String aiChatbot              = "/api/v1/services/ai-chatbot/";
  static const String chatSessions           = "/api/v1/services/chat-sessions/";
  static const String aiRecommendedReading   = "$baseUrl/api/v1/services/ai-recommended-reading/";
  static const String aiRecommendedProducts  = "$baseUrl/api/v1/services/recommended-products/";

  // ─── Shop - Categories (Public) ────────────────────────────────────
  static const String activeCategories = "$baseUrl/api/v1/shop/categories/active/";
  static String activeCategoryById(int id) => "$baseUrl/api/v1/shop/categories/active/$id/";

  // ─── Shop - Products (Public) ──────────────────────────────────────
  static const String activeProducts = "$baseUrl/api/v1/shop/products/active/";
  static String activeProductById(int id) => "$baseUrl/api/v1/shop/products/active/$id/";

  // ─── Shop - Product Reviews ────────────────────────────────────────
  static const String productReviews       = "$baseUrl/api/v1/shop/reviews/";
  static const String createProductReview  = "$baseUrl/api/v1/shop/reviews/create/";

  // ─── Shop - Cart ───────────────────────────────────────────────────
  static const String cart = "$baseUrl/api/v1/shop/cart/";
  static String cartById(int id) => "$baseUrl/api/v1/shop/cart/$id/";

  // ─── Shop - Orders ─────────────────────────────────────────────────
  static const String orders = "$baseUrl/api/v1/shop/orders/";

  // ─── Dashboard - Overview ──────────────────────────────────────────
  static const String dashboardOverview = "$baseUrl/api/v1/dashboard/overview/";

  // ─── Dashboard - User Management ──────────────────────────────────
  static const String userManagement = "$baseUrl/api/v1/dashboard/user-management/";
  static String userManagementById(int id)      => "$baseUrl/api/v1/dashboard/user-management/$id/";
  static String toggleUserActive(int id)        => "$baseUrl/api/v1/dashboard/user-management/toggle-active/$id/";

  // ─── Dashboard - Administrators ───────────────────────────────────
  static const String administrators       = "$baseUrl/api/v1/dashboard/administrators/";
  static const String createAdministrator  = "$baseUrl/api/v1/dashboard/administrators/create/";
  static String administratorById(int id)  => "$baseUrl/api/v1/dashboard/administrators/$id/";

  // ─── Dashboard - Products ──────────────────────────────────────────
  static const String dashboardProducts = "$baseUrl/api/v1/shop/products/";
  static String dashboardProductById(int id) => "$baseUrl/api/v1/shop/products/$id/";

  // ─── Dashboard - Categories ────────────────────────────────────────
  static const String dashboardCategories = "$baseUrl/api/v1/shop/categories/";
  static String dashboardCategoryById(int id) => "$baseUrl/api/v1/shop/categories/$id/";

  // ─── Dashboard - Payment Plans ─────────────────────────────────────
  static const String paymentPlans = "$baseUrl/api/v1/payment/payment-plans/";
  static String paymentPlanById(int id) => "$baseUrl/api/v1/payment/payment-plans/$id/";

  // ─── Dashboard - Orders ────────────────────────────────────────────
  static const String adminOrders = "$baseUrl/api/v1/shop/admin/orders/";
}