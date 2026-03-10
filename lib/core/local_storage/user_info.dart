import 'package:shared_preferences/shared_preferences.dart';

class UserInfo {

  // ─── Keys ──────────────────────────────────────────────────────────
  static const String _accessTokenKey        = 'access';
  static const String _refreshTokenKey       = 'refresh';
  static const String _resetTokenKey         = 'reset_token';
  static const String _onboardingKey         = 'onboarding_completed';
  static const String _userIdKey             = 'user_id';
  static const String _userEmailKey          = 'user_email';
  static const String _userFullNameKey       = 'user_full_name';
  static const String _userPhoneKey          = 'user_phone';
  static const String _userProfileImageKey   = 'user_profile_image';
  static const String _isActiveKey           = 'is_active';
  static const String _forgotPasswordEmailKey = 'forgot_password_email';

  // ─── Access Token ──────────────────────────────────────────────────
  static Future<void> setAccessToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_accessTokenKey, token);
  }

  static Future<String?> getAccessToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_accessTokenKey);
  }

  // ─── Refresh Token ─────────────────────────────────────────────────
  static Future<void> setRefreshToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_refreshTokenKey, token);
  }

  static Future<String?> getRefreshToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_refreshTokenKey);
  }

  // ─── Reset Token (Forgot Password) ────────────────────────────────
  static Future<void> setResetToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_resetTokenKey, token);
  }

  static Future<String?> getResetToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_resetTokenKey);
  }

  static Future<void> clearResetToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_resetTokenKey);
  }

  // ─── Forgot Password Email ─────────────────────────────────────────
  // Store email temporarily during forgot password flow
  static Future<void> setForgotPasswordEmail(String email) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_forgotPasswordEmailKey, email);
  }

  static Future<String?> getForgotPasswordEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_forgotPasswordEmailKey);
  }

  static Future<void> clearForgotPasswordEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_forgotPasswordEmailKey);
  }

  // ─── Onboarding ────────────────────────────────────────────────────
  static Future<void> setOnboardingCompleted(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingKey, value);
  }

  static Future<bool> getOnboardingCompleted() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onboardingKey) ?? false;
  }

  // ─── User Profile ──────────────────────────────────────────────────
  static Future<void> setUserId(int id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_userIdKey, id);
  }

  static Future<int?> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_userIdKey);
  }

  static Future<void> setUserEmail(String email) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userEmailKey, email);
  }

  static Future<String?> getUserEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userEmailKey);
  }

  static Future<void> setUserFullName(String name) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userFullNameKey, name);
  }

  static Future<String?> getUserFullName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userFullNameKey);
  }

  static Future<void> setUserPhone(String phone) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userPhoneKey, phone);
  }

  static Future<String?> getUserPhone() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userPhoneKey);
  }

  static Future<void> setUserProfileImage(String url) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userProfileImageKey, url);
  }

  static Future<String?> getUserProfileImage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userProfileImageKey);
  }

  static Future<void> setIsActive(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isActiveKey, value);
  }

  static Future<bool> getIsActive() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isActiveKey) ?? false;
  }

  // ─── Save Full Profile at Once ─────────────────────────────────────
  static Future<void> saveUserProfile({
    required int id,
    required String email,
    required String fullName,
    String? phone,
    String? profileImage,
    bool isActive = true,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await Future.wait([
      prefs.setInt(_userIdKey, id),
      prefs.setString(_userEmailKey, email),
      prefs.setString(_userFullNameKey, fullName),
      if (phone != null) prefs.setString(_userPhoneKey, phone),
      if (profileImage != null) prefs.setString(_userProfileImageKey, profileImage),
      prefs.setBool(_isActiveKey, isActive),
    ]);
  }

  // ─── Auth Helpers ──────────────────────────────────────────────────
  static Future<bool> isLoggedIn() async {
    final token = await getAccessToken();
    return token != null && token.isNotEmpty;
  }

  static Future<Map<String, String>> getAuthHeaders() async {
    final token = await getAccessToken();
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  // ─── Clear Tokens Only (e.g. token refresh failure) ───────────────
  static Future<void> clearTokens() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await Future.wait([
      prefs.remove(_accessTokenKey),
      prefs.remove(_refreshTokenKey),
    ]);
  }

  // ─── Clear All (Logout) ────────────────────────────────────────────
  static Future<void> clearAll() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}