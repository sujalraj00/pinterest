import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/photo_model.dart';
import '../../data/repositories/photos_repository.dart';
import '../providers/providers.dart';

class HomeState {
  final List<PhotoModel> photos;
  final bool isLoading;
  final bool isLoadingMore;
  final String? error;
  final int currentPage;
  final bool hasMore;

  HomeState({
    this.photos = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.error,
    this.currentPage = 1,
    this.hasMore = true,
  });

  HomeState copyWith({
    List<PhotoModel>? photos,
    bool? isLoading,
    bool? isLoadingMore,
    String? error,
    int? currentPage,
    bool? hasMore,
  }) {
    return HomeState(
      photos: photos ?? this.photos,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      error: error,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}

class HomeController extends StateNotifier<HomeState> {
  final PhotosRepository _repository;

  HomeController(this._repository) : super(HomeState()) {
    loadPhotos();
  }

  Future<void> loadPhotos() async {
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true, error: null);

    try {
      final photos = await _repository.getCuratedPhotos(page: 1);
      state = state.copyWith(
        photos: photos,
        isLoading: false,
        currentPage: 1,
        hasMore: photos.length >= 30,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> loadMorePhotos() async {
    if (state.isLoadingMore || !state.hasMore) return;

    state = state.copyWith(isLoadingMore: true);

    try {
      final nextPage = state.currentPage + 1;
      final newPhotos = await _repository.getCuratedPhotos(page: nextPage);

      state = state.copyWith(
        photos: [...state.photos, ...newPhotos],
        isLoadingMore: false,
        currentPage: nextPage,
        hasMore: newPhotos.length >= 30,
      );
    } catch (e) {
      state = state.copyWith(isLoadingMore: false, error: e.toString());
    }
  }

  Future<void> refresh() async {
    state = HomeState();
    await loadPhotos();
  }
}

final homeControllerProvider = StateNotifierProvider<HomeController, HomeState>(
  (ref) {
    return HomeController(ref.watch(photosRepositoryProvider));
  },
);
