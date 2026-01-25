import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String email;
  final String? name;
  final String? dateOfBirth;
  final String? gender;
  final String? country;
  final List<String> interests;

  const UserModel({
    required this.id,
    required this.email,
    this.name,
    this.dateOfBirth,
    this.gender,
    this.country,
    this.interests = const [],
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      name: json['name'],
      dateOfBirth: json['dateOfBirth'],
      gender: json['gender'],
      country: json['country'],
      interests: (json['interests'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'dateOfBirth': dateOfBirth,
      'gender': gender,
      'country': country,
      'interests': interests,
    };
  }

  UserModel copyWith({
    String? id,
    String? email,
    String? name,
    String? dateOfBirth,
    String? gender,
    String? country,
    List<String>? interests,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      country: country ?? this.country,
      interests: interests ?? this.interests,
    );
  }

  @override
  List<Object?> get props => [id, email, name, dateOfBirth, gender, country, interests];
}