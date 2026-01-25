import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/repositories/photos_repository.dart';
import '../../data/services/auth_service.dart';
import '../../data/services/cache_service.dart';
import '../../data/services/network_service.dart';

// Service Providers
final networkServiceProvider = Provider<NetworkService>((ref) {
  return NetworkService();
});

final cacheServiceProvider = Provider<CacheService>((ref) {
  return CacheService();
});

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('SharedPreferences must be initialized');
});

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(ref.watch(sharedPreferencesProvider));
});

// Repository Providers
final photosRepositoryProvider = Provider<PhotosRepository>((ref) {
  return PhotosRepository(
    ref.watch(networkServiceProvider),
    ref.watch(cacheServiceProvider),
  );
});
