import '../../core/constants/api_constants.dart';
import '../../domain/models/photo_model.dart';
import '../../domain/models/photos_response.dart';
import '../services/cache_service.dart';
import '../services/network_service.dart';

class PhotosRepository {
  final NetworkService _networkService;
  final CacheService _cacheService;

  PhotosRepository(this._networkService, this._cacheService);

  Future<List<PhotoModel>> getCuratedPhotos({
    int page = 1,
    int perPage = ApiConstants.perPage,
  }) async {
    final cacheKey = 'curated_$page';

    // Check cache first
    final cachedPhotos = _cacheService.getCachedPhotos(cacheKey);
    if (cachedPhotos != null) {
      return cachedPhotos;
    }

    final response = await _networkService.get(
      ApiConstants.curatedPhotos,
      queryParameters: {'page': page, 'per_page': perPage},
    );

    final photosResponse = PhotosResponse.fromJson(response.data);

    // Cache the results
    _cacheService.cachePhotos(cacheKey, photosResponse.photos);

    return photosResponse.photos;
  }

  Future<List<PhotoModel>> searchPhotos({
    required String query,
    int page = 1,
    int perPage = ApiConstants.perPage,
  }) async {
    final cacheKey = 'search_${query}_$page';

    // Check cache first
    final cachedPhotos = _cacheService.getCachedPhotos(cacheKey);
    if (cachedPhotos != null) {
      return cachedPhotos;
    }

    final response = await _networkService.get(
      ApiConstants.searchPhotos,
      queryParameters: {'query': query, 'page': page, 'per_page': perPage},
    );

    final photosResponse = PhotosResponse.fromJson(response.data);

    // Cache the results
    _cacheService.cachePhotos(cacheKey, photosResponse.photos);

    return photosResponse.photos;
  }

  Future<PhotoModel> getPhotoById(int id) async {
    final response = await _networkService.get(
      '${ApiConstants.photoDetails}/$id',
    );
    return PhotoModel.fromJson(response.data);
  }
}
