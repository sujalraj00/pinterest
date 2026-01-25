class OnboardingData {
  final String? email;
  final String? password;
  final String? name;
  final DateTime? dateOfBirth;
  final String? gender;
  final String? country;
  final List<String> interests;

  OnboardingData({
    this.email,
    this.password,
    this.name,
    this.dateOfBirth,
    this.gender,
    this.country,
    this.interests = const [],
  });

  OnboardingData copyWith({
    String? email,
    String? password,
    String? name,
    DateTime? dateOfBirth,
    String? gender,
    String? country,
    List<String>? interests,
  }) {
    return OnboardingData(
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      country: country ?? this.country,
      interests: interests ?? this.interests,
    );
  }
}

class MoodOption {
  final String id;
  final String name;
  final String emoji;

  const MoodOption({
    required this.id,
    required this.name,
    required this.emoji,
  });
}

const List<MoodOption> availableMoods = [
  MoodOption(id: 'nature', name: 'Nature', emoji: '🌿'),
  MoodOption(id: 'travel', name: 'Travel', emoji: '✈️'),
  MoodOption(id: 'food', name: 'Food', emoji: '🍕'),
  MoodOption(id: 'fashion', name: 'Fashion', emoji: '👗'),
  MoodOption(id: 'art', name: 'Art', emoji: '🎨'),
  MoodOption(id: 'technology', name: 'Technology', emoji: '💻'),
  MoodOption(id: 'fitness', name: 'Fitness', emoji: '💪'),
  MoodOption(id: 'animals', name: 'Animals', emoji: '🐾'),
  MoodOption(id: 'architecture', name: 'Architecture', emoji: '🏛️'),
  MoodOption(id: 'music', name: 'Music', emoji: '🎵'),
  MoodOption(id: 'photography', name: 'Photography', emoji: '📸'),
  MoodOption(id: 'home', name: 'Home Decor', emoji: '🏠'),
];