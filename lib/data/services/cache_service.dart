import '../../domain/models/photo_model.dart';

class CacheService {
  final Map<String, List<PhotoModel>> _cache = {};
  final Map<String, DateTime> _cacheTime = {};
  final Duration _cacheDuration = const Duration(minutes: 30);

  void cachePhotos(String key, List<PhotoModel> photos) {
    _cache[key] = photos;
    _cacheTime[key] = DateTime.now();
  }

  List<PhotoModel>? getCachedPhotos(String key) {
    if (_cache.containsKey(key)) {
      final cacheTime = _cacheTime[key];
      if (cacheTime != null &&
          DateTime.now().difference(cacheTime) < _cacheDuration) {
        return _cache[key];
      } else {
        _cache.remove(key);
        _cacheTime.remove(key);
      }
    }
    return null;
  }

  void clearCache() {
    _cache.clear();
    _cacheTime.clear();
  }

  void removeCachedPhotos(String key) {
    _cache.remove(key);
    _cacheTime.remove(key);
  }
}
