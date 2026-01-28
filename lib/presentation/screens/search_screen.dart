import 'dart:ui';
import 'package:flutter/material.dart';
import '../controllers/search_controller.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../widgets/photo_grid.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late PageController _bannerController;
  late PageController _carouselController;
  int _currentCarouselIndex = 0;
  double _scrollOffset = 0;

  final List<Map<String, String>> _featuredBoards = [
    {
      'title': 'Paper flower DIYs',
      'subtitle': 'Start a new hobby',
      'image':
          'https://images.pexels.com/photos/1070850/pexels-photo-1070850.jpeg',
    },
    {
      'title': 'Home office ideas',
      'subtitle': 'Work from home in style',
      'image':
          'https://images.pexels.com/photos/667838/pexels-photo-667838.jpeg',
    },
    {
      'title': 'Fashion inspiration',
      'subtitle': 'Elevate your style',
      'image':
          'https://images.pexels.com/photos/1926769/pexels-photo-1926769.jpeg',
    },
  ];

  final List<Map<String, dynamic>> _recommendedBoards = [
    {
      'title': 'Retrofuturism aesthetics',
      'category': 'Aesthetics',
      'verified': true,
      'pins': 64,
      'time': '3mo',
      'images': [
        'https://images.pexels.com/photos/2387873/pexels-photo-2387873.jpeg',
        'https://images.pexels.com/photos/3861969/pexels-photo-3861969.jpeg',
      ],
    },
    {
      'title': 'Kitchen countertop styling',
      'category': 'Home Decor',
      'verified': true,
      'pins': 63,
      'time': '4mo',
      'images': [
        'https://images.pexels.com/photos/1457842/pexels-photo-1457842.jpeg',
        'https://images.pexels.com/photos/1599791/pexels-photo-1599791.jpeg',
      ],
    },
  ];

  final double _bannerHeight = 380;

  final List<String> _bannerImages = [
    'https://images.pexels.com/photos/1070850/pexels-photo-1070850.jpeg',
    'https://images.pexels.com/photos/667838/pexels-photo-667838.jpeg',
    'https://images.pexels.com/photos/1926769/pexels-photo-1926769.jpeg',
  ];

  final List<String> _photos = [
    'https://images.pexels.com/photos/167832/pexels-photo-167832.jpeg',
    'https://images.pexels.com/photos/34950/pexels-photo.jpg',
    'https://images.pexels.com/photos/248797/pexels-photo-248797.jpeg',
    'https://images.pexels.com/photos/212372/pexels-photo-212372.jpeg',
    'https://images.pexels.com/photos/1252869/pexels-photo-1252869.jpeg',
    'https://images.pexels.com/photos/707046/pexels-photo-707046.jpeg',
  ];
  @override
  void initState() {
    super.initState();
    _bannerController = PageController();
    _carouselController = PageController();

    _scrollController.addListener(() {
      setState(() {
        _scrollOffset = _scrollController.offset;
      });

      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent * 0.8) {
        ref.read(searchControllerProvider.notifier).loadMorePhotos();
      }
    });

    _bannerController.addListener(() {
      int next = _bannerController.page!.round();
      if (_currentCarouselIndex != next) {
        setState(() {
          _currentCarouselIndex = next;
        });
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    _carouselController.dispose();
    _bannerController.dispose();
    super.dispose();
  }

  void _performSearch(String query) {
    if (query.isNotEmpty) {
      ref.read(searchControllerProvider.notifier).searchPhotos(query);
    }
  }

  Widget _buildExploreContent() {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _bannerImages.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentCarouselIndex == index
                        ? Colors.black
                        : Colors.grey[400],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Explore featured boards',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Ideas you might like',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          SizedBox(
            height: 280,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: _recommendedBoards.length,
              itemBuilder: (context, index) {
                final board = _recommendedBoards[index];
                return _BoardCard(board: board);
              },
            ),
          ),
          const SizedBox(height: 32),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Ideas for you',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Photography',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(searchControllerProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            state.query.isEmpty
                ? _buildScrollableContent()
                : _buildSearchResults(state),
            _buildPinterestSearchBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildScrollableContent() {
    return Positioned.fill(
      child: SingleChildScrollView(
        controller: _scrollController,
        padding: const EdgeInsets.only(top: 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBanner(),
            const SizedBox(height: 24),
            _buildExploreContent(),
            _buildCategorySection('Middle east', [
              'https://images.pexels.com/photos/3573351/pexels-photo-3573351.jpeg',
              'https://images.pexels.com/photos/1103970/pexels-photo-1103970.jpeg',
              'https://images.pexels.com/photos/3842632/pexels-photo-3842632.jpeg',
              'https://images.pexels.com/photos/2398220/pexels-photo-2398220.jpeg',
            ]),
            const SizedBox(height: 32),
            _buildCategorySection('Travel', [
              'https://images.pexels.com/photos/1619317/pexels-photo-1619317.jpeg',
              'https://images.pexels.com/photos/1066029/pexels-photo-1066029.jpeg',
              'https://images.pexels.com/photos/1680140/pexels-photo-1680140.jpeg',
              'https://images.pexels.com/photos/1619348/pexels-photo-1619348.jpeg',
            ]),
            const SizedBox(height: 32),
            _buildCategorySection('Cell phones and accessories', [
              'https://images.pexels.com/photos/699122/pexels-photo-699122.jpeg',
              'https://images.pexels.com/photos/699122/pexels-photo-699122.jpeg',
              'https://images.pexels.com/photos/699122/pexels-photo-699122.jpeg',
              'https://images.pexels.com/photos/699122/pexels-photo-699122.jpeg',
            ]),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildBanner() {
    return SizedBox(
      height: _bannerHeight,
      child: PageView.builder(
        controller: _bannerController,
        itemCount: _bannerImages.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(_bannerImages[index], fit: BoxFit.cover),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSearchResults(SearchState state) {
    final baseQuery = state.query.split(' ').first;

    return Positioned.fill(
      child: Column(
        children: [
          SizedBox(height: 70),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Row(
              children: [
                _buildFilterChip('Cute', baseQuery, state.query),
                const SizedBox(width: 8),
                _buildFilterChip('Tattoo', baseQuery, state.query),
                const SizedBox(width: 8),
                _buildFilterChip('Drawing', baseQuery, state.query),
                const SizedBox(width: 8),
                _buildFilterChip('Bulk', baseQuery, state.query),
              ],
            ),
          ),

          Expanded(
            child: state.isLoading && state.photos.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : state.photos.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No results found for "${state.query}"',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
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
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, String baseQuery, String fullQuery) {
    final queryParts = fullQuery.trim().split(' ');
    final selectedChip = queryParts.length > 1 ? queryParts.last : '';

    final isSelected = selectedChip.toLowerCase() == label.toLowerCase();

    return GestureDetector(
      onTap: () {
        final displayQuery = isSelected
            ? baseQuery
            : '$baseQuery $label'.trim();

        final apiQuery = baseQuery;

        if (apiQuery.isNotEmpty) {
          _searchController.text = displayQuery;

          ref.read(searchControllerProvider.notifier).searchPhotos(apiQuery);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.grey[800] : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildMasonryGrid() {
    // Staggered heights for Pinterest-like appearance
    final List<double> heights = [250, 300, 200, 280, 220, 290];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: MasonryGridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _photos.length,
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              height: heights[index % heights.length],
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Image.network(_photos[index], fit: BoxFit.cover),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPinterestSearchBar() {
    final state = ref.watch(searchControllerProvider);
    final hasActiveSearch = state.query.isNotEmpty;

    final double progress = (_scrollOffset / _bannerHeight).clamp(0.0, 1.0);

    double blurAmount = 0.0;
    if (progress >= 0.2) {
      blurAmount = ((progress - 0.2) / 0.3) * 20;
      blurAmount = blurAmount.clamp(0.0, 20.0);
    }

    final Color backgroundColor = hasActiveSearch
        ? Colors.white
        : (progress < 0.05 ? Colors.white.withOpacity(0.0) : Colors.white);

    final Color borderColor = Color.lerp(
      Colors.white.withOpacity(0.0),
      Colors.grey.shade300,
      progress,
    )!;

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurAmount, sigmaY: blurAmount),
          child: Container(
            padding: hasActiveSearch
                ? const EdgeInsets.fromLTRB(8, 12, 12, 12)
                : const EdgeInsets.fromLTRB(12, 12, 12, 12),
            decoration: BoxDecoration(
              color: backgroundColor,
              border: Border(bottom: BorderSide(color: borderColor)),
            ),
            child: Row(
              children: [
                // Back button - only show when search is active
                if (hasActiveSearch)
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      // Clear search and go back to explore view
                      _searchController.clear();
                      ref.read(searchControllerProvider.notifier).clearSearch();
                      setState(() {});
                    },
                  ),
                // Search field
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search for ideas',
                      prefixIcon: hasActiveSearch
                          ? null
                          : const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.grey[200]!.withOpacity(
                        progress > 0.1 ? 1 : 0.6,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                      suffixIcon: hasActiveSearch
                          ? IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                _searchController.clear();
                                ref
                                    .read(searchControllerProvider.notifier)
                                    .clearSearch();
                                setState(() {});
                              },
                            )
                          : null,
                    ),
                    onSubmitted: (query) {
                      if (query.isNotEmpty) {
                        ref
                            .read(searchControllerProvider.notifier)
                            .searchPhotos(query);
                      }
                    },
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),
                // Camera button - only show when not searching
                if (!hasActiveSearch)
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200]!.withOpacity(
                          progress > 0.1 ? 1 : 0.6,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.camera_alt_outlined),
                        onPressed: () {},
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategorySection(String categoryTitle, List<String> imageUrls) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header with title and search icon
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Ideas for you',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    categoryTitle,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  icon: const Icon(Icons.search, color: Colors.grey),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // 2x2 Grid of images
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 1.0,
            children: List.generate(
              imageUrls.length > 4 ? 4 : imageUrls.length,
              (index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(imageUrls[index], fit: BoxFit.cover),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        text,
        style: const TextStyle(fontSize: 14, color: Colors.grey),
      ),
    );
  }

  Widget _sectionBigTitle(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        text,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _BoardCard extends StatelessWidget {
  final Map<String, dynamic> board;

  const _BoardCard({required this.board});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.go('/board-detail', extra: board);
      },
      child: Container(
        width: 240,
        margin: const EdgeInsets.only(right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Board preview images
            SizedBox(
              height: 180,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      ),
                      child: Image.network(
                        board['images'][0],
                        fit: BoxFit.cover,
                        height: double.infinity,
                      ),
                    ),
                  ),
                  const SizedBox(width: 2),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                      child: Image.network(
                        board['images'][1],
                        fit: BoxFit.cover,
                        height: double.infinity,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // Board title
            Text(
              board['title'],
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),

            Row(
              children: [
                Text(
                  board['category'],
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
                if (board['verified']) ...[
                  const SizedBox(width: 4),
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: Color(0xFFE60023),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      size: 12,
                      color: Colors.white,
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 4),
            // Pins count and time
            Text(
              '${board['pins']} Pins · ${board['time']}',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}
