import 'photo_model.dart';

class PhotosResponse {
  final int page;
  final int perPage;
  final List<PhotoModel> photos;
  final int? totalResults;
  final String? nextPage;

  PhotosResponse({
    required this.page,
    required this.perPage,
    required this.photos,
    this.totalResults,
    this.nextPage,
  });

  factory PhotosResponse.fromJson(Map<String, dynamic> json) {
    return PhotosResponse(
      page: json['page'] ?? 1,
      perPage: json['per_page'] ?? 30,
      photos:
          (json['photos'] as List?)
              ?.map((photo) => PhotoModel.fromJson(photo))
              .toList() ??
          [],
      totalResults: json['total_results'],
      nextPage: json['next_page'],
    );
  }
}
