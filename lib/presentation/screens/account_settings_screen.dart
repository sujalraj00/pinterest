import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pinterest/presentation/screens/inbox_screen.dart';
import 'package:pinterest/presentation/screens/profile_screen.dart';
import '../controllers/auth_controller.dart';

class AccountSettingsScreen extends ConsumerWidget {
  const AccountSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);
    final userName = authState.user?.name ?? 'Guest User';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Your account',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          // Profile section
          ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            leading: CircleAvatar(
              radius: 24,
              backgroundColor: const Color(0xFFFFB3BA),
              child: Text(
                userName[0].toUpperCase(),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            title: Text(
              userName.toLowerCase(),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            subtitle: const Text(
              'View profile',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            trailing: const Icon(Icons.chevron_right, color: Colors.black),
            onTap: () {
              //   // Navigate to profile view
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const ProfileScreen(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                        const begin = Offset(1.0, 0.0);
                        const end = Offset.zero;
                        const curve = Curves.easeInOut;
                        var tween = Tween(
                          begin: begin,
                          end: end,
                        ).chain(CurveTween(curve: curve));
                        var offsetAnimation = animation.drive(tween);
                        return SlideTransition(
                          position: offsetAnimation,
                          child: child,
                        );
                      },
                  transitionDuration: const Duration(milliseconds: 300),
                ),
              );
            },
          ),
          // const SizedBox(height: 16),

          // Settings header
          _SettingsTile(
            title: 'Settings',
            showArrow: false,
            fontWeight: FontWeight.w400,
            onTap: () {},
          ),

          // Settings options
          _SettingsTile(
            title: 'Account management',
            fontWeight: FontWeight.w500,
            onTap: () => _navigateToScreen(context, 'Account Management'),
          ),
          _SettingsTile(
            title: 'Profile visibility',
            fontWeight: FontWeight.w500,
            onTap: () => _navigateToScreen(context, 'Profile Visibility'),
          ),
          _SettingsTile(
            title: 'Refine your recommendations',
            fontWeight: FontWeight.w500,
            onTap: () => _navigateToScreen(context, 'Refine Recommendations'),
          ),
          _SettingsTile(
            title: 'Claimed external accounts',
            fontWeight: FontWeight.w500,
            onTap: () => _navigateToScreen(context, 'Claimed Accounts'),
          ),
          _SettingsTile(
            title: 'Social permissions',
            fontWeight: FontWeight.w500,
            onTap: () => _navigateToScreen(context, 'Social Permissions'),
          ),
          _SettingsTile(
            title: 'Notifications',
            fontWeight: FontWeight.w500,
            onTap: () => _navigateToScreen(context, 'Notifications'),
          ),
          _SettingsTile(
            title: 'Privacy and data',
            fontWeight: FontWeight.w500,
            onTap: () => _navigateToScreen(context, 'Privacy and Data'),
          ),
          _SettingsTile(
            title: 'Reports and violations center',
            fontWeight: FontWeight.w500,
            onTap: () => _navigateToScreen(context, 'Reports and Violations'),
          ),

          // const SizedBox(height: 24),

          // Login header
          // const Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          //   child: Text(
          //     'Login',
          //     style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          //   ),
          // ),
          _SettingsTile(
            title: 'Login',
            showArrow: false,
            fontWeight: FontWeight.w400,
            onTap: () {},
          ),

          _SettingsTile(
            title: 'Add account',
            fontWeight: FontWeight.w500,
            onTap: () => _navigateToScreen(context, 'Add Account'),
          ),
          _SettingsTile(
            title: 'Security',
            fontWeight: FontWeight.w500,
            onTap: () => _navigateToScreen(context, 'Security'),
          ),
          _SettingsTile(
            title: 'Log out',
            showArrow: false,
            fontWeight: FontWeight.w500,
            onTap: () => _showLogoutDialog(context, ref),
          ),

          //  const SizedBox(height: 24),

          // Support header
          _SettingsTile(
            title: 'Support',
            showArrow: false,
            fontWeight: FontWeight.w400,
            onTap: () {},
          ),

          _SettingsTile(
            title: 'Get help',
            fontWeight: FontWeight.w500,
            onTap: () => _navigateToScreen(context, 'Get Help'),
          ),
          _SettingsTile(
            title: 'See terms and privacy',
            fontWeight: FontWeight.w500,
            onTap: () => _navigateToScreen(context, 'Terms and Privacy'),
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  void _navigateToScreen(BuildContext context, String title) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            _PlaceholderScreen(title: title),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;
          var tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);
          return SlideTransition(position: offsetAnimation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Log out'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Close settings screen
              await ref.read(authControllerProvider.notifier).signOut();
              if (context.mounted) {
                context.go('/welcome');
              }
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Log out'),
          ),
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final FontWeight fontWeight;
  final bool showArrow;

  const _SettingsTile({
    required this.title,
    required this.onTap,
    required this.fontWeight,
    this.showArrow = true,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      title: Text(
        title,
        style: TextStyle(fontSize: 16, fontWeight: fontWeight),
      ),
      trailing: showArrow
          ? const Icon(Icons.chevron_right, color: Colors.black)
          : null,
      onTap: onTap,
    );
  }
}

// Placeholder screen for settings options
class _PlaceholderScreen extends StatelessWidget {
  final String title;

  const _PlaceholderScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.settings_outlined, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'This feature is coming soon',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}
