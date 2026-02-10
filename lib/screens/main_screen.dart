import 'package:flutter/material.dart';
import 'package:marketing_app/screens/example_screen.dart';
import 'package:marketing_app/theme/background_scaffold.dart';
import 'package:marketing_app/widgets/main_screen_widgets/category_card.dart';
import 'package:marketing_app/widgets/main_screen_widgets/content_carousel.dart';
import 'package:marketing_app/widgets/main_screen_widgets/instructionLabel.dart';
import 'package:marketing_app/widgets/main_screen_widgets/paginationIndicator.dart';
import 'package:marketing_app/widgets/main_screen_widgets/side_bar.dart';
import 'package:marketing_app/widgets/screen_headline.dart';

// --- Constants & Colors ---
class PageColors {
  static const Color textDark = Color(0xFF2D2D2D);
  static const Color textLight = Color(0xFF757575);
  static const Color cardOrangeTop = Color(0xFFF09E72);
  static const Color cardOrangeBottom = Color(0xFFD9733E);
  static const Color dotActive = Color(0xFF6EBC73);
  static const Color dotInactive = Color(0xFFE0E0E0);
  static const Color iconBg = Colors.white;
}

// --- Main Screen ---
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.85);
  int _currentIndex =
      0; // Start at index 1 to match screenshot "Staff" being central?
  // Or 0. Let's start at 0.

  // Mock data for the cards
  final List<Map<String, dynamic>> _categories = [
    {
      'title': 'Staff',
      'description': 'Introduce your team and build trust with customers',
      'icon': Icons.groups_outlined,
      'instructions':
          'Follow these steps:\n\n1. Gather high-quality photos of your staff in action.\n\n2. Write brief bios highlighting their expertise and passion for food.\n\n3. Create engaging posts to showcase your team\'s dedication and personality.',

      'steps': [
        'Follow these steps:\n\n',
        '1. Gather high-quality photos of your staff in action.\n\n',
        '2. Write brief bios highlighting their expertise and passion for food.\n\n',
        '3. Create engaging posts to showcase your team\'s dedication and personality.',
      ],
    },
    {
      'title': 'Menu',
      'description': 'Showcase your best dishes and seasonal offers',
      'icon': Icons.restaurant_menu_outlined,
      'instructions':
          'Follow these steps:\n\n1. Photograph your most popular dishes in appealing settings.\n\n2. Highlight any seasonal or special menu items.\n\n3. Share stories behind the dishes to entice customers',

      'steps': [
        'Follow these steps:\n\n',
        '1. Photograph your most popular dishes in appealing settings.\n\n',
        '2. Highlight any seasonal or special menu items.\n\n',
        '3. Share stories behind the dishes to entice customers.  ',
      ],
    },
    {
      'title': 'Events',
      'description': 'Promote your upcoming workshops and gatherings',
      'icon': Icons.event_outlined,
      'instructions':
          'Follow these steps:\n\n1. Gather high-quality photos of your events in action.\n\n2. Create engaging posts to promote upcoming events.\n\n3. Share behind-the-scenes content to build excitement.',
      'steps': [
        'Follow these steps:\n\n',
        '1. Gather high-quality photos of your events in action.\n\n',
        '2. Create engaging posts to promote upcoming events.\n\n',
        '3. Share behind-the-scenes content to build excitement.',
      ],
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Assuming BackgroundScaffold is used as a parent or we rely on transparent background
    return BackgroundScaffold(
      drawer: const SideBar(),
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
              child: CustomNavBar(),
            ),
            const SizedBox(height: 20),
            const Spacer(flex: 1),
            const InstructionLabel(text: "Tap a card to start"),
            const SizedBox(height: 20),

            // Carousel Section
            SizedBox(
              height: 420, // Fixed height for the card area
              child: ContentCarousel(
                controller: _pageController,
                itemCount: _categories.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  final item = _categories[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: CategoryCard(
                      title: item['title'],
                      description: item['description'],
                      icon: item['icon'],
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => ExampleScreen(
                              title: item['title'],
                              description: item['instructions'],
                              steps: item['steps'],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),
            PaginationIndicator(
              itemCount: 3, // Hardcoded 6 dots as per screenshot
              currentIndex: _currentIndex,
            ),
            const SizedBox(height: 12),
            const InstructionLabel(text: "Swipe to explore more", fontSize: 12),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
