class ApiConstants {
  static const String pexelsApiKey =
      'YOUR_PEXELS_API_KEY_HERE'; // Replace with your Pexels API key
  static const String baseUrl = 'https://api.pexels.com/v1';
  static const String videosBaseUrl = 'https://api.pexels.com/videos';

  // Endpoints
  static const String curatedPhotos = '/curated';
  static const String searchPhotos = '/search';
  static const String photoDetails = '/photos';
  static const String popularVideos = '/popular';
  static const String searchVideos = '/search';

  // Pagination
  static const int perPage = 30;
}
