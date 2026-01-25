import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../controllers/onboarding_controller.dart';

class GenderScreen extends ConsumerStatefulWidget {
  const GenderScreen({super.key});

  @override
  ConsumerState<GenderScreen> createState() => _GenderScreenState();
}

class _GenderScreenState extends ConsumerState<GenderScreen> {
  String? _selectedGender;

  void _handleContinue() {
    if (_selectedGender != null) {
      ref
          .read(onboardingControllerProvider.notifier)
          .setGender(_selectedGender!);
      context.push('/signup/country');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LinearProgressIndicator(
                value: 5 / 7,
                backgroundColor: Colors.grey[200],
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Color(0xFFE60023),
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'What\'s your gender?',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'This helps us personalize your experience',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey[600],
                    ),
              ),
              const SizedBox(height: 32),
              _GenderOption(
                title: 'Male',
                icon: Icons.male,
                selected: _selectedGender == 'Male',
                onTap: () => setState(() => _selectedGender = 'Male'),
              ),
              const SizedBox(height: 12),
              _GenderOption(
                title: 'Female',
                icon: Icons.female,
                selected: _selectedGender == 'Female',
                onTap: () => setState(() => _selectedGender = 'Female'),
              ),
              const SizedBox(height: 12),
              _GenderOption(
                title: 'Other',
                icon: Icons.transgender,
                selected: _selectedGender == 'Other',
                onTap: () => setState(() => _selectedGender = 'Other'),
              ),
              const SizedBox(height: 12),
              _GenderOption(
                title: 'Prefer not to say',
                icon: Icons.remove_circle_outline,
                selected: _selectedGender == 'Prefer not to say',
                onTap: () =>
                    setState(() => _selectedGender = 'Prefer not to say'),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _selectedGender != null ? _handleContinue : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE60023),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GenderOption extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _GenderOption({
    required this.title,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: selected ? const Color(0xFFE60023) : Colors.grey[300]!,
            width: selected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
          color: selected ? const Color(0xFFE60023).withOpacity(0.05) : null,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: selected ? const Color(0xFFE60023) : Colors.grey[600],
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
                color: selected ? const Color(0xFFE60023) : Colors.black87,
              ),
            ),
            const Spacer(),
            if (selected)
              const Icon(
                Icons.check_circle,
                color: Color(0xFFE60023),
              ),
          ],
        ),
      ),
    );
  }
}