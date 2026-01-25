import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../controllers/onboarding_controller.dart';

class CountryScreen extends ConsumerStatefulWidget {
  const CountryScreen({super.key});

  @override
  ConsumerState<CountryScreen> createState() => _CountryScreenState();
}

class _CountryScreenState extends ConsumerState<CountryScreen> {
  String? _selectedCountry;
  final TextEditingController _searchController = TextEditingController();
  List<String> _filteredCountries = [];

  final List<String> _countries = [
    'United States',
    'United Kingdom',
    'Canada',
    'Australia',
    'India',
    'Germany',
    'France',
    'Italy',
    'Spain',
    'Brazil',
    'Mexico',
    'Japan',
    'South Korea',
    'China',
    'Netherlands',
    'Sweden',
    'Norway',
    'Denmark',
    'Switzerland',
    'Austria',
  ];

  @override
  void initState() {
    super.initState();
    _filteredCountries = _countries;
    _searchController.addListener(_filterCountries);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterCountries() {
    setState(() {
      _filteredCountries = _countries
          .where((country) => country
              .toLowerCase()
              .contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  void _handleContinue() {
    if (_selectedCountry != null) {
      ref
          .read(onboardingControllerProvider.notifier)
          .setCountry(_selectedCountry!);
      context.push('/signup/interests');
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LinearProgressIndicator(
                    value: 6 / 7,
                    backgroundColor: Colors.grey[200],
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Color(0xFFE60023),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Where are you from?',
                    style:
                        Theme.of(context).textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'This helps us show you relevant content',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search countries',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredCountries.length,
                itemBuilder: (context, index) {
                  final country = _filteredCountries[index];
                  final isSelected = _selectedCountry == country;
                  return ListTile(
                    title: Text(country),
                    trailing: isSelected
                        ? const Icon(Icons.check_circle,
                            color: Color(0xFFE60023))
                        : null,
                    selected: isSelected,
                    selectedTileColor: const Color(0xFFE60023).withOpacity(0.1),
                    onTap: () => setState(() => _selectedCountry = country),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _selectedCountry != null ? _handleContinue : null,
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
            ),
          ],
        ),
      ),
    );
  }
}