import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/photo_model.dart';
import '../../data/repositories/photos_repository.dart';
import '../providers/providers.dart';

class PhotoDetailState {
  final List<PhotoModel> relatedPhotos;
  final bool isLoading;
  final String? error;

  PhotoDetailState({
    this.relatedPhotos = const [],
    this.isLoading = false,
    this.error,
  });

  PhotoDetailState copyWith({
    List<PhotoModel>? relatedPhotos,
    bool? isLoading,
    String? error,
  }) {
    return PhotoDetailState(
      relatedPhotos: relatedPhotos ?? this.relatedPhotos,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class PhotoDetailController extends StateNotifier<PhotoDetailState> {
  final PhotosRepository _repository;

  PhotoDetailController(this._repository) : super(PhotoDetailState());

  Future<void> loadRelatedPhotos(String query) async {
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true, error: null);

    try {
      // Search for related photos based on the current photo's alt text
      final searchQuery = query.isNotEmpty ? query : 'nature';
      final photos = await _repository.searchPhotos(
        query: searchQuery,
        page: 1,
        perPage: 20,
      );

      state = state.copyWith(relatedPhotos: photos, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void reset() {
    state = PhotoDetailState();
  }
}

final photoDetailControllerProvider =
    StateNotifierProvider<PhotoDetailController, PhotoDetailState>((ref) {
      return PhotoDetailController(ref.watch(photosRepositoryProvider));
    });
