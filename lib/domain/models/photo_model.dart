import 'package:equatable/equatable.dart';

class PhotoModel extends Equatable {
  final int id;
  final String photographer;
  final String photographerUrl;
  final PhotoSrc src;
  final int width;
  final int height;
  final String alt;

  const PhotoModel({
    required this.id,
    required this.photographer,
    required this.photographerUrl,
    required this.src,
    required this.width,
    required this.height,
    required this.alt,
  });

  factory PhotoModel.fromJson(Map<String, dynamic> json) {
    return PhotoModel(
      id: json['id'],
      photographer: json['photographer'] ?? '',
      photographerUrl: json['photographer_url'] ?? '',
      src: PhotoSrc.fromJson(json['src']),
      width: json['width'],
      height: json['height'],
      alt: json['alt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'photographer': photographer,
      'photographer_url': photographerUrl,
      'src': src.toJson(),
      'width': width,
      'height': height,
      'alt': alt,
    };
  }

  @override
  List<Object?> get props => [id, photographer, src, width, height];
}

class PhotoSrc extends Equatable {
  final String original;
  final String large2x;
  final String large;
  final String medium;
  final String small;
  final String portrait;
  final String landscape;
  final String tiny;

  const PhotoSrc({
    required this.original,
    required this.large2x,
    required this.large,
    required this.medium,
    required this.small,
    required this.portrait,
    required this.landscape,
    required this.tiny,
  });

  factory PhotoSrc.fromJson(Map<String, dynamic> json) {
    return PhotoSrc(
      original: json['original'] ?? '',
      large2x: json['large2x'] ?? '',
      large: json['large'] ?? '',
      medium: json['medium'] ?? '',
      small: json['small'] ?? '',
      portrait: json['portrait'] ?? '',
      landscape: json['landscape'] ?? '',
      tiny: json['tiny'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'original': original,
      'large2x': large2x,
      'large': large,
      'medium': medium,
      'small': small,
      'portrait': portrait,
      'landscape': landscape,
      'tiny': tiny,
    };
  }

  @override
  List<Object?> get props => [original, large2x, large, medium, small];
}
