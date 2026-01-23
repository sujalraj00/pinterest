import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/photos_repository.dart';
import '../../data/services/cache_service.dart';
import '../../data/services/network_service.dart';

// Service Providers
final networkServiceProvider = Provider<NetworkService>((ref) {
  return NetworkService();
});

final cacheServiceProvider = Provider<CacheService>((ref) {
  return CacheService();
});

// Repository Providers
final photosRepositoryProvider = Provider<PhotosRepository>((ref) {
  return PhotosRepository(
    ref.watch(networkServiceProvider),
    ref.watch(cacheServiceProvider),
  );
});
