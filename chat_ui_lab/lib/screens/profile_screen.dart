import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('your_username', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [IconButton(icon: const Icon(Icons.menu), onPressed: () {})],
      ),
      body: ListView(
        children: <Widget>[
          _buildProfileHeader(),
          _buildPostGrid(),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=1'),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _buildStatColumn('5', 'Posts'),
                    _buildStatColumn('1,234', 'Followers'),
                    _buildStatColumn('567', 'Following'),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          const Text('Your Name', style: TextStyle(fontWeight: FontWeight.bold)),
          const Text('Content Creator | Flutter Developer\nLove building beautiful apps.'),
          const SizedBox(height: 16.0),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {},
              child: const Text('Edit Profile'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.black,
                side: const BorderSide(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column _buildStatColumn(String value, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 14)),
      ],
    );
  }

  Widget _buildPostGrid() {
    // Using placeholder images for the grid
    final List<String> postImages = [
      'assets/images/3.jpg',
      'assets/images/4.jpg',
      'assets/images/5.jpg',
      'assets/images/1.jpg',
      'assets/images/2.jpg',
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(), // to disable GridView's scrolling
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      itemCount: postImages.length,
      itemBuilder: (context, index) {
        return Image.asset(postImages[index], fit: BoxFit.cover);
      },
    );
  }
}
