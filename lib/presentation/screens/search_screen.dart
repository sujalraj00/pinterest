// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../controllers/search_controller.dart';
// import '../widgets/photo_grid.dart';
// import '../widgets/shimmer_grid.dart';

// class SearchScreen extends ConsumerStatefulWidget {
//   const SearchScreen({super.key});

//   @override
//   ConsumerState<SearchScreen> createState() => _SearchScreenState();
// }

// class _SearchScreenState extends ConsumerState<SearchScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   final ScrollController _scrollController = ScrollController();
//   final List<String> _suggestions = [
//     'Nature',
//     'Travel',
//     'Food',
//     'Animals',
//     'Architecture',
//     'Fashion',
//     'Art',
//     'Technology',
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _scrollController.addListener(_onScroll);
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     _scrollController.dispose();
//     super.dispose();
//   }

//   void _onScroll() {
//     if (_scrollController.position.pixels >=
//         _scrollController.position.maxScrollExtent * 0.8) {
//       ref.read(searchControllerProvider.notifier).loadMorePhotos();
//     }
//   }

//   void _performSearch(String query) {
//     if (query.isNotEmpty) {
//       ref.read(searchControllerProvider.notifier).searchPhotos(query);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final state = ref.watch(searchControllerProvider);

//     return Scaffold(
//       appBar: AppBar(
//         title: TextField(
//           controller: _searchController,
//           autofocus: true,
//           decoration: InputDecoration(
//             hintText: 'Search for ideas',
//             border: InputBorder.none,
//             suffixIcon: _searchController.text.isNotEmpty
//                 ? IconButton(
//                     icon: const Icon(Icons.clear),
//                     onPressed: () {
//                       _searchController.clear();
//                       ref.read(searchControllerProvider.notifier).clearSearch();
//                       setState(() {});
//                     },
//                   )
//                 : null,
//           ),
//           onSubmitted: _performSearch,
//           onChanged: (value) => setState(() {}),
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.search),
//             onPressed: () => _performSearch(_searchController.text),
//           ),
//         ],
//       ),
//       body: state.query.isEmpty
//           ? _buildSuggestions()
//           : state.isLoading && state.photos.isEmpty
//           ? const ShimmerGrid()
//           : state.error != null && state.photos.isEmpty
//           ? Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Icon(Icons.error_outline, size: 64, color: Colors.grey),
//                   const SizedBox(height: 16),
//                   Text(
//                     'Error searching photos',
//                     style: Theme.of(context).textTheme.titleMedium,
//                   ),
//                 ],
//               ),
//             )
//           : state.photos.isEmpty
//           ? Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Icon(Icons.search_off, size: 64, color: Colors.grey),
//                   const SizedBox(height: 16),
//                   Text(
//                     'No results found',
//                     style: Theme.of(context).textTheme.titleMedium,
//                   ),
//                 ],
//               ),
//             )
//           : PhotoGrid(
//               photos: state.photos,
//               scrollController: _scrollController,
//               isLoadingMore: state.isLoadingMore,
//             ),
//     );
//   }

//   Widget _buildSuggestions() {
//     return Padding(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Popular searches',
//             style: Theme.of(
//               context,
//             ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 16),
//           Wrap(
//             spacing: 8,
//             runSpacing: 8,
//             children: _suggestions.map((suggestion) {
//               return ActionChip(
//                 label: Text(suggestion),
//                 onPressed: () {
//                   _searchController.text = suggestion;
//                   _performSearch(suggestion);
//                 },
//               );
//             }).toList(),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/search_controller.dart';
import '../widgets/photo_grid.dart';
import '../widgets/shimmer_grid.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<String> _suggestions = [
    'Nature',
    'Travel',
    'Food',
    'Animals',
    'Architecture',
    'Fashion',
    'Art',
    'Technology',
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      ref.read(searchControllerProvider.notifier).loadMorePhotos();
    }
  }

  void _performSearch(String query) {
    if (query.isNotEmpty) {
      ref.read(searchControllerProvider.notifier).searchPhotos(query);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(searchControllerProvider);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search for ideas',
            prefixIcon: const Icon(Icons.search),
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      ref.read(searchControllerProvider.notifier).clearSearch();
                      setState(() {});
                    },
                  )
                : null,
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 0),
          ),
          onSubmitted: _performSearch,
          onChanged: (value) => setState(() {}),
        ),
      ),
      body: state.query.isEmpty
          ? _buildSuggestions()
          : state.isLoading && state.photos.isEmpty
          ? const ShimmerGrid()
          : state.error != null && state.photos.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text(
                    'Error searching photos',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            )
          : state.photos.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.search_off, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text(
                    'No results found',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            )
          : PhotoGrid(
              photos: state.photos,
              scrollController: _scrollController,
              isLoadingMore: state.isLoadingMore,
            ),
    );
  }

  Widget _buildSuggestions() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Popular searches',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _suggestions.map((suggestion) {
              return ActionChip(
                label: Text(suggestion),
                onPressed: () {
                  _searchController.text = suggestion;
                  _performSearch(suggestion);
                },
                backgroundColor: Colors.grey[200],
                side: BorderSide.none,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
