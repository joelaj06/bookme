class AuthEndpoints {
  static const String signin = 'users/auth/login';
  static const String signOut = 'users/auth/sign_out';
  static String user(String userId) => 'users/$userId';
}
