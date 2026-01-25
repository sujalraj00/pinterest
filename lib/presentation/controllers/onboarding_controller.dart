import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/onboarding_data.dart';

class OnboardingController extends StateNotifier<OnboardingData> {
  OnboardingController() : super(OnboardingData());

  void setEmail(String email) {
    state = state.copyWith(email: email);
  }

  void setPassword(String password) {
    state = state.copyWith(password: password);
  }

  void setName(String name) {
    state = state.copyWith(name: name);
  }

  void setDateOfBirth(DateTime dob) {
    state = state.copyWith(dateOfBirth: dob);
  }

  void setGender(String gender) {
    state = state.copyWith(gender: gender);
  }

  void setCountry(String country) {
    state = state.copyWith(country: country);
  }

  void toggleInterest(String interest) {
    final interests = List<String>.from(state.interests);
    if (interests.contains(interest)) {
      interests.remove(interest);
    } else {
      interests.add(interest);
    }
    state = state.copyWith(interests: interests);
  }

  void reset() {
    state = OnboardingData();
  }
}

final onboardingControllerProvider =
    StateNotifierProvider<OnboardingController, OnboardingData>((ref) {
  return OnboardingController();
});