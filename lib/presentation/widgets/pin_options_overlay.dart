import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../domain/models/photo_model.dart';

class PinOptionsOverlay extends StatelessWidget {
  final PhotoModel photo;

  const PinOptionsOverlay({super.key, required this.photo});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final imageHeight = screenHeight * 0.35;

    return Stack(
      children: [
        // Bottom sheet overlay
        Positioned(
          top: 500,
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Drag handle
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.cancel_outlined),
                ),

                // SizedBox(height: imageHeight / 2 + 20),
                // Options list
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        SizedBox(height: 15),
                        Text('This pin is inspired by your recent activity'),
                        SizedBox(height: 15),
                        // _OptionTile(
                        //   icon: Icons.download_outlined,
                        //   title: 'Download image',
                        //   subtitle: 'Save to your device',
                        //   onTap: () {
                        //     Navigator.pop(context);
                        //     ScaffoldMessenger.of(context).showSnackBar(
                        //       const SnackBar(
                        //         content: Text('Downloading...'),
                        //         duration: Duration(seconds: 2),
                        //       ),
                        //     );
                        //   },
                        // ),
                        // const Divider(height: 1),
                        // _OptionTile(
                        //   icon: Icons.bookmark_outline,
                        //   title: 'Save to board',
                        //   subtitle: 'Add to your collection',
                        //   onTap: () {
                        //     Navigator.pop(context);
                        //     _showBoardSelector(context);
                        //   },
                        // ),
                        // const Divider(height: 1),
                        // _OptionTile(
                        //   icon: Icons.share_outlined,
                        //   title: 'Share',
                        //   subtitle: 'Send to friends',
                        //   onTap: () {
                        //     Navigator.pop(context);
                        //     _showShareSheet(context);
                        //   },
                        // ),
                        // const Divider(height: 1),
                        // _OptionTile(
                        //   icon: Icons.link_outlined,
                        //   title: 'Copy link',
                        //   subtitle: 'Share via link',
                        //   onTap: () {
                        //     Navigator.pop(context);
                        //     ScaffoldMessenger.of(context).showSnackBar(
                        //       const SnackBar(
                        //         content: Text('Link copied to clipboard'),
                        //         duration: Duration(seconds: 2),
                        //       ),
                        //     );
                        //   },
                        // ),
                        // const Divider(height: 1),
                        // _OptionTile(
                        //   icon: Icons.hide_source_outlined,
                        //   title: 'Hide Pin',
                        //   subtitle: 'See fewer Pins like this',
                        //   onTap: () {
                        //     Navigator.pop(context);
                        //     ScaffoldMessenger.of(context).showSnackBar(
                        //       const SnackBar(
                        //         content: Text('Pin hidden'),
                        //         duration: Duration(seconds: 2),
                        //       ),
                        //     );
                        //   },
                        // ),
                        // const Divider(height: 1),
                        // _OptionTile(
                        //   icon: Icons.report_outlined,
                        //   title: 'Report Pin',
                        //   subtitle: 'Report inappropriate content',
                        //   isDestructive: true,
                        //   onTap: () {
                        //     Navigator.pop(context);
                        //     _showReportDialog(context);
                        //   },
                        // ),
                        _bottomCardText(Icons.pin_drop_outlined, 'Save'),
                        SizedBox(height: 12),
                        _bottomCardText(Icons.share, 'Share'),
                        SizedBox(height: 12),
                        _bottomCardText(Icons.download, 'Download'),
                        SizedBox(height: 12),
                        _bottomCardText(
                          Icons.heart_broken_outlined,
                          'See more like this',
                        ),
                        SizedBox(height: 12),
                        _bottomCardText(
                          Icons.remove_red_eye_outlined,
                          'See less like this',
                        ),
                        SizedBox(height: 12),
                        _bottomCardText(
                          Icons.block,
                          'Report',
                          'This goes against Pinterest\'s community guidelines',
                        ),
                        // const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        Positioned(
          top: 360,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              // width: 200,

              //  height: imageHeight * 0.7,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.black.withOpacity(0.3),
                //     blurRadius: 20,
                //     spreadRadius: 5,
                //   ),
                // ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CachedNetworkImage(
                  width: 110,
                  height: 200,

                  imageUrl: photo.src.medium,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      Container(color: Colors.grey[300]),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey[300],
                    child: const Icon(Icons.error),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _bottomCardText(IconData icon, String text, [String? desc]) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 24),
        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (desc != null)
                Padding(
                  padding: const EdgeInsets.only(top: 3, right: 5),
                  child: Text(
                    desc,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,

                    style: const TextStyle(fontSize: 15, color: Colors.black54),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  void _showBoardSelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Save to board',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.add),
              ),
              title: const Text('Create new board'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.favorite_outline),
              ),
              title: const Text('Favorites'),
              subtitle: const Text('5 Pins'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  void _showShareSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Share Pin',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _ShareOption(
                  icon: Icons.message_outlined,
                  label: 'Message',
                  onTap: () => Navigator.pop(context),
                ),
                _ShareOption(
                  icon: Icons.email_outlined,
                  label: 'Email',
                  onTap: () => Navigator.pop(context),
                ),
                _ShareOption(
                  icon: Icons.facebook_outlined,
                  label: 'Facebook',
                  onTap: () => Navigator.pop(context),
                ),
                _ShareOption(
                  icon: Icons.more_horiz,
                  label: 'More',
                  onTap: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _showReportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Report Pin'),
        content: const Text('Why are you reporting this Pin?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Report submitted')));
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Report'),
          ),
        ],
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isDestructive;
  final VoidCallback onTap;

  const _OptionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.isDestructive = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isDestructive ? Colors.red : Colors.black87;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8),
      leading: Icon(icon, color: color, size: 28),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: color,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 14,
          color: isDestructive ? Colors.red[300] : Colors.grey[600],
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.grey[400],
      ),
      onTap: onTap,
    );
  }
}

class _ShareOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ShareOption({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(30),
              ),
              child: Icon(icon, size: 30),
            ),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
