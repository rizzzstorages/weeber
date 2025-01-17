import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();

  // Brand colors
  final Color primaryColor = const Color(0xFF4A5FC1);
  final Color secondaryColor = const Color(0xFF6C63FF);
  final Color textColor = const Color(0xFF272727);

  // Track selected tab
  int selectedTab = 0;

  // Tab items
  final List<String> tabs = ['ANIME', 'MOVIES', 'TV', 'DRAMA'];

  // Content data for each tab
  final Map<String, List<Map<String, String>>> tabContent = {
    'ANIME': [
      {
        'title': 'Attack on Titan',
        'rating': '9.8',
        'type': 'Action, Drama',
        'episodes': '75',
        'image': 'assets/images/aot.jpg'
      },
      {
        'title': 'Demon Slayer',
        'rating': '9.5',
        'type': 'Action, Supernatural',
        'episodes': '44',
        'image': 'assets/images/ds.jpg'
      },
      {
        'title': 'Jujutsu Kaisen',
        'rating': '9.7',
        'type': 'Action, Fantasy',
        'episodes': '24',
        'image': 'assets/images/jjk.jpg'
      },
      {
        'title': 'One Piece',
        'rating': '9.6',
        'type': 'Adventure, Fantasy',
        'episodes': '1000+',
        'image': 'assets/images/op.jpg'
      },
    ],
    'MOVIES': [
      {
        'title': 'Inception',
        'rating': '9.3',
        'type': 'Sci-Fi, Action',
        'duration': '2h 28m',
        'image': 'assets/images/inception.jpg'
      },
      {
        'title': 'The Dark Knight',
        'rating': '9.5',
        'type': 'Action, Drama',
        'duration': '2h 32m',
        'image': 'assets/images/dark_knight.jpg'
      },
    ],
    'TV': [
      {
        'title': 'Breaking Bad',
        'rating': '9.9',
        'type': 'Crime, Drama',
        'seasons': '5',
        'image': 'assets/images/breaking_bad.jpg'
      },
      {
        'title': 'Game of Thrones',
        'rating': '9.4',
        'type': 'Fantasy, Drama',
        'seasons': '8',
        'image': 'assets/images/game_of_thrones.jpg'
      },
    ],
    'DRAMA': [
      {
        'title': 'Vincenzo',
        'rating': '9.2',
        'type': 'Crime, Romance',
        'episodes': '20',
        'image': 'assets/images/vincenzo.jpg'
      },
      {
        'title': 'Goblin',
        'rating': '9.4',
        'type': 'Fantasy, Romance',
        'episodes': '16',
        'image': 'assets/images/goblin.jpg'
      },
    ],
  };

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Modern App Bar with Search
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: primaryColor.withOpacity(0.1),
                    child: Icon(Icons.person_outline, color: primaryColor),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        controller: _searchController,
                        style: TextStyle(color: textColor),
                        decoration: InputDecoration(
                          hintText: 'Search your favorite shows...',
                          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
                          prefixIcon: Icon(Icons.search, size: 20, color: primaryColor),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                        cursorColor: primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Icon(Icons.notifications_none, color: primaryColor),
                ],
              ),
            ),

            // Custom Tab Bar
            Container(
              height: 40,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    tabs.length,
                    (index) => GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedTab = index;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.only(right: 16),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                        decoration: BoxDecoration(
                          color: selectedTab == index
                              ? primaryColor.withOpacity(0.1)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: selectedTab == index
                                ? primaryColor
                                : Colors.transparent,
                            width: 1,
                          ),
                        ),
                        child: Text(
                          tabs[index],
                          style: TextStyle(
                            color: selectedTab == index
                                ? primaryColor
                                : Colors.grey[400],
                            fontSize: 14,
                            fontWeight: selectedTab == index
                                ? FontWeight.w600
                                : FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Content Area
            Expanded(
              child: IndexedStack(
                index: selectedTab,
                children: List.generate(
                  tabs.length,
                  (index) => _buildContentGrid(tabs[index]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContentGrid(String tabName) {
    final items = tabContent[tabName] ?? [];

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        final bool isAnimeOrDrama = tabName == 'ANIME' || tabName == 'DRAMA';
        final String metaText = isAnimeOrDrama
            ? '${item['episodes']} Episodes'
            : tabName == 'TV'
                ? '${item['seasons']} Seasons'
                : item['duration'] ?? '';

        return Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Thumbnail
              Expanded(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    child: item['image'] != null
                        ? Image.asset(
                            item['image']!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          )
                        : Icon(
                            _getIconForTab(tabName),
                            size: 40,
                            color: primaryColor.withOpacity(0.5),
                          ),
                  ),
                ),
              ),
              // Content Info
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['title']!,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: textColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item['type']!,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.star, size: 16, color: Colors.amber[700]),
                          const SizedBox(width: 4),
                          Text(
                            item['rating']!,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            metaText,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  IconData _getIconForTab(String tabName) {
    switch (tabName) {
      case 'ANIME':
        return Icons.animation;
      case 'MOVIES':
        return Icons.movie_outlined;
      case 'TV':
        return Icons.tv;
      case 'DRAMA':
        return Icons.theater_comedy;
      default:
        return Icons.play_circle_outline;
    }
  }
}
