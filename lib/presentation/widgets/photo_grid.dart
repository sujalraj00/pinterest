// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:go_router/go_router.dart';
// import '../../domain/models/photo_model.dart';

// class PhotoGrid extends StatelessWidget {
//   final List<PhotoModel> photos;
//   final ScrollController? scrollController;
//   final bool isLoadingMore;

//   const PhotoGrid({
//     super.key,
//     required this.photos,
//     this.scrollController,
//     this.isLoadingMore = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return CustomScrollView(
//       controller: scrollController,
//       slivers: [
//         SliverPadding(
//           padding: const EdgeInsets.all(8),
//           sliver: SliverMasonryGrid.count(
//             crossAxisCount: 2,
//             mainAxisSpacing: 8,
//             crossAxisSpacing: 8,
//             childCount: photos.length,
//             itemBuilder: (context, index) {
//               final photo = photos[index];
//               return PhotoCard(photo: photo);
//             },
//           ),
//         ),
//         if (isLoadingMore)
//           const SliverToBoxAdapter(
//             child: Center(
//               child: Padding(
//                 padding: EdgeInsets.all(16),
//                 child: CircularProgressIndicator(),
//               ),
//             ),
//           ),
//       ],
//     );
//   }
// }

// class PhotoCard extends StatelessWidget {
//   final PhotoModel photo;

//   const PhotoCard({super.key, required this.photo});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => context.push('/photo/${photo.id}', extra: photo),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(16),
//         child: Stack(
//           children: [
//             Hero(
//               tag: 'photo_${photo.id}',
//               child: CachedNetworkImage(
//                 imageUrl: photo.src.medium,
//                 fit: BoxFit.cover,
//                 placeholder: (context, url) => AspectRatio(
//                   aspectRatio: photo.width / photo.height,
//                   child: Container(color: Colors.grey[300]),
//                 ),
//                 errorWidget: (context, url, error) => AspectRatio(
//                   aspectRatio: photo.width / photo.height,
//                   child: Container(
//                     color: Colors.grey[300],
//                     child: const Icon(Icons.error),
//                   ),
//                 ),
//               ),
//             ),
//             Positioned(
//               top: 8,
//               right: 8,
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: const Color(0xFFE60023),
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//                 child: IconButton(
//                   icon: const Icon(Icons.favorite_border, color: Colors.white),
//                   onPressed: () {},
//                   iconSize: 15,
//                   //padding: const EdgeInsets.all(8),
//                   //  constraints: const BoxConstraints(),
//                 ),
//               ),
//             ),
//             Positioned(
//               bottom: 0,
//               left: 0,
//               right: 0,
//               child: Container(
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.bottomCenter,
//                     end: Alignment.topCenter,
//                     colors: [Colors.black.withOpacity(0.7), Colors.transparent],
//                   ),
//                 ),
//                 padding: const EdgeInsets.all(12),
//                 child: Text(
//                   photo.photographer,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 12,
//                     fontWeight: FontWeight.w500,
//                   ),
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import '../../domain/models/photo_model.dart';
import 'pin_options_overlay.dart';

class PhotoGrid extends StatelessWidget {
  final List<PhotoModel> photos;
  final ScrollController? scrollController;
  final bool isLoadingMore;

  const PhotoGrid({
    super.key,
    required this.photos,
    this.scrollController,
    this.isLoadingMore = false,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        // SliverAppBar(
        //   pinned: true,
        //   // title: Text('sdfghj'),
        //   leadingWidth: 100,
        //   leading: Text(
        //     'For you',
        //     style: TextStyle(
        //       fontWeight: FontWeight.w500,
        //       fontSize: 18,
        //       decoration: TextDecoration.underline,
        //     ),
        //   ),
        // ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 3),
          sliver: SliverMasonryGrid.count(
            crossAxisCount: 2,
            mainAxisSpacing: 2,
            crossAxisSpacing: 5,
            childCount: photos.length,
            itemBuilder: (context, index) {
              final photo = photos[index];
              return PhotoCard(photo: photo);
            },
          ),
        ),
        if (isLoadingMore)
          const SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator(),
              ),
            ),
          ),
      ],
    );
  }
}

class PhotoCard extends StatelessWidget {
  final PhotoModel photo;

  const PhotoCard({super.key, required this.photo});

  void _showPinOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => PinOptionsOverlay(photo: photo),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/photo/${photo.id}', extra: photo),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: [
                Hero(
                  tag: 'photo_${photo.id}',
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
                // Positioned(
                //   bottom: 8,
                //   left: 8,
                //   right: 8,
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       // Save button
                //       Container(
                //         decoration: BoxDecoration(
                //           color: const Color(0xFFE60023),
                //           borderRadius: BorderRadius.circular(20),
                //         ),
                //         child: Material(
                //           color: Colors.transparent,
                //           child: InkWell(
                //             onTap: () {
                //               // TODO: Implement save functionality
                //               ScaffoldMessenger.of(context).showSnackBar(
                //                 const SnackBar(
                //                   content: Text('Saved to board'),
                //                   duration: Duration(seconds: 1),
                //                 ),
                //               );
                //             },
                //             borderRadius: BorderRadius.circular(20),
                //             child: const Padding(
                //               padding: EdgeInsets.symmetric(
                //                 horizontal: 16,
                //                 vertical: 8,
                //               ),
                //               child: Text(
                //                 'Save',
                //                 style: TextStyle(
                //                   color: Colors.white,
                //                   fontWeight: FontWeight.w600,
                //                   fontSize: 14,
                //                 ),
                //               ),
                //             ),
                //           ),
                //         ),
                //       ),
                //       // Three dots menu
                //       Container(
                //         decoration: BoxDecoration(
                //           color: Colors.white,
                //           borderRadius: BorderRadius.circular(20),
                //         ),
                //         child: Material(
                //           color: Colors.transparent,
                //           child: InkWell(
                //             onTap: () => _showPinOptions(context),
                //             borderRadius: BorderRadius.circular(20),
                //             child: const Padding(
                //               padding: EdgeInsets.all(8),
                //               child: Icon(
                //                 Icons.more_horiz,
                //                 size: 20,
                //                 color: Colors.black87,
                //               ),
                //             ),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
          const SizedBox(height: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 4),
              //   child: Text(
              //     photo.photographer,
              //     style: const TextStyle(
              //       fontSize: 12,
              //       fontWeight: FontWeight.w500,
              //     ),
              //     maxLines: 1,
              //     overflow: TextOverflow.ellipsis,
              //   ),
              // ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => _showPinOptions(context),
                    borderRadius: BorderRadius.circular(20),
                    child: const Padding(
                      padding: EdgeInsets.all(3),
                      child: Icon(
                        Icons.more_horiz,
                        size: 20,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
