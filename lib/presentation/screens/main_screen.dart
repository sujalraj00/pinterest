import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final currentIndexProvider = StateProvider<int>((ref) => 0);

// Provider to track current route
final currentRouteProvider = Provider<String>((ref) {
  return '';
});

class MainScreen extends ConsumerWidget {
  final Widget? child;

  const MainScreen({super.key, this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(currentIndexProvider);

    // If child is provided (from ShellRoute), use it
    if (child != null) {
      return Scaffold(
        body: child,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            ref.read(currentIndexProvider.notifier).state = index;
            _navigateToTab(context, index);
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey[600],
          showSelectedLabels: true,
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search_outlined),
              activeIcon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline),
              activeIcon: Icon(Icons.add_circle),
              label: 'Create',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline),
              activeIcon: Icon(Icons.chat_bubble),
              label: 'Inbox',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      );
    }

    // Original behavior for backward compatibility
    return const Scaffold(
      body: SizedBox.expand(),
      bottomNavigationBar: SizedBox.shrink(),
    );
  }

  void _navigateToTab(BuildContext context, int index) {
    final routes = ['/', '/search', '/create', '/inbox', '/saved'];
    if (index < routes.length) {
      context.go(routes[index]);
    }
  }
}
