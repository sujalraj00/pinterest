import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/photo_model.dart';
import '../../data/repositories/photos_repository.dart';
import '../providers/providers.dart';

class SearchState {
  final List<PhotoModel> photos;
  final bool isLoading;
  final bool isLoadingMore;
  final String? error;
  final String query;
  final int currentPage;
  final bool hasMore;

  SearchState({
    this.photos = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.error,
    this.query = '',
    this.currentPage = 1,
    this.hasMore = true,
  });

  SearchState copyWith({
    List<PhotoModel>? photos,
    bool? isLoading,
    bool? isLoadingMore,
    String? error,
    String? query,
    int? currentPage,
    bool? hasMore,
  }) {
    return SearchState(
      photos: photos ?? this.photos,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      error: error,
      query: query ?? this.query,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}

class SearchController extends StateNotifier<SearchState> {
  final PhotosRepository _repository;

  SearchController(this._repository) : super(SearchState());

  Future<void> searchPhotos(String query) async {
    if (query.isEmpty) {
      state = SearchState();
      return;
    }

    if (state.isLoading) return;

    state = state.copyWith(
      isLoading: true,
      error: null,
      query: query,
      photos: [],
      currentPage: 1,
    );

    try {
      final photos = await _repository.searchPhotos(query: query, page: 1);
      state = state.copyWith(
        photos: photos,
        isLoading: false,
        hasMore: photos.length >= 30,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> loadMorePhotos() async {
    if (state.isLoadingMore || !state.hasMore || state.query.isEmpty) return;

    state = state.copyWith(isLoadingMore: true);

    try {
      final nextPage = state.currentPage + 1;
      final newPhotos = await _repository.searchPhotos(
        query: state.query,
        page: nextPage,
      );

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

  void clearSearch() {
    state = SearchState();
  }
}

final searchControllerProvider =
    StateNotifierProvider<SearchController, SearchState>((ref) {
      return SearchController(ref.watch(photosRepositoryProvider));
    });
