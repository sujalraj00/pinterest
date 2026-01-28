import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../widgets/create_bottom_sheet.dart';

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

    if (child != null) {
      return Scaffold(
        body: child,
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
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
          items: [
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
            BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Create'),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/writing.png',
                width: 20,
                height: 20,
              ),
              activeIcon: Image.asset(
                'assets/images/writing.png',
                width: 20,
                height: 20,
              ),
              label: 'Inbox',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Saved',
            ),
          ],
        ),
      );
    }

    return const Scaffold(
      body: SizedBox.expand(),
      bottomNavigationBar: SizedBox.shrink(),
    );
  }

  void _navigateToTab(BuildContext context, int index) {
    if (index == 2) {
      _showCreateBottomSheet(context);
      return;
    }

    final routes = ['/', '/search', '/create', '/inbox', '/saved'];
    if (index < routes.length) {
      context.go(routes[index]);
    }
  }

  void _showCreateBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return const CreateBottomSheet();
      },
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      isScrollControlled: true,
    );
  }
}
