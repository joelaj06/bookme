class AuthEndpoints {
  static const String signin = 'users/auth/login';
  static const String signOut = 'users/auth/logout';
  static String user(String userId) => 'users/$userId';
  static const String signup = 'users/auth/signup';
}
