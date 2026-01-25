// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import '../../domain/models/photo_model.dart';

// class PhotoDetailScreen extends StatelessWidget {
//   final PhotoModel photo;

//   const PhotoDetailScreen({super.key, required this.photo});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomScrollView(
//         slivers: [
//           SliverAppBar(
//             expandedHeight: MediaQuery.of(context).size.height * 0.6,
//             pinned: true,
//             flexibleSpace: FlexibleSpaceBar(
//               background: Hero(
//                 tag: 'photo_${photo.id}',
//                 child: CachedNetworkImage(
//                   imageUrl: photo.src.large2x,
//                   fit: BoxFit.cover,
//                   placeholder: (context, url) =>
//                       Container(color: Colors.grey[300]),
//                   errorWidget: (context, url, error) => const Icon(Icons.error),
//                 ),
//               ),
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   if (photo.alt.isNotEmpty) ...[
//                     Text(
//                       photo.alt,
//                       style: Theme.of(context).textTheme.headlineSmall
//                           ?.copyWith(fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(height: 16),
//                   ],
//                   Row(
//                     children: [
//                       CircleAvatar(
//                         backgroundColor: Colors.grey[300],
//                         child: Text(
//                           photo.photographer[0].toUpperCase(),
//                           style: const TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                       const SizedBox(width: 12),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               photo.photographer,
//                               style: Theme.of(context).textTheme.titleMedium
//                                   ?.copyWith(fontWeight: FontWeight.bold),
//                             ),
//                             Text(
//                               'Photographer',
//                               style: Theme.of(context).textTheme.bodySmall
//                                   ?.copyWith(color: Colors.grey[600]),
//                             ),
//                           ],
//                         ),
//                       ),
//                       ElevatedButton(
//                         onPressed: () {},
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: const Color(0xFFE60023),
//                           foregroundColor: Colors.white,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(24),
//                           ),
//                         ),
//                         child: const Text('Follow'),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 24),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: _ActionButton(
//                           icon: Icons.favorite_border,
//                           label: 'Save',
//                           color: const Color(0xFFE60023),
//                           onPressed: () {},
//                         ),
//                       ),
//                       const SizedBox(width: 8),
//                       Expanded(
//                         child: _ActionButton(
//                           icon: Icons.share,
//                           label: 'Share',
//                           onPressed: () {},
//                         ),
//                       ),
//                       const SizedBox(width: 8),
//                       Expanded(
//                         child: _ActionButton(
//                           icon: Icons.download,
//                           label: 'Download',
//                           onPressed: () {},
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 24),
//                   _InfoCard(
//                     title: 'Photo Details',
//                     items: [
//                       _InfoItem(
//                         label: 'Size',
//                         value: '${photo.width} x ${photo.height}',
//                       ),
//                       _InfoItem(
//                         label: 'Photographer',
//                         value: photo.photographer,
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _ActionButton extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final Color? color;
//   final VoidCallback onPressed;

//   const _ActionButton({
//     required this.icon,
//     required this.label,
//     this.color,
//     required this.onPressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: onPressed,
//       style: ElevatedButton.styleFrom(
//         backgroundColor: color ?? Colors.grey[200],
//         foregroundColor: color != null ? Colors.white : Colors.black87,
//         padding: const EdgeInsets.symmetric(vertical: 12),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [Icon(icon, size: 20), const SizedBox(width: 8), Text(label)],
//       ),
//     );
//   }
// }

// class _InfoCard extends StatelessWidget {
//   final String title;
//   final List<_InfoItem> items;

//   const _InfoCard({required this.title, required this.items});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               title,
//               style: Theme.of(
//                 context,
//               ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 12),
//             ...items.map(
//               (item) => Padding(
//                 padding: const EdgeInsets.only(bottom: 8),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(item.label, style: TextStyle(color: Colors.grey[600])),
//                     Text(
//                       item.value,
//                       style: const TextStyle(fontWeight: FontWeight.w500),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _InfoItem {
//   final String label;
//   final String value;

//   _InfoItem({required this.label, required this.value});
// }



import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import '../../domain/models/photo_model.dart';
import '../controllers/photo_detail_controller.dart';
import '../widgets/shimmer_grid.dart';

class PhotoDetailScreen extends ConsumerStatefulWidget {
  final PhotoModel photo;

  const PhotoDetailScreen({super.key, required this.photo});

  @override
  ConsumerState<PhotoDetailScreen> createState() => _PhotoDetailScreenState();
}

class _PhotoDetailScreenState extends ConsumerState<PhotoDetailScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _showAppBar = true;
  bool _isSaved = false;
  bool _isLiked = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    // Load related photos
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(photoDetailControllerProvider.notifier)
          .loadRelatedPhotos(widget.photo.alt);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.offset > 200 && _showAppBar) {
      setState(() => _showAppBar = false);
    } else if (_scrollController.offset <= 200 && !_showAppBar) {
      setState(() => _showAppBar = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final detailState = ref.watch(photoDetailControllerProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: AnimatedOpacity(
          opacity: _showAppBar ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 200),
          child: AppBar(
            backgroundColor: Colors.black.withOpacity(0.5),
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => context.pop(),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.share, color: Colors.white),
                onPressed: () => _showShareSheet(context),
              ),
            ],
          ),
        ),
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // Full screen image
          SliverToBoxAdapter(
            child: GestureDetector(
              onTap: () => setState(() => _showAppBar = !_showAppBar),
              child: Hero(
                tag: 'photo_${widget.photo.id}',
                child: CachedNetworkImage(
                  imageUrl: widget.photo.src.large2x,
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: Colors.grey[300],
                    height: MediaQuery.of(context).size.height * 0.7,
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey[300],
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: const Icon(Icons.error, size: 64),
                  ),
                ),
              ),
            ),
          ),
          // Action buttons
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: _ActionButton(
                      icon: _isSaved ? Icons.bookmark : Icons.bookmark_border,
                      label: 'Save',
                      color: const Color(0xFFE60023),
                      isSelected: _isSaved,
                      onPressed: () => setState(() => _isSaved = !_isSaved),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _ActionButton(
                      icon: _isLiked ? Icons.favorite : Icons.favorite_border,
                      label: 'Like',
                      isSelected: _isLiked,
                      onPressed: () => setState(() => _isLiked = !_isLiked),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _ActionButton(
                      icon: Icons.comment_outlined,
                      label: 'Comment',
                      onPressed: () => _showComments(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Photo details
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.photo.alt.isNotEmpty) ...[
                    Text(
                      widget.photo.alt,
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    const SizedBox(height: 16),
                  ],
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey[300],
                        child: Text(
                          widget.photo.photographer[0].toUpperCase(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.photo.photographer,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            Text(
                              'Photographer',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: Colors.grey[600],
                                  ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE60023),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: const Text('Follow'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _InfoCard(
                    title: 'Photo Details',
                    items: [
                      _InfoItem(
                          label: 'Size',
                          value: '${widget.photo.width} x ${widget.photo.height}'),
                      _InfoItem(
                          label: 'Photographer',
                          value: widget.photo.photographer),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'More like this',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          // Related photos grid
          if (detailState.isLoading)
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 400,
                child: ShimmerGrid(),
              ),
            )
          else if (detailState.relatedPhotos.isNotEmpty)
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverMasonryGrid.count(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childCount: detailState.relatedPhotos.length,
                itemBuilder: (context, index) {
                  final photo = detailState.relatedPhotos[index];
                  return _RelatedPhotoCard(photo: photo);
                },
              ),
            ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }

  void _showShareSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.copy),
              title: const Text('Copy link'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text('Share to...'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.download),
              title: const Text('Download'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  void _showComments(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Comments',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            const Divider(),
            Expanded(
              child: ListView(
                controller: scrollController,
                padding: const EdgeInsets.all(16),
                children: const [
                  Center(
                    child: Text('No comments yet'),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Add a comment...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {},
                    color: const Color(0xFFE60023),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? color;
  final bool isSelected;
  final VoidCallback onPressed;

  const _ActionButton({
    required this.icon,
    required this.label,
    this.color,
    this.isSelected = false,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor:
            isSelected ? (color ?? const Color(0xFFE60023)) : Colors.grey[200],
        foregroundColor: isSelected ? Colors.white : Colors.black87,
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 8),
          Text(label),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final List<_InfoItem> items;

  const _InfoCard({
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            ...items.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.label,
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    Flexible(
                      child: Text(
                        item.value,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoItem {
  final String label;
  final String value;

  _InfoItem({required this.label, required this.value});
}

class _RelatedPhotoCard extends StatelessWidget {
  final PhotoModel photo;

  const _RelatedPhotoCard({required this.photo});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/photo/${photo.id}', extra: photo),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: CachedNetworkImage(
          imageUrl: photo.src.medium,
          fit: BoxFit.cover,
          placeholder: (context, url) => AspectRatio(
            aspectRatio: photo.width / photo.height,
            child: Container(color: Colors.grey[300]),
          ),
          errorWidget: (context, url, error) => AspectRatio(
            aspectRatio: photo.width / photo.height,
            child: Container(
              color: Colors.grey[300],
              child: const Icon(Icons.error),
            ),
          ),
        ),
      ),
    );
  }
}