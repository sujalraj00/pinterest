import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pinterest/presentation/screens/account_settings_screen.dart';
import 'package:pinterest/presentation/screens/profile_screen.dart';
import '../../domain/models/photo_model.dart';
import '../../presentation/screens/main_screen.dart';
import '../../presentation/screens/photo_detail_screen.dart';
import '../../presentation/screens/onboarding/welcome_screen.dart';
import '../../presentation/screens/onboarding/login_screen.dart';
import '../../presentation/screens/onboarding/email_screen.dart';
import '../../presentation/screens/onboarding/password_screen.dart';
import '../../presentation/screens/onboarding/name_screen.dart';
import '../../presentation/screens/onboarding/dob_screen.dart';
import '../../presentation/screens/onboarding/gender_screen.dart';
import '../../presentation/screens/onboarding/country_screen.dart';
import '../../presentation/screens/onboarding/interests_screen.dart';
import '../../presentation/providers/providers.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  // final authState = ref.watch(authControllerProvider);

  return GoRouter(
    // initialLocation: authState.isAuthenticated ? '/' : '/welcome',
    // redirect: (context, state) async {
    //   final isAuthenticated = authState.isAuthenticated;
    //   final isOnWelcome = state.matchedLocation == '/welcome';
    //   final isOnAuth = state.matchedLocation.startsWith('/signup') ||
    //       state.matchedLocation.startsWith('/login');

    //   // If authenticated and on auth screens, redirect to home
    //   if (isAuthenticated && (isOnWelcome || isOnAuth)) {
    //     return '/';
    //   }

    //   // If not authenticated and not on auth screens, redirect to welcome
    //   if (!isAuthenticated && !isOnWelcome && !isOnAuth) {
    //     return '/welcome';
    //   }

    //   return null;
    // },
    redirect: (context, state) async {
      final isAuthenticated = await ref
          .read(authServiceProvider)
          .isAuthenticated;
      final isOnWelcome = state.matchedLocation == '/welcome';
      final isOnAuth =
          state.matchedLocation.startsWith('/signup') ||
          state.matchedLocation.startsWith('/login');

      // If authenticated and on auth screens, redirect to home
      if (isAuthenticated && (isOnWelcome || isOnAuth)) {
        return '/';
      }

      // If not authenticated and not on auth screens, redirect to welcome
      if (!isAuthenticated && !isOnWelcome && !isOnAuth) {
        return '/welcome';
      }

      return null;
    },
    routes: [
      // Onboarding routes
      GoRoute(
        path: '/welcome',
        name: 'welcome',
        pageBuilder: (context, state) =>
            const MaterialPage(child: WelcomeScreen()),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        pageBuilder: (context, state) =>
            const MaterialPage(child: LoginScreen()),
      ),
      GoRoute(
        path: '/signup/email',
        name: 'signup-email',
        pageBuilder: (context, state) =>
            const MaterialPage(child: EmailScreen()),
      ),
      GoRoute(
        path: '/signup/password',
        name: 'signup-password',
        pageBuilder: (context, state) =>
            const MaterialPage(child: PasswordScreen()),
      ),
      GoRoute(
        path: '/signup/name',
        name: 'signup-name',
        pageBuilder: (context, state) =>
            const MaterialPage(child: NameScreen()),
      ),
      GoRoute(
        path: '/signup/dob',
        name: 'signup-dob',
        pageBuilder: (context, state) => const MaterialPage(child: DobScreen()),
      ),
      GoRoute(
        path: '/signup/gender',
        name: 'signup-gender',
        pageBuilder: (context, state) =>
            const MaterialPage(child: GenderScreen()),
      ),
      GoRoute(
        path: '/signup/country',
        name: 'signup-country',
        pageBuilder: (context, state) =>
            const MaterialPage(child: CountryScreen()),
      ),
      GoRoute(
        path: '/signup/interests',
        name: 'signup-interests',
        pageBuilder: (context, state) =>
            const MaterialPage(child: InterestsScreen()),
      ),
      // Main app routes
      GoRoute(
        path: '/',
        name: 'main',
        pageBuilder: (context, state) =>
            const MaterialPage(child: MainScreen()),
      ),
      GoRoute(
        path: '/photo/:id',
        name: 'photo-detail',
        pageBuilder: (context, state) {
          final photo = state.extra as PhotoModel;
          return MaterialPage(child: PhotoDetailScreen(photo: photo));
        },
      ),

      GoRoute(
        path: '/account-settings',
        name: 'account-settings',
        pageBuilder: (context, state) =>
            SlideFromRightPage(child: const AccountSettingsScreen()),
      ),
      GoRoute(
        path: '/profile',
        name: 'profile',
        pageBuilder: (context, state) =>
            SlideFromRightPage(child: const ProfileScreen()),
      ),
    ],
  );
});

// Custom page with slide transition from right
class SlideFromRightPage extends CustomTransitionPage<void> {
  const SlideFromRightPage({required super.child, super.key})
    : super(
        transitionsBuilder: _transitionsBuilder,
        transitionDuration: const Duration(milliseconds: 300),
      );

  static Widget _transitionsBuilder(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    const begin = Offset(1.0, 0.0);
    const end = Offset.zero;
    const curve = Curves.easeInOut;
    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    var offsetAnimation = animation.drive(tween);
    return SlideTransition(position: offsetAnimation, child: child);
  }
}
