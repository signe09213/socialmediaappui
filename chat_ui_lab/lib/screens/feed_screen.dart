import 'package:flutter/material.dart';
import '../models/post_model.dart';
import '../models/story_model.dart';
import '../widgets/post_card.dart';
import '../widgets/story_avatar.dart';
import './story_screen.dart';
import './profile_screen.dart'; // Import the new profile screen

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  int _selectedIndex = 0;
  final List<Story> _stories = [];
  final List<Post> _posts = [];

  @override
  void initState() {
    super.initState();
    _generateDummyData();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _generateDummyData() {
    // Generate themed stories
    _stories.add(Story(userName: 'Your Story', avatarUrl: 'https://i.pravatar.cc/150?img=1', mediaType: MediaType.image, mediaUrl: 'assets/images/1.jpg'));
    _stories.add(Story(userName: 'filmmaker_pro', avatarUrl: 'https://i.pravatar.cc/150?img=21', mediaType: MediaType.video, mediaUrl: 'assets/videos/story_video.mp4'));
    _stories.add(Story(userName: 'design_guru', avatarUrl: 'https://i.pravatar.cc/150?img=22', mediaType: MediaType.image, mediaUrl: 'assets/images/2.jpg'));
    _stories.add(Story(userName: 'podcast_hustle', avatarUrl: 'https://i.pravatar.cc/150?img=23', mediaType: MediaType.image, mediaUrl: 'assets/images/4.jpg'));
    _stories.add(Story(userName: 'photo_journey', avatarUrl: 'https://i.pravatar.cc/150?img=24', mediaType: MediaType.image, mediaUrl: 'assets/images/3.jpg'));
    _stories.add(Story(userName: 'study_with_me', avatarUrl: 'https://i.pravatar.cc/150?img=25', mediaType: MediaType.image, mediaUrl: 'assets/images/5.jpg'));

    // Generate themed posts
    _posts.add(Post(userName: 'filmmaker_pro', userAvatarUrl: 'https://i.pravatar.cc/150?img=21', mediaUrl: 'assets/images/3.jpg', mediaType: MediaType.image, caption: 'WE DID IT! 100,000 subscribers! Thank you... 🙏', likes: 1204, comments: 'View all 1,204 comments', timestamp: '30 minutes ago'));
    _posts.add(Post(userName: 'podcast_hustle', userAvatarUrl: 'https://i.pravatar.cc/150?img=23', mediaUrl: 'assets/images/4.jpg', mediaType: MediaType.image, caption: 'Had an unbelievable guest on the podcast today...', likes: 987, comments: 'View all 987 comments', timestamp: '4 hours ago'));
    _posts.add(Post(userName: 'study_with_me', userAvatarUrl: 'https://i.pravatar.cc/150?img=25', mediaUrl: 'assets/images/5.jpg', mediaType: MediaType.image, caption: 'Another late night study session powered by coffee and lofi beats...', likes: 312, comments: 'View all 312 comments', timestamp: '12 hours ago'));
    _posts.add(Post(userName: 'design_guru', userAvatarUrl: 'https://i.pravatar.cc/150?img=22', mediaUrl: 'assets/images/1.jpg', mediaType: MediaType.image, caption: 'Just updated my branding. What do you guys think? #graphicdesign', likes: 256, comments: 'View all 256 comments', timestamp: '1 day ago'));
    _posts.add(Post(userName: 'filmmaker_pro', userAvatarUrl: 'https://i.pravatar.cc/150?img=21', mediaUrl: 'assets/images/2.jpg', mediaType: MediaType.image, caption: 'Putting the final touches on the 100k special video...', likes: 419, comments: 'View all 419 comments', timestamp: '2 days ago'));
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      _buildFeed(),
      const Center(child: Text('Search Screen', style: TextStyle(fontSize: 24))),
      const Center(child: Text('Reels Screen', style: TextStyle(fontSize: 24))),
      const ProfileScreen(),
    ];

    return Scaffold(
      appBar: _selectedIndex == 3 ? null : AppBar(
        title: Text('Antogram', style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Billabong', fontSize: 28.0)),
        actions: [
          IconButton(icon: const Icon(Icons.add_box_outlined), onPressed: () {}),
          IconButton(icon: const Icon(Icons.favorite_border), onPressed: () {}),
          IconButton(icon: const Icon(Icons.send_outlined), onPressed: () {}),
        ],
        elevation: 1.0,
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.video_collection_outlined), label: 'Reels'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
      ),
    );
  }

  Widget _buildFeed() {
    return Column(
      children: [
        _buildStories(),
        const Divider(height: 1, color: Colors.grey),
        Expanded(
          child: ListView.builder(
            itemCount: _posts.length,
            itemBuilder: (context, index) {
              return PostCard(post: _posts[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildStories() {
    return SizedBox(
      height: 100.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _stories.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => StoryScreen(stories: _stories),
              ),
            ),
            child: StoryAvatar(story: _stories[index]),
          );
        },
      ),
    );
  }
}
