import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../controllers/auth_controller.dart';

class SavedScreen extends ConsumerWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);
    final userName = authState.user?.name ?? 'Guest User';

    final collageChipProvider = StateProvider<int>((ref) => 0);
    // 0 = My Collages
    // 1 = Shared

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              GestureDetector(
                onTap: () {
                  context.go('/account-settings');
                },
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: const Color(0xFFFFB3BA),
                  child: Text(
                    userName[0].toUpperCase(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: TabBar(
                  isScrollable: false,
                  labelPadding: EdgeInsets.symmetric(horizontal: 25),
                  labelColor: Colors.black,
                  tabAlignment: TabAlignment.center,
                  unselectedLabelColor: Colors.black,
                  indicatorColor: Colors.black,
                  dividerColor: Colors.transparent,
                  indicatorWeight: 3,
                  labelStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                  tabs: [
                    Tab(text: 'Pins'),
                    Tab(text: 'Boards'),
                    Tab(text: 'Collages'),
                  ],
                ),
              ),
            ],
          ),
          // actions: [
          //   IconButton(
          //     icon: const Icon(Icons.add),
          //     iconSize: 28,
          //     onPressed: () {},
          //   ),
          // ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(70),
            child: Builder(
              builder: (context) {
                final tabController = DefaultTabController.of(context);

                // Safety check
                if (tabController == null) return const SizedBox();

                return AnimatedBuilder(
                  animation: tabController,
                  builder: (context, _) {
                    final isCollageTab = tabController.index == 2;

                    return Padding(
                      padding: const EdgeInsets.fromLTRB(16, 10, 16, 6),
                      child: isCollageTab
                          ? _buildCollageChips(ref)
                          : _buildSearchAndAdd(),
                    );
                  },
                );
              },
            ),
          ),
        ),
        body: TabBarView(
          children: [
            _buildEmptyPinsState(context),
            _buildEmptyBoardsState(context),
            _buildEmptyCollagesState(context, ref),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchAndAdd() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search your Pins',
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.grey, width: 2),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        IconButton(icon: const Icon(Icons.add, size: 28), onPressed: () {}),
      ],
    );
  }

  // Widget _buildCollageChips() {
  //   return Row(
  //     children: const [
  //       Chip(label: Text('My Collages')),
  //       SizedBox(width: 8),
  //       Chip(label: Text('Shared')),
  //     ],
  //   );
  // }

  Widget _buildCollageChips(WidgetRef ref) {
    final collageChipProvider = StateProvider<int>((ref) => 0);
    final selectedChip = ref.watch(collageChipProvider);

    return Row(
      children: [
        ChoiceChip(
          selectedColor: Colors.black87,
          disabledColor: Colors.grey,
          showCheckmark: false,
          label: const Text(
            'My Collages',
            style: TextStyle(color: Colors.white),
          ),
          selected: selectedChip == 0,
          onSelected: (_) {
            ref.read(collageChipProvider.notifier).state = 0;
          },
        ),
        const SizedBox(width: 8),
        ChoiceChip(
          selectedColor: Colors.black87,
          showCheckmark: false,
          disabledColor: Colors.grey,
          label: const Text('Shared'),
          selected: selectedChip == 1,
          onSelected: (_) {
            ref.read(collageChipProvider.notifier).state = 1;
          },
        ),
      ],
    );
  }

  Widget _buildEmptyPinsState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 1),
        child: Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 60),
            Container(
              height: 220,
              width: 220,
              child: Image.asset('assets/images/savepins.png'),
            ),
            const Text(
              'Save what inspires you',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'Saving Pins is Pinterest\'s superpower. Browse Pins, save what you love, find them here to get inspired all over again.',
              style: TextStyle(fontSize: 16, color: Colors.black, height: 1.4),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 17),
            ElevatedButton(
              onPressed: () {
                // TODO: Navigate to explore/home
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE60023),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Explore Pins',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyBoardsState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 1),
        child: Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 60),
            Container(
              height: 220,
              width: 220,
              child: Image.asset('assets/images/saved_board.png'),
            ),
            // Icon(Icons.grid_view_rounded, size: 80, color: Colors.grey[400]),
            // const SizedBox(height: 24),
            const Text(
              'Organize your ideas',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              textAlign: TextAlign.center,
              '''Pins are sparks of inspiration. Boards are where they live. Create boards to organize your Pins your way.
              ''',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            // const SizedBox(height: 17),
            ElevatedButton(
              onPressed: () {
                // TODO: Navigate to explore/home
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE60023),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Explore Pins',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyCollagesState(BuildContext context, WidgetRef ref) {
    final collageChipProvider = StateProvider<int>((ref) => 0);
    final selectedChip = ref.watch(collageChipProvider);

    if (selectedChip == 0) {
      return _myCollagesView();
    } else {
      return _sharedCollagesView();
    }
  }

  Widget _myCollagesView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 1),
        child: Column(
          //  mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //
            SizedBox(height: 20),
            Container(
              height: 220,
              width: 220,
              child: Image.asset('assets/images/saved_collage.png'),
            ),

            //const SizedBox(height: 24),
            const Text(
              'Create a collage',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              textAlign: TextAlign.center,
              '''Snip-and-paste Pins to make something totally new--then publish it to inspire people with what you create.''',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            SizedBox(height: 17),
            ElevatedButton(
              onPressed: () {
                // TODO: Navigate to explore/home
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE60023),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Explore Pins',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _sharedCollagesView() {
  return Center(
    child: Text(
      'Shared Collages Data',
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
  );
}

Widget _buildEmptyCollagesState(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 1),
      child: Column(
        //  mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //
          Container(
            height: 220,
            width: 220,
            child: Image.asset('assets/images/saved_collage.png'),
          ),

          //const SizedBox(height: 24),
          const Text(
            'Create a collage',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            textAlign: TextAlign.center,
            '''Snip-and-paste Pins to make something totally new--then publish it to inspire people with what you create.''',
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
          SizedBox(height: 17),
          ElevatedButton(
            onPressed: () {
              // TODO: Navigate to explore/home
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE60023),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              elevation: 0,
            ),
            child: const Text(
              'Explore Pins',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    ),
  );
}
