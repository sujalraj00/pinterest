import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/models/user_model.dart';
import 'dart:convert';

class AuthService {
  final SharedPreferences _prefs;

  AuthService(this._prefs);

  Future<bool> get isAuthenticated async {
    final token = _prefs.getString('auth_token');
    return token != null && token.isNotEmpty;
  }

  Future<UserModel?> getCurrentUser() async {
    try {
      final userData = _prefs.getString('user_data');
      if (userData != null) {
        return UserModel.fromJson(json.decode(userData));
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<void> saveUserData(UserModel user) async {
    await _prefs.setString('user_data', json.encode(user.toJson()));
  }

  Future<void> signUpWithEmail(String email, String password) async {
    try {
      // Simulate API call - Replace with your actual backend API
      await Future.delayed(const Duration(seconds: 1));

      // For demo purposes, we'll just store a token
      // In production, call your backend API here
      await _prefs.setString(
        'auth_token',
        'demo_token_${DateTime.now().millisecondsSinceEpoch}',
      );
      await _prefs.setString('user_email', email);

      // You can integrate with Firebase Auth, Supabase, or your own backend here
      // Example with Firebase:
      // final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      //   email: email,
      //   password: password,
      // );
    } catch (e) {
      throw Exception('Sign up failed: ${e.toString()}');
    }
  }

  Future<void> signInWithEmail(String email, String password) async {
    try {
      // Simulate API call - Replace with your actual backend API
      await Future.delayed(const Duration(seconds: 1));

      // For demo purposes, check if user exists
      final storedEmail = _prefs.getString('user_email');
      if (storedEmail != email) {
        throw Exception('Invalid email or password');
      }

      await _prefs.setString(
        'auth_token',
        'demo_token_${DateTime.now().millisecondsSinceEpoch}',
      );

      // You can integrate with Firebase Auth, Supabase, or your own backend here
      // Example with Firebase:
      // final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      //   email: email,
      //   password: password,
      // );
    } catch (e) {
      throw Exception('Sign in failed: ${e.toString()}');
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      // Simulate OAuth - Replace with actual Google Sign-In
      await Future.delayed(const Duration(seconds: 1));

      await _prefs.setString(
        'auth_token',
        'google_token_${DateTime.now().millisecondsSinceEpoch}',
      );
      await _prefs.setString('user_email', 'user@gmail.com');

      // You can integrate with Google Sign-In package here
      // Example:
      // final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      // final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      // Then authenticate with your backend or Firebase
    } catch (e) {
      throw Exception('Google sign in failed: ${e.toString()}');
    }
  }

  Future<void> signOut() async {
    try {
      await _prefs.remove('auth_token');
      await _prefs.remove('user_data');
      await _prefs.remove('onboarding_complete');
      await _prefs.remove('user_email');
    } catch (e) {
      throw Exception('Sign out failed: ${e.toString()}');
    }
  }

  Future<void> completeOnboarding() async {
    await _prefs.setBool('onboarding_complete', true);
  }

  Future<bool> isOnboardingComplete() async {
    return _prefs.getBool('onboarding_complete') ?? false;
  }
}
