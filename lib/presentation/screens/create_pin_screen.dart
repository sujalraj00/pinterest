import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CreatePinScreen extends StatefulWidget {
  const CreatePinScreen({super.key});

  @override
  State<CreatePinScreen> createState() => _CreatePinScreenState();
}

class _CreatePinScreenState extends State<CreatePinScreen> {
  final ImagePicker _imagePicker = ImagePicker();
  List<XFile> _selectedMedia = [];
  int _currentMediaIndex = 0;

  Future<void> _pickMedia(ImageSource source, {bool isVideo = false}) async {
    try {
      if (isVideo) {
        final video = await _imagePicker.pickVideo(source: source);
        if (video != null) {
          setState(() {
            _selectedMedia.add(video);
            _currentMediaIndex = _selectedMedia.length - 1;
          });
        }
      } else {
        final images = await _imagePicker.pickMultiImage();
        if (images.isNotEmpty) {
          setState(() {
            _selectedMedia.addAll(images);
          });
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error picking media: $e')));
    }
  }

  Future<void> _pickFromFile() async {
    try {
      final result = await _imagePicker.pickMedia();
      if (result != null) {
        setState(() {
          _selectedMedia.add(result);
          _currentMediaIndex = _selectedMedia.length - 1;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error picking file: $e')));
    }
  }

  void _removeMedia(int index) {
    setState(() {
      _selectedMedia.removeAt(index);
      if (_currentMediaIndex >= _selectedMedia.length &&
          _selectedMedia.isNotEmpty) {
        _currentMediaIndex = _selectedMedia.length - 1;
      } else if (_selectedMedia.isEmpty) {
        _currentMediaIndex = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create Pin',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
        actions: [
          _selectedMedia.isNotEmpty
              ? TextButton(
                  onPressed: () {
                    // TODO: Implement pin creation logic
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Pin created successfully!'),
                      ),
                    );
                    context.pop();
                  },
                  child: const Text(
                    'Next',
                    style: TextStyle(
                      color: Color(0xFFE60023),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
      body: _selectedMedia.isEmpty
          ? _buildMediaPickerView()
          : _buildMediaDisplayView(),
    );
  }

  Widget _buildMediaPickerView() {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(60),
                ),
                child: const Icon(
                  Icons.add_photo_alternate_outlined,
                  size: 60,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Create a Pin',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Choose images or videos to share ideas',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: Colors.grey[600]),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: () => _pickMedia(ImageSource.gallery),
                  icon: const Icon(Icons.image),
                  label: const Text('Choose from gallery'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE60023),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: () => _pickMedia(ImageSource.camera),
                  icon: const Icon(Icons.camera_alt),
                  label: const Text('Take a photo'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                    foregroundColor: Colors.black87,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: () =>
                      _pickMedia(ImageSource.gallery, isVideo: true),
                  icon: const Icon(Icons.videocam),
                  label: const Text('Choose video'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                    foregroundColor: Colors.black87,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: OutlinedButton.icon(
                  onPressed: _pickFromFile,
                  icon: const Icon(Icons.folder),
                  label: const Text('Choose from files'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black87,
                    side: BorderSide(color: Colors.grey[300]!),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMediaDisplayView() {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            onPageChanged: (index) {
              setState(() {
                _currentMediaIndex = index;
              });
            },
            itemCount: _selectedMedia.length,
            itemBuilder: (context, index) {
              final media = _selectedMedia[index];
              final isVideo =
                  media.path.endsWith('.mp4') ||
                  media.path.endsWith('.mov') ||
                  media.path.endsWith('.avi');

              return Stack(
                children: [
                  Container(
                    color: Colors.black,
                    child: Image.file(File(media.path), fit: BoxFit.contain),
                  ),
                  if (isVideo)
                    const Center(
                      child: Icon(
                        Icons.play_circle_outline,
                        size: 80,
                        color: Colors.white,
                      ),
                    ),
                  Positioned(
                    top: 16,
                    right: 16,
                    child: CircleAvatar(
                      backgroundColor: Colors.black54,
                      child: IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: () => _removeMedia(index),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        if (_selectedMedia.length > 1)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              height: 100,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _selectedMedia.length,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final media = _selectedMedia[index];
                  final isCurrentMedia = index == _currentMediaIndex;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _currentMediaIndex = index;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isCurrentMedia
                              ? const Color(0xFFE60023)
                              : Colors.grey[300]!,
                          width: isCurrentMedia ? 3 : 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Image.file(File(media.path), fit: BoxFit.cover),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              if (_selectedMedia.isNotEmpty)
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: OutlinedButton.icon(
                    onPressed: () => _pickMedia(ImageSource.gallery),
                    icon: const Icon(Icons.add),
                    label: const Text('Add more'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black87,
                      side: BorderSide(color: Colors.grey[300]!),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Navigate to pin details screen
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Proceeding with ${_selectedMedia.length} item(s)',
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE60023),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: const Text(
                    'Next',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
