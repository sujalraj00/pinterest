import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../domain/models/onboarding_data.dart';
import '../../../domain/models/user_model.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/onboarding_controller.dart';

class InterestsScreen extends ConsumerWidget {
  const InterestsScreen({super.key});

  Future<void> _handleComplete(BuildContext context, WidgetRef ref) async {
    final onboardingData = ref.read(onboardingControllerProvider);
    final authState = ref.read(authControllerProvider);

    if (onboardingData.interests.length >= 3) {
      // Create user model
      final user = UserModel(
        id: authState.user?.id ?? '',
        email: onboardingData.email!,
        name: onboardingData.name,
        dateOfBirth: onboardingData.dateOfBirth?.toIso8601String(),
        gender: onboardingData.gender,
        country: onboardingData.country,
        interests: onboardingData.interests,
      );

      // Save user data
      await ref.read(authControllerProvider.notifier).completeUserProfile(user);

      // Navigate with animation
      if (context.mounted) {
        await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const _LoadingDialog(),
        );

        await Future.delayed(const Duration(seconds: 2));

        if (context.mounted) {
          Navigator.of(context).pop();
          context.go('/');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedInterests = ref.watch(
      onboardingControllerProvider.select((data) => data.interests),
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LinearProgressIndicator(
                    value: 7 / 7,
                    backgroundColor: Colors.grey[200],
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Color(0xFFE60023),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Pick 3+ interests',
                    style:
                        Theme.of(context).textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'This will help us curate your feed',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${selectedInterests.length} selected',
                    style: TextStyle(
                      color: selectedInterests.length >= 3
                          ? const Color(0xFFE60023)
                          : Colors.grey[600],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.5,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: availableMoods.length,
                  itemBuilder: (context, index) {
                    final mood = availableMoods[index];
                    final isSelected = selectedInterests.contains(mood.id);
                    return _InterestCard(
                      mood: mood,
                      isSelected: isSelected,
                      onTap: () {
                        ref
                            .read(onboardingControllerProvider.notifier)
                            .toggleInterest(mood.id);
                      },
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: selectedInterests.length >= 3
                      ? () => _handleComplete(context, ref)
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE60023),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: const Text(
                    'Complete',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InterestCard extends StatelessWidget {
  final MoodOption mood;
  final bool isSelected;
  final VoidCallback onTap;

  const _InterestCard({
    required this.mood,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFFE60023)
              : Colors.grey[200],
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? const Color(0xFFE60023)
                : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              mood.emoji,
              style: const TextStyle(fontSize: 40),
            ),
            const SizedBox(height: 8),
            Text(
              mood.name,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _LoadingDialog extends StatelessWidget {
  const _LoadingDialog();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFE60023)),
            ),
            const SizedBox(height: 24),
            Text(
              'Setting up your feed...',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}