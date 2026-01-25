// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import '../controllers/home_controller.dart';
// import '../widgets/photo_grid.dart';
// import '../widgets/shimmer_grid.dart';

// class HomeScreen extends ConsumerStatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   ConsumerState<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends ConsumerState<HomeScreen> {
//   final ScrollController _scrollController = ScrollController();

//   @override
//   void initState() {
//     super.initState();
//     _scrollController.addListener(_onScroll);
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }

//   void _onScroll() {
//     if (_scrollController.position.pixels >=
//         _scrollController.position.maxScrollExtent * 0.8) {
//       ref.read(homeControllerProvider.notifier).loadMorePhotos();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final state = ref.watch(homeControllerProvider);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Pinterest',
//           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.search),
//             onPressed: () => context.push('/search'),
//           ),
//           IconButton(
//             icon: const Icon(Icons.person_outline),
//             onPressed: () => context.push('/profile'),
//           ),
//         ],
//       ),
//       body: RefreshIndicator(
//         onRefresh: () => ref.read(homeControllerProvider.notifier).refresh(),
//         child: state.isLoading && state.photos.isEmpty
//             ? const ShimmerGrid()
//             : state.error != null && state.photos.isEmpty
//             ? Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Icon(
//                       Icons.error_outline,
//                       size: 64,
//                       color: Colors.grey,
//                     ),
//                     const SizedBox(height: 16),
//                     Text(
//                       'Error loading photos',
//                       style: Theme.of(context).textTheme.titleMedium,
//                     ),
//                     const SizedBox(height: 8),
//                     ElevatedButton(
//                       onPressed: () =>
//                           ref.read(homeControllerProvider.notifier).refresh(),
//                       child: const Text('Retry'),
//                     ),
//                   ],
//                 ),
//               )
//             : PhotoGrid(
//                 photos: state.photos,
//                 scrollController: _scrollController,
//                 isLoadingMore: state.isLoadingMore,
//               ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/home_controller.dart';
import '../widgets/photo_grid.dart';
import '../widgets/shimmer_grid.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      ref.read(homeControllerProvider.notifier).loadMorePhotos();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeControllerProvider);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 30,
        title: const Text(
          'For you',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18,
            decoration: TextDecoration.underline,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.read(homeControllerProvider.notifier).refresh(),
        child: state.isLoading && state.photos.isEmpty
            ? const ShimmerGrid()
            : state.error != null && state.photos.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Error loading photos',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () =>
                          ref.read(homeControllerProvider.notifier).refresh(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              )
            : PhotoGrid(
                photos: state.photos,
                scrollController: _scrollController,
                isLoadingMore: state.isLoadingMore,
              ),
      ),
    );
  }
}
