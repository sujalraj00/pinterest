// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'account_settings_screen.dart';
// import '../controllers/auth_controller.dart';

// class SavedScreen extends ConsumerWidget {
//   const SavedScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final authState = ref.watch(authControllerProvider);
//     final userName = authState.user?.name ?? 'Guest User';

//     return DefaultTabController(
//       length: 3,
//       child: Scaffold(
//         appBar: AppBar(
//           automaticallyImplyLeading: false,
//           title: Row(
//             children: [
//               GestureDetector(
//                 onTap: () {
//                    context.push('/account-settings');
//                   // Navigator.of(context).push(
//                   //   PageRouteBuilder(
//                   //     pageBuilder: (context, animation, secondaryAnimation) =>
//                   //         const AccountSettingsScreen(),
//                   //     transitionsBuilder:
//                   //         (context, animation, secondaryAnimation, child) {
//                   //           const begin = Offset(1.0, 0.0);
//                   //           const end = Offset.zero;
//                   //           const curve = Curves.easeInOut;
//                   //           var tween = Tween(
//                   //             begin: begin,
//                   //             end: end,
//                   //           ).chain(CurveTween(curve: curve));
//                   //           var offsetAnimation = animation.drive(tween);
//                   //           return SlideTransition(
//                   //             position: offsetAnimation,
//                   //             child: child,
//                   //           );
//                   //         },
//                   //     transitionDuration: const Duration(milliseconds: 300),
//                   //   ),
//                   // );

//                 },
//                 child: CircleAvatar(
//                   radius: 20,
//                   backgroundColor: const Color(0xFFFFB3BA),
//                   child: Text(
//                     userName[0].toUpperCase(),
//                     style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black87,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 16),
//               const Expanded(
//                 child: TabBar(
//                   isScrollable: false,
//                   labelColor: Colors.black,
//                   unselectedLabelColor: Colors.grey,
//                   indicatorColor: Colors.black,
//                   indicatorWeight: 3,
//                   labelStyle: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                   ),
//                   tabs: [
//                     Tab(text: 'Pins'),
//                     Tab(text: 'Boards'),
//                     Tab(text: 'Collages'),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           actions: [
//             IconButton(
//               icon: const Icon(Icons.add),
//               iconSize: 28,
//               onPressed: () {},
//             ),
//           ],
//           bottom: PreferredSize(
//             preferredSize: const Size.fromHeight(60),
//             child: Padding(
//               padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
//               child: TextField(
//                 decoration: InputDecoration(
//                   hintText: 'Search your Pins',
//                   hintStyle: TextStyle(color: Colors.grey[600]),
//                   prefixIcon: const Icon(Icons.search, color: Colors.grey),
//                   filled: true,
//                   fillColor: Colors.grey[200],
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(30),
//                     borderSide: BorderSide.none,
//                   ),
//                   contentPadding: const EdgeInsets.symmetric(vertical: 0),
//                 ),
//               ),
//             ),
//           ),
//         ),
//         body: TabBarView(
//           children: [
//             _buildEmptyPinsState(context),
//             _buildEmptyBoardsState(context),
//             _buildEmptyCollagesState(context),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildEmptyPinsState(BuildContext context) {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(32),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Colorful jar illustration
//             Container(
//               width: 200,
//               height: 200,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: const Color(0xFFD4F1F4),
//               ),
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   Container(
//                     width: 160,
//                     height: 180,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(80),
//                     ),
//                   ),
//                   // Colorful pins inside jar
//                   Positioned(
//                     child: SizedBox(
//                       width: 140,
//                       height: 140,
//                       child: CustomPaint(painter: ColorfulPinsPainter()),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 32),
//             const Text(
//               'Save what inspires you',
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 12),
//             Text(
//               'Saving Pins is Pinterest\'s superpower. Browse Pins, save what you love, find them here to get inspired all over again.',
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Colors.grey[700],
//                 height: 1.4,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 32),
//             ElevatedButton(
//               onPressed: () {
//                 // TODO: Navigate to explore/home
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFFE60023),
//                 foregroundColor: Colors.white,
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 32,
//                   vertical: 14,
//                 ),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(24),
//                 ),
//                 elevation: 0,
//               ),
//               child: const Text(
//                 'Explore Pins',
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildEmptyBoardsState(BuildContext context) {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(32),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.grid_view_rounded, size: 80, color: Colors.grey[400]),
//             const SizedBox(height: 24),
//             const Text(
//               'No boards yet',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'Create boards to organize your Pins',
//               style: TextStyle(fontSize: 16, color: Colors.grey[600]),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildEmptyCollagesState(BuildContext context) {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(32),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.dashboard_customize_outlined,
//               size: 80,
//               color: Colors.grey[400],
//             ),
//             const SizedBox(height: 24),
//             const Text(
//               'No collages yet',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'Create beautiful collages from your Pins',
//               style: TextStyle(fontSize: 16, color: Colors.grey[600]),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Custom painter for colorful pins illustration
// class ColorfulPinsPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final colors = [
//       const Color(0xFF00CED1), // Cyan
//       const Color(0xFF32CD32), // Green
//       const Color(0xFFFF1493), // Pink
//       const Color(0xFFFF6347), // Red
//       const Color(0xFFFFD700), // Yellow
//       const Color(0xFFFF8C00), // Orange
//     ];

//     final paint = Paint()..style = PaintingStyle.fill;

//     // Draw random colorful pin shapes
//     for (int i = 0; i < 12; i++) {
//       paint.color = colors[i % colors.length];
//       final x = (i % 4) * (size.width / 4) + 10;
//       final y = (i ~/ 4) * (size.height / 3) + 10;

//       // Draw pin shape (simplified)
//       canvas.drawRRect(
//         RRect.fromRectAndRadius(
//           Rect.fromLTWH(x, y, 20, 15),
//           const Radius.circular(3),
//         ),
//         paint,
//       );
//     }
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../controllers/auth_controller.dart';

class SavedScreen extends ConsumerWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);
    final userName = authState.user?.name ?? 'Guest User';

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              GestureDetector(
                onTap: () {
                  context.push('/account-settings');
                },
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: const Color(0xFFFFB3BA),
                  child: Text(
                    userName[0].toUpperCase(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: TabBar(
                  isScrollable: false,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Colors.black,
                  dividerColor: Colors.transparent,
                  indicatorWeight: 3,
                  labelStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  tabs: [
                    Tab(text: 'Pins'),
                    Tab(text: 'Boards'),
                    Tab(text: 'Collages'),
                  ],
                ),
              ),
            ],
          ),
          // actions: [
          //   IconButton(
          //     icon: const Icon(Icons.add),
          //     iconSize: 28,
          //     onPressed: () {},
          //   ),
          // ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search your Pins',
                  hintStyle: TextStyle(color: Colors.grey[600]),
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  filled: true,

                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),

                    // borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                ),
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            _buildEmptyPinsState(context),
            _buildEmptyBoardsState(context),
            _buildEmptyCollagesState(context),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyPinsState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Colorful jar illustration
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFD4F1F4),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 160,
                    height: 180,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(80),
                    ),
                  ),
                  // Colorful pins inside jar
                  Positioned(
                    child: SizedBox(
                      width: 140,
                      height: 140,
                      child: CustomPaint(painter: ColorfulPinsPainter()),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Save what inspires you',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'Saving Pins is Pinterest\'s superpower. Browse Pins, save what you love, find them here to get inspired all over again.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // TODO: Navigate to explore/home
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE60023),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Explore Pins',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyBoardsState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.grid_view_rounded, size: 80, color: Colors.grey[400]),
            const SizedBox(height: 24),
            const Text(
              'No boards yet',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Create boards to organize your Pins',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyCollagesState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.dashboard_customize_outlined,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 24),
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

// Custom painter for colorful pins illustration
class ColorfulPinsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final colors = [
      const Color(0xFF00CED1), // Cyan
      const Color(0xFF32CD32), // Green
      const Color(0xFFFF1493), // Pink
      const Color(0xFFFF6347), // Red
      const Color(0xFFFFD700), // Yellow
      const Color(0xFFFF8C00), // Orange
    ];

    final paint = Paint()..style = PaintingStyle.fill;

    // Draw random colorful pin shapes
    for (int i = 0; i < 12; i++) {
      paint.color = colors[i % colors.length];
      final x = (i % 4) * (size.width / 4) + 10;
      final y = (i ~/ 4) * (size.height / 3) + 10;

      // Draw pin shape (simplified)
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x, y, 20, 15),
          const Radius.circular(3),
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
