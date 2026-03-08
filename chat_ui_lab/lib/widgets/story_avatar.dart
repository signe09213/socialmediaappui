import 'package:flutter/material.dart';
import '../models/story_model.dart';

class StoryAvatar extends StatelessWidget {
  final Story story;

  const StoryAvatar({super.key, required this.story});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 34,
            backgroundColor: Colors.pink,
            child: CircleAvatar(
              radius: 32,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(story.avatarUrl),
              ),
            ),
          ),
          const SizedBox(height: 4.0),
          SizedBox(
            width: 70,
            child: Text(
              story.userName,
              style: const TextStyle(fontSize: 12.0),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
