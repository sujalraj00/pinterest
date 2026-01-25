// // import 'package:flutter/material.dart';

// // class ProfileScreen extends StatelessWidget {
// //   const ProfileScreen({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Profile'),
// //         actions: [
// //           IconButton(icon: const Icon(Icons.settings), onPressed: () {}),
// //         ],
// //       ),
// //       body: SingleChildScrollView(
// //         child: Column(
// //           children: [
// //             const SizedBox(height: 24),
// //             CircleAvatar(
// //               radius: 50,
// //               backgroundColor: Colors.grey[300],
// //               child: const Icon(Icons.person, size: 50),
// //             ),
// //             const SizedBox(height: 16),
// //             Text(
// //               'Guest User',
// //               style: Theme.of(
// //                 context,
// //               ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
// //             ),
// //             const SizedBox(height: 8),
// //             Text(
// //               '@guestuser',
// //               style: Theme.of(
// //                 context,
// //               ).textTheme.bodyLarge?.copyWith(color: Colors.grey[600]),
// //             ),
// //             const SizedBox(height: 24),
// //             Row(
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               children: [
// //                 _StatItem(label: 'Followers', value: '0'),
// //                 const SizedBox(width: 32),
// //                 _StatItem(label: 'Following', value: '0'),
// //               ],
// //             ),
// //             const SizedBox(height: 24),
// //             Padding(
// //               padding: const EdgeInsets.symmetric(horizontal: 16),
// //               child: ElevatedButton(
// //                 onPressed: () {},
// //                 style: ElevatedButton.styleFrom(
// //                   backgroundColor: Colors.grey[200],
// //                   foregroundColor: Colors.black87,
// //                   minimumSize: const Size(double.infinity, 48),
// //                   shape: RoundedRectangleBorder(
// //                     borderRadius: BorderRadius.circular(24),
// //                   ),
// //                 ),
// //                 child: const Text('Edit Profile'),
// //               ),
// //             ),
// //             const SizedBox(height: 32),
// //             DefaultTabController(
// //               length: 2,
// //               child: Column(
// //                 children: [
// //                   const TabBar(
// //                     tabs: [
// //                       Tab(text: 'Saved'),
// //                       Tab(text: 'Created'),
// //                     ],
// //                   ),
// //                   SizedBox(
// //                     height: 300,
// //                     child: TabBarView(
// //                       children: [
// //                         _buildEmptyState(context, 'No saved pins yet'),
// //                         _buildEmptyState(context, 'No created pins yet'),
// //                       ],
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildEmptyState(BuildContext context, String message) {
// //     return Center(
// //       child: Column(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         children: [
// //           Icon(Icons.push_pin, size: 64, color: Colors.grey[400]),
// //           const SizedBox(height: 16),
// //           Text(
// //             message,
// //             style: Theme.of(
// //               context,
// //             ).textTheme.titleMedium?.copyWith(color: Colors.grey[600]),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // class _StatItem extends StatelessWidget {
// //   final String label;
// //   final String value;

// //   const _StatItem({required this.label, required this.value});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Column(
// //       children: [
// //         Text(
// //           value,
// //           style: Theme.of(
// //             context,
// //           ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
// //         ),
// //         Text(
// //           label,
// //           style: Theme.of(
// //             context,
// //           ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
// //         ),
// //       ],
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import '../controllers/auth_controller.dart';

// class ProfileScreen extends ConsumerWidget {
//   const ProfileScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final authState = ref.watch(authControllerProvider);
//     final userName = authState.user?.name ?? 'Guest User';
//     final userEmail = authState.user?.email ?? 'guest@example.com';

//     return Scaffold(
//       appBar: AppBar(
//         // automaticallyImplyLeading: false,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
//           onPressed: () => Navigator.of(context).pop(),
//         ),

//         actions: [
//           IconButton(
//             icon: const Icon(Icons.share_outlined),
//             onPressed: () {
//               _showSettingsSheet(context, ref);
//             },
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             const SizedBox(height: 24),
//             CircleAvatar(
//               radius: 50,
//               backgroundColor: Colors.grey[300],
//               child: Text(
//                 userName[0].toUpperCase(),
//                 style: const TextStyle(
//                   fontSize: 32,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),

//             //
//             Text(
//               userName,
//               style: Theme.of(
//                 context,
//               ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               userEmail,
//               style: Theme.of(
//                 context,
//               ).textTheme.bodyLarge?.copyWith(color: Colors.grey[600]),
//             ),
//             const SizedBox(height: 24),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [Text('0 followers '), Text('・'), Text(' 0 following')],
//             ),
//             // Row(
//             //   mainAxisAlignment: MainAxisAlignment.center,
//             //   children: [
//             //     _StatItem(label: 'Followers', value: '0'),
//             //     const SizedBox(width: 32),
//             //     _StatItem(label: 'Following', value: '0'),
//             //   ],
//             // ),
//             const SizedBox(height: 24),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 115),
//               // child: ElevatedButton(

//               //   onPressed: () {},
//               //   style: ElevatedButton.styleFrom(
//               //     backgroundColor: Colors.grey[200],
//               //     foregroundColor: Colors.black87,
//               //     minimumSize: const Size(double.infinity, 48),
//               //     shape: RoundedRectangleBorder(
//               //       borderRadius: BorderRadius.circular(14),
//               //     ),
//               //   ),
//               //   child: const Text('Edit Profile'),
//               // ),
//               child: Container(
//                 padding: EdgeInsets.all(12),

//                 decoration: BoxDecoration(
//                   color: Colors.grey[300],
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Text('Edit profile', style: TextStyle()),
//               ),
//             ),
//             const SizedBox(height: 32),

//             // DefaultTabController(
//             //   length: 2,
//             //   child: Column(
//             //     children: [
//             //       const TabBar(
//             //         tabs: [
//             //           Tab(text: 'Saved'),
//             //           Tab(text: 'Created'),
//             //         ],
//             //       ),
//             //       SizedBox(
//             //         height: 300,
//             //         child: TabBarView(
//             //           children: [
//             //             _buildEmptyState(context, 'No saved pins yet'),
//             //             _buildEmptyState(context, 'No created pins yet'),
//             //           ],
//             //         ),
//             //       ),
//             //     ],
//             //   ),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildEmptyState(BuildContext context, String message) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.push_pin, size: 64, color: Colors.grey[400]),
//           const SizedBox(height: 16),
//           Text(
//             message,
//             style: Theme.of(
//               context,
//             ).textTheme.titleMedium?.copyWith(color: Colors.grey[600]),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showSettingsSheet(BuildContext context, WidgetRef ref) {
//     showModalBottomSheet(
//       context: context,
//       builder: (context) => SafeArea(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             ListTile(
//               leading: const Icon(Icons.person_outline),
//               title: const Text('Account settings'),
//               onTap: () => Navigator.pop(context),
//             ),
//             ListTile(
//               leading: const Icon(Icons.notifications_outlined),
//               title: const Text('Notifications'),
//               onTap: () => Navigator.pop(context),
//             ),
//             ListTile(
//               leading: const Icon(Icons.privacy_tip_outlined),
//               title: const Text('Privacy and data'),
//               onTap: () => Navigator.pop(context),
//             ),
//             const Divider(),
//             ListTile(
//               leading: const Icon(Icons.logout, color: Colors.red),
//               title: const Text(
//                 'Sign out',
//                 style: TextStyle(color: Colors.red),
//               ),
//               onTap: () async {
//                 Navigator.pop(context);
//                 final shouldSignOut = await showDialog<bool>(
//                   context: context,
//                   builder: (context) => AlertDialog(
//                     title: const Text('Sign Out'),
//                     content: const Text('Are you sure you want to sign out?'),
//                     actions: [
//                       TextButton(
//                         onPressed: () => Navigator.pop(context, false),
//                         child: const Text('Cancel'),
//                       ),
//                       TextButton(
//                         onPressed: () => Navigator.pop(context, true),
//                         style: TextButton.styleFrom(
//                           foregroundColor: Colors.red,
//                         ),
//                         child: const Text('Sign Out'),
//                       ),
//                     ],
//                   ),
//                 );

//                 if (shouldSignOut == true && context.mounted) {
//                   await ref.read(authControllerProvider.notifier).signOut();
//                   if (context.mounted) {
//                     context.go('/welcome');
//                   }
//                 }
//               },
//             ),
//             const SizedBox(height: 16),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _StatItem extends StatelessWidget {
//   final String label;
//   final String value;

//   const _StatItem({required this.label, required this.value});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Text(
//           value,
//           style: Theme.of(
//             context,
//           ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
//         ),
//         Text(
//           label,
//           style: Theme.of(
//             context,
//           ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              // App Bar with back and share buttons
              SliverAppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                pinned: false,
                floating: true,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.share_outlined, color: Colors.black),
                    onPressed: () {},
                  ),
                ],
              ),
              // Profile Header
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    // Profile Avatar
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: const Color(0xFFFFB3BA),
                      child: const Text(
                        'H',
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Username
                    const Text(
                      'hritwik',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Pinterest username
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.push_pin, size: 16, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text(
                          'hritwiksinghchauhan23',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Followers and Following
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '0 followers',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[800],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          width: 4,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.grey[600],
                            shape: BoxShape.circle,
                          ),
                        ),
                        Text(
                          '0 following',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[800],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Edit Profile Button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 140),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[200],
                          foregroundColor: Colors.black87,
                          elevation: 0,
                          minimumSize: const Size(double.infinity, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Edit profile',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
              // Sticky Tab Bar
              SliverPersistentHeader(
                pinned: true,
                delegate: _StickyTabBarDelegate(
                  TabBar(
                    controller: _tabController,
                    dividerColor: Colors.transparent,
                    padding: EdgeInsets.symmetric(horizontal: 60),
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.black,
                    indicatorColor: Colors.black,
                    indicatorWeight: 3,
                    labelStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    tabs: const [
                      Tab(text: 'Created'),
                      Tab(text: 'Saved'),
                      Tab(text: 'Collages'),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: [
              _buildEmptyCreatedState(),
              _buildEmptySavedState(),
              _buildEmptyCollagesState(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyCreatedState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Inspire with a Pin',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE60023),
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: const Text(
                'Create',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptySavedState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.bookmark_outline, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            const Text(
              'No saved Pins yet',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Start saving Pins to see them here',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyCollagesState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.collections_outlined, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            const Text(
              'No collages yet',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Create beautiful collages from your Pins',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom delegate for sticky tab bar
class _StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _StickyTabBarDelegate(this.tabBar);

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(color: Colors.white, child: tabBar);
  }

  @override
  bool shouldRebuild(_StickyTabBarDelegate oldDelegate) {
    return tabBar != oldDelegate.tabBar;
  }
}
