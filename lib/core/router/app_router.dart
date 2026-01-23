import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/models/photo_model.dart';
import '../../presentation/screens/home_screen.dart';
import '../../presentation/screens/search_screen.dart';
import '../../presentation/screens/photo_detail_screen.dart';
import '../../presentation/screens/profile_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        pageBuilder: (context, state) =>
            const MaterialPage(child: HomeScreen()),
      ),
      GoRoute(
        path: '/search',
        name: 'search',
        pageBuilder: (context, state) =>
            const MaterialPage(child: SearchScreen()),
      ),
      GoRoute(
        path: '/photo/:id',
        name: 'photo-detail',
        pageBuilder: (context, state) {
          final photo = state.extra as PhotoModel;
          return MaterialPage(child: PhotoDetailScreen(photo: photo));
        },
      ),
      GoRoute(
        path: '/profile',
        name: 'profile',
        pageBuilder: (context, state) =>
            const MaterialPage(child: ProfileScreen()),
      ),
    ],
  );
});
